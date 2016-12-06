<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<script>
	function updateText() {
		var id = document.getElementById("sel").value;
		if (id != 1)
			document.getElementById("email").value = id;
		else {
			window.location.href = '<c:url value="/user/addressBook" />';
		}
	}
</script>
<script type="text/javascript">
$(function(){
	$("#btc").keyup(function(){
		var value= $("#btc").val();
		$.ajax({
			url: "getBTC",
			method: "post",
			dataType: "json",
			success: function(data){
				$("#btcValue").val(data*value);
			}
		});
	});
});
</script>
<div class="well">
	<div class="container" style="margin-top: 100px">
		<h2 class="web-font">Send Bitcoin</h2>
		<h3 style="float: right;">
			Primary address balance: <span style="color: green;">${balance}</span>
			BTC
		</h3>
		<form class="form" action="<c:url value='/user/send' />"
			method="post">
			<br> <select onchange="updateText()" id="sel">

				<option value="">Select Email</option>
				<c:forEach items="${addressBook}" var="addressBook">
					<option value="${addressBook.contact.email }">${addressBook.name }</option>
				</c:forEach>
				<option value="1">Add New Contact</option>
			</select> <br> <br>
			
	

				
					<input class="form-control" type="email" id ="email" name="email"
						placeholder="recepient's email address" />
					<br>
					<div class = "row">
						<div class = "col-md-6">
							<input class="form-control" type="text" name="btc" id ="btc"
						placeholder="amount of BTC" />
						</div>
						<div class = "col-md-6">
						<input class = "form-control" type="text" id = "btcValue" placeholder="amount in USD" readonly/>
						</div>
					</div>
					<br>
					<input
					class="form-control" type="text" name="reason"
					placeholder="Message" /><br>
				

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
						href="<c:url value ='/user/selftransfer' />">Self
						Transfer</a>
				</h4>
			</div>
		</c:if>
	</div>
</div>

