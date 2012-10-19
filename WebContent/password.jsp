
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="no.ntnu.idi.tdt4237.h2012.g5.lut.ValidationService" %>
<%@ page import="java.util.UUID" %>

<sql:query var="users" dataSource="jdbc/lut2">
    	SELECT * FROM users
    	WHERE uname = ? <sql:param value="${param.email}" />
</sql:query>
<c:set var="userDetails" value="${users.rows[0]}"/>


<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Set Password</title>
</head>

<body>

<% 
	String email = request.getParameter("email");
	String activationCode = request.getParameter("activationCode");
	ValidationService vs = ValidationService.getInstance(600000);
	Boolean valid = vs.checkActivationCode(email, UUID.fromString(activationCode));
	if (valid) {
		%>
		<form method="post" action="set_password.jsp">
				<input type="hidden" name="email" value="${param.email}" />
				<input type="hidden" name="activationCode"   value="${param.activationCode}" /> <% //  the random value from link otherwise can change the username (should not make it used at this point!) %> 
				<c:if test="${empty userDetails}">
					Enter your display name: <input type="text" name="name" /> <br>
				</c:if>
				Please enter your new password <input type="password" name="pass" /> (must be at least 8 characters)<br>
				<input type="submit" value="submit" />
		</form>
		<%
	} else {
		%>
		Link is not correct or expired!
		
		<%
	}
%>
</body>
</html>


