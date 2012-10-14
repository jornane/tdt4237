<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp" %>

<%

String isAuthVal = (String)session.getAttribute( "isAuth" );
	
if(isAuthVal == null)
{
	response.sendRedirect("./adminlogin.jsp");
}
else if(!isAuthVal.equals("2"))
{
	response.sendRedirect("./adminlogin.jsp");
}

%>


<sql:query var="existingContries" dataSource="jdbc/lut2">
    SELECT * FROM country
    WHERE  short_name = ? <sql:param value="${param.short_name_country}" /> 
    OR full_name = ? <sql:param value="${param.full_name_country}" />
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="5;url=admin.jsp">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Review added!</title>
</head>
<body>

	<c:choose>
		<c:when test="${param.short_name_country.length() == 0}">
			Short name not specified correctly!
		</c:when>
		<c:when test="${param.full_name_country.length() == 0}">
			Full name not specified correctly!
		</c:when>		
		<c:when test="${existingContries.rowCount == 0}">
			<sql:update var="country" dataSource="jdbc/lut2">
        INSERT INTO country VALUES (?, ?);
        <sql:param value="${param.short_name_country}" />
				<sql:param value="${param.full_name_country}" />
			</sql:update>
			
			<h1>Country added!</h1>
		</c:when>
		<c:otherwise>
			You cannot add a country with same short name and/or full name as existing country.
		</c:otherwise>
	</c:choose>
	<br>
	You will be redirected to the admin page in a few seconds.
</body>
</html>