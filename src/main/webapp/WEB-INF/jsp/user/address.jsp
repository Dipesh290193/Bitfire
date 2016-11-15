<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="container">
	<div class="page-header">
		<h1>Edit Address</h1>
	</div>
	<div class="well">
		<form:form modelAttribute="address" class="form">
			<table class="table table-condensed table-striped">

				<tr>
					<th>Label</th>
					<th>Address</th>
					<th>USD</th>
					<th>BTC</th>
					<th>Primary</th>
				</tr>
				<tr>
					<td><form:input path="label" class="form-control" /></td>
					<td>${address.address}</td>
					<td>${address.USD}</td>
					<td>${address.bitcoins}</td>

					<c:if test="${not address.primary }">
						<td><input type="checkbox" name="primary" id="primary" /></td>
					</c:if>

					<c:if test="${address.primary }">
						<td>Primary</td>
					</c:if>
				</tr>

			</table>
			<input type="submit" name="save" value="Save"
				class="btn btn-md btn-danger" />
		</form:form>
	</div>
</div>