<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="tilesx" uri="http://tiles.apache.org/tags-tiles-extras" %>
<script type="text/javascript">
$(document).ready(function(){
	update();
	setInterval(update,5000);
});
	function update(){
		$.ajax({
			url: "/bitfire/user/getBTC",
			method: "post",
			dataType: "json",
			success: function(data){
				$("#btcUSD").html("1 BTC = "+data);
			}
		});	
	}
	
</script>
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
			<a class="navbar-brand" href="<c:url value ='/index '/>">
				<div class="logo text-center">
					<img src="<tiles:insertAttribute name='logo' />" alt="" style="width: 50px; height: 50px;">
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
					<li><a href="<c:url value='/index ' />">Summary</a></li>
					<li><a href="<c:url value='/user/transactions ' />">Transactions</a></li>
					<li><a href="<c:url value='/user/send ' />">Send
							Bitcoin</a></li>
					<li><a href="<c:url value='/user/request ' />">Request
							Bitcoin</a></li>
					<li><a href="<c:url value='/user/wallet ' />">Wallet</a></li>
					<li><a href="<c:url value='/user/addressBook ' />">Contacts</a></li>
					<li><a href="<c:url value='/user/invoices ' />">Invoices</a></li>
				</ul>
			</security:authorize>
			<security:authorize access="hasRole('ROLE_ADMIN')">
				<ul class="nav navbar-nav">
					<li><a href="<c:url value='/admin/users ' />">Users</a></li>
				</ul>
			</security:authorize>
			<ul class="nav navbar-nav navbar-right">
				<security:authorize access="anonymous">
					<li class = "<tiles:getAsString name='loginActive' />"><a href="<c:url value='/login ' />">Login</a></li>
					<li class = "<tiles:getAsString name='registerActive' />"><a href="<c:url value='/register ' />">Sign Up</a></li>
				</security:authorize>
				<security:authorize access="authenticated">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><span class="glyphicon glyphicon-cog"
							aria-hidden="true"></span></a>
						<ul class="dropdown-menu">
							<li><a href="<c:url value='/user/profile/edit ' />">My
									Account</a></li>
							<li><a href="<c:url value='/logout' />">Logout</a></li>
						</ul></li>
						<li id ="btcUSD" style = "border"></li>
				</security:authorize>
			</ul>
		</div>
	</div>
</nav>
