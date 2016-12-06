<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Confirmation</h4>
				</div>
				<div class="modal-body">
					<center>We have sent a confirmation text to ${user.phone }.</center>
					<center>Please enter the 4 digit confirmation number
						below.</center>
					<br>

					<form id="confirm"
						action="<c:url value ='/user/text/confirmation' />"
						method="post">
						<div class="form-group col-md-5"
							style="margin: 0 auto; float: none;">
							<input style="text-align: center;" id="confNum" type="text"
								class="form-control" name="confirmation"
								placeholder="Confirmation Number"> <br>
							<div>
								<center>
									<button id="call" style="margin: 0 auto;" class="btn btn-info"
										data-dismiss="modal">Confirm and Save</button>
								</center>
							</div>
					</form>
=======
<!-- Favicon for Bitfire -->
<link rel="shortcut icon" href="../../assets/img/favicon.ico" type="image/x-icon" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Exo+2|Rokkitt">

<!-- Custom CSS -->
<link rel="stylesheet" href="../../css/bitfire-base.css">
<link rel="stylesheet" href="../../css/bitfire-nav.css">
<link rel="stylesheet" href="../../css/bitfire-profile.css">

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
				<a class="navbar-brand" href="<c:url value ='../../index'/>">
					<div class="logo text-center">
						<img src="../../assets/img/fire.png" alt=""
							style="width: 50px; height: 50px;">
						<h2 class="web-font">
							<span class="ignite web-font">BIT</span><span
								class="white web-font">FIRE</span>
						</h2>
					</div>
				</a>
			</div>

			<!--  Collapses when screen is too small -->
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="../../index">Summary</a></li>
					<li><a href="<c:url value='/user/transactions' />">Transactions</a></li>
					<li><a href="<c:url value='/user/send' />">Send Bitcoin</a></li>
					<li><a href="<c:url value='/user/request' />">Request Bitcoin</a></li>
					<li><a href="<c:url value='/user/wallet' />">Wallet</a></li>
				</ul>
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<ul class="nav navbar-nav">
						<li><a href="<c:url value='/admin/users' />">Users</a></li>
					</ul>
				</security:authorize>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><span class="glyphicon glyphicon-cog"
							aria-hidden="true"></span></a>
						<ul class="dropdown-menu">
							<li><a href="<c:url value='/user/profile' />">My
									Account</a></li>
							<li><a href="<c:url value='/logout' />">Logout</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Confirmation</h4>
					</div>
					<div class="modal-body">
						<center>We have sent a confirmation text to ${user.phone }.</center>
						<center>Please enter the 4 digit confirmation number
							below.</center>
						<br>

						<form id="confirm"
							action="<c:url value ='/user/text/confirmation' />">
							<div class="form-group col-md-5"
								style="margin: 0 auto; float: none;">
								<input style="text-align: center;" id="confNum" type="text"
									class="form-control" name="confirmation"
									placeholder="Confirmation Number"> <br>
								<div>
									<center>
										<button id="call" style="margin: 0 auto;" class="btn btn-info"
											data-dismiss="modal">Confirm and Save</button>
									</center>
								</div>
						</form>
					</div>
>>>>>>> Stashed changes
				</div>
			</div>
			<div id="error" class="modal-footer"
				style="text-align: center; color: red;"></div>
		</div>
	</div>
<<<<<<< Updated upstream
</div>


<div class="well">
	<form:form modelAttribute="user" class="form" id="userForm"
		metod="post">
		<label for="username">Username:</label>
		<form:input path="username" class="form-control" />
		<br>
		<label for="email">Email:</label>
		<form:input path="email" class="form-control" />
		<br>
		<label for="name">Name:</label>
		<form:input path="name" class="form-control" />
		<br>
		<label for="password">Password:</label>
		<form:input path="password" class="form-control" />
		<br>
		<label for="phone">Phone:</label>
		<form:input path="phone" class="form-control" />
		<br>
		<input type="submit" class="btn btn-success" value="Save Changes" />
	</form:form>
</div>
</div>

<script>
	//text confirmation number
	$("#userForm").submit(function(e) {
		$('#myModal').modal('show');
		$.ajax({
			url : $('#confirm').attr('action'),
			type : "POST",
			data : "hi",

			success : function(data) {
				/* alert("sent message"); */
			},
			error : function(request, status, error) {
				alert(request.responseText);
			}



	<div class="well">
		<form:form modelAttribute="user" class="form" id="userForm"
			metod="post">
			<label for="username">Username:</label>
			<input value="${user.username}" class="form-control" disabled />
			<br>
			<label for="email">Email:</label>
			<form:input path="email" class="form-control" />
			<br>
			<label for="name">Name:</label>
			<form:input path="name" class="form-control" />
			<br>
			<label for="password">Password:</label>
			<form:input path="password" class="form-control" />
			<br>
			<label for="phone">Phone:</label>
			<form:input path="phone" class="form-control" />
			<br>
			<input type="submit" class="btn btn-success" value="Save Changes" />
		</form:form>
	</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script>
		//text confirmation number
		$("#userForm").submit(function(e) {
			$('#myModal').modal('show');
			$.ajax({
				url : $('#confirm').attr('action'),
				type : "POST",
				data : "hi",

				success : function(data) {
					/* alert("sent message"); */
				},
				error : function(request, status, error) {
					alert(request.responseText);
				}
			});
			return false;

		});
		return false;
	});
</script>

<script type="text/javascript">
	$('#call').on('click', function(e) {
		$.ajax({
			headers : {
				Accept : "text/plain",
				"Content-Type" : "text/plain"
			},
			url : $('#confirm').attr('action'),

			type : "GET",
			data : {
				code : $('#confNum').val(),
			},

			success : function(data) {
				if (data == 'success') {
					$('#myModal').modal('hide');
					document.getElementById("userForm").submit();
				} else {
					$('#error').text(data);
				}
			},
			error : function(request, status, error) {
				alert(request.responseText);
			}
		});

		return false;
	});
</script>
