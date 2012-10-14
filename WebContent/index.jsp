<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page errorPage="error.jsp"%>


<sql:query var="country" dataSource="jdbc/lut2">
    SELECT full_name FROM country
</sql:query>

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


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>LUT 2.0 - Help Students Conquer the World</title>
</head>
<body>
	<form action="logout.jsp">
		<input type="submit" value="Logout" />
	</form>
	<br>

	<h1>Hi student!</h1>
	<table border="0">
		<thead>
			<tr>
				<th>LUT 2.0 provides information about approved international
					schools</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>To view information about schools in a country, please
					select a country below:</td>
			</tr>
			<tr>
				<td><form action="schools.jsp">
						<strong>Select a country:</strong> <select name="country">
							<c:forEach var="row" items="${country.rowsByIndex}">
								<c:forEach var="column" items="${row}">
									<option value="<c:out value="${column}"/>">
										<c:out value="${column}" />
									</option>
								</c:forEach>
							</c:forEach>
						</select> <input type="submit" value="submit" />
					</form></td>
			</tr>
		</tbody>
	</table>

</body>
</html>
