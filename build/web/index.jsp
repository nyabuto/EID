<%-- 
    Document   : index
    Created on : Feb 5, 2019, 3:17:19 PM
    Author     : 
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  manifest="new.appcache">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>EID Monthly Data</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
                <link href="css/dataTables.bootstrap.min.css" rel="stylesheet">
                <link href="css/jquery.dataTables.min.css" rel="stylesheet">
		<link href="css/bootstrap.css" rel="stylesheet">
                <link href="css/bootstrap-datepicker.min.css" rel="stylesheet">
                    <link rel="stylesheet" href="css/select2.min.css">
                    <link rel="shortcut icon" href="logo.png">
		<link href="css/styles.css" rel="stylesheet">
                <link href='https://fonts.googleapis.com/css?family=Aclonica' rel='stylesheet'>
            <style>
            .navbar-brand {
                font-family: 'Aclonica';font-size: 35px;
            }

            @-webkit-keyframes spaceboots {
                    0% { -webkit-transform: translate(2px, 1px) rotate(0deg); }
                    10% { -webkit-transform: translate(-1px, -2px) rotate(-1deg); }
                    20% { -webkit-transform: translate(-3px, 0px) rotate(1deg); }
                    30% { -webkit-transform: translate(0px, 2px) rotate(0deg); }
                    40% { -webkit-transform: translate(1px, -1px) rotate(1deg); }
                    50% { -webkit-transform: translate(-1px, 2px) rotate(-1deg); }
                    60% { -webkit-transform: translate(-3px, 1px) rotate(0deg); }
                    70% { -webkit-transform: translate(2px, 1px) rotate(-1deg); }
                    80% { -webkit-transform: translate(-1px, -1px) rotate(1deg); }
                    90% { -webkit-transform: translate(2px, 2px) rotate(0deg); }
                    100% { -webkit-transform: translate(1px, -2px) rotate(-1deg); }
            }
            .shake{
                -webkit-animation-name: spaceboots;
                    -webkit-animation-duration: 2.2s;
                    -webkit-transform-origin:50% 50%;
                    -webkit-animation-iteration-count: infinite;
                    -webkit-animation-timing-function: linear;
            }
            </style>
                <style>
                input:focus {
                    border-color: red;
                }
                .select2-container{ width: 100% !important; }
                </style>
 <style>
.dropbtn {
    /*background-color: #4CAF50;*/
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    text-align: left;
    padding-top: 10px;
    padding-bottom: 10px;
    padding-right: 10px;
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 200px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 1px 10px 10px 6px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: #cbe5fe;}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    background-color: #3e8e41;
}

input{
    border: 20px;
}
</style>
	</head>
	<body>
<!-- header -->
<div id="top-nav" class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            
        </div>
        <div class="navbar-collapse collapse">
             <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
              
                    <ul id="g-account-menu" class="dropdown-menu" role="menu">
                        <li><a href="#">My Profile</a></li>
                    </ul>
                </li>
                <li class="dropdown dropbtn" title="Generate Raw Data" id="raw_data" data-toggle="modal" href="#raw_data_popup"><i class="glyphicon glyphicon-download" ></i> Raw Data Reports
                </li>
                <li>
                     <a title="Add Widget" id="manageuserbutton" data-toggle="modal" href="#allusersinfo">
                         <i class="glyphicon glyphicon-user glyphicon-remove"></i>
                         <span id="usernamelabel">View/ Remove Users</span></a>
                 </li>
                 
                 <li><a title="Add Widget" id="adduserbutton" data-toggle="modal" href="#userdetails"><i class="glyphicon glyphicon-user"></i><span id="usernamelabel"> Add User</span></a></li>
                 <li><a title="Add Widget" data-toggle="modal" style="display:none;" id="exportdataanchor2" href="#addWidgetModal"><i class="glyphicon glyphicon-cloud-upload"></i> Export Data</a></li>
                 <li>
                  <a  title="Help" data-toggle="modal" href="#help">
                            <i class="glyphicon glyphicon-question-sign"></i>
                            Help
                        </a></li>
                              <li><a href="#" style="display:none;" onclick="closeapp();"><i class="glyphicon glyphicon-lock"></i> Exit</a></li>
            </ul>
            <br>
        </div>
        
    </div>
    <!-- /container -->
    
