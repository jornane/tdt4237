<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp"%>

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

<sql:query var="school" dataSource="jdbc/lut2">
    SELECT * FROM school
    WHERE school_id = ? <sql:param value="${param.school_id}" />
</sql:query>
<c:choose>
	<c:when test="${school.rowCount == 0}">
		<% response.sendError(404, "School not found." ); %>
	</c:when>
</c:choose>
<sql:query var="reviews" dataSource="jdbc/lut2">
    SELECT * FROM user_reviews, school
    WHERE user_reviews.school_id = school.school_id
    AND school.school_id = ? <sql:param
		value="${school.rows[0].school_id}" />
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Reviews for <c:out value="${school.rows[0].full_name}" /></title>
</head>
<body>
	<form action="logout.jsp">
		<input type="submit" value="Logout" />
	</form>
	<br>

	<h1>
		Reviews for
		<c:out value="${school.rows[0].short_name}" />
	</h1>

	<!-- looping through all available reviews - if there are any -->
	<c:set var="review" value="${reviews.rows[0]}" />
	<c:choose>
		<c:when test="${ empty review }">
                No reviews for <c:out
				value="${school.rows[0].full_name}" /> yet. Help us out by adding one! 
                <br>
			<br>
		</c:when>
		<c:otherwise>
			<c:forEach var="review" items="${reviews.rowsByIndex}">
				<c:out value="${review[2]}" />
				<br>
				<i> <sql:query var="users" dataSource="jdbc/lut2">
    					SELECT * FROM users
    					WHERE uname =? <sql:param value="${review[1]}" />
					</sql:query> <c:choose>
						<c:when test="${ not empty users }">
							<c:out value="${users.rows[0].name}" />
						</c:when>
						<c:otherwise>
            			deleted user
            		</c:otherwise>
					</c:choose>
				</i>
				<br>
				<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>



	<table>
		<thead>
			<tr>
				<th colspan="2">Help improving LUT2.0 by adding a review of <c:out
						value="${school.rows[0].short_name}" /></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<form action="add_review.jsp" method="post">
						<input type="hidden" name="school_id"
							value="<c:out value="${school.rows[0].school_id}"/>" />
						<textarea name="review" rows=10 cols=60></textarea>
						<br> <img src="CaptchaServlet"> <br> Captcha: <input
							type="text" name="code"> <br> <br> <br> <input
							type="submit" value="Add review" />
					</form>
				</td>
			</tr>
		</tbody>
	</table>

</body>
</html>
