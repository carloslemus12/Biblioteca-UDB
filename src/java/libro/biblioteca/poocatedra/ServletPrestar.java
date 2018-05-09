/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package libro.biblioteca.poocatedra;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Emerson Torres
 */
@WebServlet(name = "ServletPrestar", urlPatterns = {"/ServletPrestar"})
public class ServletPrestar extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
       PrintWriter out = response.getWriter();
      
 
          Conexion con = new Conexion(); 
         int usuario = Integer.parseInt(request.getParameter("usuario"));
          int libro = Integer.parseInt(request.getParameter("libro"));
       String fechae = request.getParameter("fechaentre");
       String fechade = request.getParameter("fechadevo");
       out.println(fechae);
       if(fechae.trim().equals("")){
       response.sendRedirect("PrestamoLibro.jsp?error=1");
       }else if(fechade.trim().equals("")){
       response.sendRedirect("PrestamoLibro.jsp?error=1");
       }
         
         
        
         Calendar c1 = Calendar.getInstance();
         String dia = Integer.toString(c1.get(Calendar.DATE));
         String mes = Integer.toString(c1.get(Calendar.MONTH)+1);
        String año = Integer.toString(c1.get(Calendar.YEAR));
        Date fechaac = Date.valueOf(año+"-"+mes+"-"+dia);
        Integer extendido = 0;
        Integer estado = 1;
        con.PrepareStatement("INSERT INTO prestamo(ID_usuario ,ID_Libro,FechaPrestamo,FechaLimite,FechaDevoculcion,extendido,estado) values(?,?,?,?,?,?,?)");
        con.st.setInt(1, usuario);
        con.st.setInt(2,libro);
        con.st.setDate(3, fechaac);
        con.st.setString(4,fechae);
        con.st.setString(5, fechade);
        con.st.setInt(6, extendido);
        con.st.setInt(7, estado);
        con.st.executeUpdate();
       
        response.sendRedirect("PrestamoLibro.jsp?error=0");
   
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletPrestar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletPrestar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
