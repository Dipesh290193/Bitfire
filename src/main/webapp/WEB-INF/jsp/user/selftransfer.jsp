<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<div class="container" style="margin-top: 100px">
	<div class="well">
		<form class="form" action="<c:url value= '/user/selftransfer.html'/>"
			method="post">
			FROM: <select class="dropdown" name="from" style="margin-left: 6px;">
				<c:forEach items="${addresses}" var="address">
					<option value="${address.addressId}">${address.label}:
						${address.address} : ${address.bitcoins}</option>
				</c:forEach>
			</select> </br> </br> TO: <select class="dropdown" name="to" style="margin-left: 24px;">
				<c:forEach items="${addresses}" var="address">
					<option value="${address.addressId}">${address.label}:
						${address.address} : ${address.bitcoins}</option>
				</c:forEach>
			</select> <br /> <br /> <label style="float: left;"><strong>BTC</strong></label>
			<div class="col-xs-3" style="margin-left: 9px;">

				<input type="text" name="amount" class="form-control input-md"
					placeholder="amount of BTC to tranfser" />

			</div>
			<br /> <br /> <br /> <input class="btn btn-danger" type="submit"
				value="Transfer" />
		</form>
		<br>
		<div style="color: green;">
			<strong>${message}</strong>
		</div>

		<p>${selftranfererror}</p>
		<c:if test="${selftranfererror ne null}">
			<div style="color: red">${selftranfererror}
				<a href="<c:url value ='/user/selftransfer.html' />">Self
					Transfer</a>
			</div>
		</c:if>

		<div style="color: red;">
			<strong>${error}</strong>
		</div>

	</div>
</div>