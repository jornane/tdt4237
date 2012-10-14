<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp" %>

<%
String isAuthVal = (String)session.getAttribute( "isAuth" );
	
if(isAuthVal == null)
{
	response.sendRedirect("./login.jsp");
}
else if(!isAuthVal.equals("1"))
{
	response.sendRedirect("./login.jsp");
}

%>

<sql:transaction dataSource="jdbc/lut2">
    <sql:update var="count">
        INSERT INTO user_reviews VALUES (?, ?, ?);
        <sql:param value="${param.school_id}"/>
        <sql:param value="${param.name}"/>
        <sql:param value="${param.review}"/>
    </sql:update>
</sql:transaction>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="5;url=./school_reviews.jsp?school_id=${param.school_id}"> 
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>Review added!</title>
    </head>
    <body>
        <h1>Thanks <c:out value="${param.name}"/>!</h1>
        Your contribution is appreciated.<br>
        You will be redirected back to the review page in a few seconds.
    </tr>
</body>
</html>