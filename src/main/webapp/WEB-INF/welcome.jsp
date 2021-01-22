<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome!</title>
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.0/css/bootstrap.min.css" />
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container mt-5">
		<h1>Welcome!</h1>
		<div class="row justify-content-around mt-4">
			<div class="col-6">
				<h4>Register</h4>
	
				<form:form method="POST" action="/registration"
					modelAttribute="user" class="border border-dark p-3">
					<div class="form-group">
						<form:label path="fname">First Name:</form:label>
						<form:input type="text" path="fname" class="form-control" />
						
					</div>

					<div class="form-group">
						<form:label path="lname">Last Name:</form:label>
						<form:input type="text" path="lname" class="form-control" />
						
					</div>

					<div class="form-group">
						<form:label path="email">Email:</form:label>
						<form:input type="email" path="email" class="form-control" />
					</div>

					<div class="form-group">
						<form:label path="location">Location:</form:label>
						<form:input type="text" path="location" class="form-control" />
					</div>

					<div class="form-group">
						<form:label path="state">Region:</form:label>
						<form:select class="form-control" path="state" >
							<option value="RUH">RUH</option>
							<option value="MED">MED</option>
							<option value="JED">JED</option>
							<option value="YNB">YNB</option>
						</form:select>
					</div>
					<div class="form-group">
						<form:label path="password">Password:</form:label>
						<form:password path="password" class="form-control"/>
					</div>

					<div class="form-group">
						<form:label path="passwordConfirmation">Password Confirmation:</form:label>
						<form:password path="passwordConfirmation" class="form-control" />
					</div>

					<input type="submit" value="Register!" class="btn btn-primary"/>
				</form:form>
			</div>
			<div class="col-6">
				<h4>Login</h4>
				<p>
					<c:out value="${error}" />
				</p>
				<form method="post" action="/login" class="border border-dark p-3 mb-3">
					<div class="form-group">
						<label for="email">Email</label> 
						<input type="text" id="email" name="email" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="password">Password</label> 
						<input type="password" id="password" name="password" class="form-control" />
					</div>
					<input type="submit" value="Login!" class="btn btn-success" />
				</form>
				
				<p>
					<form:errors path="user.*" />
				</p>
			</div>
		</div>
	</div>


</body>
</html>