
package edu.udb.paquete;

import java.sql.SQLException;

public class VerLibroModel {
    
    public void EliminarReserva(int id_libro) throws SQLException{
        Conexion con = new Conexion();
        
        con.st = con.PrepareStatement("DELETE FROM reserva WHERE ID_Libro="+id_libro);
        con.st.executeUpdate();
        con.cerrarConexion();          
    }
    
    public void ExtenderPrestamo(int id_libro) throws SQLException{
        Conexion con2 = new Conexion();
        
        con2.PrepareStatement("UPDATE prestamo SET extendido=1 WHERE ID_Libro="+id_libro);
        con2.st.executeUpdate();  
        
    }
}
