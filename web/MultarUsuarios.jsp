<jsp:useBean id="optionusuario" scope="request" class="libro.biblioteca.poocatedra.MultaBean"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
           <link rel="stylesheet" type="text/css" href="css/estilo.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://harvesthq.github.io/chosen/chosen.jquery.js"></script>
    <link rel="stylesheet"  href="css/bootstrap-chosen.css">
     
   
        <title>Agregar multa</title>
     <script>
      $(function() {
        $('.chosen-select').chosen();
        $('.chosen-select-deselect').chosen({ allow_single_deselect: true });
      });
    </script>
    </head>
        <style>
    .chosen-focus-input{
        visibility: hidden;
    }
    span{
       
       margin-top: -13.5%;
        position: absolute;

    }
        </style>
    <body>
        <div class="container">  
           <form id="contact" action="ServletMultar" method="post" > 
               <h3>Multar lectores</h3>
 <fieldset>
         <p>Escoge el lector a multar:</p>
            <select class="chosen-select chosen-rtl" name="optionusuario" >
            <jsp:getProperty name="optionusuario" property="reserva"/>
            </select>
    </fieldset>
            <fieldset>
                  <fieldset>
         <textarea id="observaciones" placeholder="Observaciones de la multa"  class="form-control" tabindex="5" name="observaciones" ></textarea>
    </fieldset>
                <fieldset>
                    <h3 style="font-size:17px;">Cuota a asignar = $0.25</h3>
                </fieldset>
            </fieldset>
            <fieldset>
                 <button type="submit" class="btn btn-success">Enviar</button>
            </fieldset>
            <%
               if(request.getParameter("error") ==null){
                    %>
                  
                    <label class="success alert-success"></label>
                    <%}else if(request.getParameter("error").equals("1")){%>
                      <label class="danger alert-danger">¡ERROR! Campos vacios</label>
                    <%}else if(request.getParameter("error").equals("0")){%>
                       <label class="success alert-success">Multa ingresada correctamente</label>
                    <%}%>
           </form>
        </div>
    </body>
</html>
