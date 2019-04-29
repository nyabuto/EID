<%-- 
    Document   : export_data
    Created on : Nov 9, 2018, 8:48:15 AM
    Author     : GNyabuto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--<html  manifest="der.appcache">-->
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>DER Export</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		  <link href="css/dataTables.bootstrap.min.css" rel="stylesheet">
                  <link href="css/jquery.dataTables.min.css" rel="stylesheet">
		<link href="css/bootstrap.css" rel="stylesheet">
                <link href="css/bootstrap-datepicker.min.css" rel="stylesheet">
                    <link rel="stylesheet" href="css/select2.min.css">
                    <link rel="shortcut icon" href="logo.png">
		<link href="css/styles.css" rel="stylesheet">
                
		 <style>
                input:focus {
                    border-color: red;
                }
                .select2-container{ width: 100% !important; }
                </style>
                
	</head>
	<body>
            <div style="margin-top:2%;">
                <div style=" margin-left: 10%;"><a href="index.jsp"><img src="images/back.png" style="height: 5%; width: 5%;"><b style="font-size: 200%;">Go Back</b></a></div>
	<div  style="margin-left: 40%; margin-top: -4%">
          <table>  <tr><td>
	<h3 id="records">Records to be exported</h3></td>
                  <td><button type="button" id="export" class="btn btn-success" style="margin-left: 50%" >Export Data to Excel</button></td>
        </tr></table>
	</div>
           </div> 
            <br>
            <table id="table_data" class="table" style="margin-left: 50px; margin-right: 50px; width: 95%;">
          <thead><tr><th hidden="true">ID</th><th>Date</th><th>Delivery Point</th><th>Year</th><th>Month</th><th>Indicator</th><th>MFLCode</th><th>Value</th><th hidden="true">Date Key</th><th>Phone</th><th hidden="true">Timestamp</th><th>Timestamp</th>  </tr></thead>
          <tbody id="data"> </tbody>
        </table>
	
	 <script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.js"></script>
		<script src="js/scripts.js"></script>
                <script src="js/bootstrap-datepicker.min.js"></script>
                <script src="js/select2.min.js"></script>
                <script src="js/pouchdb-7.0.0.js"></script>
                <script src="js/pouchdb.find.js"></script>
                 
                  <script type="text/javascript" src="js/jquery.fileDownload.js"></script>
                 <script type="text/javascript" src="js/datatables.min.js"></script>
                 <script type="text/javascript" src="js/sweetalert.min.js"></script>

                 <script>
                     
                   $("#export").click(function(){
                       exportTableToExcel("table_data","Exported_DER_Data");
                   });  
                     
                  var db = new PouchDB('der_rri');
			                            	
                db.allDocs({
                  include_docs: true,
                  attachments: true
                }).then(function (result) {
                  // handle result
//              var data = JSON.stringify(result);
//		alert("data:"+data);
//		console.log(data);
                if(result.total_rows>0){
                 $("#records").html(((result.total_rows-1)/14)+" Records Found");
                }
                else{
                  $("#records").html(result.total_rows+" Records Found");  
                }
               var rows = result.rows;
//               console.log(result.rows);
              var output="";
            var date,delivery_point,year,month,mflcode,indicator,value,phone,timestamp,_id,_rev;
//    alert("len : "+rows.length);
               for(var i=0;i<rows.length;i++){
                        date = rows[i].doc.date;
                        delivery_point = rows[i].doc.delivery_point;
                        year = rows[i].doc.year;
                        month = rows[i].doc.month;
                        mflcode = rows[i].doc.mflcode;
                        indicator = rows[i].doc.indicator;
                        value = rows[i].doc.value;
                        phone = rows[i].doc.phone;
                        timestamp = rows[i].doc.timestamp;
                        _id = rows[i].doc._id;
                        _rev= rows[i].doc._rev;  
              if(date!==undefined)  {    
                output+="<tr><td hidden=\"true\">"+_id+"</td><td>"+date+"</td><td>"+delivery_point+"</td><td>"+year+"</td><td>"+month+"</td><td>"+indicator+"</td><td>"+mflcode+"</td><td>"+value+"</td><td hidden=\"true\">"+date+"</td><td>"+phone+"</td><td  hidden=\"true\">"+timestamp+"</td><td>"+timestamp+"</td></tr>";        
                $("#data").html(output); 
                  }
            }
                 
//              $("#data").html(output);   
                 
                 
                 
                 
//                 var form_data = {"results":data};
//                 alert("data:"+data);
                }).catch(function (err) {
                  console.log(err);
                });
						  
				  
	
    function exportTableToExcel(tableID, filename = ''){
    var downloadLink;
    var dataType = 'application/vnd.ms-excel';
    var tableSelect = document.getElementById(tableID);
    var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');
    
    // Specify file name
    filename = filename?filename+'.xls':'excel_data.xls';
    
    // Create download link element
    downloadLink = document.createElement("a");
    
    document.body.appendChild(downloadLink);
    
    if(navigator.msSaveOrOpenBlob){
        var blob = new Blob(['\ufeff', tableHTML], {
            type: dataType
        });
        navigator.msSaveOrOpenBlob( blob, filename);
    }else{
        // Create a link to the file
        downloadLink.href = 'data:' + dataType + ', ' + tableHTML;
    
        // Setting the file name
        downloadLink.download = filename;
        
        //triggering the function
        downloadLink.click();
    }
}
                 </script>
	</body>
	
	</html>
		