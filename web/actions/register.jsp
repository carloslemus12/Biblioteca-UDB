<%-- 
    Document   : register
    Created on : 27-abr-2018, 20:51:48
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
    String clave = request.getParameter("clave");
    String confirmar_clave = request.getParameter("confirmar_clave");
    
    Validacion validacion = new Validacion();
    
    validacion.setField("username", username);
    validacion.setField("nombre", nombre);
    validacion.setField("apellido", apellido);
    validacion.setField("email", email);
    validacion.setField("clave", clave);
    validacion.setField("confirmar clave", confirmar_clave);
    
    validacion.addRule("username", Validacion.requerid);
    validacion.addRule("nombre", Validacion.requerid);
    validacion.addRule("apellido", Validacion.requerid);
    validacion.addRule("email", Validacion.requerid);
    validacion.addRule("clave", Validacion.requerid);
    validacion.addRule("confirmar clave", Validacion.requerid);
    validacion.addRule("email", Validacion.email);
    
    validacion.compareFields("clave", "confirmar clave");
 %>

<% if(validacion.valido()){ %>

    <c:catch var="error_insert">
        <sql:update var="insertar" dataSource="jdbc/mysql">
            INSERT INTO usuario (ID_usuario , Nombre, Apellido, Username, Clave, CorreoElectronico, ID_tipo) VALUES (NULL,'<%= nombre %>','<%= apellido %>','<%= username %>','<%= clave %>','<%= email %>',3)
        </sql:update>  
    </c:catch>

    <c:set var="error" value = "${not empty error_insert}"/>
    <c:choose>
        <c:when test = "${error}">
           { "estado":"error", "errores":["Ha ocurrido un error ${error_insert} inesperado"] }
        </c:when>

        <c:otherwise>
            <%
                Usuario usuario = Usuario.getLast();
                session.setAttribute("usuario", usuario);
            %>
            { "estado":"perfecto", "tipo":<%= ""+usuario.getTipo_usuario() %> }
        </c:otherwise>
    </c:choose>

<%} else {%>
    { "estado":"error", "errores":<%= validacion.erroresJSON() %> }
<% } %>