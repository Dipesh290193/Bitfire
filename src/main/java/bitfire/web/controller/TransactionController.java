package bitfire.web.controller;

import java.io.IOException;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bitfire.model.Address;
import bitfire.model.Invoice;
import bitfire.model.Notifications;
import bitfire.model.Transaction;
import bitfire.model.User;
import bitfire.model.dao.AddressBookDao;
import bitfire.model.dao.AddressDao;
import bitfire.model.dao.TransactionDao;
import bitfire.model.dao.UserDao;
import bitfire.security.SecurityUtils;
import info.blockchain.api.APIException;
import info.blockchain.api.exchangerates.ExchangeRates;
import info.blockchain.api.wallet.PaymentResponse;
import info.blockchain.api.wallet.Wallet;
import bitfire.util.Confirmations;
@Controller
public class TransactionController {

	@Autowired
	private TransactionDao transDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private AddressDao addressDao;
	
	@Autowired
	private AddressBookDao addressBookDao;
	
	@RequestMapping(value ={"/user/send.html"}, method = RequestMethod.GET)
	public String send(ModelMap map, HttpServletRequest request){
		if(request.getParameter("to") != null)
			map.put("to", request.getParameter("to"));
		if(request.getParameter("amount") != null)
			map.put("amount", request.getParameter("amount"));
		User user=SecurityUtils.getUser();
		List<Transaction> trans = transDao.getAllTransactions(user);
		List<String> emails = new ArrayList<>();
		for(Transaction t: trans){
			String mail =t.getReceiverUser().getEmail();
			if(!emails.contains(mail) && !mail.equals(user.getEmail())){
				emails.add(mail);
			}
		}
		

		
		bitfire.model.Wallet userWallet = user.getWallet();
		System.out.println("WALLET: " + userWallet.getWalletId());
		Set<bitfire.model.Address> userAddresses = new HashSet<bitfire.model.Address>(addressDao.getAddresses(userWallet));
		Wallet wallet = new Wallet("http://localhost:3000/", 
				"fd592284-ed09-4910-ab9f-06129b3a4054",
    			user.getWallet().getWalletId(),
    			user.getPassword());
		
		List<info.blockchain.api.wallet.Address> apiAddresses;
		try {
			apiAddresses = wallet.listAddresses(0);
			
			for(info.blockchain.api.wallet.Address apiAddress: apiAddresses){
				for(bitfire.model.Address userAddress: userAddresses){
					if(userAddress.getAddress().equals(apiAddress.getAddress())){
						userAddress.setBitcoins((int)apiAddress.getBalance());
						userAddress.setUSD((long)(100.0 *(ExchangeRates.getUSD() * 1.0 )*(apiAddress.getBalance()/100000000.0)));
						System.out.println("ADDRESS BALANE: " + 100.0*((ExchangeRates.getUSD() * 1.0 )*(apiAddress.getBalance()/100000000.0)));
						addressDao.saveAddress(userAddress);
						break;
					}
				}
			}
				
		} catch (Exception e) {
		}
		map.put("balance", addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet()).getBitcoins());
		map.put("addressBook", addressBookDao.getAddressBook(user));
		map.put("user", SecurityUtils.getUser());
		
