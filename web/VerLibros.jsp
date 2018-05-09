<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="verLibrosReservados" scope="request" class="edu.udb.paquete.VerLibrosBean"/>
<jsp:useBean id="verLibrosPrestados" scope="request" class="edu.udb.paquete.VerLibrosBean"/>
<%@page session="true" language="java" import="java.io.*" %>
<%@page session="true" language="java" import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <title>Mis libros</title>
        <link rel="stylesheet" type="text/css" href="css/EstiloVerLibros.css"> 
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
            //Obtener el id del usuario logeado
            //int id_usuario = Integer.parseInt(request.getParameter(""));
            int id_usuario = 4;
            
            Conexion con = new Conexion();
            
            con.setRs("SELECT COUNT(*) FROM reserva WHERE ID_usuario=" + id_usuario);
            ResultSet rs = con.getRs();

        %>
        
        <div class="container"><br><br><br>
            <button type="submit" name="btnLibReservados" id="btnLibReservados" class="btn btn-primary button" >Ver libros reservados</button>
            <button type="submit" name="btnLibPrestados" id="btnLibPrestados" class="btn btn-primary" >Ver libros prestados</button><br><br>
            <div class="row">
                <div class="librosReservados" id="librosReservados">
                    <h2 class="text-center">Libros reservados</h2><br>
                    <table class="table table-bordered table-striped">
                        <tr class="table-primary">
                            <th>Titulo</th>
                            <th>Autor</th>
                            <th>Edición</th>
                            <th>Categoria</th>
                            <th>Imprenta</th>
                            <th>Fecha límite</th>
                            <th></th>
                        </tr>
                        <%
                            rs.next();
                            if(rs.getInt(1)==1){           
                                
                            Conexion con2 = new Conexion();
                
                            con2.setRs("SELECT * FROM libro lib INNER JOIN autor aut ON lib.ID_Autor=aut.ID_Autor INNER JOIN categoria cate ON lib.ID_cat=cate.ID_Cat INNER JOIN reserva res ON lib.ID_Libro=res.ID_Libro WHERE res.ID_usuario="+id_usuario);
                            ResultSet rsl = con2.getRs();
                            while(rsl.next()) {                        
                             
                        %> 
                        
                        <tr>
                            <td><%=rsl.getString("lib.Titulo")%></td>
                            <td><%=rsl.getString("aut.Nombre")+" "+rsl.getString("aut.Apellido")%></td>
                            <td><%=rsl.getString("lib.Edicion")%></td>
                            <td><%=rsl.getString("cate.Categoria")%></td>
                            <td><%=rsl.getString("lib.Imprenta")%></td>
                            <td><%=rsl.getString("res.FechaLimite")%></td>
                            <td><a href="Detalle.jsp?idLibro=<%=rsl.getInt("ID_Libro")%>"><button class="btn btn-primary">Detalles</button></a> <a href="EliminarReserva?idLibro=<%=rsl.getInt("ID_Libro")%>"><button class="btn btn-danger">Eliminar reserva</button></a></td>
                        </tr>
                        <%}}%>
                    </table>
                </div>
                <div class="librosPrestados" id="librosPrestados" style="display: none;">
                    <h2 class="text-center">Libros prestados</h2><br>
                    <table class="table table-bordered table-striped">
                        <tr class="table-primary">
                            <th>Titulo</th>
                            <th>Autor</th>
                            <th>Edición</th>
                            <th>Categoria</th>
                            <th>Imprenta</th>
                            <th>Fecha límite</th>
                            <th></th>
                        </tr>
                        <%
                            Conexion con3 = new Conexion(); 
                            
                            con3.setRs("SELECT COUNT(*) FROM prestamo WHERE ID_usuario=" + id_usuario);
                            ResultSet rs3 = con3.getRs();
                            rs3.next();
                            if(rs3.getInt(1)==1){
                                
                                Conexion con4 = new Conexion();
                                
                                con4.setRs("SELECT * FROM libro lib INNER JOIN autor aut ON lib.ID_Autor=aut.ID_Autor INNER JOIN categoria cate ON lib.ID_cat=cate.ID_Cat INNER JOIN prestamo pres ON lib.ID_Libro=pres.ID_Libro WHERE pres.ID_usuario="+id_usuario);
                                ResultSet rsla = con4.getRs();
                                
                                while(rsla.next()) {
                        %>
                        <tr>
                            <td><%=rsla.getString("Titulo")%></td>
                            <td><%=rsla.getString("aut.Nombre")+" "+rsla.getString("aut.Apellido")%></td>
                            <td><%=rsla.getString("Edicion")%></td>
                            <td><%=rsla.getString("cate.Categoria")%></td>
                            <td><%=rsla.getString("Imprenta")%></td>
                            <td><%=rsla.getString("FechaLimite")%></td>
                            <td><a href="Detalles.jsp?idLibro=<%=rsla.getInt("ID_Libro")%>"><button class="btn btn-primary">Detalles</button></a> <a href="Extendido.jsp?idLibro=<%=rsla.getInt("ID_Libro")%>"><button id="extender2" class="btn btn-success">Extender prestamo</button></a></td>
                        </tr>
                        <%}}%>
                    </table>
                </div>   
            </div>
        </div>  
        <script type="text/javascript" src="js/ModalMisLibros.js"></script> 
        <script type="text/javascript" src="js/ValidarPres.js"></script>
    </body>
</html>
