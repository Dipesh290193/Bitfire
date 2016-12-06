<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="tilesx"
	uri="http://tiles.apache.org/tags-tiles-extras"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=ISO-8859-1'>
<link rel="shortcut icon" href="<tiles:insertAttribute name="favicon" />" type="image/x-icon" />

<title><tiles:getAsString name='title' /></title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
<link rel="stylesheet" href='<c:url value="/css/bitfire-base.css" />' />
<link rel="stylesheet" href='<c:url value='/css/bitfire-nav.css' />' />

<tilesx:useAttribute id='cssUrls' name='cssUrls' />
<c:forEach items='${cssUrls}' var='cssUrl'>
	<link rel="stylesheet" href='<c:url value='${cssUrl}' />' />
</c:forEach>


<tilesx:useAttribute id='fontUrls' name='fontUrls' />
<c:forEach items='${fontUrls}' var='fontUrl'>
	<link rel="stylesheet" href='<c:url value='${fontUrl}' />' />
</c:forEach>
</head>
<body>
	<tiles:insertAttribute name="navbar" />
	<tiles:insertAttribute name="content" />
	
	<tilesx:useAttribute id='jsUrls' name='jsUrls' />
	<c:forEach items='${jsUrls}' var='jsUrl'>
		<script src='<c:url value='${jsUrl}' />' ></script>
	</c:forEach>
</body>
</html>