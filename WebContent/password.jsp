
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="no.ntnu.idi.tdt4237.h2012.g5.lut.ValidationService" %>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Set Password</title>
</head>

<body>
	<c:choose>
		<c:when test="${param.random == '1234ABC'}"> <%-- Check link correctness => i.e. exists (used only once!) --%>
			<form method="post" action="set_password.jsp">
				<input type="hidden" name="email" value="${param.email}" />
				<input type="hidden" name="random"   value="${param.random}" /> <% //  the random value from link otherwise can change the username (should not make it used at this point!) %> 
				Please enter your new password <input type="password" name="pass" /><br>
				<input type="submit" value="submit" />
			</form>
			<br>
			<br>
		</c:when>
		<c:otherwise>
			Link is not correct or expired!
			<br> <br>
		</c:otherwise>
	</c:choose>
</body>
</html>


