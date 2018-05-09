
<%@page import="java.sql.ResultSet"%>
<%@page import="libro.biblioteca.poocatedra.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista libros</title>
        <link rel="stylesheet" type="text/css" href="css/estilolibros.css">
         <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
         
       <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
         
    </head>
    <body>
       
<!-- Modal -->

        
        <h1 style="text-align: center;">Listar libros</h1>
        <% 
        Conexion con = new Conexion();
        con.setRs("SELECT l.Id_Autor,Imagen,Titulo,Edicion,Imprenta, l.Descripcion AS librodes, ISBN,Nombre,Apellido, Seudonimo,FechaNacimiento,categoria FROM libro as l join autor as u join categoria as c WHERE l.Id_Autor = u.ID_Autor and l.ID_cat = c.ID_Cat");
          ResultSet rs = con.getRs();
         while(rs.next()){
        %>
        
        <!-- Button trigger modal -->
        
        <section class="container-fluid">
            
            <h1  class="text-center">Titulo: <%= rs.getString("Titulo")  %></h1>
              <img class="imagen" src="<%= rs.getString("Imagen") %>"> 
            <div id="detalle">             
          
            
            <div class="container">                    
            <h2>Edicion:</h2>
            <h4> <%= rs.getString("Edicion") %> </h4>
            <h2>Imprenta:</h2>
            <h4><%= rs.getString("Imprenta") %></h4>
            <h2>Descripcion</h2>
            <h4><%= rs.getString("librodes") %></h4>
            <h2>ISBN:</h2>
            <h4><%= rs.getString("ISBN") %></h4>
            </div>
            
            </div>
            <button style="position: absolute; margin-left: 30%;margin-top: 15%;" type="button" class="btn btn-primary" data-toggle="modal" data-target="#Modal_<%= rs.getInt("Id_Autor") %>">
  Ver informacion de autor
</button>

<!-- Modal -->
<div class="modal fade" id="Modal_<%= rs.getInt("Id_Autor") %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Información del autor</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <h3>Nombre:</h3>
          <p><%= rs.getString("Nombre") + " "+ rs.getString("Apellido") %></p>
          <h3>Seudonimo</h3>
          <p><%= rs.getString("Seudonimo") %></p>
          <h3>Fecha de nacimiento:</h3>
          <p><%=  rs.getDate("FechaNacimiento") %></p>
          
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
     
      </div>
    </div>
  </div>
</div>
        </section>
        <%}%>
   
    </body>
</html>
