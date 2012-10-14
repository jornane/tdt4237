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

<sql:transaction dataSource="jdbc/lut2">
    <sql:update var="count">
        DELETE FROM users WHERE
        uname = ? <sql:param value="${param.email}"/>
    </sql:update>
</sql:transaction>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="5;url=index.jsp">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>User deleted!</title>
</head>
<body>
	<c:choose>
		<c:when test="${count == 0}">
			Unable to find user.
		</c:when>
		<c:otherwise>
			User deleted.
		</c:otherwise>
	</c:choose>
	<br><br>
	You will be redirected to the LUT2.0 main page in a few seconds.
</body>
</html>