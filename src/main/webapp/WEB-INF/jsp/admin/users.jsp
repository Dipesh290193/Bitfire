<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<div class="container">
	<div class="page-header web-font white">
		<h1>Users</h1>
	</div>
	<div class="well well-lg">
		<table class="table table-condensed table-striped">
			<tr>
				<th>Username</th>
				<th>email</th>
				<th>Admin</th>
				<th>Enable/Disable</th>
			</tr>
			<c:forEach items="${users}" var="user">
				<tr>
					<td>${user.username }</td>
					<td>${user.email }</td>
					<td><c:forEach items="${user.roles}" var="role">
							<c:if test="${role eq 'ROLE_USER'}">
								<a
									href="<c:url value='/admin/makeAdmin.html?id=${user.userId }' />">MakeAdmin</a>
							</c:if>
							<c:if test="${role eq 'ROLE_ADMIN'}">
								<a
									href="<c:url value='/admin/makeUser.html?id=${user.userId }' />">MakeUser</a>
							</c:if>
						</c:forEach></td>
					<td><c:if test="${user.enabled}">
							<a
								href="<c:url value='/admin/disableUser.html?id=${user.userId }' />">Disable</a>
						</c:if> <c:if test="${not user.enabled}">
							<a
								href="<c:url value='/admin/enableUser.html?id=${user.userId }' />">Enable</a>
						</c:if></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>