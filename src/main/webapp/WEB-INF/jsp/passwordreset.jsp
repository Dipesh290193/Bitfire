<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
<div class="row">
<div class="col-sm-12">
<h3>Change Password</h3>
</div>
</div>
<div class="row">
<div class="col-sm-6 col-sm-offset-3">
<h5 class="text-center">Use the form below to change your password.</h5>
<form method="post" id="passwordForm"=  action = "<c:url value='/reset.html' />" >
<input type="password" class="input-lg form-control" name="password1" id="password1" placeholder="New Password" autocomplete="off">
<br>
<input type="password" class="input-lg form-control" name="password2" id="password2" placeholder="Repeat Password" autocomplete="off">
<input type = "hidden" value = "${param.token }" name = "token"/>
<br>
<input type="submit" class="col-xs-12 btn btn-primary btn-load btn-lg" data-loading-text="Changing Password..." value="Change Password">
</form>
</div><!--/col-sm-6-->

	

</div><!--/row-->
<br>
<center style ="color:red;">${param.error }</center>
</div>
</body>
</html>