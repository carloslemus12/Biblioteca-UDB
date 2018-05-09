<%-- 
    Document   : index
    Created on : 05-08-2018, 09:42:11 AM
    Author     : Rauda
--%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Prestamos y Reservas Activas</title>
        <link
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
        rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container">
        <h1>Control de reservas y préstamos</h1>
        
        <% 
        Calendar fecha = Calendar.getInstance();
        String dia = Integer.toString(fecha.get(Calendar.DATE));
        String mes = Integer.toString(fecha.get(Calendar.MONTH));
        String anio = Integer.toString(fecha.get(Calendar.YEAR));
        String fechaAhora=anio+"-"+mes+"-"+dia;
        Connection conexion = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        //Leemos el driver de Mysql
        Class.forName("com.mysql.jdbc.Driver");
        // Se obtiene una conexión con la base de datos.
        conexion = DriverManager.getConnection("jdbc:mysql://localhost/poocatedra", "root", "");


        %>
        <h2>Reservas Activas</h2>
        <table id="tablita2" class="table table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th>ID Reserva</th>
                    <th>Libro</th>
                    <th>Usuario</th>
                    <th>Fecha Reservación</th>
                    <th>Fecha Límite</th>
                    <th>Prestar</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    st = conexion.prepareStatement("select reserva.Id_Reserva,libro.Titulo,usuario.ID_usuario,usuario.Username,reserva.FechaReservacion,reserva.FechaLimite"
                            + " from reserva"
                            + " inner join libro on libro.ID_Libro=reserva.ID_Libro"
                            + " inner join usuario on usuario.ID_usuario=reserva.ID_usuario"
                            + " where FechaReservacion>"+fechaAhora);
                    rs=st.executeQuery();
                    while(rs.next()){
                    
                %>
                <tr>
                    <td><%= rs.getString("Id_Reserva") %></td>
                    <td><%= rs.getString("Titulo") %></td>
                    <td><%= rs.getString("Username") %></td>
                    <td><%= rs.getString("FechaReservacion") %></td>
                    <td><%= rs.getString("FechaLimite") %></td>
                    <td><a href='prestar.jsp?id=<%=rs.getString("Id_Reserva")%>' class="btn btn-warning">Prestar</a></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
            <h2>Préstamos por recibir</h2>
            <a href="listarprestamos.jsp" class="btn btn-info">Ver Historial De Préstamos</a><br><br>
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
                            + "where prestamo.estado=0 "
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
            <%
                
                conexion.close();
                %>
    </body>
</html>
