package bitfire.model;

import com.sendgrid.*;
import java.io.IOException;

public class Notifications {

//	public static void main(String [] args){
//		System.getenv("SendGridKey");
//		try {
//			SendEmail("savoyvv@outlook.com", "Sevak", "dipesh@gmail.com", "Dipesh", "0.125", 
//					"http://www.ebay.com/itm/HP-DeskJet-2132-All-in-One-Color-Inkjet-Photo-Printer"
//					+ "-Copier-and-Scanner-/351873190667?_trkparms=5373%3A0%7C5374%3AFeatured");
//		} catch (IOException e) {
//			
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}

  public static void SendEmail(String toEmail, String toName, String fromEmail, String fromName, String amount, String reason) throws IOException {
    Email from = new Email("noreply@bitfire.com");
    String subject = "Invoice from " + fromName;
    Email to = new Email(toEmail);
    Content content = new Content();
    content.setType("text/html");
    content.setValue("<html> <body> <h1>Dear " + toName + "</h1>"
    		+ "<p>" + fromName + " has requested " + amount + " BTC from you for the following product/service.</p> "
    				+ "<p>Product/service: " + reason + "</p>"
    				+ "<p>If you want to pay for this product/service now, please click the following link below.</p>"
    				+ "<p><a href = 'http://localhost:8080/bitfire/user/send.html"
    				+ "?to=" + fromEmail + "&amount=" + amount + "'>Pay</a></p>"
    				+ "</body> </html>");
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