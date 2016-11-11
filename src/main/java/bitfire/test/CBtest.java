package bitfire.test;

import java.io.IOException;

import com.coinbase.api.Coinbase;
import com.coinbase.api.CoinbaseBuilder;
import com.coinbase.api.entity.Account;
import com.coinbase.api.entity.Account.Type;
import com.coinbase.api.entity.AccountResponse;
import com.coinbase.api.entity.AccountsResponse;
import com.coinbase.api.entity.User;
import com.coinbase.api.exception.CoinbaseException;

public class CBtest {
	
	public static void main (String [] args) throws CoinbaseException, IOException{
	Coinbase cb = new CoinbaseBuilder()
            .withApiKey("7jm6gc73sa7AyfAM", "lexuB2MHcuOweOJpbepktzzvKoP2PQVQ")
            .build();
	Account acc = new Account();
	acc.setActive(true);
	acc.setName("dipesh123");
	acc.setType(Type.WALLET);
	cb.createAccount(acc);
	
	for(Account account : cb.getAccounts().getAccounts()){
		System.out.println(account.getId());
	}
		
	
	
	
//	Account acc = new Account();
//	System.out.println(acc.getType().WALLET.toString());
//	
//	
//	User userParams = new User();
//	userParams.setEmail("sevakmn@icloud.com");
//	userParams.setPassword("correct horse battery staple");
//	
//	User newUser = cb.createUser(userParams);
//	newUser.getEmail(); // "newuser@example.com"
//	newUser.get
	}

	
}
