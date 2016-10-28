package bitfire.web.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

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
import bitfire.model.dao.AddressDao;
import bitfire.security.SecurityUtils;

@Controller
@SessionAttributes("address")
public class AddressController {
	
	@Autowired
	private AddressDao addressDao;
	
	@RequestMapping(value ={"/user/wallet.html"}, method = RequestMethod.GET)
	public String wallet(ModelMap maps)
	{
		maps.put("addresses",addressDao.getAddresses(SecurityUtils.getUser().getWallet()) );
		return "/user/wallet";
	}
	
	@RequestMapping(value ={"/user/addaddress.html"}, method = RequestMethod.GET)
	public String addaddress(){
		Address address = new Address();
		address.setAddress(SecurityUtils.getUser().getName().toLowerCase()+ "Address" + new Random().nextInt(10000) + 1000);
		address.setWallet(SecurityUtils.getUser().getWallet());
		addressDao.saveAddress(address);
		return "redirect:/user/wallet.html";
	}

	@RequestMapping(value ={"/user/editaddress.html"}, method = RequestMethod.GET)
	public String address(@RequestParam int id, ModelMap maps)
	{
		maps.put("address", addressDao.getAddress(id));
		return "/user/address";
	}
	
	@RequestMapping(value ={"/user/editaddress.html"}, method = RequestMethod.POST)
	public String editaddress(  @ModelAttribute Address address, HttpServletRequest request, SessionStatus status )
	{
		if(request.getParameter("primary") != null){
			System.out.println("check box value"+ request.getParameter("primary"));
			address.setPrimary(true);
			
		}
		System.out.println("label is set to: " + address.getLabel());
		addressDao.setPrimary(address, SecurityUtils.getUser().getWallet());
		
		status.isComplete();
		return "redirect:/user/wallet.html";
	}	
	
	@RequestMapping(value ={"/user/archiveaddress.html"}, method = RequestMethod.GET)
	public String archiveAddress(@RequestParam int id, ModelMap map)
	{
		Address address = addressDao.getAddress(id);
		if(address.isPrimary() || address.getBitcoinsActual() > 0 )
		{
			map.put("message", "Can't archive addresses which are primary or have a non-zero balance.");
		}
		else
		{
			address.setArchived(true);
			addressDao.saveAddress(address);
		}
		map.put("addresses",addressDao.getAddresses(SecurityUtils.getUser().getWallet()) );

		return "/user/wallet";
		
	}
	
}
