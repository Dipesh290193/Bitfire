<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	<a href="register.html" class="btn btn-danger btn-block">Sign Up</a> <br>
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