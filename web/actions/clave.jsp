<%-- 
    Document   : clave
    Created on : 29-abr-2018, 1:26:02
    Author     : MekakuZero
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="lemus.alexander.models.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    session.setAttribute("Clave_Valida", null);
 %>
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
                        <form id="form_clave" method="post" action="/Biblioteca_UDB/actions/guardar_clave.jsp">
                            <div class="card-body">
                                
                                <div class="form-group">
                                    <label for="txt_clave">Nueva contraseña</label>
                                    <input type="password" class="form-control" id="txt_clave" placeholder="Clave" name="clave" style="min-width: 250px;" />
                                </div>

                                <div class="form-group">
                                    <label for="txt_confirmar_clave">Confirmar nueva contraseña</label>
                                    <input type="password" class="form-control" id="txt_confirmar_clave" placeholder="Confirmar clave" name="confirmar_clave" style="min-width: 250px;" />
                                </div>
                                
                                <div id="cont_error"></div>
                            </div>
                            <div class="card-footer text-muted p-0">
                                <button id="btn_actualizar" class="btn btn-danger m-0 rounded-0" style="width: 100%;" type="submit">Actualizar</button>
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
                        $(form).submit();
                    }
                });
            });
        </script>
    </body>
</html>
