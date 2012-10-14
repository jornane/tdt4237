<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp"%>
<%@ page import="password.Password"%>


<%

String isAuthVal = (String)session.getAttribute( "isAuth" );
	
if(isAuthVal == null)
{
	response.sendRedirect("./login.jsp");
}
else if(!isAuthVal.equals("2"))
{
	response.sendRedirect("./adminlogin.jsp");
}

%>


<c:choose>
	<c:when test="${ not empty param.password }">
		<%
			String password = request.getParameter("password");
			String salt = Password.getSalt();
			String pwhash = Password.hashWithSalt(password, salt);
		%>
		<c:set var="DBpass" value="<%=pwhash%>" />
		<c:set var="DBsalt" value="<%=salt%>" />

		<sql:transaction dataSource="jdbc/lut2">
			<sql:update var="count">
        UPDATE users SET
        pw = ? <sql:param value="${DBpass}" />,
        salt = ? <sql:param value="${DBsalt}" />,
        uname = ? <sql:param value="${param.newEmail}" />,
        name = ? <sql:param value="${param.name}" />
        WHERE
        uname = ? <sql:param value="${param.email}" />
			</sql:update>
		</sql:transaction>
	</c:when>
	<c:otherwise>
		<sql:transaction dataSource="jdbc/lut2">
			<sql:update var="count">
        UPDATE users SET
        uname = ? <sql:param value="${param.newEmail}" />,
        name = ? <sql:param value="${param.name}" />
        WHERE
        uname = ? <sql:param value="${param.email}" />
			</sql:update>
		</sql:transaction>
	</c:otherwise>
</c:choose>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="5;url=index.jsp">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>User updated!</title>
</head>
<body>
	<c:choose>
		<c:when test="${count == 0}">
			Unable to update user.
		</c:when>
		<c:otherwise>
			User updated.
		</c:otherwise>
	</c:choose>
	<br>
	<br> You will be redirected to the LUT2.0 main page in a few
	seconds.
</body>
</html>