<%-- 
    Document   : clave
    Created on : 29-abr-2018, 1:07:02
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

<% if(validacion.valido()){ 
    if(usuario.getPassword().equals(clave)){
   session.setAttribute("Clave_Valida", true);
%>
        { "estado":"perfecto" }
<%
    } else {
    session.setAttribute("Clave_Valida", false);
%>
        { "estado":"error", "errores":["La clave no coincide con la actual"] }
    <% } %>
<%} else {
    session.setAttribute("Clave_Valida", false);
%>
    { "estado":"error", "errores":<%= validacion.erroresJSON() %> }
<% } %>