</div>
<!-- Main -->
<div class="container-fluid">
    <div class="row">
        <div id="upload_notice" style="display: none; background-color: red; height: 40px; font-weight: 900;text-align: center; color: white;font-size: 28px; margin-top: 3px; margin-bottom: 3px;">UPLOAD YOUR DATA BEFORE 5TH OF EVERY MONTH. NO UPLOAD IS POSSIBLE AFTER 5TH</div>
        <!-- /col-3 -->
        <div class="col-sm-12">
            <h3 style="text-align: center;color:black; font-weight: 900;">Early Infant Diagnosis (EID) Monthly Data <div style="font-size: 14px;">v1.0.0 [2019-02-20]</div></h3>
            <input type="hidden" id="records" name="records" value="0">
            <div class="row">
                <!-- center left-->
                <div class="col-md-12">
                   
                    <div class="btn-group btn-group-justified" style="">
                        <a href="#" id='refreshpage' class="btn btn-primary col-sm-3">
                            Refresh <i class="glyphicon glyphicon-refresh"></i>
                 
                        </a>
                        
                        <a href="#" class="btn col-sm-3 btn-danger btn-lg" id="upload_data">
                            <b id="upload_txt">Upload</b> <i class="glyphicon glyphicon-upload" id="upload_sign"> <b id="toupload" style="font-size: 18px; "></b></i>
                            
                        </a>
                        
                        <a class="btn col-sm-3 btn-info btn-lg"  data-toggle="modal" href="#edit_modal">
                            Edit <i class="glyphicon glyphicon-edit"> <b id="edit" style="font-size: 18px;"></b></i>
                            
                        </a>
                        </div>

                    <hr>
                    <!--tabs-->
                    <div class="panel">
                        <div class="tab-content">
                            <div class="tab-pane active well col-md-12" id="dataentry">
                                
                              <!--Data entry code-->
                    <div class="panel panel-default">
                       
                        <div class="panel-body" style="">
                            <div class="form form-vertical">
                                <table class='table table-striped table-bordered' >
                                    <tr id="label_header"><th style="text-align:center"><div><b><h4 id="label_title" style="font-weight: bolder; font-size: 22px;">Enter (EID) Monthly Data</h4></b></div><div style="float: right;text-align: right;"><a  data-toggle="modal" href="#delete_conf"><img src="images/delete.png" id="img_delete" style="width: 30%; height: 30%; "></a></div></th></tr>
                                    <tr><th style="text-align:center">
                                       <div class="progress">
                                           <div class="progress-bar" id="progess" role="progressbar" style="width: 0%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                       </div>     
                                        </th></tr>
                                
                                    <tr>
                                
                                <tr><td id="user_label" class="col-xs-10">
                                <div class="control-group">
                                     <div class="col-xs-3">
                                    <label>Current User<font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <!--<br>-->   
                                        <select name="user" id="user"  required="true">
                                            <option value="">Select User</option>
                                        </select>
                                    </div>
                                    </div>
                                </div>
                                 </td></tr>
                                
                                <tr>
                                    <td class="col-xs-offset-10">
                                <div class="control-group">
                                     <div class="col-xs-3">
                                    <label> Year <font color="blue"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <select name="year" id="year" required="true" class="form-control">
                                            <option value="">No option</>
                                        </select>
                                    </div>
                                    </div>
                                </div>
                                  </td>
                                    </tr>  
                                   <tr>
                                    <td class="col-xs-offset-10">
                                <div class="control-group">
                                     <div class="col-xs-3">
                                    <label> Month <font color="blue"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <select name="month" id="month" required="true" class="form-control">
                                            <option value="">No option</>
                                        </select>
                                    </div>
                                    </div>
                                </div>
                                  </td>
                                    </tr> 
                                
                                  <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  Health Facility: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <select  onchange="check_hei_no();" name="facilityname" id="facilityname" class="form-control" required="true">
                                            <option value="">Select Facility Name</option>
                                           
                                        </select>
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                                  
                                  
                                  <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  HEI No: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <input name="hei_no" id="hei_no" autocomplete="off" class="form-control" maxlength="30" required="true" placeholder="Enter HEI No." onkeyup="check_hei_no();">
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                                  <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  Gender: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <select  onchange="" name="gender" id="gender" class="form-control" >
                                            <option value="">Choose Gender</option>
                                            <option value="F">Female</option>
                                            <option value="M">Male</option>
                                        </select>
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                                  
                                  
                                   <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  Date of Birth: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <input name="dob" id="dob" autocomplete="off" class="form-control dates" readonly placeholder="e.g yyyy-mm-dd"  required="true" onchange="">
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                                   
                                   
                                      <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  Sample Collection Date: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <input name="sample_date" id="sample_date" autocomplete="off" class="form-control dates" readonly placeholder="e.g yyyy-mm-dd"  required="true">
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                                  
                                      <!--<tr id="" style="display: none;"><td class="col-xs-12">-->
                                      <tr id="" style=""><td class="col-xs-12">
                                
                                              <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  Date Tested: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <input type="text" name="date_tested" id="date_tested" autocomplete="off" class="form-control dates" readonly placeholder="e.g yyyy-mm-dd">
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                                    
                                  <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  Results: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <select  onchange="" name="result" id="result" class="form-control"  required="true">
                                            <option value="">Choose Result</option>
                                            <option value="P">Positive</option>
                                            <option value="N">Negative</option>
                                            <option value="waiting">Awaiting Results</option>
                                           
                                        </select>
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                                  
                                  
                                  
                                  <tr id="initiated_details"><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  Date initiated on ART: <font color="red"><b></b></font></label>
                                     </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <input name="date_initiated_art" id="date_initiated_art" autocomplete="off" class="form-control dates" readonly placeholder="e.g yyyy-mm-dd">
                                    </div> 
                                      </div>
                                </div>
                                   </td></tr>
                                      
                                  
                                   <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                      <div class="col-xs-3">
                                    <label>  Remarks: <font color="red"><b></b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                    <textarea name="remarks" id="remarks" class="form-control"></textarea>
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                                   
                                   <input type="hidden" name="_rev" id="_rev" value="" autocomplete="off" class="form-control dates" readonly placeholder="">
                                   <input type="hidden" name="prev_id" id="prev_id" value="" autocomplete="off" class="form-control dates" readonly placeholder="">
                                   
                                   <!--END-->
                                   <tr><td class="col-xs-12">
                                        <div class="control-group" style="margin-right: 20%; margin-left: 20%;">
                                      <button type="save_form" id="save_form" class="btn btn-primary btn-success " style="width:100%; color: white; font-weight: bold; font-size: 18px;" >Save Data</button>
                                </div>
                                   </td></tr>
                                     
                                    </table>
                                         <table class='table table-striped table-bordered' id="dynamicindicators">                      
                                    </table>
                                
                                <table class="table table-striped table-bordered">
                                <tr><td colspan="3" class="col-xs-12">               
                                <div class="control-group col-xs-12">
                                  
                                    <div class="controls">
                                        <button id='savebutton' style="margin-left: 0%;" class="btn-lg btn-success active col-xs-12">
                                           Do nothing...
                                        </button>
                                     </div>
                                 </div>
                                </td></tr>
                                        
                                </table>
                            </div>
                        </div>
                        <!--/panel content-->
                    </div>
                    <!--/panel-->
                   <!--Data entry code-->
                            
                            </div>
                         
                            </div>
                        </div>

                    </div>
                    <!--/tabs-->

                </div>
                <!--/col-->
               
                <!--/col-span-6-->

            </div>
            <!--/row-->

          <div id="prev_month"></div> 

  <table id="table_data" class="table" style="margin-left: 50px; margin-right: 50px; width: 95%;" hidden="true">
          <thead><tr><th>ID</th><th>Date</th><th>Delivery Point</th><th>Year</th><th>Month</th><th>Indicator</th><th>MFLCode</th><th>Value</th><th>Date Key</th><th>Phone</th><th>Timestamp</th><th>Timestamp</th>  </tr></thead>
          <tbody id="data"> </tbody>
        </table>
	      
        </div>
        <!--/col-span-9-->
    </div>

<!-- /Main -->

<footer class="text-center"> &copy; HSDSA USAID </footer>

<div class="modal" id="edit_modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" id="refr1" aria-hidden="true">×</button>
                <h4 class="modal-title" style="text-align: center;">Edit Records</h4>
            </div>
            <div class="modal-body">
                <form id="exportdataform">
                <table class="table table-striped table-bordered">
                      <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  Health Facility: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <select  onchange="check_search_hei_no();" name="search_mflcode" id="search_mflcode" class="form-control" required="true">
                                         <option value="">Select Facility Name</option>
                                        </select>
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                      
                      
                      <tr><td class="col-xs-12">
                                
                                  <div class="control-group">
                                       <div class="col-xs-3">
                                    <label>  HEI No: <font color="red"><b>*</b></font></label>
                                    </div>
                                      <div class="col-xs-9" style="float: left;">
                                    <div class="controls">
                                        <input name="search_hei_no" id="search_hei_no" class="form-control" maxlength="30" required="true" placeholder="Enter HEI No." autocomplete="off" onkeyup="check_search_hei_no();">
                                    </div>
                                    </div>
                                </div>
                                   </td></tr>
                </table>
                    
              </form>
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn btn-success" id="search">Search</a>
              
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dalog -->
</div>


