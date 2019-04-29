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
import java.util.Calendar;
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
public class save_data extends HttpServlet {
HttpSession session;
String all_data,rev_id,id,user_id,facility_id,year,month,hei_no,gender,dob,sample_date,date_tested,results,date_initiated_art,remarks,status,timestamp;
int counter;
int rows,added,not_uploaded;
String year_month="";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           session = request.getSession();
           dbConn conn = new dbConn();
           JSONArray jarray = new JSONArray();
           JSONObject obj_output = new JSONObject();
           
           Calendar calendar = Calendar.getInstance();
           int today = calendar.get(Calendar.DAY_OF_MONTH);
           int current_month = calendar.get(Calendar.MONTH)+1;
           int current_year = calendar.get(Calendar.YEAR);
           
           today = 3;
           int d_month = current_month-1;
           if(d_month<10){
               year_month = current_year+"-0"+d_month+"-";
           }
           else{
               if(d_month==0){
                   year_month = (current_year-1)+"-12-";
               }
               year_month = current_year+"-"+d_month+"-";
           }
           
            System.out.println("calendar is : "+calendar);
            System.out.println("today is : "+today);
            System.out.println("uploadable sample collection year-month :"+year_month);
           
           if(today<=10){
           counter =added = not_uploaded= 0;
           all_data = request.getParameter("all_data");
            System.out.println("all data:"+all_data);
           JSONParser parser = new JSONParser();
           JSONObject alldata = (JSONObject) parser.parse(all_data);

           rows = Integer.parseInt(alldata.get("total_rows").toString());
           JSONArray array_data = (JSONArray)alldata.get("rows");
            
            for(int i=0;i<rows;i++){
                JSONObject obj_data = (JSONObject)array_data.get(i);
                JSONObject hei_data = (JSONObject)obj_data.get("doc");
                System.out.println("one record :"+hei_data); 
            
                System.out.println("user id :"+hei_data.get("user_id"));
         if(hei_data.get("user_id")!=null){
           rev_id = hei_data.get("_rev").toString();
           id = hei_data.get("_id").toString();
           user_id = hei_data.get("user_id").toString();
           year = hei_data.get("year").toString();
           month = hei_data.get("month").toString();
           facility_id = hei_data.get("facility_id").toString();
           hei_no = hei_data.get("hei_no").toString();
           gender = hei_data.get("gender").toString();
           dob = hei_data.get("dob").toString();
           sample_date = hei_data.get("sample_date").toString();
           date_tested = hei_data.get("date_tested").toString();
           results = hei_data.get("results").toString();
           date_initiated_art = hei_data.get("date_initiated_art").toString();
           remarks = hei_data.get("remarks").toString();
           status = hei_data.get("status").toString();
           timestamp = hei_data.get("timestamp").toString();
           
           //if(sample_date.contains(year_month)){
           if(status.equals("0")){
           String replacer = "REPLACE INTO eid_monthly_data SET rev_id=?,id=?,phone=?,reporting_year=?,reporting_month=?,facility_id=?,hei_no=?,sex=?,dob=?,sample_date=?,date_tested=?,results=?,date_initiated_art=?,remarks=?,browser_timestamp=?";
           conn.pst = conn.conn.prepareStatement(replacer);
           conn.pst.setString(1, rev_id);
           conn.pst.setString(2, id);
           conn.pst.setString(3, user_id);
           conn.pst.setString(4, year);
           conn.pst.setString(5, month);
           conn.pst.setString(6, facility_id);
           conn.pst.setString(7, hei_no);
           conn.pst.setString(8, gender);
           conn.pst.setString(9, dob);
           conn.pst.setString(10, sample_date);
           conn.pst.setString(11, date_tested);
           conn.pst.setString(12, results);
           conn.pst.setString(13, date_initiated_art);
           conn.pst.setString(14, remarks);
           conn.pst.setString(15, timestamp);
           
           conn.pst.executeUpdate();
//          CREATE A JSON OUTPUT OF SAVED 
JSONObject obj = new JSONObject();
obj.put("_rev", rev_id);
obj.put("_id",  id);
obj.put("user_id",  user_id);
obj.put("facility_id",  facility_id);
obj.put("year",  year);
obj.put("month",  month);
obj.put("hei_no",  hei_no);
obj.put("gender",  gender);
obj.put("dob",  dob);
obj.put("sample_date",  sample_date);
obj.put("date_tested", date_tested);
obj.put("results", results);
obj.put("date_initiated_art", date_initiated_art);
obj.put("remarks", remarks);
obj.put("status", 1);
obj.put("timestamp",  timestamp);

jarray.add(obj);

added++;
           
  }
            else{
    System.out.println("Record already uploaded");
   }
//           }
//           else{
//               not_uploaded++;
//           }
   
            }
            else{
//                    bad record
                    }
      }
           
            if(conn.pst!=null){conn.pst.close();}
            if(conn.conn!=null){conn.conn.close();}
            
           obj_output.put("records",added);
           obj_output.put("not_uploaded",not_uploaded);
           obj_output.put("date",today);
           obj_output.put("records_details", jarray);
           }
           else{
         obj_output.put("date",today);
           }
           
            System.out.println(obj_output);
            out.println(obj_output);
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
        Logger.getLogger(save_data.class.getName()).log(Level.SEVERE, null, ex);
    } catch (SQLException ex) {
        Logger.getLogger(save_data.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(save_data.class.getName()).log(Level.SEVERE, null, ex);
    } catch (SQLException ex) {
        Logger.getLogger(save_data.class.getName()).log(Level.SEVERE, null, ex);
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
