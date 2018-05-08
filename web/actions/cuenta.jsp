<%-- 
    Document   : cuenta
    Created on : 29-abr-2018, 1:36:05
    Author     : MekakuZero
--%>

<%@page import="lemus.alexander.models.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    session.setAttribute("Clave_Valida", null);
 %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= usuario.getUsername() %></title>
        <jsp:include page="/definition.jsp" />
        
        <style>
            html,body,form {
                height: 100%;
            }
            body{
                background: url(../img/back_login.jpg);
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
                        <form id="form_cuenta" method="post" action="/Biblioteca_UDB/actions/guardar_cuenta.jsp">
                            <div class="card-body">
                                    <div class="row">
                                        <div class="form-group col-12 col-md-6">
                                            <label for="txt_nombre">Nombre:</label>
                                            <input type="text" class="form-control" id="txt_nombre" placeholder="Nombre" name="nombre" style="min-width: 250px;" value="<%= usuario.getNombre() %>" />
                                        </div>
                                        <div class="form-group col-12 col-md-6">
                                            <label for="txt_apellido">Apellido:</label>
                                            <input type="text" class="form-control" id="txt_apellido" placeholder="Apellido" name="apellido" style="min-width: 250px;" value="<%= usuario.getApellido()%>" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="txt_username">Nombre de usuario:</label>
                                        <input type="text" class="form-control" id="txt_username" placeholder="Username" name="username" style="min-width: 250px;" value="<%= usuario.getUsername()%>" />
                                    </div>
                                    <div class="form-group">
                                        <label for="txt_email">Correo electronico:</label>
                                        <input type="email" class="form-control" id="txt_email" placeholder="Correo electronico" name="email" style="min-width: 250px;" value="<%= usuario.getEmail()%>" />
                                    </div>
                                <div id="cont_error"></div>
                            </div>
                            <div class="card-footer text-muted p-0">
                                <button id="btn_cambios" class="btn btn-danger m-0 rounded-0" style="width: 100%;" type="submit">Guardar cambios</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
                                    
        <script>
            $(document).ready(function(){

                $("#form_cuenta").validate({
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
                        }
                    },
                    submitHandler: function(form) {
                        $(form).submit();
                    }
                });
            });
        </script>
    </body>
</html>