<div class="modal" id="addWidgetModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" id="refr1" aria-hidden="true">×</button>
                <h4 class="modal-title">Data Export</h4>
            </div>
            <div class="modal-body">
                <form id="exportdataform">
                   
              <button class=" btn-lg btn-success" style="text-align: center;" id="exportbutton" onclick="importdata();"> Export Data</button>
              
              
              <button class=" btn-lg btn-info" style="display:none;text-align: center;"  id="exportmsg" > Exporting Data..</button>
              <p id="exportresponse"> </p>
              </form>
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn" id="refr">Close</a>
              
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dalog -->
</div>
<!-- /.modal -->

<div class="modal" id="help">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"  style="font-weight: 900; text-align: center;">EID Monthly Data Collection App. User Guide v1.0.0</h4>
            </div>
            <div class="modal-body">
                <div>
                 <h4 style="font-weight: bold">a] About Application  </h4> 
                 <p>EID Mobile App is an offline browser-based application that collects EID data monthly.</p> 
                 <p>Data collected is stored locally on your browser hence users can use this application even if they have not connected to Internet.</p> 
                 <p>Users can click on the upload button to upload data to the online server. This <b>requires</b> Internet connection.</p> 
                 <p><b style="color: red;">Note</b> Do not clear your browser history/cache/data before you upload this data to the Internet. This will delete all data.</p> 
                </div>         
                <div>
                    <h4 style="font-weight: bold;">b] First Time Use</h4>
                   <p>Kindly follow these steps to set up EID System: </p> 
                   <ol>
                    <li>Enter <b>URL</b> to this system This will be provided by M&E Or clinical team.</li>
                    <li>Add a user. Ensure you enter correct details and associate this user to one or more health facility.</li>
                    <li>Select reporting year and month. </li>
                    <li>Select health facility.(When registering a user, the selected facility will be auto-selected. If you selected more  than one facility, you will be required to select the right facility at this point) </li>
                    <li><b  style="color: red;">Kindly Note: </b> Entry fields only appears if reporting year,month and health facility are selected. </li>
                   </ol>
                </div>
                <div>
                <h4 style="font-weight: bold;">c] Best Practices</h4>
                <ol>
                <li>Remember to do regular data backup</li>
                <li>Do not clear browser history/cache/data</li>
                <li>We recommend you use <b>Chrome/Mozilla Firefox</b> browsers</li>
                </ol>
                </div>

            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
               
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dalog -->
</div>
<!-- Modal -->
<div class="modal fade" id="delete_conf" tabindex="-1" role="modal" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
          <h3 class="modal-title" id="exampleModalLabel" style="text-align: center; font-weight: 900;">Delete Current Records</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        <div class="modal-body" style="font-weight: 200;">
        Are you sure you want to delete this entry?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary btn-success" data-dismiss="modal">No</button>
        <button type="button" id="btn_conf_delete" class="btn btn-primary btn-danger" data-dismiss="modal" >Yes, Am very sure</button>
      </div>
    </div>
  </div>
</div>

<!--Add User-->
<div class="modal fade" id="userdetails" role="modal" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
          <h4 class="modal-title" id="exampleModalLabel" style="text-align: center; font-weight: 900;"><u>Register a new User</u></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
        </button>
      </div>
        
   <form id="exportdataform">
        <div class="modal-body" style="font-weight: 200;">
            <div  class="row form-group">
                <div class="col-xs-3" style="clear: left;"> <label for="name" class="control-label">FullName<font color="red">*</font></label> </div>
                <div class="col-xs-8" style="padding: 3px 2px 3px 2px; float: left" ><input placeholder="Enter your fullname" type="text" name="fullname" id="fullname" class="form-control"> </div>  
      </div>
      <div  class="row form-group">
          <div class="col-xs-3" style="clear: left;"> <label for="name" class="control-label">Phone Number<font color="red">*</font></label> </div>
        <div  class="col-xs-8" style="padding: 3px 2px 3px 2px; float: left"><input placeholder="Phone Number" type="number" name="phone" id="phone" class="form-control"> </div>  
      </div>
      <div  class="row form-group">
          <div class="col-xs-3" style="clear: left;"> <label for="name" class="control-label">Email Address</label> </div>
        <div  class="col-xs-8" style="padding: 3px 2px 3px 2px; float: left"><input placeholder="Email Address (Optional)" type="email" name="email" id="email" class="form-control"> </div>  
      </div>
     
      <div  class="row">
         <div class="col-xs-3" style="clear: left;"> <label for="name" class="control-label">Health Facility<font color="red">*</font></label> </div>
        <div  class="col-xs-8" style="padding: 3px 2px 3px 2px; float: left">
            <select  name="mflcode" id="mflcode" multiple="true" class="form-control"> 
                <option value="">Chose health facility</option>  
            </select>
        </div>  
      </div>
      </div>
       </form>
      <div class="modal-footer">
        <button type="button" id="btn_add_user" class="btn btn-primary btn-success" data-dismiss="modal" >Add User</button>
      </div>
    </div>
  </div>
</div>


<!--Raw Data Report-->
<div class="modal fade" id="raw_data_popup" role="modal" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
      <div class="modal-content" id="report_values">
      <div class="modal-header">
          <h4 class="modal-title" id="exampleModalLabel" style="text-align: center; font-weight: 900;"><u>Generate Raw Data Report</u></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
        </button>
      </div>
        
   <form id="exportdataform">
        <div class="modal-body" style="font-weight: 200;">
            
            <div  class="row form-group" style="margin-left: 3%;">
                 <div  class="row">
                <div class="col-xs-5" style="clear: left;"> <label for="name" class="control-label">County<font color="red"></font></label> </div>
                <div class="col-xs-6" style="padding: 3px 2px 3px 2px; float: left" >
                <select  name="county" id="county" multiple="true" class="form-control"> 
                <option value="">Choose County</option>  
            </select>
        </div>  
      </div>
                 
      <div  class="row">
         <div class="col-xs-5" style="clear: left;"> <label for="name" class="control-label">Sub County<font color="red"></font></label> </div>
        <div  class="col-xs-6" style="padding: 3px 2px 3px 2px; float: left">
            <select  name="district" id="district" multiple="true" class="form-control"> 
                <option value="">Chose Sub County</option>  
            </select>
        </div>  
      </div>
            
                 
      <div  class="row">
         <div class="col-xs-5" style="clear: left;"> <label for="name" class="control-label">Health Facility<font color="red"></font></label> </div>
        <div  class="col-xs-6" style="padding: 3px 2px 3px 2px; float: left">
            <select  name="facility" id="facility" multiple="true" class="form-control"> 
                <option value="">Chose Facility</option>  
            </select>
        </div>  
      </div>
            
      <div  class="row">
          <div class="col-xs-5" style="clear: left;"> <label for="name" class="control-label">Sample Collection Start Date<font color="red"></font></label> </div>
        <div  class="col-xs-6" style="padding: 3px 2px 3px 2px; float: left"><input placeholder="Sample Collection Start Date" type="text" readonly name="start_date" id="start_date" class="form-control datepicker"> </div>  
      </div>
      <div  class="row">
          <div class="col-xs-5" style="clear: left;"> <label for="name" class="control-label">Sample Collection End Date</label> </div>
        <div  class="col-xs-6" style="padding: 3px 2px 3px 2px; float: left"><input placeholder="Sample Collection End Date" type="text" readonly name="end_date" id="end_date" class="form-control datepicker"> </div>  
      </div>
            
      </div>
      </div>
       </form>
      <div class="modal-footer">
        <button type="button" id="btn_rawdata" class="btn btn-primary btn-success" >Generate Raw Data</button>
      </div>
    </div>
      <div  class="modal-content" id="img_loading">
