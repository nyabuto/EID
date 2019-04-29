/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;


import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author GNyabuto
 */
public final class dbConnweb {

   public ResultSet rs0,rs, rs1, rs2, rs3, rs4, rs_1, rs_2, rs_3, rs_4, rs_5, rs_6, anc_sch_rs;
   public Statement st0,st, st1, st2, st3, st4, st_1, st_2, st_3, st_4, st_5, st_6, anc_scheduling_st;
   public PreparedStatement pst,pst1,pst2,pst3,pst4;
   String mydrive = "";
   public static int issetdbcalled_file_exists = 2;
   public static int issetdbcalled_exception = 2;
   public static int issetdbcalled_wrongpword = 2;
   public  String dbsetup[] = new String[4];
   public Connection conne = null;

    public dbConnweb() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
         conne = DriverManager.getConnection("jdbc:mysql://localhost:3308/eid?maxAllowedPacket=1000000000","root", "admin");
            
            //if the saved host name is less than 2 letters long, then thats not a genuine host name

            URL location = dbConnweb.class.getProtectionDomain().getCodeSource().getLocation();


            mydrive = location.getFile().substring(1, 2);

                     

                st0 = conne.createStatement();
                st = conne.createStatement();
                st1 = conne.createStatement();
                st2 = conne.createStatement();
                st3 = conne.createStatement();
                st4 = conne.createStatement();
                st_1 = conne.createStatement();
                st_2 = conne.createStatement();
                st_3 = conne.createStatement();
                st_4 = conne.createStatement();
                st_5 = conne.createStatement();
                st_6 = conne.createStatement();
                anc_scheduling_st = conne.createStatement();




        } catch (Exception ex) {
            Logger.getLogger(dbConnweb.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("ERROR WHILE CONNECTING TO DATABASE. CHECK YOUR CONNECTION CREDENTIALS SETTINGS in dbConn.java");
            //error in dbase configuration 
            //call the jsp page that does configuration
        }
    }

 

}
