package bitfire.web.validator;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import org.apache.commons.validator.routines.EmailValidator;

import bitfire.model.User;
import bitfire.model.dao.UserDao;

@Component
public class UserValidator implements Validator {

	private String rePassword;
	private UserDao userDao;
	
	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.isAssignableFrom(clazz);

	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;

		EmailValidator email = EmailValidator.getInstance();

		if(StringUtils.hasText( user.getEmail()) && !email.isValid(user.getEmail()))
			errors.rejectValue("email", "error.field.invalid.email");

		if( !StringUtils.hasText( user.getName()))
			errors.rejectValue("name", "error.field.name.empty");
		if( !StringUtils.hasText( user.getUsername()))
			errors.rejectValue("username", "error.field.username.empty");
		if( !StringUtils.hasText( user.getEmail()))
			errors.rejectValue("email", "error.field.email.empty");
		if( !StringUtils.hasText( user.getPassword()))
			errors.rejectValue("password", "error.field.password.empty");
		if( !StringUtils.hasText( user.getPhone()))
			errors.rejectValue("phone", "error.field.phone.empty");
		
		if(rePassword != null){
			if( StringUtils.hasText( user.getPassword())){
				if(!user.getPassword().equals(rePassword)){
					errors.rejectValue("password", "error.field.matching.passwords");
				}
			}
		}
		else{
			errors.rejectValue("password", "error.field.repassword.empty");
		}
		
		if(userDao.getUserByEmail(user.getEmail()) != null)
			errors.rejectValue("email", "error.field.email.exists");
		if(userDao.getUserByUsername(user.getUsername()) != null)
			errors.rejectValue("username", "error.field.username.exists");

	}
	
	public void setPassword(String password){
		rePassword = password;
	}
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}



}
