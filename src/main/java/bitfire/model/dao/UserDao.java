package bitfire.model.dao;

import java.util.List;

import bitfire.model.User;

public interface UserDao {

	User getUser(int id);
	
	User saveUser(User user);
	
	User getUserByUsername(String email);
	
	List<User> getUsers();
	
	List<User> getAllUsers();
}
