<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

	<div class="container">
		<div class="page-header">
			<h1>Pay Invoice</h1>
		</div>

		<div class="container">
			<div class="well">
				<table class="table table-striped table-condensed">
					<tr>
						<th>Date</th>
						<th>Email</th>
						<th>BTC</th>
						<th>USD</th>

					</tr>

					<tr>
						<td>${invoice.date}</td>
						<td>${invoice.senderUser.email}</td>


						<td>${invoice.bitcoin}</td>
						<td>${invoice.USD}</td>

					</tr>

				</table>


		<br>
	<br>		
				<h3 >
					Primary address balance: <span style="color: green;">${balance}</span>
					BTC
				</h3>
				<form class="form" action="<c:url value='/user/invoices/pay' />"
					method="post">



					<input class="form-control" type="email" id="email" name="email"
						value=${ invoice.senderUser.email } readonly/> <br>
						 <input class="form-control" type="text" name="btc" value=${ invoice.bitcoin } readonly/> <br> 
						<input class="btn btn-danger btn-block" type="submit" value="Pay Invoice" />
						 <input type = "hidden" name ="id" value = ${ invoice.invoiceId } /> 
						 <input type = "hidden" name ="reason" value = ${ invoice.message } /> 
				</form>
				<br />
				<div style="color: red">
					<h4>${error}</h4>
				</div>

			</div>
		</div>
	</div>