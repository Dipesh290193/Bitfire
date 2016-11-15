<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bitfire: Invoices</title>

<!-- Favicon for Bitfire -->
<link rel="shortcut icon" href="../assets/img/favicon.ico"
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
					<li class='active'><a
						href="<c:url value='/user/transactions.html' />">Transactions</a></li>
					<li><a href="<c:url value='/user/send.html' />">Send
							Bitcoin</a></li>
					<li><a href="<c:url value='/user/request.html' />">Request
							Bitcoin</a></li>
					<li><a href="<c:url value='/user/wallet.html' />">Wallet</a></li>
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
							<li><a href="<c:url value='/user/profile.html' />">My
									Account</a></li>
							<li><a href="<c:url value='/logout' />">Logout</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="page-header">
			<h1>Invoices</h1>
		</div>

		<div class="container">
			<div class="well">
				<table class="table table-striped table-condensed">
					<tr>
						<th>Date</th>
						<th>Type</th>
						<th>Email</th>
						<th>BTC</th>
						<th>USD</th>
						<th>Paid</th>
					</tr>
					<c:forEach items="${invoices}" var="invoice">
						<tr>
							<td>${invoice.date}</td>

							<c:if test="${user.userId eq invoice.senderUser.userId}">
								<td>Sent</td>
								<td>${invoice.receiverUser.email}</td>
							</c:if>
							
							<c:if test="${ user.userId eq invoice.receiverUser.userId}">
								<td>Received</td>
								<td>${invoice.senderUser.email}</td>
							</c:if>

							<td>${invoice.bitcoin}</td>
							<td>${invoice.USD}</td>
							<c:if test ="${invoice.paid}">
								<td>Paid</td>
							</c:if>
							<c:if test ="${not invoice.paid}">
								<td><a href = "<c:url value='/user/invoices/pay.html?id=${invoice.invoiceId }' />" 
								role="button" class="btn btn-success btn-sm">   Pay  </a></td>
							</c:if>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>

	<!-- Javascript and jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>