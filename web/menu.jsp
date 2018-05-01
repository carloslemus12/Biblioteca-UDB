<%-- 
    Document   : menu
    Created on : 28-abr-2018, 7:04:35
    Author     : MekakuZero
--%>
<%@page import="lemus.alexander.models.Usuario"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <span class="navbar-brand">
        <img src="../img/logo.svg" width="30" height="30" alt="">
    </span>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu_principal" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="menu_principal">
        <ul class="navbar-nav mr-auto">
            <% if (((Usuario)session.getAttribute("usuario")).getTipo_usuario() == 3){ %>
                <li class="nav-item">
                    <a class="nav-link" href="#">Ver lista de libros</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Libros prestados</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Libros reservados</a>
                </li>
            <% } else { %>
                
            <% } %>
            <li class="nav-item d-block d-lg-none">
                <a class="nav-link" href="/Biblioteca_UDB/actions/cerrarsesion.jsp">Cerrar sesion</a>
            </li>
            
            <li class="nav-item d-block d-lg-none">
                <a class="nav-link" href="/Biblioteca_UDB/confirmar/password.jsp?accion=1">Mi cuenta</a>
            </li>

            <li class="nav-item d-block d-lg-none">
                <a class="nav-link" href="/Biblioteca_UDB/confirmar/password.jsp?accion=2">Cambiar contraseña</a>
            </li>
        </ul>
        <div class="d-none flex-row justify-content-center d-lg-flex nav-item dropdown">
            <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <%= ((Usuario)session.getAttribute("usuario")).getUsername() %>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="/Biblioteca_UDB/actions/cerrarsesion.jsp">Cerrar sesion</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="/Biblioteca_UDB/confirmar/password.jsp?accion=1">Mi cuenta</a>
              <a class="dropdown-item" href="/Biblioteca_UDB/confirmar/password.jsp?accion=2">Cambiar contraseña</a>
            </div>
        </div>
    </div>
</nav>