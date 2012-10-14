<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp"%>
<%@ page import="password.Password"%>

<sql:query var="country" dataSource="jdbc/lut2">
    SELECT full_name FROM country
</sql:query>

<sql:query var="adminUsers" dataSource="jdbc/lut2">
    SELECT * FROM admin_users
    WHERE  uname =? <sql:param value="${param.username}" />
</sql:query>

<sql:query var="users" dataSource="jdbc/lut2">
    SELECT * FROM users
</sql:query>

<c:set var="adminUserDetails" value="${adminUsers.rows[0]}" />

<c:choose>
	<c:when test="${ not empty adminUserDetails }">
		<%  // this is for not being able to differenciate between failure
			%><c:set var="DBsalt" value="${adminUserDetails.salt}" />
		<% 
			%><c:set var="pass" value="${param.password}" />
		<%
			%><c:set var="correctPass" value="${adminUserDetails.pw}" />
		<%
				String salt = pageContext.getAttribute("DBsalt").toString();
				String password = pageContext.getAttribute("pass").toString();
				String correctPass = pageContext.getAttribute("correctPass").toString();
				
				String pwhash = Password.hashWithSalt(password, salt);
				
				int loginResult = 1;
				if (pwhash.equals(correctPass) ) {
					loginResult = 0;
				}
			%>
		<c:set var="loginSuccess" value="<%=loginResult%>" />
		<% 
%>
	</c:when>
</c:choose>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>LUT Admin pages</title>
</head>
<body>
	<c:choose>
		<c:when test="${not empty adminUserDetails and loginSuccess == 0}">
			<h1>Login succeeded</h1> 
                Welcome <c:out value="${ adminUserDetails.uname}" />.<br>
                <%
                String Authorized = "2";
                session.setAttribute( "isAuth", Authorized);
                %>                
			<br>
			<br>
			<td>
				<div
					style="background-color: gray; height: auto; width: 650px; overflow: hidden;">
					<div style="margin: 2px; background: white; width: auto;">
						<br> <strong>Add country</strong><br> <br>
						<form action="add_country.jsp" method="post">
							Full name: <input type="text" name="full_name_country"
								maxlength="50" size="50" /> <br> Short name: <input
								type="text" name="short_name_country" maxlength="3" size="3" />
							<br> <input type="submit" value="Add" /> <br> <br>
						</form>
					</div>
				</div> <br> <br>
				<div
					style="background-color: gray; height: auto; width: 650px; overflow: hidden;">
					<div style="margin: 2px; background: white; width: auto;">
						<br> <strong>Add school:</strong><br> <br>
						<form action="add_school.jsp" method="post">
							Select country: <select name="country">
								<c:forEach var="row" items="${country.rowsByIndex}">
									<c:forEach var="column" items="${row}">
										<option value="<c:out value="${column}"/>">
											<c:out value="${column}" />
										</option>
									</c:forEach>
								</c:forEach>
							</select> <br> Full name: <input type="text" name="full_name_school"
								maxlength="100" size="100" /> <br> Short name: <input
								type="text" name="short_name_school" maxlength="10" size="10" />
							<br> Place: <input type="text" name="place_school"
								maxlength="50" size="50" /> <br> Zip: <input type="text"
								name="zip_school" maxlength="11" size="11" /> <input
								type="submit" value="Add" /> <br> <br>
						</form>
					</div>
				</div> <br> <br>
				<div
					style="background-color: gray; height: auto; width: 650px; overflow: hidden;">
					<div style="margin: 2px; background: white; width: auto;">
						<br> <strong>Add user:</strong><br> <br>
						<form action="add_user.jsp" method="post">
							Email: <input type="text" name="email" maxlength="100" size="100" /><br>
							Password: <input type="text" name="password" maxlength="100"
								size="100" /><br> <input type="submit" value="Add user" />
							<br> <br>
						</form>
					</div>
				</div>
				<br> <br>
				<div
					style="background-color: gray; height: auto; width: 650px; overflow: hidden;">
					<div style="margin: 2px; background: white; width: auto;">
						<br> <strong>Edit users:</strong><br> <br>
						<c:forEach var="user" items="${users.rowsByIndex}">
							<form action="update_user.jsp" method="post">
								<input type="hidden" value="<c:out value="${user[0]}" />"
									name="email" maxlength="100" size="100" /> E-mail: <input
									type="text" value="<c:out value="${user[0]}" />"
									name="newEmail" maxlength="100" size="100" /> <br> Hash:
								<c:out value="${user[1]}" />
								<br> Salt:
								<c:out value="${user[2]}" />
								<br> Password: <input type="text"
									placeholder="Enter new password" name="password"
									maxlength="100" size="100" /> <input type="submit"
									value="Edit user" />
							</form>
							<form action="delete_user.jsp" method="post">
								<input type="hidden" value="<c:out value="${user[0]}" />"
									name="email" maxlength="100" size="100" /> <input
									type="submit" value="Delete user" /> <br> <br>
							</form>
						</c:forEach>

					</div>
				</div>
		</c:when>
		<c:otherwise>
                Login failed
		</c:otherwise>
	</c:choose>
</body>
</html>
