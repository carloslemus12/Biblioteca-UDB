<%-- 
    Document   : reservaciones
    Created on : 01-may-2018, 18:12:30
    Author     : MekakuZero
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page import="lemus.alexander.models.Usuario"%>
<sql:query var="reservas_limites" dataSource="jdbc/mysql">
    SELECT reserva.Id_Reserva, libro.Titulo as Titulo from reserva INNER JOIN libro ON libro.ID_Libro = reserva.ID_Libro WHERE reserva.ID_usuario = <%= ((Usuario)session.getAttribute("usuario")).getId() %> AND DATEDIFF(date(NOW()), date(reserva.FechaLimite)) > 0
</sql:query>

<sql:query var="reservas" dataSource="jdbc/mysql">
    SELECT reserva.Id_Reserva, libro.Titulo as Titulo from reserva INNER JOIN libro ON libro.ID_Libro = reserva.ID_Libro WHERE reserva.ID_usuario = <%= ((Usuario)session.getAttribute("usuario")).getId() %> AND DATEDIFF(date(NOW()), date(reserva.FechaLimite)) = 0
</sql:query>
    
<script>
    var estado = false;
    var msg = "";
<c:forEach var="reserva" items="${reservas_limites.rows}">
    <c:catch var="error_delete">
        <sql:update var="update" dataSource="jdbc/mysql">
            DELETE FROM reserva WHERE Id_Reserva = ${ reserva.Id_Reserva }
        </sql:update>  
    </c:catch>

    <c:set var="error" value = "${not empty error_delete}"/>
    <c:choose>
        <c:when test = "${error}">
           alert("${ error_delete }");
        </c:when>

        <c:otherwise>
            estado = true;
            msg += "<p>El libro ${ reserva.Titulo } ha expirado</p>";
        </c:otherwise>
    </c:choose>
</c:forEach>

<c:forEach var="reserva" items="${reservas.rows}">
    estado = true;
    msg += "<p>El libro ${ reserva.Titulo } esta por expirar</p>";
</c:forEach>

    if (estado) {
        libros();
        bootbox.alert({
            message: msg,
            backdrop: true
        });
    }
</script>