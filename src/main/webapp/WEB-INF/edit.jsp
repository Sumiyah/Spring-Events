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
		<div class="col-12">
		<h3>Edit Event:</h3>
		</div>
					<div class="col-4">
		<form:form method="post" action="/updateEvent/${event.id}"
					class="border border-dark p-3 mb-3" modelAttribute="event">
					<div class="form-group">
						<label for="name">Name</label> <input type="text" id="name"
							name="name" class="form-control" />
					</div>
					<div class="form-group">
						<form:label path="date">Date:</form:label>
						<form:input type="date" path="date" class="form-control" />
					</div>
					<div class="form-group">
						<form:label path="location">Location:</form:label>
						<form:input type="text" path="location" class="form-control" />
					</div>

					<div class="form-group">
						<form:label path="state">Region:</form:label>
						<form:select class="form-control" path="state">
							<option value="RUH">RUH</option>
							<option value="YNB">YNB</option>
							<option value="MED">MED</option>
							<option value="DMM">DMM</option>
							<option value="JED">JED</option>
						</form:select>
					</div>
					<input type="submit" value="Edit!" class="btn btn-success" />
				</form:form>
				</div>
				<div class="col-8">
				<form:errors path="event.*" />
			</div>
		</div>
		
	</div>
</body>
</html>