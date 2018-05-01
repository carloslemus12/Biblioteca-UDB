<%-- 
    Document   : reservar
    Created on : 01-may-2018, 17:27:20
    Author     : MekakuZero
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:catch var="error_delete">
    <sql:update var="delete" dataSource="jdbc/mysql">
        DELETE FROM reserva WHERE ID_usuario = ${ param.usuario } AND ID_Libro = ${ param.libro }
    </sql:update>  
</c:catch>
<c:set var="error" value = "${empty error_delete}"/>
{"estado":${error},"error":"${ error_delete }"}