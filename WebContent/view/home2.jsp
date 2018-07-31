<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<%response.setHeader("Pragma","No-cache");  response.setHeader("Cache-Control","no-cache");  response.setDateHeader("Expires", 0);  response.flushBuffer();%> 

<!DOCTYPE html>
<html>
  <head>
    <title>

    </title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- bootstrap css -->
    <link href="<%=path%>/plug-in/bootstrap3.3.5/css/bootstrap.css" rel="stylesheet">
    <link href="<%=path%>/css/main.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link href="<%=path%>/plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
      <style>
     .panel-body img{
     	margin:8px;
     	width:200px;
     	height:300px;
     	border: 2px solid #00ba8b;
     }
    </style>
  </head>
<body>
   
     <!-- MENU SECTION END-->
    <div class="content">
       <div class="container">
       
       
       <div  class="row">
       <div class="col-md-12">
        <div class="panel-body" style="padding-bottom:0px;">
        <!-- 搜索 -->
		<div class="accordion-group">
			<div id="collapse_search" >
				<div class="accordion-inner">
					<div class="panel panel-default" style="margin-bottom: 10px;">
            				<div class="panel-body" >
			                <form id="searchForm" class="form form-horizontal" onsubmit="return false;" >
			               <div class="row">
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                        <div class="input-group col-md-12" style="margin-top:10px">
			                        	<input type="text" class="form-control input-sm" id="folderName" name="folderName"  style="border-radius: 6px;">
			                          </div>
			                    </div>
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                         <div  class="input-group col-md-12" style="margin-top:10px">
			                         <a type="button" onclick="searchBtn()" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</a>
			                       <!--  <a type="button" onclick="resetBtn()" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> 重置</a>  -->
			                         </div>
			                    </div>
                                 </div>
                                 <div class="row">
                                 <div class="col-xs-12 col-sm-6 col-md-4">
			                         <div class=" col-md-12"  style="margin-top:20px">
			                            <label  for="name">当前搜索结果:</label>
			                            <span  id="result"  style="color:red"></span>
			                        </div>
			                    </div>
			                </div>
                              </div>
			             </form>
			             </div>
			       </div>
	          	</div>
		   </div>
		  </div>
		 </div>
       </div>
             <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default" style="overflow:auto;height:80%;min-width: 992px">

                       <div class="panel-body "  id="pics" style="min-height: 480px">
    
                        </div>
                    </div>
                </div>
            </div>
                 
            </div>
           </div> 

      <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY  -->
    <script src="<%=path%>/plug-in/jquery/jquery-1.9.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="<%=path%>/plug-in/bootstrap3.3.5/js/bootstrap.js"></script>
  <script>

	//输入验证码，回车登录
	$(document).keydown(function(e){
		console.log(123);
		if(e.keyCode == 13) {
			searchBtn();
		}
	});
  function searchBtn(){
	  var folderName=$("#folderName").val();
	  $("#pics").empty();
	  var picName="";
	  $.ajax({
	      async : false,
	      dataType: 'json',
	      cache : false,
	      type : 'POST',
	      data:{folderName:folderName},
	      url : "<%=path%>/folderServlet?method=getPicsByFolderName",// 请求的action路径
	      success : function(data) {
	    	  if(data.code=="1"){
	    	      $("#result").html(folderName) 
	    	     for(var i=0;i<data.data.length;i++){
	    	        picName+="<img src="+data.data[i] +" alt='Image' width='210'  class='img-fluid tm-img'/>";   
	    	      }
			      $("#pics").append(picName);
	    	  }else {
	    		   $("#result").html("抱歉!没有找到"+folderName) ;
	    	  }
	      }   
  });
	  

}
  
  </script>
  
</body>
</html>