<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Bitfire: Send</title>

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


<script>
function updateText(type) { 
 var id = type+'Text';
 document.getElementById("email").value = document.getElementById("sel").value;
}
</script>
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
					<li class='active'><a href="<c:url value='/user/send.html' />">Send Bitcoin</a></li>
					<li><a href="<c:url value='/user/request.html' />">Request Bitcoin</a></li>
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
							<li><a href="<c:url value='/user/profile.html' />">My Account</a></li>
							<li><a href="<c:url value='/logout' />">Logout</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="well">
		<div class="container" style="margin-top: 100px">
			<h2 class="web-font">Send Bitcoin</h2>
			<h3 style ="float: right; ">Primary address balance: <span style = "color: green;">${balance}</span> BTC</h3>
			<form class="form" action="<c:url value='/user/send.html' />"
				method="post">
				<br> <select onchange="updateText()" id ="sel">
					<c:forEach items="${emails}" var="email">						
							<option value="${email }">${email }</option>						
					</c:forEach>
				</select>
				<br>
				<br>
				<c:if test="${empty to || empty amount}">
					<input class="form-control" type="email" id ="email" name="email"
						placeholder="recepient's email address" />
					<br>
					<input class="form-control" type="text" name="btc"
						placeholder="amount of BTC" />
					<br>
				</c:if>

				<c:if test="${not empty to && not empty amount}">
					<input class="form-control" type="email"  id ="email" name="email" value=${ to } />
					<br>
					<input class="form-control" type="text" name="btc" value=${amount } />
					<br>
				</c:if>

				<input class="btn btn-danger btn-block" type="submit" value="Send" />
			</form>
			<br />
			<div style="color: red">
				<h4>${error}</h4>
			</div>
			<c:if test="${not empty selftranfererror }">
				<div style="color: red">
					<h4>
						${selftranfererror } <a
							href="<c:url value ='/user/selftransfer.html' />">Self
							Transfer</a>
					</h4>
				</div>
			</c:if>
		</div>
	</div>
	
	<!-- Javascript and jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>