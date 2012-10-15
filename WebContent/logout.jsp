<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%               
	String Authorized = "0";
	session.setAttribute( "isAuth", Authorized);
	
	String redirect = request.getParameter("redirect");
	if (redirect!= null) {
		response.sendRedirect("./"+redirect);
	} else {
		response.sendRedirect("./");
	}
	
%>
</body>
</html>