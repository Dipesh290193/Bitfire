<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bitfire:Profile</title>

<!-- Favicon for Bitfire -->
<link rel="shortcut icon" href="assets/img/favicon.ico" type="image/x-icon" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Exo+2|Rokkitt">

<!-- Custom CSS -->
<link rel="stylesheet" href="css/bitfire-base.css">
<link rel="stylesheet" href="css/bitfire-summary.css">
<link rel="stylesheet" href="css/bitfire-nav.css">


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
						<img src="assets/img/fire.png" alt=""
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
				<security:authorize access="authenticated">
					<ul class="nav navbar-nav">
						<li class="active"><a href="index.html">Summary</a></li>
						<li><a href="<c:url value='/user/transactions.html' />">Transactions</a></li>
						<li><a href="<c:url value='/user/send.html' />">Send
								Bitcoin</a></li>
						<li><a href="<c:url value='/user/request.html' />">Request
								Bitcoin</a></li>
						<li><a href="<c:url value='/user/wallet.html' />">Wallet</a></li>
					</ul>
				</security:authorize>
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<ul class="nav navbar-nav">
						<li><a href="<c:url value='/admin/users.html' />">Users</a></li>
					</ul>
				</security:authorize>
				<ul class="nav navbar-nav navbar-right">
					<security:authorize access="anonymous">
						<li><a href="<c:url value='/login.html' />">Login</a></li>
						<li><a href="register.html">Sign Up</a></li>
					</security:authorize>
					<security:authorize access="authenticated">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false"><span class="glyphicon glyphicon-cog"
								aria-hidden="true"></span></a>
							<ul class="dropdown-menu">
								<li><a href="<c:url value='/user/profile.html' />">My
										Account</a></li>
								<li><a href="<c:url value='/logout' />">Logout</a></li>
							</ul></li>
					</security:authorize>
				</ul>
			</div>
		</div>
	</nav>
	
	<!-- Will only be shown if user is authenticated -->
	<security:authorize access="authenticated">
		<div class="jumbotron">
			<div class="container">
				<h1>Welcome, ${user.name }!</h1>
			</div>
		</div>

		<div class="container wrapper">
			<div class="page-header text-center web-font">
				<h2>Account Summary</h2>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="panel-group">
						<div class="panel panel-default">
							<div class="panel-heading">
								<a href="#">BitFire Balance <span
									class="glyphicon glyphicon-chevron-right pull-right"
									aria-hidden="true"></span></a>
							</div>

							<div class="panel-body">
								<p>
									<strong>Balance:</strong> ${balance} BTC
								</p>

								<ul style="list-style: none;">
									<li><a href="<c:url value='/user/send.html' />">Send Bitcoin</a></li>
									<li><a href="<c:url value='/user/request.html' />">Request Bitcoin</a></li>
								</ul>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<a href="#">Addresses <span
									class="glyphicon glyphicon-chevron-right pull-right"
									aria-hidden="true"></span></a>
							</div>
							<div class="panel-body">
								<c:forEach items="${addresses}" var="address">
									<div class="row">
										<div class="col-md-5">
											<p>
												<strong></>${address.label}</strong>
											</p>
										</div>
										<div class="col-md-7">
											<p>${address.address}</p>
										</div>
									</div>
								</c:forEach>
							</div>
							<div class="panel-footer text-center">
								<a href="<c:url value='/user/wallet.html' />">Manage Wallet</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-8">
					<div class="panel panel-default">
						<div class="panel-heading trans-panel">Transactions</div>

						<div class="panel-body scroll-panel">
							<c:forEach items="${transactions }" var="trans" varStatus="i">
								<div class="panel-group" id="accordion" role="tablist"
									aria-multiselectable="true">
									<div class="panel panel-default">
										<div class="panel-heading trans" role="tab"
											id="heading${i.index}">
											<h4 class="panel-title title">
												<a role="button" data-toggle="collapse"
													data-parent="#accordion" href="#collapse${i.index}"
													aria-expanded="true" aria-controls="collapse${i.index}">
													<div class="row">
														<div class="col-md-4">${trans.date }</div>
														<div class="col-md-5">
															<c:if
																test="${ trans.senderUser.userId eq trans.receiverUser.userId}">
																<td>Self transfer</td>
															</c:if>

															<c:if
																test="${ trans.senderUser.userId ne trans.receiverUser.userId}">
																<c:if test="${user.userId eq trans.senderUser.userId}">
																	<td>Sent</td>
																</c:if>
																<c:if
																	test="${ user.userId eq trans.receiverUser.userId}">
																	<td>Received</td>
																</c:if>
															</c:if>
														</div>
														<div class="col-md-3">
															<c:if
																test="${ trans.senderUser.userId eq trans.receiverUser.userId}">
																<td><span class="glyphicon glyphicon-plus"
																	style="color: #3ea134" aria-hidden="true"></span>
																	${trans.bitcoin}</td>
															</c:if>

															<c:if
																test="${ trans.senderUser.userId ne trans.receiverUser.userId}">
																<c:if test="${user.userId eq trans.senderUser.userId}">
																	<td><span class="glyphicon glyphicon-minus"
																		style="color: #ff0000" aria-hidden="true"></span>
																		${trans.bitcoin}</td>
																</c:if>
																<c:if
																	test="${ user.userId eq trans.receiverUser.userId}">
																	<td><span class="glyphicon glyphicon-plus"
																		style="color: #3ea134" aria-hidden="true"></span>
																		${trans.bitcoin}</td>
																</c:if>
															</c:if>
														</div>
													</div>
												</a>
											</h4>
										</div>
										<div id="collapse${i.index}"
											class="panel-collapse collapse in" role="tabpanel"
											aria-labelledby="heading${i.index}">

											<div class="panel-body">
												<div class="row">
													<div class="col-md-3">${trans.senderUser.username}</div>
													<div class="col-md-1">
														<a href="https://blockchain.info/tx/${trans.txId }">TX</a>
													</div>
													<div class="col-md-3">${trans.bitcoin}BTC</div>
													<div class="col-md-2">${trans.USD}</div>
													<div class="col-md-3">
														<strong>Confirmations:</strong> ${trans.confirmations }
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="panel-footer text-center">
							<a href="<c:url value='/user/transactions.html' />">View All Transactions</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</security:authorize>

	<!-- Javascript and jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
</body>
</html>