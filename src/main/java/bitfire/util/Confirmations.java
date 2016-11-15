package bitfire.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import info.blockchain.api.APIException;



public class Confirmations {
	/**********Test********/
//	public static void main(String[] args) throws Exception
//	{ 
//		System.out.println(getConfirmations("41ec68e8f85ad4da82677221b5939c5d1b89a37bc8e1f8fd43a7215bfb9c01fb"));
//	}
	/**********End of Test********/
	public static int getConfirmations(String tx) throws APIException, IOException{
		String latestBlockURL = "https://blockchain.info/latestblock";
		String txURL = "https://blockchain.info/rawtx/" + tx;
		
		JsonObject element = parseResponse(getData(latestBlockURL));
		int latestBlockNumber = Integer.parseInt(element.get("height").toString());
		System.out.println(latestBlockNumber);
		
		JsonObject element2 = parseResponse(getData(txURL));
		int transactionBlockNumber = Integer.parseInt(element2.get("block_height").toString());
		System.out.println(transactionBlockNumber);
		
		return latestBlockNumber - transactionBlockNumber + 1;
	}
	

	
    private static JsonObject parseResponse (String response) throws APIException {
    	JsonParser jsonParser = new JsonParser();
        JsonObject topElem = jsonParser.parse(response).getAsJsonObject();
        if (topElem.has("error")) {
            throw new APIException(topElem.get("error").getAsString());
        }

        return topElem;
    }
    
    private static String getData(String url) throws IOException{
    	URL obj = new URL(url);
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
		return response.toString();
    }
}
