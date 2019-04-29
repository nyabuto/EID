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
public class delete_data extends HttpServlet {
HttpSession session;
String results,id,date,year,month,mflcode,indicator,value,timestamp,rev_id;
int counter;
int rows;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
          session = request.getSession();
           dbConn conn = new dbConn();
           
           counter = 0;
           results = request.getParameter("results");
           System.out.println("delete results : "+results);
           
           JSONParser parser = new JSONParser();
           JSONObject alldata = (JSONObject) parser.parse(results);

           rows = Integer.parseInt(alldata.get("total_rows").toString());
           JSONArray array_data = (JSONArray)alldata.get("rows");
            System.out.println("rows to delete : "+rows);
            for(int i=0;i<rows;i++){
                JSONObject obj_data = (JSONObject)array_data.get(i);
                JSONObject indic_data = (JSONObject)obj_data.get("doc");
                
           System.out.println(i+". objdata_deelte : "+obj_data);
           date = indic_data.get("date").toString();
           mflcode = indic_data.get("mflcode").toString();
           rev_id = indic_data.get("_rev").toString();
            
            
            
            System.out.println("Console logs for results delete : "+results);
           
           
           String replacer = "DELETE FROM der_data WHERE date=? AND mflcode=?";
           conn.pst = conn.conn.prepareStatement(replacer);
           conn.pst.setString(1, date);
           conn.pst.setString(2, mflcode);
           
           conn.pst.executeUpdate();
            }
           
            
            if(conn.pst!=null){conn.pst.close();}
            if(conn.conn!=null){conn.conn.close();}
           JSONObject obj_output = new JSONObject();
           obj_output.put("updated", (rows/14)+" Entries added/updated");
            
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
    } catch (SQLException | ParseException ex) {
        Logger.getLogger(delete_data.class.getName()).log(Level.SEVERE, null, ex);
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
    } catch (SQLException | ParseException ex) {
        Logger.getLogger(delete_data.class.getName()).log(Level.SEVERE, null, ex);
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
