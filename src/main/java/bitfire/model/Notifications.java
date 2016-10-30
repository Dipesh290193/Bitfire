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

	 public static void main(String [] args){
	// sendMessage("8186011574", "hi");
	//
	// System.getenv("SendGridKey");
	 try {
	 SendEmail("smnatsa2@calstatela.edu", "Sevak", "dipesh@gmail.com", "Dipesh",
	 "0.125",
	 "http://www.ebay.com/itm/HP-DeskJet-2132-All-in-One-Color-Inkjet-Photo-Printer"
	 +
	 "-Copier-and-Scanner-/351873190667?_trkparms=5373%3A0%7C5374%3AFeatured");
	 } catch (IOException e) {
	
	 // TODO Auto-generated catch block
	 e.printStackTrace();
	 }
	 }

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
		content.setValue(
				"<html>"
				+ "<body style = 'background: rgb(87,159,160);border-radius: 10px; color: #000000'>"
				+ "		<div style = 'margin: 5px; padding: 20px;'>"
				+ "			<div>"
				+ "				<img src='https://www.emergencyreporting.com/wp-content/uploads/2015/03/Fire.png' alt='' style='width: 50px; height: 50px; display: inline-block;'>"
				+ "				<h1 style = \"font-family: monospace; display: inline-block; font-size: 35px;\">"
				+ "					<span style = 'color: rgb(139,0,0);'>BIT</span><span style='color: rgb(255,255,255);'>FIRE</span>"
				+ "				</h1>"
				+ "			</div>"
				+ "			<div style = 'border: 1px solid #AAAAAA; border-radius: 25px; background: rgb(255,255,255)'>"
				+ "				<div style = 'padding: 50px'>"
				+ "					<h1 style = 'border-bottom: 2px solid #999999;'><strong>You've received an invoice</strong></h1>"
				+ "					<h3>Dear " + toName + ",</h3>" 
				+ "					<p>" + fromName + " has requested " + amount + "BTC from you for the following product/service.</p> " 
				+ "					<div style = 'padding: 5px 25px; border-radius: 5px; background: rgb(255,250,205)'>"				
				+ "						<p><strong>Product/service:<strong><p>" 
				+ "						<p>"+ reason + "</p>"
				+ "						<p>If you want to pay for this product/service now, please click the following link below.</p>"
				+ "					</div>"
				+ "					<a style='display: block;max-width: 100px; color: #ffffff;background: rgb(247,97,22); padding: 10px 15px; margin-top:10px; border-radius: 5px; text-decoration: none; text-align:center; font-weight:bold;' href = 'http://localhost:8080/bitfire/user/send.html" + "?to=" + fromEmail + "&amount=" + amount + "'>Pay</a><br>"
				+ "					<p>Sincerely,</p>"
				+ "					<p>&nbsp;&nbsp;&nbsp;&nbsp;Bitfire</p>"
				+ "				</div>" 
				+ "			</div>"
				+ "		</div>"
				+ "</body> "
				+ "</html>");
		Mail mail = new Mail(from, subject, to, content);

		SendGrid sg = new SendGrid(System.getenv("SendGridKey"));

		//SendGrid sg = new SendGrid("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");

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