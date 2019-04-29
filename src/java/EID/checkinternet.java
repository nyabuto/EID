/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package EID;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author GNyabuto
 */
public class checkinternet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            JSONObject obj = new JSONObject();
//            obj.put("isreacheable", checknet());
            obj.put("isreacheable", checknetnow());
            out.println(obj);
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
        processRequest(request, response);
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
        processRequest(request, response);
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

    
 public boolean checknet(){
     boolean isreachable = false;
        try{
            int timeOutInMilliSec=5000;// 5 Seconds
            URL url = new URL("http://www.google.com/");
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod("HEAD");
            conn.setConnectTimeout(timeOutInMilliSec);
            conn.setReadTimeout(timeOutInMilliSec);
            int responseCode = conn.getResponseCode();
            if(200 <= responseCode && responseCode <= 399){
                System.out.println("Internet is Available");
                isreachable = true;
            }
        }
        catch(Exception ex){
            System.out.println("No Connectivity");
            isreachable = false;
        }
        
        return isreachable;
    }  

public boolean checknetnow(){
    try{
            String host="google.com";
            int port=80;
            int timeOutInMilliSec=5000;// 5 Seconds
            Socket socket = new Socket();
            socket.connect(new InetSocketAddress(host, port), timeOutInMilliSec);
            System.out.println("Internet is Available");
            
            return true;
        }
        catch(IOException ex){
            System.out.println("No Connectivity");
            
            return false;
        }
} 
    
}
