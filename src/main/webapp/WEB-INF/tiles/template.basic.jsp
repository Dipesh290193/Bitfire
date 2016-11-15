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
<title><tiles:getAsString name='title' /></title>

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
	<div class = "container">
		<tiles:insertAttribute name="content" />
	</div>
	
	<tilesx:useAttribute id='jsUrls' name='jsUrls' />
	<c:forEach items='${jsUrls}' var='jsUrl'>
		<link rel="stylesheet" href='<c:url value='${jsUrl}' />' />
	</c:forEach>
</body>
</html>