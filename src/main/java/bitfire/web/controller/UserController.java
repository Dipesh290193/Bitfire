package bitfire.web.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import java.util.Set;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import bitfire.model.Address;
import bitfire.model.Notifications;
import bitfire.model.Transaction;
import bitfire.model.User;
import bitfire.model.Wallet;
import bitfire.model.dao.AddressDao;
import bitfire.model.dao.TransactionDao;
import bitfire.model.dao.UserDao;
import bitfire.model.dao.WalletDao;
import bitfire.security.SecurityUtils;
import bitfire.util.Confirmations;
import bitfire.web.validator.UserValidator;
import info.blockchain.api.APIException;
import info.blockchain.api.createwallet.CreateWallet;
import info.blockchain.api.createwallet.CreateWalletResponse;
import info.blockchain.api.exchangerates.ExchangeRates;

@Controller
@SessionAttributes(names = { "address", "user" })
public class UserController {

	@Autowired
	private UserDao userDao;

	@Autowired
	private WalletDao walletDao;

	@Autowired
	private AddressDao addressDao;

	@Autowired
	private TransactionDao transDao;
	

	@Autowired
	private UserValidator userValidator;

	@RequestMapping(value = { "/register.html" }, method = RequestMethod.GET)
	public String register(ModelMap maps) {
		maps.put("user", new User());
		return "register";
	}
	
	@RequestMapping(value = { "/register.html" }, method = RequestMethod.POST)
	public String register(@ModelAttribute User user, @RequestParam(value="re-password") String password, 
			SessionStatus status, BindingResult result, ModelMap map) {
		
		userValidator.setPassword(password);
		userValidator.setUserDao(userDao);
		userValidator.validate(user, result);
		
		if(result.hasErrors()){
			map.put("errors", true);
			return "register";
		}
		
		// Add wallet
		Wallet wallet = new Wallet();
		CreateWalletResponse wal;
		try {
			 wal = CreateWallet.create(
			        "http://localhost:3000/",
			        user.getPassword(),
			        "fd592284-ed09-4910-ab9f-06129b3a4054");
		} catch (Exception e) {
			map.put("error", "Something went wrong. Please try again.");
			return "register";		
		}
		wallet.setWalletId(wal.getIdentifier());
		
		

		walletDao.saveWallet(wallet);

		// Add Address
		Address address = new Address();
		address.setAddress(wal.getAddress());
		address.setLabel("Label");
		address.setPrimary(true);
		address.setWallet(wallet);
		addressDao.saveAddress(address);

		Set<String> roles=new HashSet<String>();
		roles.add(User.ROLE_USER);

		// Add User
		user.setWallet(wallet);
		user.setRoles(roles);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:login.html";
	}


