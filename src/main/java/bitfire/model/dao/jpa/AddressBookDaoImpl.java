package bitfire.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import bitfire.model.AddressBook;
import bitfire.model.User;
import bitfire.model.dao.AddressBookDao;

@Repository
public class AddressBookDaoImpl implements AddressBookDao{

	@PersistenceContext
	private EntityManager entityManager;
	
	@Override
	public List<AddressBook> getAddressBook(User user) {
		List<AddressBook> addressBook = entityManager.createQuery("from AddressBook where owner = :owner", AddressBook.class)
				.setParameter("owner", user)
				.getResultList();
		return addressBook.size()==0 ? null : addressBook;
	}

	@Override
	public AddressBook getAddressBook(int id) {
		return entityManager.find(AddressBook.class, id);
	}

	@Override
	@Transactional
	public AddressBook saveAddressBook(AddressBook addressBook) {
		return entityManager.merge(addressBook);
	}

	@Override
	@Transactional
	public void deleteAddressBook(AddressBook addressBook) {
		 entityManager.remove(addressBook);
	}

	
}
