/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package usuario.validaciones;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.*;

/**
 *
 * @author Rauda
 */
public class ValidacionesUsuarios {
    public boolean validarNombre(String cadena){
        Pattern patron = Pattern.compile("([A-Za-z]+\\s[A-Za-z]+)|([A-Za-z]+)");
        Matcher expresion = patron.matcher(cadena);
        if(cadena.trim().length()==0){
            return false;
        }
        if(expresion.find()){
            return true;
        }
        else{
            return false;
        }
    }
    public boolean validarUsuario(String cadena){
        Pattern patron = Pattern.compile("[A-Za-z]+");
        Matcher expresion = patron.matcher(cadena);
        if(cadena.trim().length()==0){
            return false;
        }
        if(expresion.find()){
            return true;
        }
        else{
            return false;
        }
    }
    public boolean validarCorreo(String cadena){
        Pattern patron = Pattern.compile("([a-z0-9]+(\\.?[a-z0-9])*)+@(([a-z]+)\\.([a-z]+))+");
        Matcher expresion = patron.matcher(cadena);
        if(expresion.find()){
            return true;
        }
        else{
            return false;
        }
    }
    public boolean validarContra(String cadena){
        if(cadena.trim().length()==0){
            return false;
        }else{
            return true;
        }
    }
    public boolean verificarUsuario(String cadena) throws ClassNotFoundException{
        int i = 0;
        Connection conexion = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            //Leemos el driver de Mysql
            Class.forName("com.mysql.jdbc.Driver");
        
            // Se obtiene una conexión con la base de datos.
            conexion = DriverManager.getConnection("jdbc:mysql://localhost/poocatedra", "root", "");
            st = conexion.prepareStatement("select * from usuario where Username=?");
            st.setString(1,cadena);
            rs=st.executeQuery();
            do{
                i++;
            }while(rs.next());
            
        } catch (SQLException ex) {
            
        }
        if(i>1){
            return false;
        }else{
            return true;
        }
    }
    public boolean verificarCorreo(String cadena) throws ClassNotFoundException{
        int i = 0;
        Connection conexion = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            //Leemos el driver de Mysql
            Class.forName("com.mysql.jdbc.Driver");
            // Se obtiene una conexión con la base de datos.
            conexion = DriverManager.getConnection("jdbc:mysql://localhost/poocatedra", "root", "");
            st = conexion.prepareStatement("select * from usuario where CorreoElectronico=?");
            st.setString(1,cadena);
            rs=st.executeQuery();
            do{
                i++;
            }while(rs.next());
            
        } catch (SQLException ex) {
            
        }
        if(i>1){
            return false;
        }else{
            return true;
        }
    }
}
