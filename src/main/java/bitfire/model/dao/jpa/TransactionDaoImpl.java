package bitfire.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import bitfire.model.Transaction;
import bitfire.model.User;
import bitfire.model.dao.TransactionDao;

@Repository
public class TransactionDaoImpl implements TransactionDao{

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	@Transactional
	public Transaction saveTransaction(Transaction transaction) {
		return entityManager.merge(transaction);

	}

	@Override
	public Transaction getTransaction(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Transaction> getSenderTransacations(User user) {
//		return entityManager.createQuery("from Transactions where senderUser = :sender", Transaction.class)
//				.setParameter("sender", user)
//				.getResultList();
		return null;
	}

	@Override
	public List<Transaction> getReceiverTransacations(int receiverUserId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Transaction> getTransactionSenderAddress(int senderAddressId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Transaction> getTransactionReceiverAddress(int receiverAddressId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Transaction> getAllTransactions(User user) {
		return entityManager.createQuery("from Transaction where senderUser = :sender or receiverUser = :receiver", Transaction.class)
		.setParameter("sender", user)
		.setParameter("receiver", user)
		.getResultList();

	}
	
	
	
}
