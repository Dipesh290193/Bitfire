<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<style>
.loader {
	border: 16px solid #f3f3f3;
	border-radius: 50%;
	border-top: 16px solid blue;
	border-bottom: 16px solid blue;
	width: 12px;
	height: 12px;
	-webkit-animation: spin 2s linear infinite;
	animation: spin 2s linear infinite;
}

@
-webkit-keyframes spin { 0% {
	-webkit-transform: rotate(0deg);
}

100%
{
-webkit-transform






:



 



rotate






(360
deg




);
}
}
@
keyframes spin { 0% {
	transform: rotate(0deg);
}
100%
{
transform






:



 



rotate






(360
deg




);
}
}
</style>
<script>
	$(function() {
		$("#addButton")
				.click(
						function() {
							$("#errorDiv").html("");
							var anim = "<div id = \"loader\" class = \"loader\"></div>"
									+ "<div id =  \"loaderText\"><h4>Generating a new address...</h4></div>";

							$("#addressTable").append(anim);
							$
									.ajax({
										url : $('#userForm').attr('action'),
										method : "GET",
										dataType : "json",

										success : function(address) {

											var row = "<tr id = " + address.addressId + ">"
													+ "<td>"
													+ address.address
													+ "</td>"
													+ "<td>"
													+ address.label
													+ "</td>"
													+ "<td>$0.00</td>"
													+ "<td>"
													+ address.bitcoins
													+ "</td>";
											<c:if test="${address.primary }">
											row += "<td>Primary</td>";
											</c:if>
											<c:if test="${not address.primary }">
											row += "<td></td>";
											</c:if>

											row += "<td><a "
													+ "href=\"<c:url value='/user/editaddress?id="
													+ address.addressId
													+ "'/>\""
													+ "class=\"btn btn-sm btn-default\">Edit</a></td>"
													+ "<td><button onclick=\"archiveFunc('"
													+ address.addressId
													+ "')\" data-id = \""
													+ address.addressId
													+ "\" class=\"archive btn btn-sm btn-default\">Archive</button></td>"
													+

													"</tr>";
											$("#loader").remove();
											$("#loaderText").remove();

											$("#addressTable").append(row);
										},
										error : function(error) {

											alert(error.responseText);
										}
									});
						});
	});
</script>


<script>
	function archiveFunc(id) {

		event.preventDefault();
		$("#errorDiv").html("");

		$.ajax({
			url : "archiveaddress/" + id,
			method : "GET",
			dataType : "text",
			context : $(this),
			success : function(data) {

				if (data != "OK") {

					$("#errorDiv").html(data);
				} else {
					$("tr[id ='" + id + "']").remove();
				}
			},
			error : function(error) {
				alert(error.responseText);
			}
		});

	};
</script>

<script>
	function editAddressFunction(id, usd) {
		$('#editprimary').prop('checked', false);
	    $.ajax({
	        url: "editaddress/" + id,
	        dataType: "json",
	        success: function(data) {
	        	
	        	
	    	 	$("#editaddress").val(data.address);
	    		$("#editaddressLabel").val(data.label);
	     		 $("#editaddressUSD").val(usd);
	    		$("#editaddressBTC").val(data.bitcoins);  
	    		$("#addressId").val(data.addressId);  
	    		
	    		if(data.primary == true){
	    		
	    			$('#editprimary').prop('checked', true);
	    		}
	    		 
	        }

	    }); 
		$("#editAddressForm").modal('show');

		
	
	}
</script>

<script>
function saveEdit() {

	$.ajax({
			type: "POST",
			url : "editaddress/" + $("#addressId").val() + "/" + $("#editaddressLabel").val() + "/" + $("#editprimary").is(":checked"),
			dataType: "json",
			
			success : function(data){
				
				var tr = $("tr[id='" + data.addressId + "']");
			
				tr.find("td[id='addressLabel']").html(data.label);
	    		if(data.primary == true){
	    			 var td =$("td:contains(Primary)" );
	    			
	    			td.html("");
	    			tr.find("td[id='primary']").html("Primary");
	    		}
	    		else{
	    			tr.find("td[id='primary']").html("");
	    		}
	    		$("#editAddressForm").modal('hide');
	    		tr.effect("highlight", {color: 'red'}, 1500);
				/* alert(data); */
			},
			error: function(error){
				alert(error.responseText)
			}
	});
}
</script>

<div class="container">
	<div class="page-header web-font">
		<h1>My Wallet</h1>
	</div>

	<div class="well well-lg">


		<table id="addressTable" class="table table-striped table-condensed">
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
				<tr id="${ address.addressId }">
					<td id="address">${address.address}</td>
					<td id="addressLabel">${address.label}</td>
					<td id="addressUSD">${address.USD}</td>
					<td id="addressBTC">${address.bitcoins}</td>
					<c:if test="${address.primary }">
						<td id="primary">Primary</td>
					</c:if>
					<c:if test="${not address.primary }">
						<td id="primary"></td>
					</c:if>

					<td><button
							onclick="editAddressFunction('${ address.addressId }', '${address.USD}')"
							class="btn btn-sm btn-default">Edit</button></td>

					<td><button onclick="archiveFunc('${address.addressId}')"
							class="btn btn-sm btn-default">Archive</button></td>


				</tr>
			</c:forEach>
		</table>

<div>
		<input style="float: left; margin-right: 1em;" type="button"
			onclick='location.href="<c:url value ='/user/selftransfer' />"'
			value="Self Transfer" class="btn btn-danger"> 
		<button style="float: left;" id="addButton" class="btn btn-danger">Add address</button>
		</div>
		<br>
		
		
		<div class="modal fade" id="editAddressForm" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Edit Address</h4>
					</div>
					<div class="modal-body">
						<form id="addressBook" id = "editForm"
							action="<c:url value ='/user/editAddressBook' />" method=GET>
							<div class="form-group">


								Address: <input id="editaddress" type="text"
									class="form-control" name="editaddress" readonly>



								Label: <input id="editaddressLabel" name="editaddressLabel"
									type="text" class="form-control">  USD: <input
									id="editaddressUSD" name="editaddressUSD" type="text"
									class="form-control" readonly> BTC: <input
									id="editaddressBTC" name="editaddressBTC" type="text"
									class="form-control" readonly> Primary: <input
									type="checkbox" id="editprimary" class="form-control checkbox" />
								<br> <input type="hidden" name="id" id="addressId" />
								<div></div>
							</div>
						</form>
						<center>
							<button onclick = "saveEdit()" id="editSave" style="margin: 0 auto;"
								class="btn btn-info">Save Changes</button>
						</center>
					</div>
				</div>
			</div>
		</div>
		<div style="color: red;">${message}</div>
		<br>
		<div id="errorDiv" style="color: red; font-size: 1.2em;"></div>
	</div>
</div>