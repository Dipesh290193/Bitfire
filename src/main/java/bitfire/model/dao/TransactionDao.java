package bitfire.model.dao;

import java.util.List;

import bitfire.model.Transaction;
import bitfire.model.User;

public interface TransactionDao {

	Transaction saveTransaction(Transaction transaction);
	
	Transaction getTransaction(int id);
		
	List<Transaction> getSenderTransacations(User user);
	
	List<Transaction> getReceiverTransacations(int receiverUserId);
	
	List<Transaction> getTransactionSenderAddress(int senderAddressId);
	
	List<Transaction> getTransactionReceiverAddress(int receiverAddressId);
	
	List<Transaction> getAllTransactions(User user);
}
