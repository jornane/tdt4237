<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp"%>
<%@page import="captcha.LoginValidator"%>


<sql:query var="users" dataSource="jdbc/lut2">
    SELECT * FROM users
    WHERE uname =? <sql:param value="${param.username}" />
</sql:query>

<c:set var="userDetails" value="${users.rows[0]}" />

<c:choose>
	<c:when test="${ not empty userDetails }">
		<%  // this is for not being able to differenciate between failure
			%><c:set var="DBsalt" value="${userDetails.salt}" />
		<% 
			%><c:set var="pass" value="${param.password}" />
		<%
			%><c:set var="correctPass" value="${userDetails.pw}" />
		<%
				// check password
				String salt = pageContext.getAttribute("DBsalt").toString();
				String password = pageContext.getAttribute("pass").toString();
				String hash = pageContext.getAttribute("correctPass").toString();
				String captcha = (String) request.getParameter("code");

				boolean isLoginValid = LoginValidator.isValidLogin(password, hash, salt, captcha, request, session);

				if (isLoginValid) {
					String User_Name_For_Session = request
							.getParameter("username");

					String Authorized = "1";
					session.setAttribute("isAuth", Authorized);
					session.setAttribute("username", User_Name_For_Session);
					response.sendRedirect("./");
				} else {
	        		response.sendRedirect("./login.jsp");
				}
			%>
		<% 
%>
	</c:when>
	<c:otherwise>
		<%
			LoginValidator.triedToLogin(request);
			response.sendRedirect("./login.jsp");
		%>
	</c:otherwise>
</c:choose>
