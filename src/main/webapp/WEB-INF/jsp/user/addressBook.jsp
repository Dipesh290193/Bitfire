<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bitfire: Contact</title>

<!-- Favicon for Bitfire -->
<link rel="shortcut icon" href="../assets/img/favicon.ico" type="image/x-icon" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Exo+2|Rokkitt">

<!-- Custom CSS -->
<link rel="stylesheet" href="../css/bitfire-base.css">
<link rel="stylesheet" href="../css/bitfire-nav.css">
<link rel="stylesheet" href="../css/bitfire-wallet.css">

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
				<a class="navbar-brand" href="<c:url value ='/index.html'/>">
					<div class="logo text-center">
						<img src="../assets/img/fire.png" alt=""
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
					<li><a href="../index.html">Summary</a></li>
					<li><a href="<c:url value='/user/transactions.html' />">Transactions</a></li>
					<li><a href="<c:url value='/user/send.html' />">Send Bitcoin</a></li>
					<li><a href="<c:url value='/user/request.html' />">Request Bitcoin</a></li>
					<li><a href="<c:url value='/user/wallet.html' />">Wallet</a></li>
					<li class='active'><a href="<c:url value='/user/addressBook.html' />">Contact</a></li>
				</ul>
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<ul class="nav navbar-nav">
						<li><a href="<c:url value='/admin/users.html' />">Users</a></li>
					</ul>
				</security:authorize>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><span class="glyphicon glyphicon-cog"
							aria-hidden="true"></span></a>
						<ul class="dropdown-menu">
							<li><a href="<c:url value='/user/profile.html' />">My Account</a></li>
							<li><a href="<c:url value='/logout' />">Logout</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="page-header web-font">
			<h1>Contact</h1>
		</div>
		
		<div class = "well well-lg">
			<table class = "table table-striped table-condensed">
				<tr>
					<th>Name</th>
					<th>Email</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>

				<c:forEach items="${contacts}" var="contact">
					<tr>
						<td>${contact.name}</td>
						<td>${contact.contact.email}</td>
						<td>
							<button onclick="editAddressBookFunction('${contact.id}')" class = "btn btn-sm btn-default"> Edit </button>
							</td>
						<td><a
							href="<c:url value='/user/deleteAddressBook.html?id=${ contact.id }' />" class = "btn btn-sm btn-default">Delete</a></td>

					</tr>
				</c:forEach>
			</table>
			<button onclick="addAddressBookFunction()" class = "btn btn-danger"> Add New Contact </button>
		<br>
		<div style = "color: red;">${error}</div>
		<div style = "color: green;">${success}</div>
	</div>
	
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="addAddressBookForm" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Add Contact</h4>
					</div>
					<div class="modal-body">
						<form id="addressBook" action="<c:url value ='/user/addAddressBook.html' />" method=POST>
							<div class="form-group col-md-5" style="margin: 0 auto; float: none;">
								<label>Name</label><input style="text-align: center;" id="name" type="text"
									class="form-control" name="name"
									placeholder="Enter Name" required> <br>
								<label>Email</label><input style="text-align: center;" id="email" type="email"
									class="form-control" name="email"
									placeholder="Enter email" required> <br>
								<div>
									<center>
									<input type="submit" name="save" value="Save" style="margin: 0 auto;" 
									class="btn btn-info" />
									</center>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
		
			<div class="container">
			<div class="modal fade" id="editAddressBookForm" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Edit Contact</h4>
					</div>
					<div class="modal-body">
						<form id="addressBook" action="<c:url value ='/user/editAddressBook.html' />" method=POST>
							<div class="form-group col-md-5" style="margin: 0 auto; float: none;">
								<label>Name</label><input style="text-align: center;" id="editName" type="text"
									class="form-control" name="name"
									placeholder="Enter Name" required> <br>
									<input type = "hidden" name="id" id = "addressBookId" />
								<div>
									<center>
									<input type="submit" name="save" value="Save" style="margin: 0 auto;" 
									class="btn btn-info" />
									</center>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		</div>
		
		
	</div>
	
	<!-- Javascript and jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
		function addAddressBookFunction()
		{
			$("#addAddressBookForm").modal('show');
		}
	</script>
	<script>
	function editAddressBookFunction(id)
	{
		$("#editAddressBookForm").modal('show');
		
		$.ajax({
			type: "GET",
			url : "<c:url value='/user/editAddressBook.html' />",
			data : {addressBookId: id},
			success : function(data)
			{
				 $("#editName").val(data);
				 $("#addressBookId").val(id);
			},
			error : function(e)
			{
				alert(e);
			}
		});
	}
	
	</script>
</body>
</html>