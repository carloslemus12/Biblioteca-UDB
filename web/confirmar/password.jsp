<%-- 
    Document   : password
    Created on : 29-abr-2018, 0:44:45
    Author     : MekakuZero
--%>

<%@page import="lemus.alexander.models.Usuario"%>
<%
    if (session.getAttribute("usuario") == null){
        session.setAttribute("erro_login", "Debe de iniciar session");
        response.sendRedirect("/Biblioteca_UDB/index.jsp");
    }
    
    int accion = Integer.parseInt(request.getParameter("accion"));
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirmar clave</title>
        <jsp:include page="/definition.jsp" />
        
        <style>
            html,body,form {
                height: 100%;
            }
            body{
                background: url(../img/books.jpg);
            }
        </style>
    </head>
    <body>
        <div class="h-100 container d-flex justify-content-center align-items-center">
            <div class="row">
                <div class="col">
                    <div class="card border border-success shadow">
                        <div class="card-header bg-success text-white text-center">
                            Sistema biblioteca
                        </div>
                        <form id="form_clave">
                            <div class="card-body">
                                    
                                <input type="hidden" value="<%= accion %>" />
                                
                                <div class="form-group">
                                    <label for="txt_clave">Contraseña</label>
                                    <input type="password" class="form-control" id="txt_clave" placeholder="Clave" name="clave" style="min-width: 250px;" />
                                </div>

                                <div class="form-group">
                                    <label for="txt_confirmar_clave">Confirmar contraseña</label>
                                    <input type="password" class="form-control" id="txt_confirmar_clave" placeholder="Confirmar clave" name="confirmar_clave" style="min-width: 250px;" />
                                </div>
                                
                                <div id="cont_error"></div>
                            </div>
                            <div class="card-footer text-muted p-0">
                                <button id="btn_aceptar" class="btn btn-success m-0 rounded-0" style="width: 100%;" type="submit">Aceptar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            $(document).ready(function(){
                jQuery.validator.addMethod("clave_compare", function(value, element) {
                    return $("#txt_clave").val() == $("#txt_confirmar_clave").val();
                }, "Passwords do not match");
                
                $("#form_clave").validate({
                    rules: {
                        clave: {
                            required: true,
                        },
                        confirmar_clave: {
                            required: true,
                            clave_compare: true
                        }
                    },
                    submitHandler: function(form) {
                        $.post('/Biblioteca_UDB/comprobar/clave.jsp', $('#form_clave').serialize(), function(data){
                            //alert(data);
                            var json = jQuery.parseJSON(data.trim());
                            
                            if(json.estado == "error"){
                                var msg = "<ul class='p-0 m-0 pl-2'>";

                                json.errores.forEach(function(element) {
                                    msg += "<li>" + element + "</li>";
                                });
                                msg += "</ul>";

                                $("#cont_error").html(
                                        "<div class='alert alert-danger' role='alert'>"
                                        + msg
                                        +"</div>"
                                );
                            } else {
                                $("#cont_error").html("");
                                window.location.replace("<%= (accion == 2)? "/Biblioteca_UDB/actions/clave.jsp":"/Biblioteca_UDB/actions/cuenta.jsp"%>");
                            }
                        });
                    }
                });
                
                $("#form_login").submit(function(stay){
                    stay.preventDefault(); 
                    return false;
                });
            });
        </script>
    </body>
</html>
