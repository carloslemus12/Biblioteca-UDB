<%-- 
    Document   : libro
    Created on : 08-may-2018, 6:28:48
    Author     : MekakuZero
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page import="lemus.alexander.models.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
%>
<sql:query var="libro_temas" dataSource="jdbc/mysql">
    SELECT tema.Tema as tema, tema.Descripcion as descripcion FROM tema_libro INNER JOIN tema ON tema_libro.ID_tema = tema.ID_tema WHERE tema_libro.ID_Libro = <%= id %>
</sql:query>
[<c:forEach var="tema" items="${libro_temas.rows}">{ "tema":"${ tema.tema }", "descripcion":"${ tema.descripcion }" },</c:forEach>{}]