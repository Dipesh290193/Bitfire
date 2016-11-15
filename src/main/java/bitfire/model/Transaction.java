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
@Table(name="transactions")
public class Transaction implements Serializable{

	private static final long serialVersionUID = 1L;

	@Column(unique=true,name="tx_id")
	String txId;
	
	@Id
	@GeneratedValue
	@Column(name="transaction_id")
	int transactionId;
	
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
	
	int confirmations;
	
	@Column(name="notified_sender")
	Boolean notifiedSender;
	
	@Column(name="notified_receiver")
	Boolean notifiedReceiver;

	@Column(name="trans_date")
	Date date;
	
	public Transaction()
	{
		date=new Date();
		confirmations=0;
		notifiedReceiver=true;
		notifiedSender=true;
	}
	
	public int getConfirmations() {
		return confirmations;
	}

	public void setConfirmations(int confirmations) {
		this.confirmations = confirmations;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	public String getTxId() {
		return txId;
	}

	public void setTxId(String txId) {
		this.txId = txId;
	}

	public int getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(int transactionId) {
		this.transactionId = transactionId;
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
