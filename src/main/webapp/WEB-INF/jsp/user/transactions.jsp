<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<div class="container">
	<div class="page-header">
		<h1>Transactions</h1>
	</div>

	<div class="container">
		<div class="well">
			<table class="table table-striped table-condensed">
				<tr>
					<th>Date</th>
					<th>Type</th>
					<th>Email</th>
					<th>TX</th>
					<th>BTC</th>
					<th>USD</th>
					<th>Confirmations</th>
				</tr>
				<c:forEach items="${transactions}" var="trans">
					<tr>
						<td>${trans.date}</td>
						<c:if
							test="${ trans.senderUser.userId eq trans.receiverUser.userId}">
							<td>Self transfer</td>
							<td>${trans.receiverUser.username}</td>
						</c:if>

						<c:if
							test="${ trans.senderUser.userId ne trans.receiverUser.userId}">
							<c:if test="${user.userId eq trans.senderUser.userId}">
								<td>Sent</td>
								<td>${trans.receiverUser.email}</td>
							</c:if>
							<c:if test="${ user.userId eq trans.receiverUser.userId}">
								<td>Received</td>
								<td>${trans.senderUser.email}</td>
							</c:if>
						</c:if>
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