/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Reports;

import code.copytemplates;
import static database.OSValidator.isUnix;
import database.dbConn;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.FontFamily;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTTable;

/**
 *
 * @author GNyabuto
 */
public class RawData extends HttpServlet {
    HttpSession session;
    String start_date,end_date,county,sub_county,facility,where_location,query,value;
    int has_data=0,row=0;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, InvalidFormatException {
        response.setContentType("text/html;charset=UTF-8");
          session = request.getSession();
          dbConn conn = new dbConn();
         
          
          county = request.getParameter("county");
          sub_county = request.getParameter("district");
          facility = request.getParameter("facility");
          start_date = request.getParameter("start_date");
          end_date = request.getParameter("end_date");
          
          start_date =start_date.replace("_", "-");
          end_date = end_date.replace("_", "-");
        
       

                if(county==null || county.equals("")){
                where_location=" 1=1 ";    
                }
            
        else if(!(facility==null || facility.equals(""))){
         String[] facility_data = request.getParameter("facility").split("_");   
            where_location = " (";
           has_data=0;
           for(String fac:facility_data){
            if(fac!=null && !fac.equals("")){
             where_location+=" subpartnera.SubpartnerID='"+fac+"' OR ";
             has_data++;
            }  
           }
           
           if(has_data>0){
           where_location = removeLast(where_location, 3);
           where_location+=")";
           }
           else{   
           } 
              
        }
        else if(!(sub_county==null || sub_county.equals(""))){
            String[] sub_county_data = request.getParameter("district").split("_");
               where_location = " (";
           has_data=0;
           for(String sct:sub_county_data){
            if(sct!=null && !sct.equals("")){
             where_location+=" district.DistrictID='"+sct+"' OR ";
             has_data++;
            }  
           }
           
           if(has_data>0){
           where_location = removeLast(where_location, 3);
           where_location+=")";
           }
           else{  
           } 
                System.out.println(has_data+" where : "+where_location);    
              // where = " WHERE district.DistrictID='"+sub_county+"' ";    
            }
                
                      
            else if(!(county==null || county.equals(""))){
                   String[] county_data = request.getParameter("county").split("_"); 
                   where_location = " (";
                    has_data=0;
                    System.out.println("counties : "+county_data.length);
                    for(String ct:county_data){
                     if(ct!=null && !ct.equals("")){
                         
                      where_location+=" county.CountyID='"+ct+"' OR ";
                      has_data++;
                     }  
                    }

                    if(has_data>0){
                    where_location = removeLast(where_location, 3);
                    where_location+=")";
                    }
                    else{  
                    }
                   
                }
          
        if(!where_location.contains("1=1")){
        String all_loc_ids = where_location;
        where_location=" SubPartnerID IN(";
         //get mfls
        String getFacilIDS = "SELECT SubpartnerID FROM subpartnera LEFT JOIN district on subpartnera.DistrictID = district.DistrictID LEFT JOIN county ON county.CountyID=district.CountyID"
            + " WHERE "+all_loc_ids+" AND subpartnera.active=1";
            System.out.println("getmfls : "+getFacilIDS);
        conn.rs = conn.st.executeQuery(getFacilIDS);
        while(conn.rs.next()){
        where_location+=""+conn.rs.getString(1)+",";
        }
        
        where_location = removeLast(where_location, 1);
        where_location+=")";  
        }
        else{
            
        }
        
        if(!start_date.equals("") && end_date.equals("")){
         where_location+= " AND date>='"+start_date+"' ";   
        }
        else if(start_date.equals("") && !end_date.equals("")){
         where_location+= " AND date<='"+end_date+"' ";   
        }
        else if(start_date.equals("") && end_date.equals("")){
        // do nothing
        }
        else if(!start_date.equals("") && !end_date.equals("")){
         where_location+= " AND sample_date BETWEEN '"+start_date+"' AND '"+end_date+"' ";   
        }
        else{}
       
        where_location +=" AND PMTCT=1 ";
       
String allpath = getServletContext().getRealPath("/template.xlsx");

XSSFWorkbook wb1;
 
String pathtodelete=null;

Date da= new Date();
String dat2 = da.toString().replace(" ", "_");

dat2 = dat2.toString().replace(":", "_");

String mydrive = allpath.substring(0, 1);

String np=mydrive+":\\HSDSA\\EID\\MACROS\\";

String filepath="EID_REPORT"+dat2+".xlsx";


if(isUnix()){
    np="/HSDSA/EID/MACROS/";
}


 new File(np).mkdirs();

 np+=filepath;
 
//check if file exists
String sourcepath = getServletContext().getRealPath("/template.xlsx");

File f = new File(np);
if(!f.exists()&& !f.isFile() ) {
    /* do something */
    
    copytemplates ct= new copytemplates();
    System.out.println("Copying macros..");
    ct.transfermacros(sourcepath,np);
    
}
else
    //copy the file alone  
{
    
    copytemplates ct= new copytemplates();
//copy the agebased file only
ct.copymacros(sourcepath,np);

}
File allpathfile= new File(np);

OPCPackage pkg = OPCPackage.open(allpathfile);

pathtodelete=np;


//wb = new XSSFWorkbook( OPCPackage.open(allpath) );
wb1 = new XSSFWorkbook(pkg);


//SXSSFWorkbook wb = new SXSSFWorkbook(wb1, 100);

XSSFWorkbook wb = wb1;



             //            ^^^^^^^^^^^^^CREATE STATIC AND WRITE STATIC DATA TO THE EXCELL^^^^^^^^^^^^
//    XSSFWorkbook wb=new XSSFWorkbook();
//    XSSFSheet shet1=wb.createSheet("Raw Data Report");
    XSSFSheet shet1= wb.getSheet("Raw Data Report");
    XSSFFont font=wb.createFont();
    font.setFontHeightInPoints((short)18);
    font.setFontName("Cambria");
    font.setColor((short)0000);
    
    CellStyle style=wb.createCellStyle();
    style.setFont(font);
    style.setAlignment(HorizontalAlignment.CENTER);
    
    XSSFCellStyle styleHeader = wb.createCellStyle();
    styleHeader.setFillForegroundColor(HSSFColor.GREY_40_PERCENT.index);
    styleHeader.setFillPattern(FillPatternType.SOLID_FOREGROUND);
    styleHeader.setBorderTop(BorderStyle.THIN);
    styleHeader.setBorderBottom(BorderStyle.THIN);
    styleHeader.setBorderLeft(BorderStyle.THIN);
    styleHeader.setBorderRight(BorderStyle.THIN);
    styleHeader.setAlignment(HorizontalAlignment.CENTER);
    
    XSSFFont fontHeader = wb.createFont();
    fontHeader.setColor(HSSFColor.BLACK.index);
    fontHeader.setBold(true);
    fontHeader.setFamily(FontFamily.MODERN);
    fontHeader.setFontName("Cambria");
    fontHeader.setFontHeight(15);
    styleHeader.setFont(fontHeader);
    styleHeader.setWrapText(true);
    
    XSSFCellStyle stylex = wb.createCellStyle();
    stylex.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
    stylex.setFillPattern(FillPatternType.SOLID_FOREGROUND);
    stylex.setBorderTop(BorderStyle.THIN);
    stylex.setBorderBottom(BorderStyle.THIN);
    stylex.setBorderLeft(BorderStyle.THIN);
    stylex.setBorderRight(BorderStyle.THIN);
    stylex.setAlignment(HorizontalAlignment.LEFT);
    
    XSSFFont fontx = wb.createFont();
    fontx.setColor(HSSFColor.BLACK.index);
    fontx.setBold(true);
    fontx.setFamily(FontFamily.MODERN);
    fontx.setFontName("Cambria");
    stylex.setFont(fontx);
    stylex.setWrapText(true);
    
    XSSFCellStyle stborder = wb.createCellStyle();
    stborder.setBorderTop(BorderStyle.THIN);
    stborder.setBorderBottom(BorderStyle.THIN);
    stborder.setBorderLeft(BorderStyle.THIN);
    stborder.setBorderRight(BorderStyle.THIN);
    stborder.setAlignment(HorizontalAlignment.LEFT);
    
    XSSFFont font_cell=wb.createFont();
    font_cell.setColor(HSSFColor.BLACK.index);
    font_cell.setFamily(FontFamily.MODERN);
    font_cell.setFontName("Cambria");
    stborder.setFont(font_cell);
    stborder.setWrapText(true);
        
    row=0;  
//    XSSFRow RowHeader = shet1.createRow(row);
//    RowHeader.setHeightInPoints(50);
    
          
      System.out.println("WHERE : "+where_location);
      
   query = "SELECT county.County AS County,district.DistrictNom AS sub_county,subpartnera.SubPartnerNom AS Facility,subpartnera.CentreSanteId as MFLCode,IFNULL(PMTCT_Support,'') AS 'Support Type'," +
"reporting_year as 'Reporting Year', " +
"CASE " +
"WHEN reporting_month=1 THEN 'Jan' " +
"WHEN reporting_month=2 THEN 'Feb' " +
"WHEN reporting_month=3 THEN 'Mar' " +
"WHEN reporting_month=4 THEN 'Apr' " +
"WHEN reporting_month=5 THEN 'May' " +
"WHEN reporting_month=6 THEN 'Jun' " +
"WHEN reporting_month=7 THEN 'Jul' " +
"WHEN reporting_month=8 THEN 'Aug' " +
"WHEN reporting_month=9 THEN 'Sep' " +
"WHEN reporting_month=10 THEN 'Oct' " +
"WHEN reporting_month=11 THEN 'Nov' " +
"WHEN reporting_month=12 THEN 'Dec' " +
"else 'Unknown Month' " +
"END AS 'Reporting Month'," +
" " +
" concat(hei_no,' ') AS 'HEI No.',sex AS 'Sex/Gender',dob AS 'Date of Birth',sample_date AS 'Sample Collection Date',date_tested AS 'Date EID Test Done'," +
"CASE " +
"WHEN  TIMESTAMPDIFF(day, dob,sample_date)<=7 THEN  CONCAT(TIMESTAMPDIFF(day, dob,sample_date),' Days') " +
"WHEN  TIMESTAMPDIFF(day, dob,sample_date)>7 AND TIMESTAMPDIFF(MONTH, dob,sample_date)<1 THEN  CONCAT(ROUND((TIMESTAMPDIFF(day, dob,sample_date)/7)),' Weeks') " +
"WHEN  TIMESTAMPDIFF(MONTH, dob,sample_date)>=1 and TIMESTAMPDIFF(MONTH, dob,sample_date)<=12 THEN  CONCAT(TIMESTAMPDIFF(MONTH, dob,sample_date),' Months') " +
"ELSE 'ABOVE 1 YEAR' " +
"END AS 'Age Bracket'," +
" " +
"CASE " +
"WHEN results='P' THEN 'Positive' " +
"WHEN results='N' THEN 'Negative' " +
"WHEN results='waiting' THEN 'Awaiting Results' " +
"ELSE 'Unknown Results' " +
"END AS 'Test Results'," +
"date_initiated_art AS 'ART Initiation Date',remarks AS 'Remarks'," +
"browser_timestamp AS 'Date Data Entered'," +
"timestamp AS 'Date Data Uploaded'," +
" " +
"IFNULL(ART_highvolume,0) AS 'ART High Volume', IFNULL(HTC_highvolume,0) AS 'HTC High Volume', IFNULL(PMTCT_highvolume,0) AS 'PMTCT High Volume'  " +
"FROM eid_monthly_data LEFT JOIN subpartnera ON eid_monthly_data.facility_id=subpartnera.SubPartnerID " +
"LEFT JOIN district ON subpartnera.DistrictID=district.DistrictID " +
"LEFT JOIN county ON district.CountyID=county.CountyID " +
"WHERE  "+where_location+" " +
"ORDER BY County,sub_county,Facility";
   
        System.out.println(query);   
   conn.rs = conn.st.executeQuery(query);
   System.out.println("Running Query : "+query);
        
   ResultSetMetaData metaData = conn.rs.getMetaData();
   int col_count = metaData.getColumnCount(); //number of column
   
   
      
//      for(int i=0;i<col_count; i++){
//      value = metaData.getColumnLabel(i+1);
//      XSSFCell cell = RowHeader.createCell(i);
//      if(isNumeric(value)){cell.setCellValue(Integer.parseInt(value));}
//      else{cell.setCellValue(value);}
//      cell.setCellStyle(stylex);
//      shet1.autoSizeColumn(i);
//      }
   row=1;
   while (conn.rs.next()) {
    row++;
    XSSFRow RowData = shet1.createRow(row);
    for(int i=0;i<col_count; i++){ // read and output data
          value = conn.rs.getString(i+1);
      XSSFCell cell = RowData.createCell(i);
      if(isNumeric(value)){cell.setCellValue(Integer.parseInt(value));}
      else{cell.setCellValue(value);}
      cell.setCellStyle(stborder);
      }
    
    }

        if(1==1){
    // XSSFSheet shet2= wb.getSheet("Raw Data Report");
        // tell your xssfsheet where its content begins and where it ends
((XSSFSheet)shet1).getCTWorksheet().getDimension().setRef("A1:U" + (shet1.getLastRowNum() + 1));

CTTable ctTable = ((XSSFSheet)shet1).getTables().get(0).getCTTable();

ctTable.setRef("A1:U" + (shet1.getLastRowNum() + 1)); // adjust reference as needed
    
        }

   
    ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
    wb.write(outByteStream);
    byte [] outArray = outByteStream.toByteArray();
    response.setContentType("application/ms-excel");
    response.setContentLength(outArray.length);
    response.setHeader("Expires:", "0"); // eliminates browser caching
    response.setHeader("Set-Cookie:", "fileDownload=true; path=/"); // set cookie header
    response.setHeader("Content-Disposition", "attachment; filename=Raw_Data_Report_2018.xlsx");
    OutputStream outStream = response.getOutputStream();
    outStream.write(outArray);
    outStream.flush();
     
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
        } catch (SQLException | InvalidFormatException ex) {
            Logger.getLogger(RawData.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException | InvalidFormatException ex) {
            Logger.getLogger(RawData.class.getName()).log(Level.SEVERE, null, ex);
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
public boolean isNumeric(String s) {  
        return s != null && s.matches("[-+]?\\d*\\.?\\d+");  
}
   private static String removeLast(String str, int num) {
    return str.substring(0, str.length() - num);
}
}
