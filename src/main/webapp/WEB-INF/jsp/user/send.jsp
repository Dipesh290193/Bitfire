<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bitfire:Send</title>
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
					<li><a href="<c:url value='/user/transactions.html' />">Transactions</a></li>
					<li class="active"><a href="<c:url value='/user/send.html' />">Send
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
<div class = "well">
<div class = "container" style="margin-top:100px">
<h2 class = "web-font">Send Bitcoin</h2>
<form class = "form" action = "<c:url value='/user/send.html' />" method = "post"><br>
	<c:if test="${empty to || empty amount}">
		<input class = "form-control" type = "email" name = "email" placeholder = "recepient's email address"/><br>
		<input class = "form-control" type = "text" name = "btc" placeholder = "amount of BTC"/><br>
	</c:if>
	
	<c:if test="${not empty to && not empty amount}">
		<input class = "form-control" type = "email" name = "email" value = ${ to } /><br>
		<input class = "form-control" type ="text" name = "btc" value =${amount } /><br>
	</c:if>
	
	<input class = "btn btn-danger btn-block" type ="submit" value = "Send" />
</form>
<br/>
<div style="color:red">
<h4> ${error} </h4>
</div>
<c:if test = "${not empty selftranfererror }">
<div style="color:red">
<h4> ${selftranfererror } <a href = "<c:url value ='/user/selftransfer.html' />">Self Transfer</a></h4>
</div>
</c:if>
</div>
</div>

</body>
</html>