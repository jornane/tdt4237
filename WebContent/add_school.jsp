<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp" %>

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
 
 
<sql:query var="countries" dataSource="jdbc/lut2">
    SELECT * FROM country
    WHERE full_name = ? <sql:param value="${param.country}" />
</sql:query>

<sql:query var="existingSchools" dataSource="jdbc/lut2">
    SELECT * FROM country, school
    WHERE country.full_name = ? <sql:param value="${param.country}" />
    AND school.country = country.short_name
    AND (school.short_name = ? <sql:param value="${param.short_name_school}" /> 
	OR school.full_name = ? <sql:param value="${param.full_name_school}" /> )
</sql:query>


<c:set var="country" value="${countries.rows[0]}"/>

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
		<c:when test="${param.short_name_school.length() == 0}">
			Short name not specified correctly!
		</c:when>
		<c:when test="${param.full_name_school.length() == 0}">
			Full name not specified correctly!
		</c:when>	
		<c:when test="${param.place_school.length() == 0}">
			Place not specified correctly!
		</c:when>
		<c:when test="${param.zip_school.length() == 0}">
			Zip not specified correctly!
		</c:when>
        <c:when test="${ empty country }">
			Country not specified correctly!
		</c:when>	
		<c:when test="${existingSchools.rowCount == 0}">
			<sql:update var="school" dataSource="jdbc/lut2">
        INSERT INTO school (full_name, short_name, place, zip, country) VALUES (?, ?, ?, ?, ?);
       			<sql:param value="${param.full_name_school}" />
				<sql:param value="${param.short_name_school}" />
				<sql:param value="${param.place_school}" />
				<sql:param value="${param.zip_school}" />
				<sql:param value="${country.short_name}" />
			</sql:update>
			
			<h1>School added!</h1>
		</c:when>
		<c:otherwise>
			You cannot add a school with same short name and/or full name as existing school in same country.
		</c:otherwise>
	</c:choose>
	<br>	You will be redirected to the admin page in a few seconds.
</body>
</html>