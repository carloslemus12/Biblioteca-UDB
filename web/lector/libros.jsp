<%-- 
    Document   : libros
    Created on : 28-abr-2018, 16:12:07
    Author     : MekakuZero
--%>

<%@page import="lemus.alexander.models.Usuario"%>
<%
    if (session.getAttribute("usuario") == null){
        session.setAttribute("erro_login", "Debe de iniciar session");
        response.sendRedirect("/Biblioteca_UDB/index.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/definition.jsp" />
        <title>Libros</title>
    </head>
    <body>
        <jsp:include page="/menu.jsp" />
    </body>
</html>
