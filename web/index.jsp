<%-- 
    Document   : index
    Created on : 25-abr-2018, 3:39:50
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
        <title>Login</title>
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
                    <div class="card border border-primary shadow">
                        <div class="card-header bg-primary text-white text-center">
                            Sistema biblioteca
                        </div>
                        <form id="form_login">
                            <div class="card-body">
                                    <div class="form-group">
                                        <label for="txt_email">Correo electronico:</label>
                                        <input type="email" class="form-control" id="txt_email" placeholder="Correo electronico" name="email" style="min-width: 250px;" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txt_clave">Contraseña</label>
                                        <input type="password" class="form-control" id="txt_clave" placeholder="Clave" name="clave" style="min-width: 250px;" />
                                    </div>
                                
                                <%
                                    String msg = (String)session.getAttribute("erro_login");
                                    
                                    if (msg != null && !msg.isEmpty()) {
                                %>
                                  
                                <div class="alert alert-danger">
                                    <%= msg %>
                                </div>
                                
                                <%      
                                    }
                                %>
                                
                                <div id="cont_error"></div>
                                <a href="/Biblioteca_UDB/registrarse.jsp" class="text-danger">Registrarse</a>
                            </div>
                            <div class="card-footer text-muted p-0">
                                <button id="btn_login" class="btn btn-primary m-0 rounded-0" style="width: 100%;" type="submit">Iniciar sesion</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            $(document).ready(function(){
                $("#form_login").validate({
                    rules: {
                        email: {
                            required: true,
                            email: true
                        },
                        clave: {
                            required: true,
                        }
                    },
                    submitHandler: function(form) {
                        $.post('http://localhost:8081/Biblioteca_UDB/actions/login.jsp', $('#form_login').serialize(), function(data){
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
                
                $("#form_login").submit(function(stay){
                    stay.preventDefault(); 
                    return false;
                });
            });
        </script>
    </body>
</html>
