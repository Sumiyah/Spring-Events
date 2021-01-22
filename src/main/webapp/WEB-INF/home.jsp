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
				Welcome,
				<c:out value="${user.fname}" />
			</h1>
			<a href="/logout">Logout</a>
		</div>

		<div class="row justify-content-between mt-3">
			<div class="col-12">
				<h4>Here are some of the events in your region ( ${user.state}
					):</h4>
			</div>
			<div class="col">
				<table class="table">
					<thead>
						<tr>
							<th>Event:</th>
							<th>Date</th>
							<th>Location</th>
							<th>Host</th>
							<th>Action / Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${stateEvent}" var="event">
							<tr>
								<td><a href="/events/${ event.id }">${event.name}</a></td>
								<td><fmt:formatDate pattern="dd-MMMM-yyyy"
										value="${event.date}" /></td>
								<td>${event.location}</td>
								<td>${event.user.fname}</td>
								<td><c:if test="${event.user.id == user.id }">
										<a href="/events/${ event.id }/edit">Edit</a> |
						<a href="/events/${ event.id }/delete">Delete</a>
									</c:if> 
									<c:if test="${event.user.id != user.id }">
									<c:if test="${event.isOnEvent(user.id) }">
									<a href="/events/${event.id}/leave">Leave</a>
									</c:if>
									<c:if test="${!event.isOnEvent(user.id) }">
									<a href="/events/${event.id}/join">Join</a>
									</c:if>
									</c:if>
					</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="row justify-content-between mt-3">
			<div class="col-12">
				<h4>Here are some of the events in other regions:</h4>
			</div>
			<div class="col">
				<table class="table">
					<thead>
						<tr>
							<th>Event:</th>
							<th>Date</th>
							<th>Location</th>
							<th>Region</th>
							<th>Host</th>
							<th>Action / Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${notStateEvent}" var="event">
							<tr>
								<td><a href="/events/${ event.id }">${event.name}</a></td>
								<td><fmt:formatDate pattern="dd-MMMM-yyyy"
										value="${event.date}" /></td>
								<td>${event.location}</td>
								<td>${event.state}</td>
								<td>${event.user.fname}</td>
								<td><c:if test="${event.user.id == user.id }">
										<a href="/events/${ event.id }/edit">Edit</a> |
						<a href="/events/${ event.id }/delete">Delete</a>
									</c:if> 
									<c:if test="${event.user.id != user.id }">
									<c:if test="${event.isOnEvent(user.id) }">
									<a href="/events/${event.id}/leave">Leave</a>
									</c:if>
									<c:if test="${!event.isOnEvent(user.id) }">
									<a href="/events/${event.id}/join">Join</a>
									</c:if>
									</c:if>
					</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="row justify-content-between mt-3">
			<div class="col-12">
				<h4>Create an Event</h4>
			</div>
			<div class="col-4">
				<form:form method="post" action="/createEvent"
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
					<input type="submit" value="create!" class="btn btn-success" />
				</form:form>
			</div>
			<div class="col-8">
				<form:errors path="event.*" />
			</div>
		</div>
	</div>
</body>
</html>