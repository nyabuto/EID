/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package EID;

import database.dbConn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author GNyabuto
 */
public class save_users extends HttpServlet {
HttpSession session;
String results,phone,fullname,email,mflcode;
int counter;
int rows;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
         counter = 0;
           results = request.getParameter("results");
           
           JSONParser parser = new JSONParser();
           JSONObject alldata = (JSONObject) parser.parse(results);

           rows = Integer.parseInt(alldata.get("total_rows").toString());
           JSONArray array_data = (JSONArray)alldata.get("rows");
            
            for(int i=0;i<rows;i++){
                JSONObject obj_data = (JSONObject)array_data.get(i);
                JSONObject indic_data = (JSONObject)obj_data.get("doc");
                
//           System.out.println(i+". user objdata : "+obj_data);
          
           phone = indic_data.get("_id").toString();
           fullname = indic_data.get("fullname").toString();
           email = indic_data.get("email").toString();
           mflcode = indic_data.get("mflcode").toString().replace("\"", "").replace("[", "").replace("]", "");
           
           String replacer = "REPLACE INTO users SET phone=?,fullname=?,email=?,mflcode=?";
           conn.pst = conn.conn.prepareStatement(replacer);
           conn.pst.setString(1, phone);
           conn.pst.setString(2, fullname);
           conn.pst.setString(3, email);
           conn.pst.setString(4, mflcode);
           
               System.out.println("Add Users : "+conn.pst);
           conn.pst.executeUpdate();
           
            }
           
            if(conn.pst!=null){conn.pst.close();}
            if(conn.conn!=null){conn.conn.close();}
            
           JSONObject obj_output = new JSONObject();
           obj_output.put("updated", rows+" Entries added/updated");
            
            out.println("success");
        }
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
    } catch (ParseException ex) {
        Logger.getLogger(save_users.class.getName()).log(Level.SEVERE, null, ex);
    } catch (SQLException ex) {
        Logger.getLogger(save_users.class.getName()).log(Level.SEVERE, null, ex);
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
    } catch (ParseException ex) {
        Logger.getLogger(save_users.class.getName()).log(Level.SEVERE, null, ex);
    } catch (SQLException ex) {
        Logger.getLogger(save_users.class.getName()).log(Level.SEVERE, null, ex);
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