<img src="images/loading.gif" style="width:100%">
</div>
  </div>
</div>

<!--Manage User-->
<div class="modal fade" id="allusersinfo" role="modal" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
          <h4 class="modal-title" id="exampleModalLabel" style="text-align: center; font-weight: 900;"><u>Current Registered Users</u></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
        </button>
      </div>
        
        <form id="exportdataform">
            <table  class="table table-striped table-responsive" style="padding: 10px 30px 10px 30px" >
       <thead>
      <tr><th>Fullname</th><th>Phone</th><th>Email</th><th>Facility MFL Code(s)</th><th>Action</th></tr>
      </thead>
      <tbody  id="registered_users">
      
      </tbody>
      </table>
       </form>
    </div>
  </div>
</div>
	<!-- script references -->
                <!--<script src="js/jquery-2.1.4.min.js"></script>-->
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
                  var db = new PouchDB('eid');
                  var db_delete = new PouchDB('eid_deleted');
                  var db_new = new PouchDB('eid_new');
                  var db_user = new PouchDB('eid_user');
                  var application_name = "EID Monthly Data App";
                  var max_date=40;
                  var notice_date=5;
                 </script>
                 <script>
                   $(document).ready(function(){
                    load_years(0);
                    lock_upload();
                    load_facilities();
                    
                    $("#year").change( function(){
                       get_month(0); 
                    });
                    
                   });  
                     </script>
                 <script>
                     
                     function lock_upload(){
                       var today = new Date();
                        var day = today.getDate();
                         
                         
                         if(parseInt(day)<=max_date){ //allow upload of data
                         $("#upload_txt").html('Upload');       
                         $("#upload_sign").addClass('glyphicon-upload');       
                         $("#upload_data").css('background-color','red');
                       
                         }
                         else{ // lock data
                         $("#upload_txt").html('Records : ');    
                         $("#upload_sign").removeClass('glyphicon-upload');    
                         $("#upload_data").css('background-color','green'); 
                       
                         }
                         
                     }
                     
                     
                     function load_years(selected_year){
                         var years = [2018, 2019, 2020,2021,2022,2023];
                         var current_year = (new Date()).getFullYear();
                         var years_output="<option value=\"\"> Select Year</option>";
                         
                         var y_counter=0;
                         while(y_counter<years.length){
                             if(parseInt(years[y_counter])<=parseInt(current_year)){
                                 
                             if(selected_year==parseInt(years[y_counter])){
                               years_output+="<option value=\""+years[y_counter]+"\" selected>"+years[y_counter]+"</option>";   
                             }    
                              else{
                                  years_output+="<option value=\""+years[y_counter]+"\">"+years[y_counter]+"</option>"; 
                              }   
                                 
                                 
                           
                       }
                       y_counter++;
                         }
                         
                         //add it to the output
                $("#year").html(years_output);
                $("#year").select2();   
                     }
                     
                    
                    function get_month(selected_month){
                        var year = $("#year").val();
                         var month = "";
                        var options = "";
                        var months_output=""; 
                       if(year==""){months_output="<option value=\"\">No Month</option>";}
                       else{
                   var json_months= {
		"shortname": ["Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept"],
		"monthno": [10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9],
		"fullname": ["October", "November", "December", "January", "February", "March", "April", "May", "June", "July", "August", "September"]
                    };
                         
              var json_nos = json_months['monthno'];
              var month_counter = 0;
              while(month_counter<json_nos.length){
                  if(parseInt(json_nos[month_counter])>=10){
                      
                      if(selected_month==parseInt(json_nos[month_counter])){
            months_output +="<option value=\""+json_nos[month_counter]+"\" selected>"+json_months['shortname'][month_counter]+" - "+(parseInt(year)-1)+"</option>";                          
                      }
                      
                      else{
             months_output +="<option value=\""+json_nos[month_counter]+"\">"+json_months['shortname'][month_counter]+" - "+(parseInt(year)-1)+"</option>";                         
                      }
            }
            
            else{ // month less 10.... show same year
                
                if(selected_month==parseInt(json_nos[month_counter])){
                     months_output +="<option value=\""+json_nos[month_counter]+"\" selected>"+json_months['shortname'][month_counter]+" - "+year+"</option>";      
                }
                
                else{
                      months_output +="<option value=\""+json_nos[month_counter]+"\">"+json_months['shortname'][month_counter]+" - "+year+"</option>";     
                }
         
            }
            month_counter++;
              }
          }
              
                $("#month").html(months_output);
                $("#month").select2();  
                    } 
                     
                     </script>
                     <script>
                     function load_facilities(){
                       var output = "",output2 = ""; 
             $.getJSON("json/facilities.json",function(facilities){
             for( var a=0;a< facilities.length; a++){
                var facilityID=facilities[a].FacilityID;    
                var facilityName=facilities[a].FacilityName;
                var mflcode = facilities[a].MFLCode;
                      output+="<option value=\""+mflcode+"\">"+facilityName+" - ["+mflcode+"]</option>";
                      output2+="<option value=\""+mflcode+"\">"+facilityName+"</option>";
                 } 
                // for user registration
                $("#mflcode").html(output2);
                $("#mflcode").select2();    
            });

        }
                    </script>
                    
                           <script type="text/javascript">
                $(document).ready(function(){
                    $("#hei_exist").hide();
                        new_updated_records();
                        check_data();
                        
                        $('#dob').datepicker({
                             todayHighlight: true, 
                             clearBtn: true, 
                             autoclose: true,
                             format: "yyyy-mm-dd",
                             startDate: '-1y',
                             endDate: '+0d'
                            });
                            
                            
                    $("#dob").change(function(){
                        var start_date = $("#dob").val();
                        if(start_date!=""){
                        $("#sample_date").val("");
//                        $("#date_tested").val("");
//                        $("#date_initiated_art").val("");
                        
                         $('#sample_date').datepicker({
                             todayHighlight: true, 
                             clearBtn: true, 
                             autoclose: true,
                             format: "yyyy-mm-dd",
                             startDate:start_date,
                             endDate: '+0d'
                            });
       
                        }
                    });
                    
                    $("#sample_date").change(function(){
                        var start_date = $("#sample_date").val();
                        if(start_date!=""){
                        $("#date_tested").val("");
//                        $("#date_initiated_art").val("");
                        
                        $('#date_tested').datepicker({
                             todayHighlight: true, 
                             clearBtn: true, 
                             autoclose: true,
                             format: "yyyy-mm-dd",
                             startDate:start_date,
                             endDate: '+0d'
                            }); 
                              $('#date_tested').datepicker('update');
                        }
                    });
                    
                    $("#date_tested").change(function(){
                        var start_date = $("#date_tested").val();
                         if(start_date!=""){
                        $("#date_initiated_art").val("");
                        $('#date_initiated_art').datepicker({
                             todayHighlight: true, 
                             clearBtn: true, 
                             autoclose: true,
                             format: "yyyy-mm-dd",
                             startDate: start_date,
                             endDate: '+0d'
                            }); 
                        $('#date_initiated_art').datepicker('update');
                        }
                    });
                    
                    
                    $("#save_form").click(function(){
                        save_data();
                    });
                    
                    $("#result").change(function(){
                        results_changed();
                    });
                    
                    
                    $("#search").click(function(){
                      load_prev_data();  
                    });
                        });  
                        
                        
   </script>
   <script>
   function check_data(){
        $("#img_delete").hide();
        $("#savebutton").html('Save');
   }   
   
   function results_changed(){
       var result = $("#result").val();
       $("#date_initiated_art").val("");
       if(result=="P"){
           //enable date initiated on ART
          var start_date = $("#date_tested").val();
          if(start_date!=""){
                       $('#date_initiated_art').datepicker({
                             todayHighlight: true, 
                             clearBtn: true, 
                             autoclose: true,
                             format: "yyyy-mm-dd",
                             startDate: start_date,
                             endDate: '+0d'
                            }); 
                            
             $('#date_initiated_art').datepicker('update');
             $("#initiated_details").show();
                        }
                        
       }
       else{
           //disable date initiated on ART
       $("#initiated_details").hide();
       $("#date_initiated_art").datepicker('remove');
       }
   }
   </script>
      
   <script>
