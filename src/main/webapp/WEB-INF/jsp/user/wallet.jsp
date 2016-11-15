<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<div class="container">
	<div class="page-header web-font">
		<h1>My Wallet</h1>
	</div>

	<div class="well well-lg">
		<form action="<c:url value='/user/addaddress.html' />" action='GET'>

			<table class="table table-striped table-condensed">
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
							href="<c:url value='/user/editaddress.html?id=${ address.addressId }' />"
							class="btn btn-sm btn-default">Edit</a></td>
						<td><a
							href="<c:url value='/user/archiveaddress.html?id=${ address.addressId }' />"
							class="btn btn-sm btn-default">Archive</a></td>

					</tr>
				</c:forEach>
			</table>
			<input type="submit" value="Add address" class="btn btn-danger" /> <input
				type="button"
				onclick='location.href="<c:url value ='/user/selftransfer.html' />"'
				value="Self Transfer" class="btn btn-danger">
		</form>
		<br>
		<div style="color: red;">${message}</div>
	</div>
</div>