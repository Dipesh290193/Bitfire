package bitfire.web.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import bitfire.model.Address;
import bitfire.model.Transaction;
import bitfire.model.User;
import bitfire.model.Wallet;
import bitfire.model.dao.AddressDao;
import bitfire.model.dao.TransactionDao;
import bitfire.model.dao.UserDao;
import bitfire.model.dao.WalletDao;
import bitfire.security.SecurityUtils;

@Controller
@SessionAttributes(names={"userRegister","address"})
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
	public String index(ModelMap map)
	{
		
		User user = SecurityUtils.getUser();
		if(user != null){
			List<Address> addresses = addressDao.getAddresses(user.getWallet());
			map.put("user", user);
			map.put("addresses", addresses);
			int sum =0;
			
			for(Address ad: addresses){
				sum +=ad.getBitcoinsActual();
			}
			DecimalFormat format=new DecimalFormat("#0.00000000");
			String total = format.format(sum/100000000.0);
			
			map.put("balance", total);
			
			List<Transaction> transactions= transDao.getAllTransactions(user);
			Collections.reverse(transactions);
			map.put("transactions", transactions);
		}
		return "index";
	}
	
	@RequestMapping(value={"/register.html"}, method=RequestMethod.GET)
	public String register(ModelMap maps){
		maps.put("userRegister", new User());
		return "register";
	}
	
	@RequestMapping(value={"/register.html"}, method=RequestMethod.POST)
	public String register(@ModelAttribute User user,SessionStatus status){
		
		//Add wallet
		Wallet wallet=new Wallet();
		wallet.setWalletId(user.getName()+"123wallet");
		walletDao.saveWallet(wallet);
		
		//Add Address
		Address address=new Address();
		address.setAddress(user.getName()+"Address123");
		address.setLabel("default");
		address.setPrimary(true);
		address.setWallet(wallet);
		addressDao.saveAddress(address);
		
		//Add User
		user.setWallet(wallet);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:login.html";
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
