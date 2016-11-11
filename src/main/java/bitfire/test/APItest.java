package bitfire.test;
import java.util.List;

import info.blockchain.api.createwallet.*;
import info.blockchain.api.wallet.Address;
import info.blockchain.api.wallet.Wallet;

public class APItest 
{
    public static void main(String[] args) throws Exception
    {   
    	Wallet wallet = new Wallet("http://localhost:3000/", 
    			"fd592284-ed09-4910-ab9f-06129b3a4054",
    			"40372232-9072-46a4-8f0c-a3590b786cb6",//wallet id
    			"Abpop31515%");
    	
    	List<Address> addresses = wallet.listAddresses(0);
    	for(Address add: addresses){
    		System.out.println(add.getAddress());
    	}
    }
}


