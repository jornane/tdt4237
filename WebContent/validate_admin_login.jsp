<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp"%>
<%@page import="captcha.LoginValidator"%>

<sql:query var="adminUsers" dataSource="jdbc/lut2">
    SELECT * FROM admin_users
    WHERE  uname = ? <sql:param value="${param.username}" />
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
				// check password
				String salt = pageContext.getAttribute("DBsalt").toString();
				String password = pageContext.getAttribute("pass").toString();
				String hash = pageContext.getAttribute("correctPass").toString();
				String captcha = (String) request.getParameter("code");

				boolean isLoginValid = LoginValidator.isValidLogin(password, hash, salt, captcha, request, session, true);

				if (isLoginValid) {
	                String Authorized = "2";
	                session.setAttribute( "isAuth", Authorized);
	        		response.sendRedirect("./admin.jsp");
				} else {
	        		response.sendRedirect("./adminlogin.jsp");
				}
			%>
		<% 
%>
	</c:when>
	<c:otherwise>
		<%
			LoginValidator.triedToLogin(request, true);
			response.sendRedirect("./adminlogin.jsp");
		%>
	</c:otherwise>
</c:choose>