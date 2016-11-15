package bitfire.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bitfire.model.AddressBook;
import bitfire.model.User;
import bitfire.model.dao.AddressBookDao;
import bitfire.model.dao.UserDao;
import bitfire.security.SecurityUtils;

@Controller
public class AddressBookController {

	@Autowired
	private AddressBookDao addressBookDao;
	
	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value={"/user/addressBook"})
	public String addressBook(ModelMap map)
	{
		map.put("contacts", addressBookDao.getAddressBook(SecurityUtils.getUser()));
		return "/user/addressBook";
	}
	
	@RequestMapping(value={"/user/addAddressBook"}, method=RequestMethod.POST)
	public String addAddressBook(ModelMap map,@RequestParam String name, @RequestParam String email, RedirectAttributes redirAtt)
	{
		List<AddressBook> contacts=addressBookDao.getAddressBook(SecurityUtils.getUser());
		
		Map<Integer, String> contact=new HashMap<Integer, String>();
		if(contacts != null){
		for(AddressBook addressBook : contacts)
		{
			contact.put(addressBook.getContact().getUserId(), addressBook.getName().toLowerCase());
		}}
		User user= userDao.getUserByEmail(email);
		if(name.trim().equals("") || name.trim().equals(null) || contact.values().contains(name.toLowerCase()))
		{
			redirAtt.addFlashAttribute("error","name already exists" );
		}
		else if(user ==null || user.getUserId() == SecurityUtils.getUser().getUserId() || contact.containsKey(user.getUserId()))
		{
			redirAtt.addFlashAttribute("error","email not valid or email is already in the contact");
		}
		else
		{
			AddressBook addressBook = new AddressBook();
			addressBook.setContact(user);
			addressBook.setName(name);
			addressBook.setOwner(SecurityUtils.getUser());
			addressBookDao.saveAddressBook(addressBook);
			redirAtt.addFlashAttribute("success","Successfully added");
		}
		return "redirect:/user/addressBook.html";
	}
	

	@RequestMapping(value={"/user/editAddressBook"}, method=RequestMethod.GET)
	@ResponseBody
	public  String editAddressBook(@RequestParam int addressBookId )
	{
		AddressBook addressBook = addressBookDao.getAddressBook(addressBookId);
		return addressBook.getName();
	}
	
	@RequestMapping(value={"/user/editAddressBook"}, method=RequestMethod.POST)
	public String editAddressBook(@RequestParam int id, @RequestParam String name)
	{
		AddressBook addressBook = addressBookDao.getAddressBook(id);
		addressBook.setName(name);
		addressBookDao.saveAddressBook(addressBook);
		return "redirect:/user/addressBook.html";
	}
	
	@RequestMapping(value={"/user/deleteAddressBook"})
	public String deleteAddressBook(@RequestParam int id)
	{
		AddressBook addressBook = addressBookDao.getAddressBook(id);
		addressBookDao.deleteAddressBook(addressBook);
		return "redirect:/user/addressBook.html";
	}
		
}
