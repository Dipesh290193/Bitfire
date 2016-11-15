<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Confirmation</h4>
				</div>
				<div class="modal-body">
					<center>We have sent a confirmation text to ${user.phone }.</center>
					<center>Please enter the 4 digit confirmation number
						below.</center>
					<br>

					<form id="confirm"
						action="<c:url value ='/user/text/confirmation.html' />"
						method="post">
						<div class="form-group col-md-5"
							style="margin: 0 auto; float: none;">
							<input style="text-align: center;" id="confNum" type="text"
								class="form-control" name="confirmation"
								placeholder="Confirmation Number"> <br>
							<div>
								<center>
									<button id="call" style="margin: 0 auto;" class="btn btn-info"
										data-dismiss="modal">Confirm and Save</button>
								</center>
							</div>
					</form>
				</div>
			</div>
			<div id="error" class="modal-footer"
				style="text-align: center; color: red;"></div>
		</div>
	</div>
</div>


<div class="well">
	<form:form modelAttribute="user" class="form" id="userForm"
		metod="post">
		<label for="username">Username:</label>
		<form:input path="username" class="form-control" />
		<br>
		<label for="email">Email:</label>
		<form:input path="email" class="form-control" />
		<br>
		<label for="name">Name:</label>
		<form:input path="name" class="form-control" />
		<br>
		<label for="password">Password:</label>
		<form:input path="password" class="form-control" />
		<br>
		<label for="phone">Phone:</label>
		<form:input path="phone" class="form-control" />
		<br>
		<input type="submit" class="btn btn-success" value="Save Changes" />
	</form:form>
</div>
</div>

<script>
	//text confirmation number
	$("#userForm").submit(function(e) {
		$('#myModal').modal('show');
		$.ajax({
			url : $('#confirm').attr('action'),
			type : "POST",
			data : "hi",

			success : function(data) {
				/* alert("sent message"); */
			},
			error : function(request, status, error) {
				alert(request.responseText);
			}
		});
		return false;
	});
</script>

<script type="text/javascript">
	$('#call').on('click', function(e) {
		$.ajax({
			headers : {
				Accept : "text/plain",
				"Content-Type" : "text/plain"
			},
			url : $('#confirm').attr('action'),

			type : "GET",
			data : {
				code : $('#confNum').val(),
			},

			success : function(data) {
				if (data == 'success') {
					$('#myModal').modal('hide');
					document.getElementById("userForm").submit();
				} else {
					$('#error').text(data);
				}
			},
			error : function(request, status, error) {
				alert(request.responseText);
			}
		});

		return false;
	});
</script>
