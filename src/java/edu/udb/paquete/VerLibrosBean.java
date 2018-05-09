
package edu.udb.paquete;

import java.sql.ResultSet;
import java.sql.SQLException;

public class VerLibrosBean {
    private int id_libro;
    private int id_autor;
    private int id_categoria;
    private String imagen;
    private String titulo;
    private String edicion;
    private String imprenta;
    private String descripcion;
    private String isbn;

    public int getId_libro() {
        return id_libro;
    }

    public void setId_libro(int id_libro) {
        this.id_libro = id_libro;
    }

    public int getId_autor() {
        return id_autor;
    }

    public void setId_autor(int id_autor) {
        this.id_autor = id_autor;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getEdicion() {
        return edicion;
    }

    public void setEdicion(String edicion) {
        this.edicion = edicion;
    }

    public String getImprenta() {
        return imprenta;
    }

    public void setImprenta(String imprenta) {
        this.imprenta = imprenta;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    public String getTabla() throws SQLException{
        Conexion con = new Conexion();
        String tabla = "";
        con.setRs("SELECT Titulo, Edicion, Imprenta, Descripcion, ISBN FROM libro INNER JOIN autor ON libro.ID_Autor = autor.ID_Autor INNER JOIN categoria ON libro.ID_cat = categoria.ID_Cat");
        ResultSet rs = con.getRs();
        while(rs.next()) {
            tabla += "<tr><td>"+rs.getString("Titulo")+"</td><td>"+rs.getString("autor")+"</td><td>"+rs.getString("Edicion")+"</td><td>"+rs.getString("categoria")+"</td><td>"+rs.getString("Imprenta")+"</td><td>"+rs.getString("Descripcion")+"</td><td>"+rs.getString("ISBN")+"</td></tr>";
        }
        return tabla;
    }
}
