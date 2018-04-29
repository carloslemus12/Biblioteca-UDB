<%-- 
    Document   : cerrarsesion
    Created on : 28-abr-2018, 16:39:22
    Author     : MekakuZero
--%>

<%
    request.getSession().invalidate();
    response.sendRedirect("/Biblioteca_UDB/index.jsp");
%>
