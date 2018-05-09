
<%@page import="java.sql.ResultSet"%>
<%@page import="libro.biblioteca.poocatedra.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
        <link rel="stylesheet" type="text/css" href="css/estilorecibir.css">
        
           <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
         
       <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
       
        <title>Recibir libro</title>
    </head>
    <body>
        
        <h1>Lista de pedidos</h1>
        <section class="container">
            <% Conexion con = new Conexion();
            con.setRs("SELECT u.ID_usuario,l.ID_Libro,Id_Prestamo,FechaPrestamo,FechaLimite,Nombre,Apellido,Username,Titulo,Imagen,ISBN FROM prestamo as p INNER JOIN usuario as u INNER JOIN libro as l WHERE p.ID_usuario = u.ID_usuario && p.ID_Libro = l.ID_Libro");
             ResultSet rs = con.getRs();
         while(rs.next()){
            %>
            <div id="prestamo">
                <div style="position: absolute;">
                <h3>Prestado por:</h3>
                <p><%= rs.getString("Nombre") +" "+ rs.getString("Apellido") +" | "+ rs.getString("Username") %></p>
                </div>
                 <div style="position: absolute; margin-left: 20%;">
                <h3>Fecha prestamo:</h3>
                <p><%= rs.getString("FechaPrestamo") %></p>
                </div>
                 <div style="position: absolute; margin-left: 39%;">
                <h3>Fecha limite:</h3>
                <p><%= rs.getString("FechaLimite") %></p>
                </div>
                <div style="position: absolute;margin-left: 55%; margin-top: 1%;">
                    <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#Modal_<%= rs.getInt("Id_Prestamo") %>">Ver detalle</button> 
                </div>
                <div style="position: absolute;margin-left: 65%; margin-top: 1%;"> 
                  
                      <button  type="button" class="btn btn-danger" data-toggle="modal" data-target="#Modal_<%= rs.getInt("l.ID_Libro") %>">Finalizar prestamo</button> 
              
                </div>
                <div class="modal fade" id="Modal_<%= rs.getInt("Id_Prestamo") %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Información del libro</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        <div class="modal-body text-center" >
              <h3>Libro prestado:</h3>
          <img style="height:200px; width: 150px;" src=" <%= rs.getString("Imagen") %>">
          <h3>Titulo</h3>
          <p> <%= rs.getString("Titulo") %> </p>
          <h3>ISBN:</h3>
          <p><%= rs.getString("ISBN") %></p>
          
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
     
      </div>
    </div>
  </div>
          
</div>
                   <div class="modal fade" id="Modal_<%= rs.getInt("l.ID_Libro") %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Pregunta</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        <div class="modal-body text-center" >
              <h3>¿Estas seguro de finalizar este prestamo?</h3>
              <form method="post" action="ServletActPres">
                  <button class="btn btn-danger" value="<%= rs.getInt("Id_Prestamo") %>">Si</button>
              </form>
              <br>
          <button type="button" class="btn btn-success" data-dismiss="modal">No</button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
     
      </div>
    </div>
  </div>
          
</div>
            </div>
            <%}%>
        </section>
     

<!-- Modal -->

    </body>
</html>