		return "/user/send";
	}
	
	@RequestMapping(value ={"/user/send.html"}, method = RequestMethod.POST)
	public String send(@RequestParam String email, @RequestParam Double btc, ModelMap map, String reason){
		
		User receiverUser=userDao.getUserByEmail(email.toLowerCase());
		User senderUser = SecurityUtils.getUser();
		
//		System..println("Sender add: " + senderAddress.getAddress() + " : " + "Rec add: " + receiverAddress.getAddress());
		
		 if(receiverUser == null){
			map.put("error", email + " is not registered on BitFire. Please check the email address and try again.");

			map.put("balance", addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet()).getBitcoins());

			map.put("emails", getTransactionEmails());
			map.put("user", SecurityUtils.getUser());
			return "/user/send";
			
		}
		 Address receiverAddress=addressDao.getPrimaryAddress(receiverUser.getWallet());
			Address senderAddress=addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet());
		  if(receiverAddress.getAddress().equals(senderAddress.getAddress())){
			map.put("selftranfererror", "You can not send BTC to yourself. \n If you want to transfer BTC between "
					+ "your addresses, please use the following link: ");

			map.put("balance", addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet()).getBitcoins());

			map.put("emails", getTransactionEmails());
			map.put("user", SecurityUtils.getUser());
			return "/user/send";
		}
		else if(senderAddress.getBitcoinsActual()>=(int)(btc*100000000))
		{
			try {
				Transaction trans = tranfer(senderAddress, receiverAddress, btc, reason);
				///send email
				int btcValue = (int)(btc *100000000);

				
				DecimalFormat format=new DecimalFormat("#0.00000000");
				String amount = format.format(btcValue/100000000.0);
				
				Notifications.sendSenderTranactionNotification(email, receiverUser.getName(), senderUser.getEmail(), senderUser.getName(), 
						amount, reason);
				
				Notifications.sendReceiverTranactionNotification(email, receiverUser.getName(), senderUser.getEmail(), senderUser.getName(), 
						amount, reason);
				
				trans.setNotifiedReceiver(true);
				trans.setNotifiedReceiver(true);
			} catch (APIException | IOException e) {
				map.put("error", "We were not able to transfer your BTC at this time. Please try again later.");
				e.printStackTrace();
			}
			return "redirect:/user/transactions.html";
		}


		else
		{
			map.put("error", "You don't have enough funds in your primary address " +senderAddress.getAddress());

			map.put("balance", addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet()).getBitcoins());

			map.put("emails", getTransactionEmails());
			map.put("user", SecurityUtils.getUser());
			return "/user/send";
		
		}
		
	}
	
	@RequestMapping(value ={"/user/request.html"}, method = RequestMethod.GET)
	public String send(ModelMap map){

		map.put("emails", addressBookDao.getAddressBook(SecurityUtils.getUser()));
		return "/user/request";
	}
	
	@RequestMapping(value ={"/user/request.html"}, method = RequestMethod.POST)
	public String request(@RequestParam String email, @RequestParam Double btc, @RequestParam String reason, ModelMap map) throws APIException, IOException{
		User sender = SecurityUtils.getUser();
		User receiver = userDao.getUserByEmail(email);
		int btcValue = (int)(btc *100000000);
		
//		String btcStr = btcValue * 
//		System.out.println("BTC: " + btcValue);
		
		if(receiver == null){
			map.put("error", email + " does not have a bitfire account. Please check the email address and try again.");

			map.put("emails", getTransactionEmails());
			return "user/request";
		}
		
		DecimalFormat format=new DecimalFormat("#0.00000000");
		String amount = format.format(btcValue/100000000.0);
		
		System.out.println("AMOUNT " + amount);
		
		Address receiverAddress=addressDao.getPrimaryAddress(receiver.getWallet());
		Address senderAddress=addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet());
		
		Invoice invoice= new Invoice();
