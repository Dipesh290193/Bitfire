<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transactions</title>
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
				<a class="navbar-brand" href="../index.html">
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
					<li><a href="../index.html">Profile</a></li>
					<li class = "active"><a href="<c:url value='/user/transactions.html' />">Transactions</a></li>
					<li><a href="<c:url value='/user/send.html' />">Send
							Bitcoin</a></li>
					<li><a href="<c:url value='/user/request.html' />">Request
							Bitcoin</a></li>
					<li><a href="<c:url value='/user/wallet.html' />">Wallet</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="<c:url value='/logout' />">Logout</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>
	
	<div class = "container">
	<div class = "page-header">
		<h1>Transactions</h1>
	</div>

<div class = "container">
<div class ="well">
<table class = "table table-striped table-condensed">
<tr><th>Type</th><th>Date</th><th>Email</th><th>TX</th><th>BTC</th><th>USD</th><th>Confirmations</th></tr>
<c:forEach items="${transactions}" var="trans">
<tr>
	<c:if test = "${ trans.senderUser.userId eq trans.receiverUser.userId}" >
		<td>Self transfer</td>
	</c:if >
	
	<c:if test = "${ trans.senderUser.userId ne trans.receiverUser.userId}" >
		<c:if test = "${user.userId eq trans.senderUser.userId}" >
			<td>Sent</td>
		</c:if>
		<c:if test = "${ user.userId eq trans.receiverUser.userId}" >
			<td>Received</td>
		</c:if> 
 	</c:if>
	<td>${trans.date}</td>
	<td>${trans.receiverUser.username}</td>
	<td>${trans.txId}</td>
	<td>${trans.bitcoin}</td>
	<td>${trans.USD}</td>
	<td>${trans.confirmations}</td>
</tr>
</c:forEach>
</table>
</div>
</div>
</div>
</body>
</html>