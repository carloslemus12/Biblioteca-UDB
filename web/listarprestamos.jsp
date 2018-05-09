<%-- 
    Document   : listarprestamos
    Created on : 05-08-2018, 02:02:34 PM
    Author     : Rauda
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historial De Préstamos</title>
        <link
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
        rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </head>
    <body>
        <% 
        Connection conexion = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        //Leemos el driver de Mysql
        Class.forName("com.mysql.jdbc.Driver");
        // Se obtiene una conexión con la base de datos.
        conexion = DriverManager.getConnection("jdbc:mysql://localhost/poocatedra", "root", "");


        %>
        <div class="container">
        <h1>Préstamos</h1>
        <form action="buscarHU.jsp" class="form-inline" id="buscarHU">
        <div class="form-group">
        <label for="usernombre">Nombre de Usuario:</label>
        <input type="text" class="form-control" id="usernombre" name="usernombre">
        <input type="submit" class="btn btn-info" id="enviar" value="Ver Préstamos De Usuario">
        </div>
        </form>
        
        <br><br>
            <table id="tablita" class="table table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th>ID Préstamo</th>
                    <th>Libro</th>
                    <th>Usuario</th>
                    <th>Fecha Préstamo</th>
                    <th>Fecha Límite</th>
                    <th>Extendido</th>
                    <th>Estado</th>
                    <th>Recibir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    st = conexion.prepareStatement("select prestamo.Id_Prestamo,"
                            + "libro.Titulo,usuario.ID_usuario,usuario.Username,"
                            + "prestamo.FechaPrestamo,prestamo.FechaLimite,"
                            + "prestamo.FechaDevoculcion,prestamo.extendido,prestamo.estado "
                            + "from prestamo "
                            + "inner join libro on libro.ID_Libro=prestamo.ID_Libro "
                            + "inner join usuario on usuario.ID_usuario=prestamo.ID_usuario "
                            + "order by prestamo.FechaLimite asc");
                    rs=st.executeQuery();
                    while(rs.next()){
                    
                %>
                <tr>
                    <td><%= rs.getString("Id_Prestamo") %></td>
                    <td><%= rs.getString("Titulo") %></td>
                    <td><%= rs.getString("Username") %></td>
                    <td><%= rs.getString("FechaPrestamo") %></td>
                    <td><%= rs.getString("FechaLimite") %></td>
                    <%
                        if(rs.getString("extendido").equals("1")){
                    %>
                    <td>Si</td>
                    <%
                        }else{
                    %>
                    <td>No</td>
                     <%
                            }
                    %>
                    <%
                        if(rs.getString("estado").equals("0")){
                    %>
                    <td>No Devuelto</td>
                    <td><a href='recibir.jsp?id=<%=rs.getString("Id_Prestamo")%>' class="btn btn-warning">Recibir</a></td>
                    <%
                        }else{
                    %>
                    <td>Devuelto</td>
                     <%
                            }
                    %>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
        </div>
    </body>
</html>