//		invoice.setSenderAddress(senderAddress);
//		invoice.setReceiverAddress(receiverAddress);
		invoice.setBitcoin((int) (btc*100000000));
		invoice.setUSD((long)(ExchangeRates.getUSD()*btc*100));
		invoice.setSenderUser(SecurityUtils.getUser());
		invoice.setReceiverUser(receiverAddress.getWallet().getUser());
		invoice.setPaid(false);
		invoice.setMessage(reason);
		
		Invoice sendInvoice = transDao.saveInvoice(invoice);
		
		
		try {
			Notifications.SendInvoice(email, receiver.getName(), sender.getEmail(), sender.getName(), amount, reason, sendInvoice.getInvoiceId());
			map.put("message", "Successfully requested " + amount + " BTC from " + email);

			map.put("emails", getTransactionEmails());
		} catch (IOException e) {
			map.put("error", "We were not able to send your request at this time. Please try again");
			e.printStackTrace();
		}
		
		return "user/request";
		
	}
	
	@RequestMapping(value ={"/user/selftransfer.html"}, method = RequestMethod.GET)
	public String selftransfer(ModelMap map)
	{	
		map.put("addresses", addressDao.getAddresses(SecurityUtils.getUser().getWallet()));
		return "/user/selftransfer";
	}
	
	@RequestMapping(value ={"/user/selftransfer.html"}, method = RequestMethod.POST)
	public String selftransfer(@RequestParam int from, @RequestParam int to, @RequestParam Double amount, ModelMap map)
	{	
		
		if(from == to){
			map.put("error", "From address can not be the same as TO address");
			map.put("addresses", addressDao.getAddresses(SecurityUtils.getUser().getWallet()));
			return "/user/selftransfer";
		}
		else if(addressDao.getAddress(from).getBitcoinsActual()< (int)(amount*100000000))
		{
			System.out.println("FROM: " + addressDao.getAddress(from).getBitcoinsActual());
			System.out.println("Amount: " + (int)(amount*100000000));
			map.put("error", "You don't have enough funds in "+addressDao.getAddress(from).getAddress());
			map.put("addresses", addressDao.getAddresses(SecurityUtils.getUser().getWallet()));
			return "/user/selftransfer";
		}
		else{
			Address senderAddress=addressDao.getAddress(from);
			Address receiverAddress=addressDao.getAddress(to);
			try {
				tranfer(senderAddress,receiverAddress, amount, "Self tranfer");
			} catch (APIException | IOException e) {
				e.printStackTrace();
				map.put("error", "We were not able to transfer your BTC at thist time. Please try again later.");
				return "/user/wallet";
			}
			DecimalFormat format=new DecimalFormat("#0.00000000");
		    String actualAmount = format.format(amount);
			map.put("message", "Successfully tranferred " + actualAmount + " BTC from " + addressDao.getAddress(from).getAddress() + 
					" to " + addressDao.getAddress(to).getAddress());
			map.put("addresses", addressDao.getAddresses(SecurityUtils.getUser().getWallet()));
		}
		return "/user/wallet";
	}

	@RequestMapping(value ={"/user/transactions.html"}, method = RequestMethod.GET)
	public String transactoins(ModelMap map){
		User user  = SecurityUtils.getUser();
		
		
		for(Transaction trans: transDao.getAllTransactions(user)){
			try {
				trans.setConfirmations(Confirmations.getConfirmations(trans.getTxId()));
				transDao.saveTransaction(trans);
			} catch (APIException | IOException e) {
				System.out.println("FAILED TO FETCH THE CONFIRMATIOS");
				e.printStackTrace();
			}
		}
		
		map.put("transactions", transDao.getAllTransactions(SecurityUtils.getUser()));
		map.put("user", SecurityUtils.getUser());
		return "/user/transactions";
	}
	
	@RequestMapping(value ={"/user/invoices.html"}, method = RequestMethod.GET)
	public String invoices(ModelMap map){
		User user = SecurityUtils.getUser();
		map.put("invoices", transDao.getAllInvoices(user));
		map.put("user", user);
		return "/user/invoice";
	}
	
	@RequestMapping(value ={"/user/invoices/pay.html"}, method = RequestMethod.GET)
	public String payInvoice(ModelMap map, HttpServletRequest request){
		User user = SecurityUtils.getUser();
		if(request.getParameter("id") ==null){
			return "redirect:/user/invoices.html";
		}
		
		Invoice invoice = transDao.getInvoice(Integer.parseInt(request.getParameter("id")));
		if(invoice == null){
			System.out.println("NO SUCH INVOICE");
			return "redirect:/user/invoices.html";
		}
		
		map.put("balance", addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet()).getBitcoins());
		map.put("user", user);
		map.put("invoice", invoice);
		return "/user/invoice/pay";
	}
	
	@RequestMapping(value ={"/user/invoices/pay.html"}, method = RequestMethod.POST)
	public String payInvoice(ModelMap map, @RequestParam int id, @RequestParam String email, @RequestParam Double btc, 
			 @RequestParam String reason, RedirectAttributes attrs){
		System.out.println("Id: " + id);
		User receiverUser=userDao.getUserByEmail(email.toLowerCase());
		

		 Address receiverAddress=addressDao.getPrimaryAddress(receiverUser.getWallet());
			Address senderAddress=addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet());
			

	 if(senderAddress.getBitcoinsActual()>=(int)(btc*100000000))
		{
			try {
				
				tranfer(senderAddress, receiverAddress, btc, reason);
				Invoice invoice = transDao.getInvoice(id);
				invoice.setReceiverAddress(receiverAddress);
				invoice.setSenderAddress(senderAddress);
				invoice.setPaid(true);
				transDao.saveInvoice(invoice);
				
				
				
			} catch (APIException | IOException e) {
				map.put("error", "We were not able to transfer your BTC at this time. Please try again later.");
				e.printStackTrace();
			}
		
	}
	 
		else
		{
			attrs.addFlashAttribute("error", "You don't have enough funds in your primary address " +senderAddress.getAddress());

//			try {
//				tranfer(senderAddress, receiverAddress, btc, reason);
//				Invoice invoice = transDao.getInvoice(id);
//				invoice.setReceiverAddress(receiverAddress);
//				invoice.setSenderAddress(senderAddress);
//				invoice.setPaid(true);
//				transDao.saveInvoice(invoice);
//			} catch (APIException | IOException e) {
//				// TODO Auto-generated catch block
//				attrs.addFlashAttribute("error", "We were not able to send you invoice at this time. Pleas try again later.");
//			}
			return "redirect:/user/invoices/pay.html?id=" + id;
		
		}

	 return "/user/invoices";
	}
	
	

	private Transaction tranfer(Address senderAddress, Address receiverAddress, double btc, String reason) throws APIException, IOException{
		User user = SecurityUtils.getUser();
//		senderAddress.setBitcoins(senderAddress.getBitcoinsActual()-(int)(btc*100000000));
//		senderAddress.setUSD(senderAddress.getUSDActual()-(int)(650*btc*100));
//		addressDao.saveAddress(senderAddress);
//		
//		
//		receiverAddress.setBitcoins(receiverAddress.getBitcoinsActual()+(int)(btc*100000000));
//		receiverAddress.setUSD(receiverAddress.getUSDActual()+(int)(650*btc*100));
//		addressDao.saveAddress(receiverAddress);
    	Wallet wallet = new Wallet("http://localhost:3001/", 
		"fd592284-ed09-4910-ab9f-06129b3a4054",
		user.getWallet().getWalletId(),
		user.getPassword());
    	
    	
    	
    	System.out.println("SENDING: " + (long)(btc*100000000.0));
    	
    	PaymentResponse response =wallet.send(receiverAddress.getAddress(), (long)(btc*100000000.0), senderAddress.getAddress(), null, reason);
    	
  
    	
    	System.out.println("NOTICE " + response.getNotice());
    	
    	
		Transaction transaction= new Transaction();
		transaction.setSenderAddress(senderAddress);
		transaction.setReceiverAddress(receiverAddress);
		transaction.setBitcoin((int) (btc*100000000));
		transaction.setUSD((long)(ExchangeRates.getUSD()*btc*100));
		transaction.setSenderUser(SecurityUtils.getUser());
		transaction.setReceiverUser(receiverAddress.getWallet().getUser());
		transaction.setTxId(response.getTxHash());
		transaction.setMessage(reason);
		
	
		
		return transDao.saveTransaction(transaction);
	}
	
	public List<String> getTransactionEmails(){
		String userEmail = SecurityUtils.getUser().getEmail();
		List<Transaction> trans = transDao.getAllTransactions(SecurityUtils.getUser());
		List<String> emails = new ArrayList<>();
		for(Transaction t: trans){
			String mail =t.getReceiverUser().getEmail();
			if(!emails.contains(mail)  && !mail.equals(userEmail)){
				emails.add(mail);
			}
		}
		return emails;
	}
}
