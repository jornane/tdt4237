<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Signup / password reset</title>
</head>

<body unload="">
	<form method="post" action="send_email.jsp">
		Please enter your email: <input type="text" name="email" /><br> <br>
		<img src="http://localhost:8080/LUT_2.0_Nice/CaptchaServlet"> <br>
		Captcha: <input type="text" name="code"> <br>
		<input type="submit" value="submit" />
	</form>
</body>
</html>


