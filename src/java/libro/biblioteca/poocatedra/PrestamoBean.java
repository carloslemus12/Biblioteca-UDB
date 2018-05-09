
package libro.biblioteca.poocatedra;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PrestamoBean {
    public String getUsuarios() throws SQLException{
        Conexion con = new Conexion();
        String option = "";
        con.setRs("SELECT * FROM usuario WHERE ID_tipo=3");
         ResultSet rs = con.getRs();
         while(rs.next()){
         option += "<option value="+rs.getInt("ID_usuario")+">"+rs.getString("Nombre")+"</option>";
         }
        return option;
    }
    public String getLibros() throws SQLException{
        Conexion con = new Conexion();
        String option = "";
        con.setRs("SELECT * FROM libro");
         ResultSet rs = con.getRs();
         while(rs.next()){
         option += "<option value="+rs.getInt("ID_Libro")+">"+rs.getString("Titulo")+"</option>";
         }
        return option;
    }
}
