<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@page errorPage="error.jsp" %> --%>

<%@ page import="password.Password" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="5;url=index.jsp"> 
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>Password saved!</title>
    </head>
<body>

	<c:choose>
		<c:when test="${param.random != '1234ABC'}">
			<% //  Check link correctness => i.e. exists (used only once!) %>
			Link is not correct or expired! <br>
		</c:when>
		<c:otherwise>
			<sql:query var="users" dataSource="jdbc/lut2">
    			SELECT * FROM users
    			WHERE uname = ? <sql:param value="${param.email}" />
			</sql:query>
			<c:set var="userDetails" value="${users.rows[0]}"/>
			<%
				// does the user exist?
			%>

			<%
				String username = request.getParameter("email");
				String password = request.getParameter("pass");
			%>

			<c:choose>
				<c:when test="${empty userDetails}">
					Added new user with the password. <br>
					<%
						String salt = Password.getSalt();
						String pwhash = Password.hashWithSalt(password, salt);
					%>
					<c:set var="DBpass" value="<%=pwhash%>" />
					<c:set var="DBsalt" value="<%=salt%>" />

					<sql:transaction dataSource="jdbc/lut2">
						<sql:update var="count">
        				INSERT INTO users VALUES (?, ?, ?);
       						<sql:param value="${param.email}" />
							<sql:param value="${DBpass}" />
							<sql:param value="${DBsalt}" />
						</sql:update>
					</sql:transaction>

				</c:when>
				<c:otherwise>
					User existed - updating password! <br>
					<c:set var="DBsalt" value="${userDetails.salt}" />
					<%
						String salt = pageContext.getAttribute("DBsalt").toString();
						String pwhash = Password.hashWithSalt(password,salt);
					%>
					<c:set var="DBpass" value="<%=pwhash%>" />
					<sql:transaction dataSource="jdbc/lut2">
						<sql:update var="count">
							UPDATE users
							SET pw=? <sql:param value="${DBpass}" />
							WHERE uname=? <sql:param value="${param.email}" />;
						</sql:update>
					</sql:transaction>

				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
	<br> You will be redirected to the LUT2.0 main page in a few
	seconds.
</body>
</html>