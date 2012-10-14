<%@page import="captcha.CaptchaServlet"%>
<%@page import="no.ntnu.idi.tdt4237.h2012.g5.lut.ValidationService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="no.ntnu.idi.tdt4237.h2012.g5.lut.EMailCheck"%>
<%@ page import="no.ntnu.idi.tdt4237.h2012.g5.lut.MailMessage"%>


<%
String MD5_captcha = (String) session.getAttribute("captcha");
String code = (String) request.getParameter("code");
String MD5_code = CaptchaServlet.getMD5Hash(code);
%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Signup / password reset</title>
</head>
<body>
	<%
	  if (MD5_captcha != null && code != null) {

		    if (MD5_captcha.equals(MD5_code)) { 
		    	
		    	EMailCheck emailck = EMailCheck.getInstance();
		    	String email = request.getParameter("email");
		    	if (emailck.check(email)) {
		    		// create activation code
		    		ValidationService vs = ValidationService.getInstance(600000); // lifetime in milliseconds (10min = 600000)
		    		String activationCode = vs.getActivationCode(email).toString();
		    		// save it to validation service thing
		    		String message = "To set a new password for your account in ";
		    		message += "LUT go to the following webpage: \n http://localhost:8080/LUT_2.0_6_new/password.jsp?email=";
		    		message += email + "&activationCode=" + activationCode + "\n";
		    		message += "\n\n";
		    		
		    		// TODO: sending the email 
		    		
		    		%>
		    	<%=message %>
		    	<br> Email sent to
		    	<c:out value="${param.email}" />
		    	<br>
		    	<%
		    	} else {
		    		%>
		    	Entered email address is not valid!
		    	<br>
		    	<%
		    	}
		    	
		    } else {
		    	%>
		    	Wrong captcha!
		    	<%   
		    }
	}
	
	

%>


</body>
</html>


