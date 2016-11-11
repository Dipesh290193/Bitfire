<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    

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
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>

				<ul class="nav navbar-nav navbar-right">
					<li class="active"><a href="login.html">Login</a></li>
					<li><a href="register.html">Register</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>

	<div class="container">
		<div class="logo text-center">
			<img src="assets/img/fire.png" alt=""
				style="width: 50px; height: 50px;">
			<h1 class="web-font">
				<span class="ignite web-font">BIT</span><span class="white web-font">FIRE</span>
			</h1>
		</div>

		<div class="well well-lg">
			<!-- Login Form -->
			<!-- action needs to be updated -->
			<c:if test="${not empty param.error}">
    			<div class="alert alert-danger" role="alert">
  					<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  					&nbsp;Invalid Username and/or Password
				</div>
			</c:if>
			<form action="login" method="post">
				<div class="form_group">
					<label class="white" for="email_field"> Email Address </label> <input
						type="text" class="form-control" id="text" name="username"
						placeholder="Enter email">
				</div>
				<br>
				<div class="form_group">
					<label class="white" for="password_field"> Password </label> <input
						type="password" class="form-control" id="password_field"
						name="password" placeholder="Enter password">
				</div>
				<br>

				<button type="submit" class="btn btn-primary btn-block">Log
					In</button>
			</form>

			<!-- For password recovery modal -->
			<div id="password-recovery">
				<a href="#" data-toggle="modal" data-target="#reset-password">Having
					trouble logging in?</a><br> <br>
			</div>

			<!-- Redirect to sign up page -->
			<a href="register.html" class="btn btn-danger btn-block">Sign Up</a>
			<br>
			<c:if test="${not empty message }">
				<div class="alert alert-success">
					<h4>${message }</h4>
				</div>
			</c:if>
			<c:if test="${not empty error }">
				<div class="alert alert-danger">
					<h4>${error }</h4>
				</div>
			</c:if>
		</div>

	</div>

	<%-- <a href="<c:url value='/passwordreset.html' />">Reset</a> --%>
	<div id="reset-password" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title web-font">Password Reset</h4>
				</div>
				<div class="modal-body">
					<p>After submitting you will receive an email with instruction
						on how to reset your password:</p>
					<form action="<c:url value='/passwordreset.html' />" method="POST">
						<input type="email" id="reset" name="email" class="form-control"
							placeholder="Enter your email (eg. bitfire@gmail.com)"><br>

						<input type="submit" class="btn btn-danger" value="Reset Password" />
						<!-- data-dismiss="modal" -->
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>