	@RequestMapping("/index.html")
	public String index(ModelMap map) {

		User user = SecurityUtils.getUser();
		
		
		for(Transaction trans: transDao.getAllTransactions(user)){
			try {
				trans.setConfirmations(Confirmations.getConfirmations(trans.getTxId()));
				transDao.saveTransaction(trans);
			} catch (APIException | IOException e) {
				System.out.println("FAILED TO FETCH THE CONFIRMATIOS");
				e.printStackTrace();
			}
		}
		
		if (user != null) {
			List<Address> addresses = addressDao.getAddresses(user.getWallet());
			map.put("user", user);
			map.put("addresses", addresses);
//			int sum = 0;
//
//			for (Address ad : addresses) {
//				sum += ad.getBitcoinsActual();
//			}
//
//
//			DecimalFormat format = new DecimalFormat("#0.00000000");
//			String total = format.format(sum / 100000000.0);
			info.blockchain.api.wallet.Wallet wallet = new info.blockchain.api.wallet.Wallet("http://localhost:3001/", 
					"fd592284-ed09-4910-ab9f-06129b3a4054",
	    			user.getWallet().getWalletId(),
	    			user.getPassword());
			
			DecimalFormat format = new DecimalFormat("#0.00000000");
			String total = null;
			try {
				total = format.format(wallet.getBalance() / 100000000.0);
			} catch (APIException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			bitfire.model.Wallet userWallet = user.getWallet();

			Set<bitfire.model.Address> userAddresses = new HashSet<bitfire.model.Address>(addressDao.getAddresses(userWallet));

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
			
			
			
			
			map.put("balance", total);

			List<Transaction> transactions = transDao.getAllTransactions(user);
			Collections.reverse(transactions);
			map.put("transactions", transactions);
		}
		return "index";
	}
	
	@RequestMapping(value = { "/reset.html" }, method = RequestMethod.POST)
	public String passwordResetConfirm(ModelMap maps, @RequestParam String password1, @RequestParam String password2, @RequestParam String token,
			HttpServletRequest request) {
		if(!password1.equals(password2) && password1 != null && password2 !=null && !password1.isEmpty() && !password2.isEmpty()){
			System.err.println("Passwords do NOT match");
			maps.put("error", "Two passwords do not match. Please try again.");
			return "redirect:" + request.getHeader("Referer");
		}
		
		for(String key: Notifications.securityTokens.keySet()){
			System.out.println(key + " : " + Notifications.securityTokens.get(key));
		}
		
		String email = Notifications.securityTokens.get(token);

		User user = userDao.getUserByEmail(email);
		user.setPassword(password1);
		userDao.saveUser(user);
		maps.put("message", "You password has successfully been reset. You can now log in.");
		for(String key: Notifications.securityTokens.keySet()){
			if(Notifications.securityTokens.get(key).equals(email)){
				Notifications.securityTokens.remove(key);
			}
		}
		
		return "login";
	}
	
	@RequestMapping(value = { "/passwordreset.html" }, method = RequestMethod.POST)
	public String passwordReset(ModelMap maps, @RequestParam String email) {
		User user = userDao.getUserByEmail(email);
		if(user == null){
			maps.put("error", "We could not find user " + email + " in our records. Please check your email address and try again.");
			return "login";
		}
		maps.put("message", "We just sent instructions on how to reset your password to " + email);
		String securityToken = UUID.randomUUID().toString().replaceAll("\\-","" );
		try {
			Notifications.SendPasswordResetLink(email, userDao.getUserByEmail(email).getName(), securityToken);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "login";
	}
	
	@RequestMapping(value = { "/passwordreset.html" }, method = RequestMethod.GET)
	public String passwordReset(HttpServletRequest request, ModelMap map) {
		if(request.getParameter("token") == null){
			System.out.println("no parameter token");
			return "login";
		}
		if(!Notifications.securityTokens.containsKey(request.getParameter("token"))){
			System.out.println("didnt find token on hashmap");
			return "login";
		}
		return "passwordreset";
	}


	@RequestMapping(value = { "/user/profile.html" }, method = RequestMethod.GET)
	public String userPanel(ModelMap map, HttpServletRequest request) {
		map.put("user", SecurityUtils.getUser());
		return "/user/profile";
	}

	@RequestMapping(value = { "/user/profile.html" }, method = RequestMethod.POST)
	public String userPanel(ModelMap map) {
//		System.out.println("in post");
		map.put("user", SecurityUtils.getUser());
		return "redirect:/user/profile/edit.html";
	}

	@RequestMapping(value = "/user/text/confirmation.html", method = RequestMethod.GET,
			produces = "text/plain", headers="Accept=*/*")
	public @ResponseBody String getConfirmatino(@RequestParam String code) {
//		System.out.println("Got value: " + code);
		User user = SecurityUtils.getUser();
		String phone = user.getPhone();
		
		try{
			Integer.parseInt(code);
		}catch(NumberFormatException e){
			return "Wrong confirmation number. Please try again.";
		}
		if((Notifications.codes.get(phone) != null)){
			if(Notifications.codes.get(phone) == Integer.parseInt(code)){
				Notifications.codes.remove(phone);
				return "success";
			}
		}
	
			return "Wrong confirmation number. Please try again.";
		
	
	}
	
	@RequestMapping(value = "/user/text/confirmation.html", method = RequestMethod.POST, produces = "text/plain", headers="Accept=*/*")
	public @ResponseBody String sendConfirmatino() {	
		System.out.println("Sending message to phone");
		
		Notifications.sendConfirmationNumber(SecurityUtils.getUser().getPhone(), new Random().nextInt(9000) + 1000);
		return "success";
	}

	@RequestMapping(value = { "/user/profile/edit.html" }, method = RequestMethod.GET)
	public String editProfile(ModelMap map, HttpServletRequest request) {
		map.put("user", SecurityUtils.getUser());
		return "/user/profile/edit";
	}
	
	@RequestMapping(value = { "/user/profile/edit.html" }, method = RequestMethod.POST)
	public String editProfile(@ModelAttribute User user, SessionStatus status, ModelMap map) {
//		System.out.println("EDIt profile post");
		userDao.saveUser(user);
		map.put("message", "Successfully updated your profile.");
		status.setComplete();
		return "redirect:/user/profile.html";
	}
	




	
	@RequestMapping(value={"/admin/users"}, method=RequestMethod.GET)
	public String geUsers(ModelMap map)
	{
		List<User> users=userDao.getAllUsers();
		User currentUser=SecurityUtils.getUser();
		for(int i=0;i<users.size();i++)
		{
			if(users.get(i).getUserId()==currentUser.getUserId())
			{
				users.remove(i);
			}
		}
		map.put("users",users);
		return "/admin/users";
	}
	
	@RequestMapping("/admin/disableUser")
	public String disableUser(@RequestParam int id)
	{
		User user=userDao.getUser(id);
		user.setEnabled(false);
		userDao.saveUser(user);
		return "redirect:/admin/users.html";
	}
	
	@RequestMapping("/admin/enableUser")
	public String enableUser(@RequestParam int id)
	{
		User user=userDao.getUser(id);
		user.setEnabled(true);
		userDao.saveUser(user);
		return "redirect:/admin/users.html";
	}
	
	@RequestMapping("/admin/makeAdmin")
	public String makeAdmin(@RequestParam int id)
	{
		User user=userDao.getUser(id);
		Set<String> role=new HashSet<String>();
		role.add(User.ROLE_ADMIN);
		user.setRoles(role);
		userDao.saveUser(user);
		return "redirect:/admin/users.html";
	}
	
	@RequestMapping("/admin/makeUser")
	public String makeUser(@RequestParam int id)
	{
		User user=userDao.getUser(id);
		Set<String> role=new HashSet<String>();
		role.add(User.ROLE_USER);
		user.setRoles(role);
		userDao.saveUser(user);
		return "redirect:/admin/users.html";
	}
}
