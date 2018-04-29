<%-- 
    Document   : guardar_cuenta
    Created on : 29-abr-2018, 1:46:11
    Author     : MekakuZero
--%>

<%@page import="lemus.alexander.models.Usuario"%>
<%@page import="mojica.alexander.utilidades.Validacion"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    
    Validacion validacion = new Validacion();
    
    validacion.setField("username", username);
    validacion.setField("nombre", nombre);
    validacion.setField("apellido", apellido);
    validacion.setField("email", email);
    
    validacion.addRule("username", Validacion.requerid);
    validacion.addRule("nombre", Validacion.requerid);
    validacion.addRule("apellido", Validacion.requerid);
    validacion.addRule("email", Validacion.requerid);
    validacion.addRule("email", Validacion.email);
    
    Usuario usuario = (Usuario)session.getAttribute("usuario");
 %>

<% if(validacion.valido()){ %>

    <c:catch var="error_update">
        <sql:update var="insertar" dataSource="jdbc/mysql">
            UPDATE usuario SET Nombre = '<%= nombre %>', Apellido = '<%= apellido %>', Username = '<%= username %>', CorreoElectronico = '<%= email %>' WHERE ID_usuario = <%= usuario.getId() %>
        </sql:update>  
    </c:catch>

    <c:set var="error" value = "${not empty error_update}"/>
    <c:choose>
        <c:when test = "${error}">
           
        </c:when>

        <c:otherwise>
            <%
                usuario.actualizar();
                session.setAttribute("usuario", usuario);
            %>
        </c:otherwise>
    </c:choose>

<%} %>

<% response.sendRedirect("/Biblioteca_UDB/"); %>