<%-- 
    Document   : guardar_clave
    Created on : 29-abr-2018, 2:12:16
    Author     : MekakuZero
--%>

<%@page import="lemus.alexander.models.Usuario"%>
<%@page import="mojica.alexander.utilidades.Validacion"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
    String clave = request.getParameter("clave");
    String confirmar_clave = request.getParameter("confirmar_clave");
    
    Validacion validacion = new Validacion();
    
    validacion.setField("clave", clave);
    validacion.setField("confirmar clave", confirmar_clave);
    
    validacion.addRule("clave", Validacion.requerid);
    validacion.addRule("confirmar clave", Validacion.requerid);
    
    validacion.compareFields("clave", "confirmar clave");
    
    Usuario usuario = (Usuario)session.getAttribute("usuario");
 %>

<% if(validacion.valido()){ %>
    <c:catch var="error_update">
        <sql:update var="update" dataSource="jdbc/mysql">
            UPDATE usuario SET Clave = '<%= clave %>' WHERE ID_usuario = <%= usuario.getId() %>
        </sql:update>  
    </c:catch>

    <% usuario.actualizar();%>
<% } %>
<% response.sendRedirect("/Biblioteca_UDB/"); %>
