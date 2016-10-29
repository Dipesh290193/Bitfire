<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Bitfire:Wallet</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<link href="https://fonts.googleapis.com/css?family=Exo+2|Rokkitt"
	rel="stylesheet">
<link href="../css/bitfire-wallet.css" rel="stylesheet">
</head>
<body>

	<!-- Static navbar -->
	<nav class="navbar navbar-default navbar-fixed-top" >
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
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="<c:url value='../index.html' />">Profile</a></li>
					<li><a href="<c:url value='/user/transactions.html' />">Transactions</a></li>
					<li><a href="<c:url value='/user/send.html' />">Send
							Bitcoin</a></li>
					<li><a href="<c:url value='/user/request.html' />">Request
							Bitcoin</a></li>
					<li class="active"><a href="<c:url value='/user/wallet.html' />">Wallet</a></li>
					<li><a href="<c:url value='/user/profile.html' />">User Panel</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<c:url value='/logout' />">Logout</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>

	<div class="container">
		<div class="page-header web-font">
			<h1>My Wallet</h1>
		</div>
		
		<div class = "well well-lg">
		<form action="<c:url value='/user/addaddress.html' />" action='GET'>

			<table class = "table table-striped table-condensed">
				<tr>
					<th>Address</th>
					<th>Label</th>
					<th>USD</th>
					<th>BTC</th>
					<th>Primary</th>
					<th>Edit</th>
					<th>Archive</th>
				</tr>

				<c:forEach items="${addresses}" var="address">
					<tr>
						<td>${address.address}</td>
						<td>${address.label}</td>
						<td>${address.USD}</td>
						<td>${address.bitcoins}</td>
						<c:if test="${address.primary }">
							<td>Primary</td>
						</c:if>
						<c:if test="${not address.primary }">
							<td></td>
						</c:if>

						<td><a
							href="<c:url value='/user/editaddress.html?id=${ address.addressId }' />" class = "btn btn-sm btn-default">Edit</a></td>
						<td><a
							href="<c:url value='/user/archiveaddress.html?id=${ address.addressId }' />" class = "btn btn-sm btn-default">Archive</a></td>

					</tr>
				</c:forEach>
			</table>
			<input type="submit" value="Add address" class = "btn btn-danger" />
			<input type="button"
			onclick='location.href="<c:url value ='/user/selftransfer.html' />"'
			value="Self Transfer" class = "btn btn-danger">
		</form>
		<br>
		<div style = "color: red;">${message}</div>
	</div>
</body>
</html>