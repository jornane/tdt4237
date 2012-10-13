<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp" %>

<sql:transaction dataSource="jdbc/lut2">
    <sql:update var="count">
        UPDATE users SET
        email = ? <sql:param value="${param.newEmail}"/>
        WHERE
        email = ? <sql:param value="${param.email}"/>
    </sql:update>
</sql:transaction>

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
	<br><br>
	You will be redirected to the LUT2.0 main page in a few seconds.
</body>
</html>