<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="error.jsp"%>
<%@page import="captcha.CaptchaServlet"%>

<%@ page import="password.Password"%>


<sql:query var="users" dataSource="jdbc/lut2">
    SELECT * FROM users
    WHERE uname =? <sql:param value="${param.username}" />
</sql:query>



<c:set var="userDetails" value="${users.rows[0]}" />

<c:choose>
	<c:when test="${ not empty userDetails }">
		<%
			// this is for not being able to differenciate between failure
		%><c:set var="DBsalt" value="${userDetails.salt}" />
		<%
			
		%><c:set var="pass" value="${param.password}" />
		<%
			
		%><c:set var="correctPass" value="${userDetails.pw}" />
		<%
			String salt = pageContext.getAttribute("DBsalt").toString();
					String password = pageContext.getAttribute("pass")
							.toString();
					String correctPass = pageContext
							.getAttribute("correctPass").toString();

					String pwhash = Password.hashWithSalt(password, salt);
					
					//check captcha, if needed
					String MD5_captcha = (String) session.getAttribute("captcha");
					String code = (String) request.getParameter("code");
					String MD5_code = CaptchaServlet.getMD5Hash(code);

					Integer loginTries = (Integer)session.getAttribute("loginTries");
					boolean isCaptchaNeeded = loginTries != null && loginTries>2 ? true : false;
					boolean isCaptchaValid = false;
					if (isCaptchaNeeded) {
						if (MD5_captcha != null && code != null
								&& MD5_captcha.equals(MD5_code)) {
							isCaptchaValid = true;
						}
					} else {
						isCaptchaValid = true;
					}
					
					
					int loginResult = 1;
					if (pwhash.equals(correctPass) && isCaptchaValid) {
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
</head>
<body>
	<c:choose>
		<c:when test="${not empty userDetails and loginSuccess == 0}">
			<%
				session.setAttribute("loginTries", 0);

						String User_Name_For_Session = request
								.getParameter("username");

						String Authorized = "1";
						session.setAttribute("isAuth", Authorized);
						session.setAttribute("username", User_Name_For_Session);
						response.sendRedirect("./");
			%>
		</c:when>
		<c:otherwise>
			<%
				Integer loginTries = (Integer) session
								.getAttribute("loginTries");
						if (loginTries == null) {
							loginTries = 0;
						}

						session.setAttribute("loginTries", loginTries + 1);

						response.sendRedirect("./login.jsp");
			%>
		</c:otherwise>
	</c:choose>
</body>
</html>
