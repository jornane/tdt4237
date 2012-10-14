<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp" %>

<%@ page import="password.Password" %>

<sql:query var="users" dataSource="jdbc/lut2">
    SELECT * FROM users
    WHERE uname =? <sql:param value="${param.username}" /> 
</sql:query>

    
    
<c:set var="userDetails" value="${users.rows[0]}"/>

<c:choose> <c:when test="${ not empty userDetails }"> <%  // this is for not being able to differenciate between failure
			%><c:set var="DBsalt" value="${userDetails.salt}" /> <% 
			%><c:set var="pass" value="${param.password}" /> <%
			%><c:set var="correctPass" value="${userDetails.pw}" /> <%
				String salt = pageContext.getAttribute("DBsalt").toString();
				String password = pageContext.getAttribute("pass").toString();
				String correctPass = pageContext.getAttribute("correctPass").toString();
				
				String pwhash = Password.hashWithSalt(password, salt);
				int loginResult = 1;
				if (pwhash.equals(correctPass) ) {
					loginResult = 0;
				}
			%> <c:set var="loginSuccess" value="<%=loginResult %>" /> <% 
%> </c:when> </c:choose>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="lutstyle.css">
	<title>LUT logging in</title>
</head>
<body>
	<c:choose>
			<c:when test="${not empty userDetails and loginSuccess == 0}">
					<h1>Login succeeded</h1> 
		                Welcome <c:out value="${ userDetails.uname}" />.<br> 
		        </c:when>
		        <c:otherwise>
		                Login failed <br>
				</c:otherwise>
			</c:choose>
</body>
</html>
