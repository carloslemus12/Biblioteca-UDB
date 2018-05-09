<jsp:useBean id="optionusuario" scope="request" class="libro.biblioteca.poocatedra.PrestamoBean"/>
<%@page session="true" language="java" import="java.io.*" %>
<%@page session="true" language="java" import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Prestamo libros</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet"  href="css/bootstrap-chosen.css">
        <link rel="stylesheet" type="text/css" href="css/estilo.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://harvesthq.github.io/chosen/chosen.jquery.js"></script>
    <script>
      $(function() {
        $('.chosen-select').chosen();
        $('.chosen-select-deselect').chosen({ allow_single_deselect: true });
      });
    </script>
    </head>
    <body>
        <style>
    .chosen-focus-input{
        visibility: hidden;
    }
    span{
       
       margin-top: -13.5%;
        position: absolute;

    }
        </style>
          <div class="container">  
           <form id="contact" action="ServletPrestar" method="post" > 
    <h3>Ingresar prestamos</h3>

      
    <fieldset>
        <p>¿Quien presta el libro?</p>
          
        <select class="chosen-select chosen-rtl" name="usuario" >
            <jsp:getProperty name="optionusuario" property="usuarios"/>
            </select>
    </fieldset>
    <fieldset>
         <p>Escoge el libro que prestaras:</p>
            <select class="chosen-select chosen-rtl" name="libro" >
            <jsp:getProperty name="optionusuario" property="libros"/>
            </select>
    </fieldset>
    <fieldset>
       <p>Fecha limite de entrega:</p>
        <input type="date" class="form-control" name="fechaentre">
    </fieldset>
     <fieldset>
            <p>Fecha devolución:</p>
        <input type="date" class="form-control" name="fechadevo">      
     </fieldset>
       
    <fieldset>
    
      <button type="submit" class="btn btn-success">Enviar</button>
    </fieldset>
      <%
               if(request.getParameter("error") ==null){
                    %>
                  
                    <label class="success alert-success"></label>
                    <%}else if(request.getParameter("error").equals("1")){%>
                      <label class="danger alert-danger">Campo  vacio</label>
                    <%}else if(request.getParameter("error").equals("0")){%>
                       <label class="success alert-success">Prestamo ingresado correctamente</label>
                    <%}%>
  </form>
       
</div>
    </body>
</html>
