package bitfire.model;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="invoices")
public class Invoice implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name="invoice_id")
	int invoiceId;
	
	@OneToOne
	@JoinColumn(name="sender_address_id")
	Address senderAddress;
	
	@OneToOne
	@JoinColumn(name="receiver_address_id")
	Address receiverAddress;
	
	@OneToOne
	@JoinColumn(name="sender_user_id")
	User senderUser;
	
	@OneToOne
	@JoinColumn(name="receiver_user_id")
	User receiverUser;
	
	long USD;
	
	int bitcoin;
	
	boolean paid;
	
	String message;
	
	
	public int getInvoiceId() {
		return invoiceId;
	}


	public void setInvoiceId(int invoiceId) {
		this.invoiceId = invoiceId;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public boolean isPaid() {
		return paid;
	}


	public void setPaid(boolean paid) {
		this.paid = paid;
	}

	@Column(name="notified_sender")
	Boolean notifiedSender;
	
	@Column(name="notified_receiver")
	Boolean notifiedReceiver;

	@Column(name="invoice_date")
	Date date;
	
	public Invoice()
	{
		date=new Date();
		notifiedReceiver=true;
		notifiedSender=true;
		paid = false;
	}
	

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	

	public int getTransactionId() {
		return invoiceId;
	}

	public void setTransactionId(int invoiceId) {
		this.invoiceId = invoiceId;
	}

	public String getUSD() {
		
		return NumberFormat.getCurrencyInstance().format(USD/100.0);
	}

	public void setUSD(long uSD) {
		USD = uSD;
	}

	public String getBitcoin() {
		
		DecimalFormat format=new DecimalFormat("#0.00000000");
		return format.format(bitcoin/100000000.0);
	}

	public void setBitcoin(int bitcoin) {
		this.bitcoin = bitcoin;
	}

	public Address getSenderAddress() {
		return senderAddress;
	}

	public void setSenderAddress(Address senderAddress) {
		this.senderAddress = senderAddress;
	}

	public Address getReceiverAddress() {
		return receiverAddress;
	}

	public void setReceiverAddress(Address receiverAddress) {
		this.receiverAddress = receiverAddress;
	}

	public Boolean getNotifiedSender() {
		return notifiedSender;
	}

	public void setNotifiedSender(Boolean notifiedSender) {
		this.notifiedSender = notifiedSender;
	}

	public Boolean getNotifiedReceiver() {
		return notifiedReceiver;
	}

	public void setNotifiedReceiver(Boolean notifiedReceiver) {
		this.notifiedReceiver = notifiedReceiver;
	}

	public User getSenderUser() {
		return senderUser;
	}

	public void setSenderUser(User senderUser) {
		this.senderUser = senderUser;
	}

	public User getReceiverUser() {
		return receiverUser;
	}

	public void setReceiverUser(User receiverUser) {
		this.receiverUser = receiverUser;
	}

}
