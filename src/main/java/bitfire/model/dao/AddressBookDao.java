package bitfire.model.dao;

import java.util.List;

import bitfire.model.AddressBook;
import bitfire.model.User;

public interface AddressBookDao {

	List<AddressBook> getAddressBook(User user);
	
	AddressBook getAddressBook(int id);
	
	AddressBook saveAddressBook(AddressBook addressBook);
	
	void deleteAddressBook(AddressBook addressBook);
}
