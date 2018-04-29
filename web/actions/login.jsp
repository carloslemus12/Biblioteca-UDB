<%-- 
    Document   : login
    Created on : 25-abr-2018, 5:36:22
    Author     : MekakuZero
--%>

<%@page import="lemus.alexander.models.Usuario"%>
<%@page import="mojica.alexander.utilidades.Validacion"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
    String email = request.getParameter("email");
    String clave = request.getParameter("clave");
    
    boolean estado = ((email == null || email.equals("")) || (clave == null || clave.equals("")));
 %>

<% if(estado){ %>
   { "estado":"error", "errores":["Ambos campos deben de estar llenos"] }
<% } else { %>
    <% if(Validacion.validarEmail(email)){ %>
        <sql:query var="usuarios" dataSource="jdbc/mysql">
            SELECT * from usuario WHERE CorreoElectronico = '<%= email %>' AND Clave = '<%= clave %>' AND ID_tipo > 1
        </sql:query>
        
            <%! boolean existe = false; %>
            <c:forEach var="usuario" items="${usuarios.rows}">
                <% existe = true; %>
            </c:forEach>
            
            <% if (existe) {
                Usuario usuario = Usuario.getUsuario(email, clave);
                session.setAttribute("usuario", usuario);
            %>
                { "estado":"perfecto", "tipo":<%= ""+usuario.getTipo_usuario() %> }
            <% } else { %>
                { "estado":"error", "errores":["La clave o el correo no coinciden"] }
            <% } %>
            
    <%} else {%>
        { "estado":"error", "errores":["El correo electronico es invalido"] }
    <% } %>
<% } %>