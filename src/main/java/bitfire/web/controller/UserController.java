package bitfire.web.controller;

import java.security.Security;
import java.text.DecimalFormat;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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

@Controller
@SessionAttributes(names = { "userRegister", "address", "user" })
public class UserController {

	@Autowired
	private UserDao userDao;

	@Autowired
	private WalletDao walletDao;

	@Autowired
	private AddressDao addressDao;

	@Autowired
	private TransactionDao transDao;

	@RequestMapping("/index.html")
	public String index(ModelMap map) {

		User user = SecurityUtils.getUser();
		if (user != null) {
			List<Address> addresses = addressDao.getAddresses(user.getWallet());
			map.put("user", user);
			map.put("addresses", addresses);
			int sum = 0;

			for (Address ad : addresses) {
				sum += ad.getBitcoinsActual();
			}

			DecimalFormat format = new DecimalFormat("#0.00000000");
			String total = format.format(sum / 100000000.0);

			map.put("balance", total);

			List<Transaction> transactions = transDao.getAllTransactions(user);
			Collections.reverse(transactions);
			map.put("transactions", transactions);
		}
		return "index";
	}

	@RequestMapping(value = { "/register.html" }, method = RequestMethod.GET)
	public String register(ModelMap maps) {
		maps.put("userRegister", new User());
		return "register";
	}

	@RequestMapping(value = { "/user/profile.html" }, method = RequestMethod.GET)
	public String userPanel(ModelMap map, HttpServletRequest request) {
		map.put("user", SecurityUtils.getUser());
		System.out.println("User name is: " + SecurityUtils.getUser().getName());
		return "/user/profile";
	}

	@RequestMapping(value = { "/user/profile.html" }, method = RequestMethod.POST)
	public String userPanel(ModelMap map) {
//		System.out.println("in post");
		map.put("user", SecurityUtils.getUser());
		return "redirect:/user/profile/edit.html";
	}

	@RequestMapping(value = "/user/text/confirmation.html", method = RequestMethod.GET, produces = "text/plain", headers="Accept=*/*")
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
		return "/user/profile";
	}
	


	@RequestMapping(value = { "/register.html" }, method = RequestMethod.POST)
	public String register(@ModelAttribute User user, SessionStatus status) {

		// Add wallet
		Wallet wallet = new Wallet();
		wallet.setWalletId(user.getName() + "123wallet");
		walletDao.saveWallet(wallet);

		// Add Address
		Address address = new Address();
		address.setAddress(user.getName() + "Address123");
		address.setLabel("default");
		address.setPrimary(true);
		address.setWallet(wallet);
		addressDao.saveAddress(address);

		// Add User
		user.setWallet(wallet);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:login.html";
	}
}
