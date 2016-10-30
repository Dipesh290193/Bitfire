<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<meta charset="UTF-8">
<title>Profile</title>
</head>
<body>

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
						<center>Please enter the 4 digit confirmation number below.</center>
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
<div class = "col-md-6" style ="float: none; margin-left: auto; margin-right: auto; margin-top: 2em;
 border: 1px solid black; padding: 2em; border-radius: 20px;">
		<form:form modelAttribute="user" class="form" id="userForm"
			metod="post">
	Username: <form:input path="username" class="form-control" />
			<br>
	Email: <form:input path="email" class="form-control" />
			<br>
	Name: <form:input path="name" class="form-control" />
			<br>
	Password: <form:input path="password" class="form-control" />
			<br>
	Phone: <form:input path="phone" class="form-control" />
			<br>
			<input type="submit" class="btn btn-success" value ="Save Changes"/>
		</form:form>
	</div>
	</div>
	<script>
		//text confirmation number
		$("#userForm").submit(function(e){
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
</body>
</html>