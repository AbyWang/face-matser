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
    <link href="<%=path%>/plug-in/sweet-alert/css/sweetalert2.min.css" rel="stylesheet">
    <%--  <link href="<%=path%>/font-awesome/css/font-awesome.css"> --%>
     <link href="<%=path%>/plug-in/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="<%=path%>/plug-in/sweet-alert/js/sweetalert2.min.js"></script>
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
       <div class="container-fluid">
             <div class="row">
                <div class="col-md-3">
                  <!--   Kitchen Sink -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            文件列表
                        </div>
        
                         
                           <ul class="list-group" id="list-group">
                            
                            </ul>
                      
                    </div>
                     <!-- End  Kitchen Sink -->
                </div>
                <div class="col-md-9" style="overflow:auto;height:80%;min-width: 992px">
                     <!--   Basic Table  -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            图片列表
                        </div>
                        
                       <div class="panel-body" id="picList" style="min-height: 480px">

                        </div>

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
  
  $(function(){

	  loadFolder();
	  
  })
 function loadFolder(folderName){
   $("#list-group").empty();
   var folderHtml="";
   var length=0;
   $.ajax({
	      async : false,
	      dataType: 'json',
	      cache : false,
	      type : 'POST',
	      data:{folderName:folderName},
	      url : "<%=path%>/folderServlet?method=getFolderList",// 请求的action路径
	      success : function(data) {
	    	if(data.code="1"){
	    	var rdata=data.data;
	    	 if(rdata!=""&&rdata!=null){
	    		  for(var i=0;i<rdata.length;i++){
		    		  folderHtml+="<li href='javascript:void(0);' onclick='getPicture.call(this)' data-value='"+rdata[i]+"' class='list-group-item'><i class='icon-folder-open-alt'></i> "+rdata[i]+"</li>";
		    	  }
		    	  $("#list-group").append(folderHtml); 
		    	  length=rdata.length;
	    		}
	    	  }
	      }
   });
   return length;
  }
  
  function getPicture(){
	  $("#picList").empty();
	    var picName="";
	  	$(this).siblings().css("border-left","");
		var dataValue=$(this).attr("data-value");//获取文件名
		//改变点击的颜色
		$(this).css("border-left","5px solid #00ba8b");
		//清空未选择的li的id
		$(this).siblings().removeAttr("id");
		//添加特定的id名
		$(this).prop("id","delLi");
		reloadImg(dataValue);    
  }
 
   $(document).on('click','.img-fluid',function(){   //选择需要删除的图片
	   var imgStatus = $(this).attr("imgStatus");
   		if(imgStatus=="noSelected"){
   		 $(this).css("border","4px solid #da542e");
   		 $(this).attr("imgStatus","selected");
   		 
   		}else{
   		 $(this).attr("imgStatus","noSelected");
   		 $(this).css("border","2px solid #00ba8b");
   		}
	  
	 
	   
	 /*   $(this).siblings().css("border","2px solid #00ba8b");
		 //清空未选择的img
		$(this).siblings().removeAttr("id");
		//添加特定的id名
		$(this).prop("id","delImg"); */
	   
	   var img =$(this).attr("src");
	   
	   
	   var filename;
	   if(img.indexOf("\\")>0){//如果包含有"/"号 从最后一个"/"号+1的位置开始截取字符串,本地用"\\"
	   		filename=img.substring(img.lastIndexOf("\\")+1,img.length);
	   	} else{
	  		 filename=img;
	  	 }
	   var folderName =$(this).attr("dataValue");
	   
	   console.log(filename+"======="+folderName);
      })
     function reloadImg(dataValue){
	   console.log("调用刷新img方法"+dataValue);
	   $("#picList").empty();
	   var picName="";
		 $.ajax({
		      async : false,
		      dataType: 'json',
		      cache : false,
		      type : 'POST',
		      url : "<%=path%>/folderServlet?method=getPicsByFolderName",// 请求的action路径
		      data:{"folderName":dataValue},
		      success : function(data) {
		    	  if(data.code="1"){
		    		  var rdata=data.data;
		    		  if(data!=null&&rdata!=""){
		    		  for(var i=0;i<data.data.length;i++){
		    			  picName+="<img src="+data.data[i] +" alt='Image' width='210' dataValue="+dataValue+" imgStatus='noSelected' class='img-fluid tm-img'/>";   
		    		    }
			    	    $("#picList").append(picName); 
		    		  }
		    	  }
		      }
	   });
   }
  
  </script>
</body>
</html>