<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div class="container">
	<div class="well well-lg">
		<!-- Login Form -->
		<!-- action needs to be updated -->
		<form:form modelAttribute="user">

			<c:if test="${errors}">
				<div class="alert alert-danger" role="alert">
					<form:errors path="name" htmlEscape="false" />
					<form:errors path="email" htmlEscape="false" />
					<form:errors path="username" htmlEscape="false" />
					<form:errors path="password" htmlEscape="false" />
					<form:errors path="phone" htmlEscape="false" />
				</div>
			</c:if>

			<div class="form_group">
				<label class="white" for="name_field"> Name </label>
				<form:input type="text" path="name" class="form-control"
					id="name_field" placeholder="Enter your full name" />
			</div>
			<br>
			<div class="form_group">
				<label class="white" for="email_field"> Email Address </label>
				<form:input type="email" path="email" class="form-control"
					id="email_field" placeholder="Enter email" />
			</div>
			<br>
			<div class="form_group">
				<label class="white" for="email_field"> Username </label>
				<form:input type="text" path="username" class="form-control"
					id="email_field" placeholder="Enter Username" />
			</div>
			<br>
			<div class="form_group">
				<label class="white" for="password_field"> Password </label>
				<form:input type="password" path="password" class="form-control"
					id="password_field" placeholder="Enter password" />
			</div>
			<br>
			<div class="form_group">
				<label class="white" for="re-password_field"> Password
					Re-entry </label> <input type="password" class="form-control"
					id="re-password" name="re-password" placeholder="Re-enter password" />
			</div>
			<br>
			<div class="form_group">
				<label class="white" for="email_field"> Phone </label>
				<form:input type="text" path="phone" class="form-control"
					id="email_field" placeholder="Enter Phone" />
			</div>
			<br>
			<button type="submit" class="btn btn-primary btn-block">Register</button>
		</form:form>
	</div>
</div>
