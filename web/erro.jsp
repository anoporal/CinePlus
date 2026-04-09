<%-- 
    Document   : erro
    Created on : 22/05/2023, 09:38:26
    Author     : PTOLEDO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Falha na operação</title>
    </head>
    <body>
        <%
           Object msg = request.getAttribute("message");
        %>
        <h1>Erro: <%out.println(msg);%></h1>
    </body>
</html>
