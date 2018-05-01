<%-- 
    Document   : libros
    Created on : 28-abr-2018, 16:12:07
    Author     : MekakuZero
--%>

<!-- JST -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page import="lemus.alexander.models.Usuario"%>
<%
    if (session.getAttribute("usuario") == null){
        session.setAttribute("erro_login", "Debe de iniciar session");
        response.sendRedirect("/Biblioteca_UDB/index.jsp");
    }
    
    Usuario usuario = (Usuario)session.getAttribute("usuario");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/definition.jsp" />
        <title>Libros</title>
        <link href="../css/pagination.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <jsp:include page="/menu.jsp" />
        
        <form id="form-libros" class="w-100 d-flex justify-content-center bg-danger py-2">
            <div class="form-row">
                <div class="col-12 col-md-auto px-4 px-md-2 my-2 my-md-0">
                    <input type="text" name="titulo" class="form-control" placeholder="Titulo">
                </div>
                <div class="col-12 col-md-auto px-4 px-md-2 my-2 my-md-0">
                    <label class="sr-only" for="inlineFormInputGroup">Username</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <div class="input-group-text"><img src="../img/autor.svg" width="20px" height="20px" /></div>
                      </div>
                      <select name="autor" class="form-control">
                        <sql:query var="autores" dataSource="jdbc/mysql">
                            SELECT autor.ID_Autor, concat(autor.Nombre, ' ', autor.Apellido) as Autor FROM autor
                        </sql:query>
                        <c:forEach var="autor" items="${autores.rows}">
                            <option value="${ autor.ID_Autor }">${ autor.Autor }</option>
                        </c:forEach>
                      </select>
                    </div>
                </div>
                <div class="col-12 col-md-auto px-4 px-md-2 my-2 my-md-0">
                    <label class="sr-only" for="inlineFormInputGroup">Username</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <div class="input-group-text"><img src="../img/categoria.svg" width="20px" height="20px" /></div>
                      </div>
                      <select name="categoria" class="form-control">
                        <sql:query var="categorias" dataSource="jdbc/mysql">
                            SELECT * FROM categoria
                        </sql:query>
                        <c:forEach var="categoria" items="${categorias.rows}">
                            <option value="${ categoria.ID_Cat }">${ categoria.Categoria }</option>
                        </c:forEach>
                      </select>
                    </div>
                </div>
                <div class="col-12 col-md-auto d-flex d-md-block justify-content-center my-2 my-md-0">
                    <button type="submit" class="btn btn-dark px-4 bg-transparent"><img src="../img/filter.svg" width="25px" height="25px" /></button>
                </div>
            </div>
        </form>
        
        <!-- Modal structure -->
        <div id="modal"> <!-- data-iziModal-fullscreen="true"  data-iziModal-title="Welcome"  data-iziModal-subtitle="Subtitle"  data-iziModal-icon="icon-home" -->
            <!-- Modal content -->
        </div>
        
        <div id="modal_error"> <!-- data-iziModal-fullscreen="true"  data-iziModal-title="Welcome"  data-iziModal-subtitle="Subtitle"  data-iziModal-icon="icon-home" -->
            <!-- Modal content -->
        </div>
        
        <section class="container-fluid mt-3">
            
            <div class="card" style="background: url(../img/wood-foot.jpg)">
                <div class="card-body">
                    <div id="cont" class="data-container"></div>
                </div>
                
                <div class="card-footer d-flex justify-content-center">
                    <div id="pagination-demo1"></div>
                </div>
            </div>
            
        </section>
        
        <div class="modal fade border-success" id="modal_info" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog border-success" role="document">
                <div class="modal-content border-success">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="title">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true" class="text-white">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="descripcion">Descripcion</label>
                            <textarea class="form-control" id="descripcion" rows="1" disabled></textarea>
                        </div>
                        <div class="form-group">
                            <label for="categoria">Categoria</label>
                            <input type="email" class="form-control" id="categoria" disabled>
                        </div>
                        <div class="form-group">
                            <label for="autor">Autor</label>
                            <input type="email" class="form-control" id="autor" disabled>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="../js/pagination.js"></script>
        <script>
            
            function libros_filtro(){
                $.get( "/Biblioteca_UDB/actions/libros.jsp", $('#form-libros').serialize(), function( data ) {
                    var libros = jQuery.parseJSON(data.trim());
                    libros.splice(-1,1);

                    var container = $('#pagination-demo1');

                    var options = {
                        dataSource: libros,
                        callback: function (response, pagination) {
                                var dataHtml = '<div class="card-columns">';

                                $.each(response, function (index, item) {
                                    dataHtml += '<div class="card bg-transparent border-dark mb-3" style="background:url(../img/wood.jpg)">';
                                    dataHtml += "<div class='card-header border-dark text-center text-white'><strong>" + item.titulo + "</strong></div>";
                                    dataHtml += "<div class='card-body text-success'>";
                                    dataHtml += (item.img === "")? "<img src='../img/no-img.svg' />" : item.img; 
                                    dataHtml += "</div>";
                                    dataHtml += "<div class='card-footer bg-dark border-dark d-flex justify-content-around'>";

                                    dataHtml += "<a href=\"#\" onclick=\" $('#title').html('" + item.titulo + "'); $('#descripcion').val('" + item.descripcion + "'); $('#autor').val('" + item.autor + "'); $('#categoria').val('" + item.categoria + "'); $('#modal_info').modal('show'); return false; \"><img src=\"../img/search.svg\" width=\"48px\" height=\"100%\" /></a>";
                                    if (!item.reservado) {
                                        dataHtml += "<a href='#' libro='" + item.id + "' titulo='" + item.titulo + "' class='trigger'><img src='../img/bookmark.svg' class='p-0 m-0' width='48px' height='48px' /></a>";
                                    } else if (item.myReserva) {
                                        dataHtml += "<a href='#' libro='" + item.id + "' titulo='" + item.titulo + "' class='cancel-reservation'><img src='../img/reser.svg' class='p-0 m-0' width='48px' height='48px' /></a>";
                                    }

                                    dataHtml += "</div>";
                                    dataHtml += '</div>';
                                });

                                dataHtml += '</div>';
                                $('#cont').html(dataHtml);
                        },
                        className: 'paginationjs-theme-red paginationjs-big'
                    };

                    container.pagination(options);
                });
            }
            
            function libros(){
                $.get( "/Biblioteca_UDB/actions/libros.jsp", function( data ) {
                    var libros = jQuery.parseJSON(data.trim());
                    libros.splice(-1,1);

                    var container = $('#pagination-demo1');

                    var options = {
                        dataSource: libros,
                        callback: function (response, pagination) {
                                var dataHtml = '<div class="card-columns">';

                                $.each(response, function (index, item) {
                                    dataHtml += '<div class="card bg-transparent border-dark mb-3" style="background:url(../img/wood.jpg)">';
                                    dataHtml += "<div class='card-header border-dark text-center text-white'><strong>" + item.titulo + "</strong></div>";
                                    dataHtml += "<div class='card-body text-success'>";
                                    dataHtml += (item.img === "")? "<img src='../img/no-img.svg' />" : item.img; 
                                    dataHtml += "</div>";
                                    dataHtml += "<div class='card-footer bg-dark border-dark d-flex justify-content-around'>";

                                    dataHtml += "<a href=\"#\" onclick=\" $('#title').html('" + item.titulo + "'); $('#descripcion').val('" + item.descripcion + "'); $('#autor').val('" + item.autor + "'); $('#categoria').val('" + item.categoria + "'); $('#modal_info').modal('show'); return false; \"><img src=\"../img/search.svg\" width=\"48px\" height=\"100%\" /></a>";
                                    if (!item.reservado) {
                                        dataHtml += "<a href='#' libro='" + item.id + "' titulo='" + item.titulo + "' class='trigger'><img src='../img/bookmark.svg' class='p-0 m-0' width='48px' height='48px' /></a>";
                                    } else if (item.myReserva) {
                                        dataHtml += "<a href='#' libro='" + item.id + "' titulo='" + item.titulo + "' class='cancel-reservation'><img src='../img/reser.svg' class='p-0 m-0' width='48px' height='48px' /></a>";
                                    }

                                    dataHtml += "</div>";
                                    dataHtml += '</div>';
                                });

                                dataHtml += '</div>';
                                $('#cont').html(dataHtml);
                        },
                        className: 'paginationjs-theme-red paginationjs-big'
                    };

                    container.pagination(options);
                });
            }
            
            $(document).ready(function(){
                $("#modal").iziModal({
                    title: 'El libro ha sido reservado con exito',
                    subtitle: 'Este mensaje se cerrara en 5 seg',
                    headerColor: '#3F51B5',
                    overlayColor: 'rgba(0, 0, 0, 0.4)',
                    iconColor: 'red',
                    iconClass: 'face',
                    overlayClose: true,
                    closeOnEscape: true,
                    bodyOverflow: false,
                    focusInput: true,
                    autoOpen: false,
                    fullscreen: false,
                    openFullscreen: false,
                    timeout: 5000,
                    timeoutProgressbar: true,
                    timeoutProgressbarColor: '#4183D7',
                    transitionInModal: 'transitionIn',
                    transitionOutModal: 'transitionOut',
                    transitionInOverlay: 'fadeIn',
                    transitionOutOverlay: 'fadeOut',
                });
                
                $("#modal_error").iziModal({
                    title: 'La reserva ha sido cancelada con exito',
                    subtitle: 'Este mensaje se cerrara en 5 seg',
                    headerColor: '#3F51B5',
                    overlayColor: 'rgba(0, 0, 0, 0.4)',
                    iconColor: 'red',
                    iconClass: 'face',
                    overlayClose: true,
                    closeOnEscape: true,
                    bodyOverflow: false,
                    focusInput: true,
                    autoOpen: false,
                    fullscreen: false,
                    openFullscreen: false,
                    timeout: 5000,
                    timeoutProgressbar: true,
                    timeoutProgressbarColor: '#4183D7',
                    transitionInModal: 'transitionIn',
                    transitionOutModal: 'transitionOut',
                    transitionInOverlay: 'fadeIn',
                    transitionOutOverlay: 'fadeOut',
                });
                
                $(document).on('click', '.trigger', function(event){
                    event.preventDefault();
                    
                    var titulo = $(this).attr('titulo');
                    var id = parseInt($(this).attr('libro'));
        
                    bootbox.confirm({
                        message: "¿Desea reservar el libro " + titulo + "?",
                        buttons: {
                            confirm: {
                                label: 'Reservar',
                                className: 'btn-success'
                            },
                            cancel: {
                                label: 'Cancelar',
                                className: 'btn-danger'
                            }
                        },
                        callback: function (result) {
                            if (result) {
                                $.post('/Biblioteca_UDB/actions/reservar.jsp', { usuario:<%= usuario.getId() %>, libro:id }, function(data){
                                    var resultado = jQuery.parseJSON(data.trim());
                                    
                                    if (resultado.estado) {
                                        libros_filtro();
                                        $('#modal').iziModal('open');
                                    } else
                                        alert("No se ha podido reservar" + resultado.error);
                                });
                            }
                        }
                    });
                });
                
                $(document).on('click', '.cancel-reservation', function(event){
                    event.preventDefault();
                    
                    var titulo = $(this).attr('titulo');
                    var id = parseInt($(this).attr('libro'));
        
                    bootbox.confirm({
                        message: "¿Desea cancelar la reserva del libro " + titulo + "?",
                        buttons: {
                            confirm: {
                                label: 'Aceptar',
                                className: 'btn-success'
                            },
                            cancel: {
                                label: 'Cancelar',
                                className: 'btn-danger'
                            }
                        },
                        callback: function (result) {
                            if (result) {
                                $.post('/Biblioteca_UDB/actions/cancelar_reservar.jsp', { usuario:<%= usuario.getId() %>, libro:id }, function(data){
                                    var resultado = jQuery.parseJSON(data.trim());
                                    
                                    if (resultado.estado) {
                                        libros_filtro();
                                        $('#modal_error').iziModal('open');
                                    } else
                                        alert("No se ha podido cancelar la reserva " + resultado.error);
                                });
                            }
                        }
                    });
                });
                
                $('#form-libros').submit(function(){
                    libros_filtro();
                    return false;
                });
            });
            
            libros();
        </script>
        
        <jsp:include page="/comprobar/reservaciones.jsp" />
    </body>
</html>
