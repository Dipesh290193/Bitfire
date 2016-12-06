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

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
<script>
$(function(){
$("#addButton").click(function(){
	$("#errorDiv").html("");
	var anim ="<div id = \"loader\" class = \"loader\"></div>" +
	"<div id =  \"loaderText\"><h4>Generating a new address...</h4></div>";
		
	$("#addressTable").append(anim);
    $.ajax({
        url: $('#userForm').attr('action'),
        method: "GET",
        dataType: "json",
        
      
        success: function(address){
        
       	
        	var row = 
				"<tr>" +
			"<td>" + address.address + "</td>" + 
			"<td>" + address.label + "</td>" +
			"<td>$0.00</td>" +
			"<td>" + address.bitcoins + "</td>";
			<c:if test="${address.primary }">
				row += "<td>Primary</td>";
			</c:if>
			<c:if test="${not address.primary }">
				row += "<td></td>";
			</c:if>

			row +=
			"<td><a " + 
				"href=\"<c:url value='/user/editaddress?id=${ address.addressId }' />\"" +
				"class=\"btn btn-sm btn-default\">Edit</a></td>" +
			"<td><button data-id = \"" +  address.addressId +"\" class=\"archive btn btn-sm btn-default\">Archive</button></td>"+
				
		"</tr>";
			$("#loader").remove();
			$("#loaderText").remove();
			
        	$("#addressTable").append(row);
        },
        error: function (error){
        	
        	  alert(error.responseText);
        }
    });
});
});

</script>


	<script>
$(function(){
	$(".archive").click(function(){
		
		event.preventDefault();
		$("#errorDiv").html("");
		var id = $(this).attr("data-id");
		$.ajax({
			url: "archiveaddress/" + id,
	        method: "GET",
	        dataType: "text",
	        context: $(this),
	        success: function(data){
	       
	        	if(data != "OK"){
	        		
	        		$("#errorDiv").html(data);
	        	}
	        	else{
	        		$(this).closest("tr").remove();
	        	}
	        },
	        error: function(error){
	        	alert(error.responseText);
	        }
	    });
	});
	
});
</script>

<div class="container">
	<div class="page-header web-font">
		<h1>My Wallet</h1>
	</div>

	<div class="well well-lg">
		<form id = "userForm" action="<c:url value='/user/addaddress' />" action='GET'>

			<table id ="addressTable" class="table table-striped table-condensed">
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
							href="<c:url value='/user/editaddress?id=${ address.addressId }' />"
							class="btn btn-sm btn-default">Edit</a></td>
						<td><button data-id = "${ address.addressId }" class="archive btn btn-sm btn-default">Archive</button></td>
							

					</tr>
				</c:forEach>
			</table>
			
			<input
				type="button"
				onclick='location.href="<c:url value ='/user/selftransfer' />"'
				value="Self Transfer" class="btn btn-danger">
		</form>
		<br>
		<button id = "addButton" class="btn btn-danger"> Add address</button>
		<br>
		<div style="color: red;">${message}</div>
		<br>
		<div id = "errorDiv" style="color: red; font-size: 1.2em;"></div>
	</div>
</div>