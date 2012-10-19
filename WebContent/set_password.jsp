<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp" %>

<%@ page import="password.Password" %>
<%@ page import="no.ntnu.idi.tdt4237.h2012.g5.lut.ValidationService" %>
<%@ page import="java.util.UUID" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
 
String password = request.getParameter("pass");
	
if (password.length() < 8) { %>
	    <head>
	        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	        <meta http-equiv="refresh" content="5;url=./password.jsp?email=${param.email}&activationCode=${param.activationCode}"> 
	        <link rel="stylesheet" type="text/css" href="lutstyle.css">
	        <title>Password too short!</title>
	    </head>
	    <body>
	        Entered password has to be at least 8 characters long.
	        You will be redirected back to the password page in a few seconds.
		</body>
	<%
} else { %>



    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="5;url=index.jsp"> 
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>Password saved!</title>
    </head>
<body>
<% 
	String email = request.getParameter("email");
	String activationCode = request.getParameter("activationCode");
	ValidationService vs = ValidationService.getInstance(600000);
	Boolean valid = vs.checkActivationCode(email, UUID.fromString(activationCode));
	vs.invalidate(email);
	if (valid) {
		%>
		<sql:query var="users" dataSource="jdbc/lut2">
    			SELECT * FROM users
    			WHERE uname = ? <sql:param value="${param.email}" />
			</sql:query>
			<c:set var="userDetails" value="${users.rows[0]}"/>
			<%
				String username = request.getParameter("email");
				
				String salt = Password.getSalt();
				String pwhash = Password.hashWithSalt(password, salt);
			%>
			<c:set var="DBpass" value="<%=pwhash%>" />
			<c:set var="DBsalt" value="<%=salt%>" />

			<c:choose>
				<c:when test="${empty userDetails}">
					Added new user with the password. <br>
					
					<sql:transaction dataSource="jdbc/lut2">
						<sql:update var="count">
        				INSERT INTO users VALUES (?, ?, ?, ?);
       						<sql:param value="${param.email}" />
							<sql:param value="${DBpass}" />
							<sql:param value="${DBsalt}" />
							<sql:param value="${param.name}" />
						</sql:update>
					</sql:transaction>

				</c:when>
				<c:otherwise>
					User existed - updating password! <br>
					
					<sql:transaction dataSource="jdbc/lut2">
						<sql:update var="count">
							UPDATE users
							SET pw=? <sql:param value="${DBpass}" /> , salt=? <sql:param value="${DBsalt}" />
							WHERE uname=? <sql:param value="${param.email}" />;
						</sql:update>
					</sql:transaction>

				</c:otherwise>
			</c:choose>
		<%		
	} else {
		%>
		Link is not correct or expired!
		
		<%
	}
%>

	<br> You will be redirected to the LUT2.0 main page in a few
	seconds.
</body>

<% 
} %>

</html>

