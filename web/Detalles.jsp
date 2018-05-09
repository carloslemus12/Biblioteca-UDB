<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" language="java" import="java.io.*" %>
<%@page session="true" language="java" import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="edu.udb.paquete.Conexion"%>
<%@page import="edu.udb.paquete.Conexion"%>
<%@page import="lemus.alexander.models.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    if (session.getAttribute("usuario") == null){
        session.setAttribute("erro_login", "Debe de iniciar session");
    %>
        <c:redirect url="/index.jsp"/>
    <%
    }

    Usuario usuario = (Usuario)session.getAttribute("usuario");
%>

<%
    Conexion conP = new Conexion();
    
    conP.setRs("SELECT COUNT(*) FROM prestamo WHERE extendido=1");
    ResultSet rsP = conP.getRs();
    rsP.next();
    if(rsP.getInt(1)==1){
%>
    <input type="hidden" id="Ya" value="Ya">
<%
    }

    int id_libro = Integer.parseInt(request.getParameter("idLibro"));
    
    try{
        Conexion con = new Conexion();
        con.setRs("SELECT * FROM libro lib INNER JOIN autor aut ON lib.ID_Autor=aut.ID_Autor INNER JOIN categoria cate ON lib.ID_cat=cate.ID_Cat INNER JOIN prestamo pres ON lib.ID_Libro=pres.ID_Libro WHERE lib.ID_Libro="+id_libro+" AND res.ID_Libro="+id_libro);
        ResultSet rs = con.getRs();
        while(rs.next()) {
    //}   
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/EstiloVerLibros.css">        
        <title><%=rs.getString("Titulo")%></title>
    </head>
    <body>
           <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <span class="navbar-brand">
        <img src="../img/logo.svg" width="30" height="30" alt="">
    </span>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu_principal" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="menu_principal">
        <ul class="navbar-nav mr-auto">
            <% if (((Usuario)session.getAttribute("usuario")).getTipo_usuario() == 3){ %>
                <li class="nav-item">
                    <a class="nav-link" href="/Biblioteca_UDB/lector/libros.jsp">Ver lista de libros</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="VerLibros.jsp">Mis libros</a>
                </li>
            <% } else { %>
                
            <% } %>
            <li class="nav-item d-block d-lg-none">
                <a class="nav-link" href="/Biblioteca_UDB/actions/cerrarsesion.jsp">Cerrar sesion</a>
            </li>
            
            <li class="nav-item d-block d-lg-none">
                <a class="nav-link" href="/Biblioteca_UDB/confirmar/password.jsp?accion=1">Mi cuenta</a>
            </li>

            <li class="nav-item d-block d-lg-none">
                <a class="nav-link" href="/Biblioteca_UDB/confirmar/password.jsp?accion=2">Cambiar contraseña</a>
            </li>
        </ul>
        <div class="d-none flex-row justify-content-center d-lg-flex nav-item dropdown">
            <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <%= ((Usuario)session.getAttribute("usuario")).getUsername() %>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="/Biblioteca_UDB/actions/cerrarsesion.jsp">Cerrar sesion</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="/Biblioteca_UDB/confirmar/password.jsp?accion=1">Mi cuenta</a>
              <a class="dropdown-item" href="/Biblioteca_UDB/confirmar/password.jsp?accion=2">Cambiar contraseña</a>
            </div>
        </div>
    </div>
</nav>    
            <div class="container">
            <section><br><br>
                <div class="Libro">
                    <h3><%=rs.getString("Titulo")%></h3>
                    <img id="imagen" class="imagen" src="<%=rs.getString("Imagen")%>">
                    
                    <div class="divAutor">
                        <strong><label class="hAutor">Autor:</label></strong>
                        <label class="hAutor"><%=rs.getString("aut.Nombre")+" "+rs.getString("aut.Apellido")%></label>
                    </div>
                    <div class="divEdicion">
                        <strong><label class="hEdicion">Edición:</label></strong>
                        <label class="hEdicion"><%=rs.getString("Edicion")%></label>
                    </div>
                    <div class="divCategoria">
                        <strong><label class="hCategoria">Categoria:</label></strong>
                        <label class="hCategoria"><%=rs.getString("cate.Categoria")%></label>
                    </div>
                    <div class="divImprenta">
                        <strong><label class="hImprenta">Imprenta:</label></strong>
                        <label class="hImprenta"><%=rs.getString("Imprenta")%></label>
                    </div>
                    <div class="divIsbn">
                        <strong><label class="hIsbn">ISBN:</label></strong>
                        <label class="hIsbn"><%=rs.getString("ISBN")%></label>
                    </div>
                    <div class="divDescrip">
                        <strong><label class="hAutor">Descripción:</label></strong>
                        <p id="vozdescrip" class="hDes p"><%=rs.getString("Descripcion") %></p>
                    </div>
                    <a href=""><button id="extender1" class="btn btn-success extender1">Extender prestamo</button></a>  
                    <div class="divFecha1">
                        <strong><label class="hFecha">Fecha límite:</label></strong>
                        <label class="hFecha p"><%=rs.getString("pres.FechaLimite")%></label>
                    </div>
                </div>                
            </section>
            <%  
                }
                }catch(SQLException e){
                    
                }            
            %>    
        </div>
        <script type="text/javascript" src="js/ValidarPrestamo.js"></script>
    </body>
</html>
