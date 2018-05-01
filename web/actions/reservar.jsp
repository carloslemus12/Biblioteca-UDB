<%-- 
    Document   : reservar
    Created on : 01-may-2018, 17:27:20
    Author     : MekakuZero
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:catch var="error_insert">
    <sql:update var="insertar" dataSource="jdbc/mysql">
        INSERT INTO reserva (Id_Reserva,ID_usuario,ID_Libro,FechaReservacion,FechaLimite) VALUES (NULL,${ param.usuario },${ param.libro },NOW(),NOW() + INTERVAL 1 DAY)
    </sql:update>  
</c:catch>
<c:set var="error" value = "${empty error_insert}"/>
{"estado":${error},"error":"${ error_insert }"}