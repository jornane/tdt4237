<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>LUTAdmin</title>
    </head>
    <body>
        <h1>Welcome to the LUT administration pages!</h1>
        <table border="0">
            <thead>
                <tr>
                    <th>Log on here to perform administrative tasks</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><form method="post" action="admin.jsp">

                            <p>
                                Username: <input type="text" name="username" size="20"></p>
                            <p>
                                Password: <input type="password" name="password" size="20"></p>
                            <p><input type="submit" value="submit" name="login"></p>
                        </form></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
