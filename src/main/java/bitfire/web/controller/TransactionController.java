package bitfire.web.controller;

import java.io.IOException;
import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import bitfire.model.Address;
import bitfire.model.Notifications;
import bitfire.model.Transaction;
import bitfire.model.User;
import bitfire.model.dao.AddressDao;
import bitfire.model.dao.TransactionDao;
import bitfire.model.dao.UserDao;
import bitfire.security.SecurityUtils;

@Controller
public class TransactionController {

	@Autowired
	private TransactionDao transDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private AddressDao addressDao;
	
	@RequestMapping(value ={"/user/send.html"}, method = RequestMethod.GET)
	public String send(ModelMap map, HttpServletRequest request){
		if(request.getParameter("to") != null)
			map.put("to", request.getParameter("to"));
		if(request.getParameter("amount") != null)
			map.put("amount", request.getParameter("amount"));
		return "/user/send";
	}
	
	@RequestMapping(value ={"/user/send.html"}, method = RequestMethod.POST)
	public String send(@RequestParam String email, @RequestParam Double btc, ModelMap map){
		User receiverUser=userDao.getUserByUsername(email);
		Address receiverAddress=addressDao.getPrimaryAddress(receiverUser.getWallet());
		Address senderAddress=addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet());
		if(senderAddress.getBitcoinsActual()>=(int)(btc*100000000))
		{
			tranfer(senderAddress, receiverAddress, btc);
			return "redirect:/user/transactions.html";
		}
		else if(receiverAddress == null){
			map.put("error", "Invalid email addres.");
			return "/user/send";
		}
		else if(receiverAddress.getAddress().equals(senderAddress.getAddress())){
			map.put("selftranfererror", "You can not send BTC to yourself. \n If you want to transfer BTC between "
					+ "you addresses, please use the following link: ");
			return "/user/send";
		}
		else
		{
			map.put("error", "You don't have enough funds in your primary address " +senderAddress.getAddress());
			return "/user/send";
		}
		
	}
	
	@RequestMapping(value ={"/user/request.html"}, method = RequestMethod.GET)
	public String send(){
		return "/user/request";
	}
	
	@RequestMapping(value ={"/user/request.html"}, method = RequestMethod.POST)
	public String request(@RequestParam String email, @RequestParam Double btc, @RequestParam String reason, ModelMap map){
		User sender = SecurityUtils.getUser();
		User receiver = userDao.getUserByEmail(email);
		
		if(receiver == null){
			map.put("error", email + " does not have a bitfire account. Please check the email address and try again.");
			return "user/request";
		}
		
//		DecimalFormat format=new DecimalFormat("#0.00000000");
//		String amount = format.format(btc/100000000.0);
		
		try {
			Notifications.SendEmail(email, receiver.getName(), sender.getUsername(), sender.getName(), btc.toString(), reason);
			map.put("message", "Successfully requested " + btc.toString() + " BTC from " + email);
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
			tranfer(senderAddress,receiverAddress, amount);
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
		map.put("transactions", transDao.getAllTransactions(SecurityUtils.getUser()));
		map.put("user", SecurityUtils.getUser());
		return "/user/transactions";
	}

	private void tranfer(Address senderAddress, Address receiverAddress, double btc ){
		
		senderAddress.setBitcoins(senderAddress.getBitcoinsActual()-(int)(btc*100000000));
		senderAddress.setUSD(senderAddress.getUSDActual()-(int)(650*btc*100));
		addressDao.saveAddress(senderAddress);
		
		
		receiverAddress.setBitcoins(receiverAddress.getBitcoinsActual()+(int)(btc*100000000));
		receiverAddress.setUSD(receiverAddress.getUSDActual()+(int)(650*btc*100));
		addressDao.saveAddress(receiverAddress);
		
		Transaction transaction= new Transaction();
		transaction.setSenderAddress(senderAddress);
		transaction.setReceiverAddress(receiverAddress);
		transaction.setBitcoin((int) (btc*100000000));
		transaction.setUSD((int)(650*btc*100));
		transaction.setSenderUser(SecurityUtils.getUser());
		transaction.setReceiverUser(receiverAddress.getWallet().getUser());
		transaction.setTxId("trans"+Math.random());
		transDao.saveTransaction(transaction);
	}
}
