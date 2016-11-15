package bitfire.web.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import bitfire.model.User;
import bitfire.model.dao.AddressDao;
import bitfire.security.SecurityUtils;
import info.blockchain.api.APIException;
import info.blockchain.api.exchangerates.ExchangeRates;
import info.blockchain.api.wallet.Wallet;

@Controller
@SessionAttributes("address")
public class AddressController {
	
	@Autowired
	private AddressDao addressDao;
	
	@RequestMapping(value ={"/user/wallet.html"}, method = RequestMethod.GET)
	public String wallet(ModelMap maps)
	{
//		APIUpdate.updateAddresses();
		
		User user = SecurityUtils.getUser();
		
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
		maps.put("addresses",addressDao.getAddresses(SecurityUtils.getUser().getWallet()) );
		return "/user/wallet";
	}
	
	@RequestMapping(value ={"/user/addaddress.html"}, method = RequestMethod.GET)
	public String addaddress(ModelMap map){
		User user = SecurityUtils.getUser();
		Address address = new Address();
		
    	Wallet wallet = new Wallet("http://localhost:3000/", 
		"fd592284-ed09-4910-ab9f-06129b3a4054",
		user.getWallet().getWalletId(),
		user.getPassword());
    	
    	try {
			
			address.setAddress(wallet.newAddress("Label").getAddress());
			address.setWallet(SecurityUtils.getUser().getWallet());
			addressDao.saveAddress(address);
		} catch (APIException | IOException e) {
			e.printStackTrace();
			map.put("error", "We were not able to genereate a new address at this time. Pleaset try again later");
			return "redirect:/user/wallet.html";
			
		}
    	
		
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
