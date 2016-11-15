<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<script>
function updateText(type) { 
 var id = type+'Text';
 document.getElementById("email").value = document.getElementById("sel").value;
}
</script>

<div class="well">
	<div class="container" style="margin-top: 100px">
		<h2 class="web-font">Send Bitcoin</h2>
		<h3 style="float: right;">
			Primary address balance: <span style="color: green;">${balance}</span>
			BTC
		</h3>
		<form class="form" action="<c:url value='/user/send.html' />"
			method="post">
			<br> <select onchange="updateText()" id="sel">
				<option value="">Select Email</option>
				<c:forEach items="${emails}" var="email">
					<option value="${email }">${email }</option>
				</c:forEach>
			</select> <br> <br>
			<c:if test="${empty to || empty amount}">
				<input class="form-control" type="email" id="email" name="email"
					placeholder="recepient's email address" />
				<br>
				<input class="form-control" type="text" name="btc"
					placeholder="amount of BTC" />
				<br>
			</c:if>

			<c:if test="${not empty to && not empty amount}">
				<input class="form-control" type="email" id="email" name="email"
					value=${ to } />
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