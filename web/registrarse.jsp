<%-- 
    Document   : registrarse
    Created on : 27-abr-2018, 16:52:34
    Author     : MekakuZero
--%>
<%@page import="lemus.alexander.models.Usuario"%>
<%
    if (session.getAttribute("usuario") != null){
        Usuario usuario = (Usuario)session.getAttribute("usuario");
        if(usuario.getTipo_usuario() == 3)
            response.sendRedirect("/Biblioteca_UDB/lector/libros.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrarse</title>
        <jsp:include page="definition.jsp" />
        
        <style>
            html,body,form {
                height: 100%;
            }
            body{
                background: url(img/back_login.jpg);
            }
        </style>
    </head>
    <body>
        <div class="h-100 container d-flex justify-content-center align-items-center">
            <div class="row">
                <div class="col">
                    <div class="card border border-danger shadow">
                        <div class="card-header bg-danger text-white text-center">
                            Sistema biblioteca
                        </div>
                        <form id="form_register">
                            <div class="card-body">
                                    <div class="row">
                                        <div class="form-group col-12 col-md-6">
                                            <label for="txt_nombre">Nombre:</label>
                                            <input type="text" class="form-control" id="txt_nombre" placeholder="Nombre" name="nombre" style="min-width: 250px;" />
                                        </div>
                                        <div class="form-group col-12 col-md-6">
                                            <label for="txt_apellido">Apellido:</label>
                                            <input type="text" class="form-control" id="txt_apellido" placeholder="Apellido" name="apellido" style="min-width: 250px;" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="txt_username">Nombre de usuario:</label>
                                        <input type="text" class="form-control" id="txt_username" placeholder="Username" name="username" style="min-width: 250px;" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txt_email">Correo electronico:</label>
                                        <input type="email" class="form-control" id="txt_email" placeholder="Correo electronico" name="email" style="min-width: 250px;" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txt_clave">Contraseña:</label>
                                        <input type="password" class="form-control" id="txt_clave" placeholder="Clave" name="clave" style="min-width: 250px;" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txt_confirmarClave">Confirmar contraseña:</label>
                                        <input type="password" class="form-control" id="txt_confirmarClave" placeholder="Clave" name="confirmar_clave" style="min-width: 250px;" />
                                    </div>
                                <div id="cont_error"></div>
                            </div>
                            <div class="card-footer text-muted p-0">
                                <button id="btn_login" class="btn btn-danger m-0 rounded-0" style="width: 100%;" type="submit">Registrarse</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            $(document).ready(function(){
                jQuery.validator.addMethod("clave_compare", function(value, element) {
                    return $("#txt_clave").val() == $("#txt_confirmarClave").val();
                }, "Passwords do not match");

                $("#form_register").validate({
                    rules: {
                        nombre: {
                            required: true,
                        },
                        username: {
                            required: true,
                        },
                        apellido: {
                            required: true,
                        },
                        email: {
                            required: true,
                            email: true
                        },
                        clave: {
                            required: true,
                        },
                        confirmar_clave: {
                            required: true,
                            clave_compare: true
                        }
                    },
                    submitHandler: function(form) {
                        $.post('http://localhost:8081/Biblioteca_UDB/actions/register.jsp', $('#form_register').serialize(), function(data){
                            
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
                                var tipo = json.tipo;
                                if(tipo == 3)
                                    window.location.replace("/Biblioteca_UDB/lector/libros.jsp");
                            }
                        });
                    }
                });
                
                $("#form_register").submit(function(stay){
                    stay.preventDefault();

                    return false;
                });
            });
        </script>
    </body>
</html>