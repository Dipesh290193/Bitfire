<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

	<div class="well">
		<form class="form" action="<c:url value ='/user/profile.html' />" method="post">
			<label for="username">Username:</label> 
			<input type="text" name="username" value=${user.username} class="form-control" readonly disabled/> <br> 
			<label for="email">Email:</label>
			<input type="email" name="email" value=${user.email } class="form-control" readonly disabled/><br> 
			<label for="name">Name:</label>
			<input type="text" name="name" value=${user.name } class="form-control" readonly disabled/><br>
			<label for="password">Password:</label>
			<input type="password" name="password" value=${user.password } class="form-control" readonly disabled/><br>
			<label for="phone">Phone:</label> 
			<input type="text" name="phone" value=${user.phone} class="form-control" readonly disabled /> <br> 
			<input type="hidden" value="edit" /> 
			<input type="submit" value="Edit Profile" class="btn btn-md btn-danger" />
		</form>
		<div style="color: #00ff00; text-align:center" >
			<h4>${message}${param.message }</h4>
		</div>
</div>