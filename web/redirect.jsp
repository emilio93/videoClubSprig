<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Video Club</title>
    </head>
    <body>
        <jsp:forward page="index.html"></jsp:forward>
    </body>
</html>
<% response.sendRedirect("index"); %>
