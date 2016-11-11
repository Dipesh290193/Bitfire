<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bitfire</title>

<!-- Favicon for Bitfire -->
<link rel="shortcut icon" href="../assets/img/favicon.ico" type="image/x-icon" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Exo+2|Rokkitt">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/bitfire-base.css">
<link rel="stylesheet" href="css/bitfire-nav.css">
<link rel="stylesheet" href="css/bitfire.css">

</head>
<body>
 	<!-- Static navbar -->
   <nav class="navbar navbar-default navbar-fixed-top" >
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>

          <ul class="nav navbar-nav navbar-right">
            <li><a href="login.html">Login</a></li>
            <li class="active"><a href="register.html">Register</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

	<div class = "container">
		<div class = "logo text-center">
			<img src = "assets/img/fire.png" alt = "" style = "width:50px; height:50px;">
			<h1 class = "web-font"><span class = "ignite web-font">BIT</span><span class = "white web-font">FIRE</span></h1>
		</div>
		
		<div class = "well well-lg">
			<!-- Login Form -->
			<!-- action needs to be updated -->
			<form:form modelAttribute="user">
				
				<c:if test="${errors}">
					<div class="alert alert-danger" role="alert">
  						<form:errors path="name" htmlEscape="false"/>	
  						<form:errors path="email" htmlEscape="false"/>	
  						<form:errors path="username" htmlEscape="false"/>
  						<form:errors path="password" htmlEscape="false"/>
  						<form:errors path="phone" htmlEscape="false"/>	
					</div>
				</c:if>
			
				<div class = "form_group">
					<label class = "white" for = "name_field"> Name </label>
					<form:input type = "text" path="name"  class = "form-control" id = "name_field" placeholder = "Enter your full name" />
				</div><br>
				<div class = "form_group">
					<label class = "white" for = "email_field"> Email Address </label>
					<form:input type = "email" path="email" class = "form-control" id = "email_field" placeholder = "Enter email" />
				</div><br>
				<div class = "form_group">
					<label class = "white" for = "email_field"> Username </label>
					<form:input type = "text" path="username" class = "form-control" id = "email_field" placeholder = "Enter Username" />
				</div><br>
				<div class = "form_group">
					<label class = "white" for = "password_field"> Password </label>
					<form:input type = "password" path="password" class = "form-control" id = "password_field" placeholder = "Enter password" />
				</div><br>
				<div class = "form_group">
					<label class = "white" for = "re-password_field"> Password Re-entry </label>
					<input type = "password" class = "form-control" id = "re-password" name = "re-password" placeholder = "Re-enter password" />
				</div><br>
				<div class = "form_group">
					<label class = "white" for = "email_field"> Phone </label>
					<form:input type = "text" path="phone" class = "form-control" id = "email_field" placeholder = "Enter Phone" />
				</div><br>
				<button type = "submit" class = "btn btn-primary btn-block">Register</button>
			</form:form>
		</div>
	</div>
	
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>