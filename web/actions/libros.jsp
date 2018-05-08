<%-- 
    Document   : libros
    Created on : 30-abr-2018, 21:16:39
    Author     : MekakuZero
--%>
<%@page import="lemus.alexander.models.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
    String titulo = ((request.getParameter("titulo") != null)? request.getParameter("titulo") : "");
    String autor = ((request.getParameter("autor") != null)? request.getParameter("autor") : "''");
    String categoria = ((request.getParameter("categoria") != null)? request.getParameter("categoria") : "''");
    
    String titulo_like = "";
    
    if (titulo.equals("")) 
        titulo_like = "'%%'";
    else
        titulo_like = "'%" + titulo + "%'";
    
    if (autor.equals("") || autor.equals("-1")) autor = "''";
    if (categoria.equals("") || categoria.equals("-1")) categoria = "''";
%>
<sql:query var="libros" dataSource="jdbc/mysql">
    SELECT libro.ID_Libro, libro.Titulo, libro.Imagen, libro.Descripcion, categoria.Categoria, concat(autor.Nombre, ' ', autor.Apellido) as Autor FROM libro inner join categoria on categoria.ID_Cat = libro.ID_cat inner join autor on autor.ID_Autor = libro.Id_Autor WHERE (libro.Titulo like <%= titulo_like %> or '<%= titulo %>' = '' ) and (autor.ID_Autor = <%= autor %> or <%= autor %> = '' ) and (categoria.ID_Cat = <%= categoria %> or <%= categoria %> = '' )
</sql:query>
[<c:forEach var="libro" items="${libros.rows}">{ "id":${ libro.ID_Libro }, "titulo":"${ libro.Titulo }", "img":"${ libro.Imagen }", "descripcion":"${ libro.Descripcion }", "categoria":"${ libro.Categoria }", "autor":"${ libro.Autor }"<sql:query var="reservas" dataSource="jdbc/mysql"> SELECT reserva.ID_Libro, (reserva.ID_usuario = <%= ((Usuario)session.getAttribute("usuario")).getId() %>) as Estado from reserva INNER JOIN libro on libro.ID_Libro = reserva.ID_Libro WHERE libro.ID_Libro = ${ libro.ID_Libro } </sql:query><%boolean estado = false;boolean mi_libro = false;%><c:forEach var="reserva" items="${reservas.rows}"> <% estado = true;%>,"myReserva":${ reserva.Estado == 1 } </c:forEach>,"reservado":<%= estado %> },</c:forEach>{}]