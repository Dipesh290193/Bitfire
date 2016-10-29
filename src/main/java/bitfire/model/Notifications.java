package bitfire.model;

import com.sendgrid.*;

import java.io.IOException;
import java.util.HashMap;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

public class Notifications {
	public static final String ACCOUNT_SID = "AC72952a9a62e7905e896f6b9c590f13ed";
	public static final String AUTH_TOKEN = "d740460509fd1ad9e754a7977923f1af";
	public static final String MY_NUMBER = "+18182104092";
	
	public static HashMap<String, Integer> codes= new HashMap<>();

	/***************************** TEST ***********************************************/
	// public static void main(String [] args){
	// sendMessage("8186011574", "hi");
	//
	// System.getenv("SendGridKey");
	// try {
	// SendEmail("savoyvv@outlook.com", "Sevak", "dipesh@gmail.com", "Dipesh",
	// "0.125",
	// "http://www.ebay.com/itm/HP-DeskJet-2132-All-in-One-Color-Inkjet-Photo-Printer"
	// +
	// "-Copier-and-Scanner-/351873190667?_trkparms=5373%3A0%7C5374%3AFeatured");
	// } catch (IOException e) {
	//
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// }

	/****************************** END OF TEST******************************************/
	
	public static void sendConfirmationNumber(String to, Integer code) {
		System.out.println("Sent code: " + code);
		sendMessage(to, "Your BitFire confirmation number is " + code);
		codes.put(to, code);
	}

	public static void sendMessage(String to, String text) {
		Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
		Message message = Message.creator(new PhoneNumber(to), new PhoneNumber(MY_NUMBER), text).create();
		
	}

	public static void SendEmail(String toEmail, String toName, String fromEmail, String fromName, String amount,
			String reason) throws IOException {
		Email from = new Email("noreply@bitfire.com");
		String subject = "Invoice from " + fromName;
		Email to = new Email(toEmail);
		Content content = new Content();
		content.setType("text/html");
		content.setValue("<html> <body> <h1>Dear " + toName + "</h1>" + "<p>" + fromName + " has requested " + amount
				+ " BTC from you for the following product/service.</p> " + "<p>Product/service: " + reason + "</p>"
				+ "<p>If you want to pay for this product/service now, please click the following link below.</p>"
				+ "<p><a href = 'http://localhost:8080/bitfire/user/send.html" + "?to=" + fromEmail + "&amount="
				+ amount + "'>Pay</a></p>" + "</body> </html>");
		Mail mail = new Mail(from, subject, to, content);

		SendGrid sg = new SendGrid("SendGridKey");
		Request request = new Request();
		try {
			request.method = Method.POST;
			request.endpoint = "mail/send";
			request.body = mail.build();
			Response response = sg.api(request);
			System.out.println(response.statusCode);
			System.out.println(response.body);
			System.out.println(response.headers);
		} catch (IOException ex) {
			throw ex;
		}
	}
}