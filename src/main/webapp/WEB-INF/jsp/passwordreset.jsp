<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bitfire: Reset Password</title>

<!-- Favicon for Bitfire -->
<link rel="shortcut icon" href="assets/img/favicon.ico"
	type="image/x-icon" />

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- Google Fonts -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Exo+2|Rokkitt">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/bitfire-base.css">
<link rel="stylesheet" href="css/bitfire-nav.css">
<link rel="stylesheet" href="css/bitfire-passwordreset.css">

</head>
<body>

	<!-- Static Navigation Bar -->
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
			</div>

			<!--  Collapses when screen is too small -->
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<c:url value='/login.html' />">Login</a></li>
					<li><a href="register.html">Sign Up</a></li>
				</ul>
			</div>
		</div>
	</nav>


	<div class="container">
		<div class="well">
			<div class="row">
				<div class="col-sm-12 web-font">
					<h2>Change Password</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h5 class="text-center">Use the form below to change your
						password.</h5>
					<form method="post" id="passwordForm"
						=  action="<c:url value='/reset.html' />">
						<input type="password" class="input-lg form-control"
							name="password1" id="password1" placeholder="New Password"
							autocomplete="off"> <br> <input type="password"
							class="input-lg form-control" name="password2" id="password2"
							placeholder="Repeat Password" autocomplete="off"> <input
							type="hidden" value="${param.token }" name="token" /> <br>
						<input type="submit"
							class="col-xs-12 btn btn-primary btn-load btn-lg"
							data-loading-text="Changing Password..." value="Change Password">
					</form>
				</div>
				<!--/col-sm-6-->



			</div>
			<!--/row-->
			<br>
			<center style="color: red;">${param.error }</center>
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