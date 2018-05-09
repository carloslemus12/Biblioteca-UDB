<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" language="java" import="java.io.*" %>
<%@page session="true" language="java" import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="edu.udb.paquete.Conexion"%>
<%@page import="edu.udb.paquete.VerLibroModel"%>

<%

    int id_libro = Integer.parseInt(request.getParameter("idLibro"));
    
    VerLibroModel model = new VerLibroModel();
    
    model.ExtenderPrestamo(id_libro);
    
    response.sendRedirect("VerLibros.jsp");

%>
