<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp"%>
<%@ page import="password.Password"%>

<sql:query var="adminUsers" dataSource="jdbc/lut2">
    SELECT * FROM admin_users
    WHERE  uname =? <sql:param value="${param.username}" />
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

<c:choose>
	<c:when test="${not empty adminUserDetails and loginSuccess == 0}">
		<%
                String Authorized = "2";
                session.setAttribute( "isAuth", Authorized);
        		response.sendRedirect("./admin.jsp");
		%>


	</c:when>
	<c:otherwise>
	<%
		response.sendRedirect("./adminlogin.jsp");
	%>
		</c:otherwise>
</c:choose>