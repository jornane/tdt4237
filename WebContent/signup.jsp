<%@page errorPage="error.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Signup / password reset</title>
</head>

<body>
	<form method="post" action="send_email.jsp">
		Please enter your email: <input type="text" name="email" /><br> <br>
		<img src="CaptchaServlet"> <br>
		Captcha: <input type="text" name="code"> <br>
		<input type="submit" value="submit" />
	</form>
</body>
</html>


