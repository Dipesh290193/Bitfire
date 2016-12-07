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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
public class AddressController {

	@Autowired
	private AddressDao addressDao;

	@RequestMapping(value = { "/user/wallet" }, method = RequestMethod.GET)
	public String wallet(ModelMap maps) {
		// APIUpdate.updateAddresses();

		User user = SecurityUtils.getUser();

		bitfire.model.Wallet userWallet = user.getWallet();
		System.out.println("WALLET: " + userWallet.getWalletId());
		Set<bitfire.model.Address> userAddresses = new HashSet<bitfire.model.Address>(
				addressDao.getAddresses(userWallet));

		Wallet wallet = new Wallet("http://localhost:3000/", "fd592284-ed09-4910-ab9f-06129b3a4054",
				user.getWallet().getWalletId(), user.getPassword());

		List<info.blockchain.api.wallet.Address> apiAddresses;
		try {
			apiAddresses = wallet.listAddresses(0);

			for (info.blockchain.api.wallet.Address apiAddress : apiAddresses) {
				for (bitfire.model.Address userAddress : userAddresses) {
					if (userAddress.getAddress().equals(apiAddress.getAddress())) {
						userAddress.setBitcoins((int) apiAddress.getBalance());
						userAddress.setUSD((long) (100.0 * (ExchangeRates.getUSD() * 1.0)
								* (apiAddress.getBalance() / 100000000.0)));
						System.out.println("ADDRESS BALANE: "
								+ 100.0 * ((ExchangeRates.getUSD() * 1.0) * (apiAddress.getBalance() / 100000000.0)));
						addressDao.saveAddress(userAddress);
						break;
					}
				}
			}

		} catch (Exception e) {
		}
		maps.put("addresses", addressDao.getAddresses(SecurityUtils.getUser().getWallet()));
		return "/user/wallet";
	}

	@RequestMapping(value = { "/user/addaddress" }, method = RequestMethod.GET)
	@ResponseBody
	public Address getUser() {
		User user = SecurityUtils.getUser();
		Address address = new Address();
		Address newAddres = new Address();
		Wallet wallet = new Wallet("http://localhost:3000/", "fd592284-ed09-4910-ab9f-06129b3a4054",
				user.getWallet().getWalletId(), user.getPassword());

		try {

			address.setAddress(wallet.newAddress("Label").getAddress());
			address.setWallet(SecurityUtils.getUser().getWallet());
			newAddres = addressDao.saveAddress(address);
		} catch (APIException | IOException e) {
			e.printStackTrace();
			// map.put("error", "We were not able to genereate a new address at
			// this time. Pleaset try again later");
			// return "redirect:/user/wallet";

		}

		System.out.println("IS IS " + newAddres.getUSD());

		return newAddres;
	}

	@RequestMapping(value = { "/user/editaddress/{id}" }, method = RequestMethod.GET)
	@ResponseBody
	public Address address(@PathVariable int id) {
		System.out.println("usd: " + addressDao.getAddress(id).getUSD());
		return addressDao.getAddress(id);
	}

	@RequestMapping(value ={"/user/editaddress/{id}/{label}/{primary}"}, method = RequestMethod.POST)
	@ResponseBody
	public Address editaddress(@PathVariable int id, @PathVariable String label, @PathVariable String primary)
	{
		System.out.println("GOt primary: " + primary);
		Address address = addressDao.getAddress(id);
		if(address != null){
			if(primary.equals("true")){
				
				address.setPrimary(true);
				System.out.println("now its: " + address.isPrimary());
				Address oldPrimary = addressDao.getPrimaryAddress(SecurityUtils.getUser().getWallet());
				
//				addressDao.setPrimary(address, SecurityUtils.getUser().getWallet());
				if(!oldPrimary.getAddress().equals(address.getAddress())){
					oldPrimary.setPrimary(false);
					addressDao.saveAddress(oldPrimary);
				}
				
			}
			
			
			address.setLabel(label);
			
			
			System.out.println("address info: " + address.getLabel() + " | " + address.isPrimary());
			
			address = addressDao.saveAddress(address);

			
			return address;
		}
		else
			return null;
	}	
	
	@RequestMapping(value ={"/user/archiveaddress/{id}"}, method = RequestMethod.GET)
	@ResponseBody
	public String archiveAddress(@PathVariable int id)
	{
		Address address = addressDao.getAddress(id);
		if(address.isPrimary() || address.getBitcoinsActual() > 0 )
		{
			return  "Can't archive addresses which are primary or have a non-zero balance.";
		}
		else
		{
			address.setArchived(true);
			addressDao.saveAddress(address);
			return "OK";
		}
		

		
	}
}
