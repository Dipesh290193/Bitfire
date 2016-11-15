package bitfire.util;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import bitfire.util.Confirmations;

import bitfire.model.User;
import bitfire.model.dao.AddressDao;
import bitfire.security.SecurityUtils;
import info.blockchain.api.exchangerates.ExchangeRates;
import info.blockchain.api.wallet.Wallet;

public class APIUpdate {
	
	@Autowired
	private static AddressDao addressDao;
	
	public static void updateConfirmations(){
		
		
	}
	
	public static void updateAddresses(){
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
						userAddress.setUSD(ExchangeRates.getUSD()*apiAddress.getBalance());
						addressDao.saveAddress(userAddress);
						break;
					}
				}
			}
				
		} catch (Exception e) {
		}
	}
}
