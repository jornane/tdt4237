
<%@page import="no.ntnu.idi.tdt4237.h2012.g5.lut.ValidationService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="no.ntnu.idi.tdt4237.h2012.g5.lut.EMailCheck" %>
<%@ page import="no.ntnu.idi.tdt4237.h2012.g5.lut.MailMessage" %>
<%@ page import="java.net.InetAddress" %>


<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Signup / password reset</title>
</head>
<body>
<%
	EMailCheck emailck = EMailCheck.getInstance();
	String email = request.getParameter("email");
	if (emailck.check(email)) {
		// create activation code
		ValidationService vs = ValidationService.getInstance(600000); // lifetime in milliseconds (10min = 600000)
		String activationCode = vs.getActivationCode(email).toString();
		// save it to validation service thing
		String link = request.getScheme() + "://" + request.getLocalName() + ":" + request.getLocalPort() + request.getContextPath() + "/"; 
		link += "password.jsp?email=" + email + "&activationCode=" + activationCode;
		
		String message = "To set a new password for your account in ";
		message += "LUT go to the following webpage: \n " + link + "\n";
		message += "\n\n";
		
		
		//new MailMessage("yorinad@stud.ntnu.no", email, "Set password for your LUT account", message, InetAddress.getByName("smtp.stud.ntnu.no")).run();
		
		%>
		<a href=<%=link %>>Set password here for TESTING</a> <br>
		
		Email sent to <c:out value="${param.email}"/> <br>
		<%
	} else {
		%>
		Entered email address is not valid! <br>
		<%
	}
%>

	
</body>
</html>


