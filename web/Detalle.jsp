<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" language="java" import="java.io.*" %>
<%@page session="true" language="java" import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="edu.udb.paquete.Conexion"%>

<%

    //int id_libro = Integer.parseInt(request.getParameter("idLibro"));
    
    int id_libro = 1;
    
    try{
        Conexion con = new Conexion();
        con.setRs("SELECT * FROM libro lib INNER JOIN autor aut ON lib.ID_Autor=aut.ID_Autor INNER JOIN categoria cate ON lib.ID_cat=cate.ID_Cat INNER JOIN reserva res ON lib.ID_Libro=res.ID_Libro WHERE lib.ID_Libro="+id_libro+" AND res.ID_Libro="+id_libro);
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
                        <p class="hDes p"><%=rs.getString("Descripcion") %></p>
                    </div>                    
                    <a href="EliminarReserva.jsp?idLibro=<%=id_libro%>"><button class="btn btn-danger extender">Eliminar reserva</button></a>  
                    <div class="divFecha">
                        <strong><label class="hFecha">Fecha límite:</label></strong>
                        <label class="hFecha p"><%=rs.getString("res.FechaLimite")%></label>
                    </div>
                </div>                
            </section>
            <%  
                }
                }catch(SQLException e){
                    
                }            
            %>    
        </div>
    </body>
</html>
