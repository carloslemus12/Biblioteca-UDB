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
<sql:query var="libro_notas" dataSource="jdbc/mysql">
    SELECT * FROM `nota` WHERE ID_Libro = <%= id %>
</sql:query>
[<c:forEach var="nota" items="${libro_notas.rows}">{ "nota":"${ nota.Nota }" },</c:forEach>{}]