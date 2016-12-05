<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

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
								<td><a href = "<c:url value='/user/invoices/pay?id=${invoice.invoiceId }' />" 
								role="button" class="btn btn-success btn-sm">   Pay  </a></td>
							</c:if>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>