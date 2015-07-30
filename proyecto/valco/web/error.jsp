<%-- 
    Document   : error
    Created on : 12/07/2015, 12:01:42 AM
    Author     : 10015097
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <h1>¡Error!</h1>
        ${requestScope.error} 
    </body>
</html>
