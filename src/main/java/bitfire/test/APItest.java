package bitfire.test;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import info.blockchain.api.APIException;
import info.blockchain.api.createwallet.*;
import info.blockchain.api.exchangerates.ExchangeRates;
import info.blockchain.api.wallet.Address;
import info.blockchain.api.wallet.Wallet;

public class APItest 
{
    public static void main(String[] args) throws Exception
    {   
//    	ExchangeRates.getTicker();
    	URL obj = new URL("https://blockchain.info/latestblock");
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		//print result
		System.out.println(response.toString());
		
    	JsonObject topElem = parseResponse(response.toString());
    	System.out.println(topElem.get("height"));
//    	CreateWalletResponse wal = CreateWallet.create(
//		        "http://localhost:3000/",
//		        "Abpop31515%",
//		        "fd592284-ed09-4910-ab9f-06129b3a4054");
//    	System.out.println("Wal address: " + wal.getAddress());
//    	
//    	
//    	Wallet wallet = new Wallet("http://localhost:3000/", 
//    			"fd592284-ed09-4910-ab9f-06129b3a4054",
//    			wal.getIdentifier(),//wallet id
//    			"Abpop31515%");
//    	
//    	List<Address> addresses = wallet.listAddresses(0);
//    	for(Address add: addresses){
//    		System.out.println(add.getAddress());
//    	}
    }
    private static JsonObject parseResponse (String response) throws APIException {
    	JsonParser jsonParser = new JsonParser();
        JsonObject topElem = jsonParser.parse(response).getAsJsonObject();
        if (topElem.has("error")) {
            throw new APIException(topElem.get("error").getAsString());
        }

        return topElem;
    }
}