//     Database operations
 
 function check_hei_no() {
     var  facility_id,hei_no;
    facility_id = $("#facilityname").val();
    hei_no = $("#hei_no").val();
     
        if(facility_id!="" && hei_no!=""){ // if they have been entered, check if data exist and load it
             var id = facility_id+"_"+hei_no;  
             db.get(id, function(err, doc) {
             if (err) { 
     $("#hei_no").css('background-color','white');
     $("#save_form").show();
     $("#save_form").prop('disabled',false);
                      }
                     else{
     $("#hei_no").css('background-color','red');
     $("#save_form").hide();
     $("#save_form").prop('disabled',true);
                     }  
             });
             
            }              
 }  
 
 //search for editing
 function check_search_hei_no() {
     var  facility_id,hei_no;
    facility_id = $("#search_mflcode").val();
    hei_no = $("#search_hei_no").val();
     
        if(facility_id!="" && hei_no!=""){ // if they have been entered, check if data exist and load it
             var id = facility_id+"_"+hei_no;  
             db.get(id, function(err, doc) {
             if (err) { 
     $("#search_hei_no").css('background-color','red');
     $("#search").hide();
     $("#search").prop('disabled',true);
                      }
                     else{
     $("#search_hei_no").css('background-color','white');
     $("#search").show();
     $("#search").prop('disabled',false);
                     }  
             });
             
            }              
 }  
    
function load_prev_data(){
 var user_id,year,month,facility_id,hei_no,gender,dob,sample_date,date_tested,results,date_initiated_art,remarks,_rev;
           
            facility_id = $("#search_mflcode").val();
            hei_no = $("#search_hei_no").val();
            
            if(facility_id!="" && hei_no!=""){ // if they have been entered, check if data exist and load it
             var id = facility_id+"_"+hei_no;  
             
             var json_drop_down = {
    "gender_code":['F','M'],
    "gender_value":['Female','Male'],
    "results_code":['P','N','waiting'],
    "results_value":['Positive','Negative','Awaiting Results']
        };
var gender_values="",results_value="";
var gender_codes = json_drop_down.gender_code;
var result_codes = json_drop_down.results_code;

             db.get(id, function(err, doc) {
             if (err) { 
           var title = "Error Missing EID";
           var text = "For the selected facility, we do not have the HEI you are searching";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);
        }
                     else{     
gender_values="",results_value="";
var month,year;
//for gender
for(var i=0;i<gender_codes.length;i++){
    if(gender_codes[i]==doc.gender){
        gender_values += "<option value=\""+gender_codes[i]+"\" selected>"+json_drop_down['gender_value'][i]+"</option>";
    }
    else{
      gender_values += "<option value=\""+gender_codes[i]+"\">"+json_drop_down['gender_value'][i]+"</option>";  
    }
}

//end for gender
//start for results
for(var i=0;i<result_codes.length;i++){
    if(result_codes[i]==doc.results){
        results_value += "<option value=\""+result_codes[i]+"\" selected>"+json_drop_down['results_value'][i]+"</option>";
        
            // check for positives
    if(result_codes[i]=="P"){ //show date initiated on ART, enable
     
     var start_date = doc.date_tested;
          if(start_date!=""){
                       $('#date_initiated_art').datepicker({
                             todayHighlight: true, 
                             clearBtn: true, 
                             autoclose: true,
                             format: "yyyy-mm-dd",
                             startDate: start_date,
                             endDate: '+0d'
                            }); 
                            
             $('#date_initiated_art').datepicker('update');
             $("#initiated_details").show();
                        }
                        
     $("#initiated_details").show();   
    }
    
    else{
    $("#date_initiated_art").datepicker('remove');
    $("#initiated_details").hide();    
    }
    
    
    }
    else{
      results_value += "<option value=\""+result_codes[i]+"\">"+json_drop_down['results_value'][i]+"</option>";  
    }
    
}
$("#label_title").html("Edit & Update (EID) Monthly Data");
$("#label_header").css('background-color','red');
$("#label_header").css('color','white');

var year,month,user_id;
year = doc.year;
month = doc.month;
user_id = doc.user_id;

// load year
if(parseInt(month)>=10){
load_years(parseInt(year)+1);
}
else{
 load_years(parseInt(year));   
}

get_month(parseInt(month)); // load months


get_user_info(user_id,facility_id); // load and reload users and facility

//end for results
            $("#hei_no").val(hei_no);
            $("#gender").html(gender_values);
            $("#dob").val(doc.dob);
            $("#sample_date").val(doc.sample_date);
            $("#date_tested").val(doc.date_tested);
            $("#result").html(results_value);
            $("#date_initiated_art").val(doc.date_initiated_art);
            $("#remarks").val(doc.remarks);
            $("#_rev").val(doc._rev);
            $("#prev_id").val(doc._id);
             $("#save_form").html('Update Data');
                     }  
             });
             
            }
            
            else{
           var title = "Error: Missing HEI Details";
           var text = "For the selected facility, we do not have the HEI you are searching.";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);   
            }

    }
          
