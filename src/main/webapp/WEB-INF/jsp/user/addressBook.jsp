<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<script>
		function addAddressBookFunction()
		{
			
			$("#addAddressBookForm").modal('show');
			$("#save").click(function(){

				$.ajax({

			        url: "address",
			        method: "POST",
			        dataType: "json",
			        data: {
			        	name: $("input[name ='name']").val(),
			        	email: $("input[name ='email']").val()
			        },
			      
			        success: function(contact){
						var tr = "<tr data-id = \"" + contact.id +"\">" +
						"<td>" + contact.name + "</td>" +
						"<td>" + $("input[name ='email']").val() + "</td>"+
							"<td><button onclick=\"editAddressBookFunction('" + contact.id + "')\" class = \"btn btn-sm btn-default\"> Edit </button>"+
							"</td>" +
						"<td><button onclick=\"deleteAddressBookFunction('" + contact.id + "')\" class = \"delete btn btn-sm btn-default\">Delete</button></td>" +

					"</tr>"
						$("#tbl").append(tr);
						$("#addAddressBookForm").modal('hide');
						tr.effect("highlight", {color: 'red'}, 1500);
			        },
			        error: function (error){
			        	
			        	  alert(error.responseText);
			        }
			    });

			});
		}
		
	</script>
	
	<script>
	function editAddressBookFunction(id)
	{
		$("#editAddressBookForm").modal('show');
		
		$.ajax({
			type: "GET",
			url : "<c:url value='/user/editAddressBook' />",
			data : {addressBookId: id},
			dataType: "text",
			success : function(data)
			
			{
					
				 $("#editName").val(data);
				 console.log(id);
				 $('input[id="addressBookId"]').val(id);
				
				 console.log($('input[id="addressBookId"]').val());
			},
			error : function(e)
			{
				alert(e);
			}
		});
	}
	
	</script>
	
	<script>
	function deleteAddressBookFunction(id){
		$.ajax({
			url: "deleteAddressBook/" + id,
	        method: "DELETE",
	        context: $(this),
	        success: function(department){
	        	$("tr[data-id='" + id + "']").remove();
	        },
	        error: function(error){
	        	alert(error.responseText);
	        }
	    });
	
	
}
</script>
<script>
$(function(){
	$("#editSave").click(function( event ) {
		//alert("in save edit");
		//alert($("#addressBookId").val());
		/* alert("<c:url value='/user/editAddressBook' />" + "/" + $("#addressBookId").val() + "/"  + $("#editName").val()); */
		$.ajax({
			
			url : "editAddressBookSave" + "/" + $("#addressBookId").val() + "/"  + $("#editName").val(),
			dataType: "json",
			
			success : function(data)
			
			{
				//alert("done");
				console.log(data.name);
				$("#editAddressBookForm").modal('hide');
				var tr =$("tr[data-id ='" + data.id +"']");
				tr.find("td[data-field = 'contact-name']").text(data.name);
				tr.effect("highlight", {color: 'red'}, 1500);
			},
			error : function(e)
			{
				//alert(e.responseText);
			}
		});
	});
	return false;
});
</script>
	<div class="container">
		<div class="page-header web-font">
			<h1>Contact</h1>
		</div>
		
		<div class = "well well-lg">
			<table id = "tbl" class = "table table-striped table-condensed">
				<tr>
					<th>Name</th>
					<th>Email</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>

				<c:forEach items="${contacts}" var="contact">
					<tr data-id = "${contact.id}">
						<td data-field = 'contact-name'>${contact.name}</td>
						<td data-field = 'contact-email'>${contact.contact.email}</td>
						<td>
							<button onclick="editAddressBookFunction('${contact.id}')" class = "btn btn-sm btn-default"> Edit </button>
							</td>
						<td><button onclick="deleteAddressBookFunction('${contact.id}')" class = "delete btn btn-sm btn-default">Delete</button></td>

					</tr>
				</c:forEach>
			</table>
			<button onclick="addAddressBookFunction()" class = "btn btn-danger"> Add New Contact </button>
		<br>
		<div style = "color: red;">${error}</div>
		<div style = "color: green;">${success}</div>
		
	</div>
	
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="addAddressBookForm" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Add Contact</h4>
					</div>
					<div class="modal-body">
							<div class="form-group col-md-5" style="margin: 0 auto; float: none;">
								<label>Name</label><input style="text-align: center;" id="name" type="text"
									class="form-control" name="name"
									placeholder="Enter Name" required> <br>
								<label>Email</label><input style="text-align: center;" id="email" type="email"
									class="form-control" name="email"
									placeholder="Enter email" required> <br>
								<div>
									<center>
									<button id="save" style="margin: 0 auto;" 
									class="btn btn-info">Save</button>
									</center>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
			<div class="container">
			<div class="modal fade" id="editAddressBookForm" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Edit Contact</h4>
					</div>
					<div class="modal-body">
						<form id="addressBook" action="<c:url value ='/user/editAddressBook' />" method=GET>
							<div class="form-group col-md-5" style="margin: 0 auto; float: none;">
								<label>Name</label><input style="text-align: center;" id="editName" type="text"
									class="form-control" name="name"
									placeholder="Enter Name" required> <br>
									<input type = "hidden" name="id" id = "addressBookId" />
								<div>
									
									
									
								</div>
							</div>
						</form>
						<center>
						<button id = "editSave" style="margin: 0 auto;" class="btn btn-info">Save</button>
						</center>
					</div>
				</div>
			</div>
		</div>
		</div>
		
		
	</div>
	