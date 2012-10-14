

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>LUT login page</title>
</head>
<body>
	<h1>Welcome to LUT</h1>
	<table>
		<thead>
			<tr>
				<th>Log on here to perform see, add reviews for schools</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><form method="post" action="user.jsp">

						<p>
							Email:<input type="text" name="username" size="20">
						</p>
						<p>
							Password:<input type="password" name="password" size="20">
						</p>
						<p>
							<input type="submit" value="submit" name="login">
						</p>
						<a href="signup.jsp">Sign up here</a>

					</form></td>
			</tr>
		</tbody>
	</table>
</body>
</html>
