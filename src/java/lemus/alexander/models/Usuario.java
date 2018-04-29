/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lemus.alexander.models;

/**
 *
 * @author MekakuZero
 */
import java.sql.ResultSet;
import mojica.alexander.mvc.Conexion;

public class Usuario extends Conexion{

    int id;
    String nombre;
    String apellido;
    String username;
    String email;
    String password;
    int tipo_usuario;
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getTipo_usuario() {
        return tipo_usuario;
    }

    public void setTipo_usuario(int tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }
    
    public static Usuario getLast(){
        Usuario usuario = new Usuario();
        
        Conexion con = Conexion.obtenerConexion();
        
        con.conectar();
        
        con.crearQuery("SELECT * from usuario ORDER by usuario.ID_usuario DESC LIMIT 1");
        
        ResultSet rs = con.getResultSet();

        try{
            if (rs.next()) {
                usuario.setId(rs.getInt("ID_usuario"));
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setApellido(rs.getString("Apellido"));
                usuario.setUsername(rs.getString("Username"));
                usuario.setPassword(rs.getString("Clave"));
                usuario.setEmail(rs.getString("CorreoElectronico"));
                usuario.setTipo_usuario(rs.getInt("ID_tipo"));
            }
        } catch(Exception error){}
        
        con.desconectar();
        
        return usuario;
    }
    
    public static Usuario getUsuario(String email, String password){
        Usuario usuario = new Usuario();
        
        Conexion con = Conexion.obtenerConexion();
        
        con.conectar();
        
        con.crearQuery("SELECT * from usuario WHERE CorreoElectronico = ? AND Clave = ?");
        
        con.agregarParametro(1, email);
        con.agregarParametro(2, password);
        
        ResultSet rs = con.getResultSet();

        try{
            if (rs.next()) {
                usuario.setId(rs.getInt("ID_usuario"));
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setApellido(rs.getString("Apellido"));
                usuario.setUsername(rs.getString("Username"));
                usuario.setPassword(rs.getString("Clave"));
                usuario.setEmail(rs.getString("CorreoElectronico"));
                usuario.setTipo_usuario(rs.getInt("ID_tipo"));
            }
        } catch(Exception error){}
        
        con.desconectar();
        
        return usuario;
    }
    
    @Override
    public boolean guardar() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean eliminar() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean actualizar() {
        boolean estado = false;
        
        Conexion con = Conexion.obtenerConexion();
        
        con.conectar();
        
        con.crearQuery("SELECT * from usuario WHERE usuario.ID_usuario = ?");
        
        con.agregarParametro(1, this.id);
        
        ResultSet rs = con.getResultSet();

        try{
            if (rs.next()) {
                estado = true;
                this.setId(rs.getInt("ID_usuario"));
                this.setNombre(rs.getString("Nombre"));
                this.setApellido(rs.getString("Apellido"));
                this.setUsername(rs.getString("Username"));
                this.setPassword(rs.getString("Clave"));
                this.setEmail(rs.getString("CorreoElectronico"));
                this.setTipo_usuario(rs.getInt("ID_tipo"));
            }
        } catch(Exception error){}
        
        con.desconectar();
        
        return estado;
    }
    
}
