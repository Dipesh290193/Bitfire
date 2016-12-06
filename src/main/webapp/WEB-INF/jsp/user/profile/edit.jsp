<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
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
						action="<c:url value ='/user/text/confirmation' />">
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
		</div>
		<div id="error" class="modal-footer"
			style="text-align: center; color: red;"></div>
	</div>
</div>

<div class="well">
	<form id = 'edit_profile' action = "" method="">
		<label for="username">Username:</label>
		<input data-field = "username" class="form-control" value=${user.username } readonly = "readonly" disabled = "disabled" />
		<br>
		<label for="email">Email:</label>
		<input data-field = "email" class="form-control" value=${user.email } readonly = "readonly" disabled = "disabled"/>
		<br>
		<label for="name">Name:</label>
		<input data-field = "name" class="form-control" value=${user.name } readonly = "readonly" disabled = "disabled"/>
		<br>
		<label for="password">Password:</label>
		<input data-field = "password" class="form-control" value=${user.password } readonly = "readonly" disabled = "disabled" />
		<br>
		<label for="phone">Phone:</label>
		<input data-field = "phone" class="form-control" value=${user.phone } readonly = "readonly" disabled = "disabled"/>
		<br>
		<input type = 'hidden' data-field='wallet' value=${user.wallet.walletId }>
		<button id = "edit" type="button" class="btn btn-danger">Edit Profile</button>
	</form>
</div>

<script>
	$(function(){
		$('form#edit_profile > button').on('click', function(){
			//console.log($('button[id = "edit"]'));
			//console.log($('input[type = "hidden"]').attr('value'));
			
			if($('button[id = "edit"]').length == 1){
				$('input')
				.removeAttr('readonly')
				.removeAttr('disabled');
			
				$(this)
				.removeClass('btn-danger')
				.addClass('btn-success')
				.attr('id','update')
				.text('Submit Changes');
			}
			else if ($('button[id = "update"]').length == 1){
				 console.log('sending code');
				$('#myModal').modal('show');
				$.ajax({
					url : $('#confirm').attr('action'),
					method : "POST",
					data : "hi",

					success : function(data) {
						/* alert("sent message"); */
					},
					error : function(request, status, error) {
						alert(request.responseText);
					}
				});
			}
		});
		
		$('#call').on('click', function(e) {
			$.ajax({
				headers : {
					Accept : "text/plain",
					"Content-Type" : "text/plain"
				},
				//url : $('#confirm').attr('action'),
				url: '/bitfire/user/text/confirmation',
				method : "GET",
				data : {
					code : $('#confNum').val(),
				},

				success : function(data) {
					if (data == 'success') {
						$('#myModal').modal('hide');
						var username = $('input[data-field = "username"]').val();
						var email = $('input[data-field = "email"]').val();
						var name = $('input[data-field = "name"]').val();
						var password = $('input[data-field = "password"]').val();
						var phone = $('input[data-field = "phone"]').val();
						var walletId = $('input[type = "hidden"]').attr('value');
						$.ajax({
							url: 'edit ',
						    method: "POST",
						    dataType: "text",
						    processData: false,
					        contentType: "application/json",
					        data: JSON.stringify({
					            username: username,
					            email: email,
					            name: name,
					            password: password,
					            phone: phone
					        }),
					        success: function(data){
						        var $message = $('<div style="color: #00ff00; text-align:center" ><h3>Profile was successfully updated!</h3></div>')
						        $('form#edit_profile').before($message)
						        console.log('done');
					        }
					        //statusCode: {
					        //	200: function(){
					        //		var $message = $('<div style="color: #00ff00; text-align:center" ><h3>Profile was successfully updated!</h3></div>')
					        //		$('form#edit_profile').before($message)
					        //		console.log('done');
					        //	}
					        //},
/* 					        complete: function(data){
						        alert(data.username);
					        } */
					        //error: function(data){
					        //	console.log(data);
					        //}
						});
						
						//document.getElementById("userForm").submit();
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
	});
</script>