function save_data(){
    // save data to the local database remember to add a flag at the end to denote changed files...
    var user_id,year,month,facility_id,hei_no,gender,dob,sample_date,date_tested,results,date_initiated_art,remarks,_rev,prev_id;
            user_id = $("#user").val();
            year = $("#year").val();
            month = $("#month").val();
            facility_id = $("#facilityname").val();
            hei_no = $("#hei_no").val();
            gender = $("#gender").val();
            dob = $("#dob").val();
            sample_date = $("#sample_date").val();
            date_tested = $("#date_tested").val();
            results = $("#result").val();
            date_initiated_art = $("#date_initiated_art").val();
            remarks = $("#remarks").val();
            
            //foe editing purposes
            _rev = $("#_rev").val();
            prev_id = $("#prev_id").val();
            
            
            var timeStamp = new Date().toUTCString();
            
         var errors = "Kindly enter/choose value for the following fields : \n";
         var error_counter=0;
         if(user_id==""){
         error_counter++; 
         errors +=error_counter+". Select Current User.\n";
         }
         
         if(year==""){
         error_counter++; 
         errors +=error_counter+". Select Year.\n";
         }
         
         if(month==""){
         error_counter++; 
         errors +=error_counter+". Select Month.\n";
         }
         if(facility_id==""){
         error_counter++; 
         errors +=error_counter+". Select Health Facility.\n";
         }
         
         if(hei_no==""){
         error_counter++; 
         errors +=error_counter+". Enter HEI No.\n";
         }
         
         if(gender==""){
         error_counter++; 
         errors +=error_counter+". Select Gender.\n";
         }
         
         if(dob==""){
         error_counter++; 
         errors +=error_counter+". Choose Date of Birth.\n";
         }
         
          if(sample_date==""){
         error_counter++; 
         errors +=error_counter+". Choose Sample collection date.\n";
         }
    
          if(date_tested==""){
         error_counter++; 
         errors +=error_counter+". Choose Test Date.\n";
         }
         
         if(results==""){
         error_counter++; 
         errors +=error_counter+". Choose HEI's Test Result.\n";
         }
         
       if(error_counter>0) { // data has issues
         
           var title = "Error. Missing Data";
           var text = errors;
           var icon = "error";
           var button = "Close";
           notify(title,text,icon,button); 
       } 
       
       else{
           month = parseInt(month);
           year = parseInt(year);
           if(month>9){year = year-1;}
         var id = facility_id+"_"+hei_no;  
           
           var json_array = [];
           //save data to the local database
             
     var obj_item ={ 
        _id: id,
        user_id: user_id,
        facility_id: facility_id,
        year: year,
        month: month,
        hei_no: hei_no,
        gender: gender,
        dob: dob,
        sample_date: sample_date,
        date_tested:date_tested,
        results:results,
        date_initiated_art:date_initiated_art,
        remarks:remarks,
        status:0,
        timestamp: timeStamp};
    
    json_array.push(obj_item);
    
   if(_rev!=""){
       //delete the current record and insert a new record.
    db.remove(prev_id,_rev, function(err, response) {
    if (err) 
    {console.log(err);
    }
    else{
    console.log(response);
    db.bulkDocs(json_array);
    //remove from inputs and reload page
    $("#prev_id").val("");
    $("#_rev").val("");
    
    //mark and save deleted items
     save_deleted(prev_id,_rev,"editing");
    //reloading();
    //deleted items 
    }
  });  
   }
   else{
       db.bulkDocs(json_array);
     reloading();
   }
    }
    }
    
   function show_upload_warning(){
        var today = new Date();
        var day = today.getDate();
        
         if(parseInt(day)<=notice_date){ //allow upload of data
                         $("#upload_notice").show();
                         
                         }
                         else{ // lock data
                         $("#upload_notice").hide();
                         }
   } 
    
function new_updated_records(){
                db.allDocs({
              include_docs: true,
              attachments: true
            }).then(function (result) {
            console.log(result);
            var num_Recs = result.total_rows;
            var array_data = result.rows;
            var num_new_records=0;
            
            if(num_Recs>0){
                for(var i=0; i<num_Recs;i++){
                  var status = array_data[i].doc.status;
         if(status==0){
             num_new_records++;
         }
         if(num_new_records==1){
             create_index();// to create index once
          $("#upload_data").show();
          $("#toupload").html(num_new_records+" Record");
          show_upload_warning();
      }
         else if(num_new_records>1){
          $("#upload_data").show();
          $("#toupload").html(num_new_records+" Records");
          show_upload_warning();
      }
      
        else{
            $("#upload_data").hide();
        }
                }
            }
            }).catch(function (err) {
              console.log(err);
            });
}

function save_deleted(id,rev,source){
   var json_array = [];
   var obj_item ={ 
        _id: id,
        rev: rev,
        source:source
        };  
    json_array.push(obj_item); 
     db_delete.bulkDocs(json_array);
  reloading();      
}

function create_index(){
db.createIndex({
  index: {
    fields: ['user_id','facility_id', 'year', 'month','hei_no','gender','dob','sample_date','date_tested','results','date_initiated_art','remarks','status','timeStamp']
  }
}, function (err, result) {
  if (err) { return console.log(err); }
  // handle result
});

}
       </script>
  <script>

                    function numbers(evt){
      
                        var charCode=(evt.which) ? evt.which : evt.keyCode
                         console.log(charCode); 
                         if( charCode===43 ||  charCode===9 ||  charCode===8 || charCode===46 || ( charCode >= 48 && charCode<=57)){

                         return true;   
                        }
                        else {
                        return false;
                        }
                     
                    }
