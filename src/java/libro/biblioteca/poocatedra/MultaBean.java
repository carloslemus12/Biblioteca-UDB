
package libro.biblioteca.poocatedra;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Emerson Torres
 */
public class MultaBean {
    public String getReserva() throws SQLException{
     Conexion con = new Conexion();
        String option = "";
        con.setRs("SELECT Id_Reserva,Nombre,Apellido,Username FROM reserva as r INNER join usuario as u WHERE r.ID_usuario= u.ID_usuario");
         ResultSet rs = con.getRs();
          while(rs.next()){
         option += "<option value="+rs.getInt("Id_Reserva")+">"+rs.getString("Nombre")+" "+ rs.getString("Apellido")+" | "+ rs.getString("Username")+"</option>";
         }
        return option;
    }
}
