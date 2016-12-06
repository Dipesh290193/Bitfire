package bitfire.model;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.NumberFormat;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.ManyToOne;


@Entity
@Table(name="addresses")
public class Address implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name="address_id")
	int addressId;
	
	String address;
	
	String label;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="wallet_id",nullable=false)
	Wallet wallet;
	
	@Column(name="is_primary")
	boolean primary;
	
	@Column(nullable=false,columnDefinition="int default 0")
	int bitcoins;
	
	@Column(nullable=false, columnDefinition="int default 0")
	long USD;
	
	boolean archived;

	public Address()
	{
		this.bitcoins=0;
		this.USD=0;
		this.primary =false;
		this.label ="Label";
		this.archived =false;
	}
	
	public boolean isArchived() {
		return archived;
	}

	public void setArchived(boolean archived) {
		this.archived = archived;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public Wallet getWallet() {
		return wallet;
	}

	public void setWallet(Wallet wallet) {
		this.wallet = wallet;
	}

	public String getBitcoins() {
		
		DecimalFormat format=new DecimalFormat("#0.00000000");
		return format.format(bitcoins/100000000.0);
	}
	public int getBitcoinsActual() {
		return bitcoins;
	}

	public void setBitcoins(int bitcoins) {
		this.bitcoins = bitcoins;
	}

	public String getUSD() {
		
		return NumberFormat.getCurrencyInstance().format(USD/100.0);
	}
	public long getUSDActual() {
		
		return USD;
	}

	public void setUSD(long uSD) {
		USD = uSD;
	}

	public boolean isPrimary() {
		return primary;
	}

	public void setPrimary(boolean primary) {
		this.primary = primary;
	}
	
}