</script>   
 <script type="text/javascript">
                $(document).ready(function(){
                        $("#user").select2();
                          read_all_users();// load users for deleting
                          load_facilities(); 
           });  
   </script>  
    <script>
                    </script>
               
                 <script type="text/javascript">
            $(document).ready(function(){
                get_user_info(0,0);
                $("#adduserbutton").show();
      
            $("#savebutton").click(function(){
             save_data();   
            });
            $("#btn_add_user").click(function(){
             add_user();   
            });
          
           });  
   </script>
       
       <script>          
     $(document).ready(function(){
     $("#img_delete").hide();
     $("#savebutton").hide();
      create_index();// index our fields     
    $("#upload_data").click(function(){
      checkInternet(); 
    });
    
   $("#btn_conf_delete").click(function(){
       //delete these entries for this day
   delete_records();    
   }); 
   $("#refreshpage").click(function(){
       // refresh page
   reloading();    
   }); 
    
    }); 
    
function send_data(){
    
    var today = new Date();
    var day = today.getDate();
    
    if(parseInt(day)<=max_date){
    var url = "save_data";
         db.allDocs({
              include_docs: true,
              attachments: true
            }).then(function (result) {
              // handle result
              var data = JSON.stringify(result);
             var form_data = {"all_data":data};
        $.post(url,form_data,function(output){
//           console.log(output);
var response = JSON.parse(output);
        console.log("output :"+output);
        if(output==null || output==""){
   //error while uploading. 
           var title = "Error Sending data to Server";
           var text = "An error occured while uploading data to server. Kindly contact developers.";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);
        }
        else{
         //read the values
         var date = response.date;
         
         if(parseInt(date)>max_date){
           var title = "Error: Data Upload Blocked";
           var text = "No data uploaded to server. You are only allowed to upload data from 1st to 10th of Every month.";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);   
            }
            
            else{
         var added_records = response.records;
         var not_uploaded = response.not_uploaded;
         var title = "Server Upload Successful.";
         var message="";
         if(added_records==1){
             message = added_records+" Record uploaded successfully ";
         }
         else if(added_records>1){
             message = added_records+" Records uploaded successfully "; 
         }
         else{
             title="No Records Uploaded";
         }
         
         if(parseInt(not_uploaded)==1){
             if(message==""){message+="1 Record was skipped.";}
             else{message+=" and 1 Record was skipped.";}
         }
         else if(parseInt(not_uploaded)>1){
              if(message==""){message+=not_uploaded+" Records were skipped.";}
             else{message+=" and "+not_uploaded+" Records were skipped.";}
             
         }
         else{}
         
         console.log("added records :"+added_records);
           var text = message;
           var icon = "success";
           var button = "Ok";
           
           notify(title,text,icon,button);
            
           //update uploaded records as marked i.e status to 1
           update_sent_records(response.records_details);
       }
}
        });
        
            });
           }
            
            else{
           var title = "Error. Data Upload Blocked";
           var text = "You are only allowed to upload data from 1st to 10th of Every month. e.g Jan 2019 data should be uploaded between 1st and 10th Feb 2019";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);             
    }
            
 }
            

function update_sent_records(updated_items){ // change status to 1.
    console.log(updated_items);
db.bulkDocs(updated_items, function(err, response) {
  if (err) { return console.log("error many items :"+err); }
  else{console.log("succes many items: "+response);}
  // handle result
});     
    //db.bulkDocs(json_array);   
        send_users(); 
        }
  


function remove_deleted(){
      db_delete.destroy(function (err, response) {
          if (err) {
            console.log(err);
          } else {
         console.log(response);
         db_delete = new PouchDB('eid_deleted');
            new_updated_records(); //to reload
          }
        });
}
  
function progress(per_value){
    if(per_value==0){
    $("#progess").html("Error Occured ");
    $("#progess").css({'width':"100%"}); 
    setTimeout(waitnhide, 3000);
    }
    else if(per_value==100){
    $("#progess").html("Task Completed");
    $("#progess").css({'width':"100%"}); 
    setTimeout(waitnhide, 3000);
    }
    else{
    $("#progess").html(per_value+"% Completed. Please Wait...");
    $("#progess").css({'width':per_value+"%"});
    }
    
    if(per_value<10){
     $("#progess").addClass('progress-bar-danger');  
     $("#progess").removeClass('progress-bar-success'); 
    }
    if(per_value>=30 && per_value<60){
     $("#progess").addClass('progress-bar-warning');   
     $("#progess").removeClass('progress-bar-danger');   
    }
    if(per_value>=60 && per_value<80){
     $("#progess").addClass('progress-bar-info'); 
     $("#progess").removeClass('progress-bar-warning');   
     $("#progess").removeClass('progress-bar-danger');  
    }
    if(per_value>=90){
     $("#progess").addClass('progress-bar-success'); 
     $("#progess").removeClass('progress-bar-info'); 
     $("#progess").removeClass('progress-bar-warning');   
     $("#progess").removeClass('progress-bar-danger');  
    }
}

function waitnhide(){
     $("#progess").html("");
     $("#progess").css({'width':"0%"});          
}


function refresh(){
//    location.reload(); 
setTimeout(reloading, 1500);
}

function reloading(){
    location.reload();
    new_updated_records();
}

function checkInternet(){
    jQuery.ajax({
        url:'checkinternet',
        type:"post",
        dataType:"json",
        success:function(response){
        if(response.isreacheable){
          send_data();   
         }
         else{
           var title = "Error. No Internet connections";
           var text = "Kindly re-connect your internet and then try uploading again.";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);
         }
        }, 
        error: function(jqXHR, textStatus, errorThrown) {
           var title = "Error. An error has occured on the server.";
           var text = "Kindly re-connect your internet and then try uploading again.";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);
            }
  });
}
function notify(title,text,icon,button){
 swal({
            title: title,
            text: text,
            icon: icon,
            button: button
          });   
}


function get_user_info(selected_phone,selected_facility_id){
//    alert("called");
db_user.allDocs({
  include_docs: true,
  attachments: true
}, function(err, response) {
  if (err) { 
      console.log("error users is : "+err);
//      $("#user_label").hide();
      $("#adduserbutton").show();
      $("#manageuserbutton").hide();
    }
    else{
        
      //manage results here
        var num_users = response.total_rows;
         var array_data = response.rows;
         var fullname="",email="",phone="",mflcodes="",mflcode="",output="",output2="";
         
         
         if(num_users>0){
        for(var i=0; i<num_users;i++){
     var user_data = array_data[i].doc;
              mflcodes += user_data.mflcode+",";
                fullname=user_data.fullname;
                email=user_data.email;
                phone=user_data._id;
                mflcode=user_data.mflcode;
                if(selected_phone==phone){
                output2+="<option value=\""+phone+"\" selected>"+fullname+" - ["+mflcode+"]</option>";     
                }
                else{
              output2+="<option value=\""+phone+"\">"+fullname+" - ["+mflcode+"]</option>"; 
                }
          }
         var output = "<option value=\"\">Choose Facility</option>";
             $.getJSON("json/facilities.json",function(facilities){
             for( var a=0;a< facilities.length; a++){
                var facilityID=facilities[a].FacilityID;    
                var facilityName=facilities[a].FacilityName;
                var mflcode = facilities[a].MFLCode;
                if(mflcodes.indexOf(mflcode) != -1){
                    if(selected_facility_id==facilityID){
                      output+="<option value=\""+facilityID+"\" selected>"+facilityName+" - ["+mflcode+"]</option>";
                  }
                  else{
                     output+="<option value=\""+facilityID+"\">"+facilityName+" - ["+mflcode+"]</option>";  
                  }
                  }
                 } 
                $("#facilityname").html(output);
                $("#facilityname").select2();
                
                $("#search_mflcode").html(output);
                $("#search_mflcode").select2();
                
            });

//          alert(output);
           $("#user").html(output2);
           $("#user").select2();
//           $("#user_label").show();
           $("#manageuserbutton").show();
         }
         else{
//      $("#user_label").hide();
      $("#adduserbutton").show();
      $("#manageuserbutton").hide();     
         }
    }
  // handle result
});
}

