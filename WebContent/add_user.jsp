<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp" %>
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


<sql:transaction dataSource="jdbc/lut2">
		<%
			String password = request.getParameter("password");
			String salt = Password.getSalt();
			String pwhash = Password.hashWithSalt(password, salt);
		%>
		<c:set var="DBpass" value="<%=pwhash%>" />
		<c:set var="DBsalt" value="<%=salt%>" />

    <sql:update var="count">
        INSERT INTO users VALUES (?, ?, ?, ?);
        <sql:param value="${param.email}"/>
        <sql:param value="${DBpass}"/>
        <sql:param value="${DBsalt}"/>
         <sql:param value="${param.name}"/>       
    </sql:update>
</sql:transaction>


<c:set var="country" value="${countries.rows[0]}"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="5;url=index.jsp">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Review added!</title>
</head>
<body>
	<c:choose>
		<c:when test="${count == 0}">
			Unable to add user.
		</c:when>
		<c:otherwise>
			User added.
		</c:otherwise>
	</c:choose>
	<br>
	You will be redirected to the LUT2.0 main page in a few seconds.
</body>
</html>