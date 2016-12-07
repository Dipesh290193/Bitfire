package bitfire.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
		return "redirect:/user/addressBook";
	}
	

	@RequestMapping(value={"/user/editAddressBook"}, method=RequestMethod.GET)
	@ResponseBody
	public  String editAddressBook(@RequestParam int addressBookId )
	{
		AddressBook addressBook = addressBookDao.getAddressBook(addressBookId);
		System.out.println("name: " + addressBook.getName());
		return addressBook.getName();
	}
	
	@RequestMapping(value={"/user/editAddressBookSave/{id}/{name}"}, method=RequestMethod.GET)
	@ResponseBody
	public AddressBook editAddressBook(@PathVariable int id, @PathVariable String name)
	{
		System.out.println("saving edit");
		AddressBook addressBook = addressBookDao.getAddressBook(id);
		addressBook.setName(name);
		addressBook = addressBookDao.saveAddressBook(addressBook);
		
		return addressBook;
	}
	
	@RequestMapping(value={"/user/deleteAddressBook/{id}"})
	@ResponseBody
	public void deleteAddressBook(@PathVariable int id)
	{
		AddressBook addressBook = addressBookDao.getAddressBook(id);
		addressBookDao.deleteAddressBook(addressBook);
	}
	
	@RequestMapping(value={"/user/address"}, method=RequestMethod.POST)
	@ResponseBody
	public AddressBook getUser(@RequestParam String name, @RequestParam String email) throws JsonProcessingException
	{
		AddressBook addressBook = new AddressBook();
		addressBook.setOwner(SecurityUtils.getUser());
		System.out.println("email is: " + email);
		User contact = userDao.getUserByEmail(email);
		if(contact ==null){
			System.out.println("NULL");
			return null;
		}

		System.out.println("contact name: " + contact.getName());
		addressBook.setContact(contact);
		addressBook.setName(name);
		addressBook = addressBookDao.saveAddressBook(addressBook);
		return addressBook;
	}
		
}