function add_user(){
   var fullname,email,phone,mflcode;
   fullname = $("#fullname").val();
   email = $("#email").val();
   phone = $("#phone").val();
   mflcode = $("#mflcode").val();
   
       db_user.put({
       _id: phone,
       fullname: fullname,
       email: email,
       mflcode: mflcode
         }).then(function (response) {
         console.log(response);
         get_user_info(0,0);
         read_all_users();
         }).catch(function (err) {
           console.log(err);
         });
}

function send_users()
{
    var url = "save_users";
         db_user.allDocs({
              include_docs: true,
              attachments: true
            }).then(function (result) {
              // handle result
             var data = JSON.stringify(result);
             var form_data = {"results":data};
        $.post(url,form_data,function(output){
           remove_deleted();
         });  
             console.log(result);
            }).catch(function (err) {
//              console.log(err);
            });  
}


function read_all_users(){
db_user.allDocs({
  include_docs: true,
  attachments: true
}, function(err, response) {
  if (err) { 
      console.log("error users is : "+err);
//      $("#user_label").hide();
      $("#adduserbutton").show();
    }
    else{
      //manage results here
        var num_users = response.total_rows;
         var array_data = response.rows;
         var fullname="",email="",phone="",mflcode="",output="",_rev;
         
     for(var i=0; i<num_users;i++){
        var user_details = array_data[i].doc;
                fullname=user_details.fullname;
                email=user_details.email;
                phone=user_details._id;
                mflcode=user_details.mflcode;
                _rev = user_details._rev;
              output+="<tr><td>"+fullname+"</td><td>"+phone+"</td><td>"+email+"</td><td>"+mflcode+"</td><td><input type='hidden' name='id_"+i+"' id='id_"+i+"' value='"+phone+"' /><input type='hidden' name='rev_"+i+"' id='rev_"+i+"' value='"+_rev+"' /><img src=\"images/delete.png\" onclick=\"delete_user("+i+");\" style=\"width: 20%; height: 30%; \"></td></tr>";  
          }
          
           $("#registered_users").html(output);
    }

});  
}

function delete_user(pos){
var phone=$("#id_"+pos).val();
var _rev=$("#rev_"+pos).val();

db_user.remove(phone,_rev, function(err, response) {
    if (err) { return console.log(err); }
    else{
   progress(100);
   
   var title = "Success";
           var text = "User Details Deleted Successfully";
           var icon = "success";
           var button = "Ok";
           
 notify(title,text,icon,button);
   
   setTimeout(reloading,2000);
        }
  });
}
 </script>
 
     
    <script>
      $(document).ready(function() {
          
            $("#img_loading").hide();
            $("#report_values").show();
            
         load_counties();
         $("#county").select2();
         $("#district").select2();
         $("#facility").select2();
         
         $("#county").change(function(){
         load_sub_counties();    
         });
         $("#district").change(function(){
         load_facilities_2();    
         });
         
        //date pickers here 
         $('.datepicker').datepicker({
             format: 'yyyy-mm-dd'
         });
        $("#btn_rawdata").click(function(){
               jQuery.ajax({
        url:'checkinternet',
        type:"post",
        dataType:"json",
        success:function(response){
        if(response.isreacheable){
         generate_raw_data();  
         }
         else{
           var title = "Error. No Internet connections";
           var text = "Kindly re-connect your internet and then try Generating Report.";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);
         }
        }, 
        error: function(jqXHR, textStatus, errorThrown) {
           var title = "Error. No Internet connections";
           var text = "Kindly re-connect your internet and then try Generating Report.";
           var icon = "error";
           var button = "Close";
           
           notify(title,text,icon,button);
            }
    }); 
        }); 
         
        });   
        
        
        
        
    function load_counties(){
       $.ajax({
        url:'load_counties',
        type:"post",
        dataType:"html",
        success:function(output){
        $("#county").html(output);
        $("#county").select2(); 
         // ouput
        }
    });   

   } 
    function load_sub_counties(){
        var county= $("#county").val();
     county = (""+county).split(",").join("_");
       $.ajax({
        url:'load_district?counties='+county,
        type:"post",
        dataType:"html",
        success:function(output){
         $("#district").html(output);
         $("#district").select2();
         // ouput
        }
    });   

   } 
   
    function load_facilities_2(){
  var district= $("#district").val();
     district = (""+district).split(",").join("_");
       $.ajax({
        url:'load_facilities?districts='+district,
        type:"post",
        dataType:"html",
        success:function(output){
        $("#facility").html(output);
        $("#facility").select2(); 
         // ouput
        }
    });   
   } 
   
   
    function  generate_raw_data(){
            $("#img_loading").show();
            $("#report_values").hide();
            
        var counties = $("#county").val();
        var districts = $("#district").val();
        var facilities = $("#facility").val();
        
        var start_date = $("#start_date").val();
        var end_date = $("#end_date").val();
        
        if(counties==null){counties="";}
        if(districts==null){districts="";}
        if(facilities==null){facilities="";}
        if(start_date==null){start_date="";}
        if(end_date==null){end_date="";}
        
        
        counties = (""+counties).split(",").join("_");
        districts = (""+districts).split(",").join("_");
        facilities = (""+facilities).split(",").join("_");
        
        start_date = (""+start_date).split("-").join("_");
        end_date = (""+end_date).split("-").join("_");
    
        var url = "RawData?county="+counties+"&&district="+districts+"&&facility="+facilities+"&&start_date="+start_date+"&&end_date="+end_date;
        
            $.fileDownload(url)
            .done( function () {
            $("#img_loading").hide();
            $("#report_values").show();
//            alert("Report Done");
                        })
            .fail(function () {
            $("#img_loading").hide();
            $("#report_values").show();
            alert('Report generation failed, kindly try again!'); 
             });
     
    }
    
    </script>
</body>
</html>
