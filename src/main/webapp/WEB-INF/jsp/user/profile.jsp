<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<meta charset="UTF-8">
<title>Profile</title>
</head>
<body>

<div class = "col-md-6" style ="float: none; margin-left: auto; margin-right: auto; margin-top: 2em;
 border: 1px solid black; padding: 2em; border-radius: 20px;">
<form class = "form" action ="<c:url value ='/user/profile.html' />" method = "post">
	Username: <input type = "text" name = "username" value = ${user.username} class = "form-control" readonly/> <br>
	Email: <input type = "email" name = "email" value = ${user.email} class = "form-control" readonly /><br>
	Name: <input type = "text" name = "name" value = ${user.name} class = "form-control" readonly /><br>
	Password: <input type = "password" name = "password" value = ${user.password} class = "form-control" readonly /><br>
	Phone: <input type = "text" name = "phone" value = ${user.phone} class = "form-control" readonly /> <br>
			<input type = "hidden" value ="edit" />
	<input type = "submit" value = "Edit Profile" class="btn btn-md btn-danger" /> 
</form >
<div style ="color:green"">
<center><h4>${message}</h4></center>
</div>
</div>
<br>

</body>
</html>