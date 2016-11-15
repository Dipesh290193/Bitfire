<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
					<!--<img src='<tiles:insertAttribute name='logo' />' alt=""
							style="width: 50px; height: 50px;">-->
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
					<li><a href="<c:url value='/register.html' />">Sign Up</a></li>
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
