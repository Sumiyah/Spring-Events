<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Events</title>
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.0/css/bootstrap.min.css" />
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container mt-5">
		<div class="row justify-content-between">
			<h1>
				<c:out value="${event.name}" />
			</h1>
			
			<p><a href="/home">Back</a> | <a href="/logout">Logout</a></p>
		</div>
		<div class="row justify-content-between">
		<h6>
		<strong>Host: </strong> ${event.user.fname} ${event.user.lname} <br>
		<strong>Date: </strong> <fmt:formatDate pattern="dd-MMMM-yyyy" value="${event.date}" /> <br>
		<strong>Location: </strong> ${event.location}, ${event.state} <br>
		<strong>People who are attending this event: </strong> ${event.attendance.size()}
		</h6>
		
		<table class="table mt-5">
		<thead>
		<tr>
		<th>Name</th>
		<th>Location</th>
		</tr>
		</thead>
		<tbody>
	 	<c:forEach items="${event.attendance }" var="e">
	 	<tr> 
	 	<td>${e.fname } ${e.lname } </td>
	 	<td>${e.location }</td>
	 	</tr>
	 	</c:forEach> 
		</tbody>
		</table>
		</div>
		
	</div>
</body>
</html>