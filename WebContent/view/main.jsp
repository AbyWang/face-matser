<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
String user =(String)session.getAttribute("admin");
%>
<%response.setHeader("Pragma","No-cache");  response.setHeader("Cache-Control","no-cache");  response.setDateHeader("Expires", 0);  response.flushBuffer();%> 

<!DOCTYPE html>
<html>
  <head>
    <title>
      信通人脸识别系统
    </title>
    <meta http-equiv="Content-Type" Content="text/html; Charset=utf-8" />
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
   
    <!-- bootstrap css -->
    <link href="<%=path%>/plug-in/bootstrap3.3.5/css/bootstrap.css" rel="stylesheet">
    <link href="<%=path%>/css/main.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link href="<%=path%>/plug-in/sweet-alert/css/sweetalert2.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=path%>/plug-in/webuploader/webuploader.css"></link>
	<link href="<%=path%>/plug-in/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<style>
	.floatLeft {
    	float: left;
	}
	.floatRight{
		float:right;
	}
	
	.logo-tittle {
    font-family: 新宋体;
    font-size: 20px;
    font-weight: bold;
    color: #ffffff;
     }
    .searchType {
       padding:20px 10px 20px 10px
     }

     .resultInfo{
       padding:25px 15px 25px 15px
     }
     .resultInfo span{
       color:red;
       font-weight:bold;
       font-size :1em;
     }
    .resultInfo{
      
    }
	.navbar{
	height:70px !important;
	}
	
	</style>
  </head>
<body>
	<%-- <div class="logo floatLeft">
		     <img src="<%=path%>/images/st.png" style="vertical-align: middle; width:50px;">
		  <span class="logo-tittle">信通人脸识别系统管理端</span>
	</div> --%>
     <!-- <div class="navbar navbar-inverse set-radius-zero" >
        <div class="container">
              <div class="right-div">
            <h2>  信通人脸识别系统管理端</h2>
              </div>
        </div>
    </div>  -->
    
     <div class="navbar navbar-inverse set-radius-zero" >
        <div class="container" style="margin-left:8px;margin-right:16px;width:96%;">
	             <div class="logo floatLeft">
			     <img src="<%=path%>/images/st.png" style="vertical-align: middle; width:60px;">
			  	<span class="logo-tittle">信通人脸识别系统管理端</span>
				</div>
				<div class="floatRight clearFix" style="margin: 20px;">
					  <div class="back floatLeft" style="color:#ffffff;font-size:16px">
					  	 <i class='fa fa-user-circle'></i> 
					  	<span><%=user %></span>
					     <a href="<%=path%>/index.html" style="color:#ffffff;font-size:16px">
						  [ 退出登录 ]   
					      </a>
					  </div>
		  		</div>
        </div>
        </div>
   
    
    <!-- LOGO HEADER END-->
    <section class="menu-section">
        <div class="container-fluid">
            <div class="row ">
                <div class="col-md-12">
                    <div class="navbar-collapse collapse ">
                        <ul id="menu-top" class="nav navbar-nav navbar-left">
                            <li><a href="javascript:void(0);" onclick="searchA()">浏览</a></li>
                           
                          <!--  <li><a href="javascript:void(0);" onclick="searchB()">搜索</a></li>  -->
                            <li><a href="javascript:void(0);" onclick="check()">测试</a></li>

                        </ul>
                        
                  <div class="col-sm-2  searchType" >
                    <div class="input-group">
                    <input type="text" id="folderName" placeholder="请输入类别" class="form-control input-group-sm">
                    <span class="input-group-addon btn btn-primary">
                    <a href="javascript:void(0);" onclick="searchType()">搜索</a>
                    </span>
                  </div>
                  </div>
                  
                  <div class="col-sm-2 resultInfo">
                     <span id="tips"></span>
                  </div>
            
                     <ul id="menu-top" class="nav navbar-nav navbar-right">
                        <li> <button type="button" class="btn btn-primary">训练</button></li>
                        <li> <button type="button" class="btn btn-warning" onclick="addFolder()">新建类别</button></li>
                        <li> <button type="button" class="btn btn-danger" onClick="deleteType()">删除类别</button></li>
                        <li> <button type="button" class="btn btn-warning"  onclick="show_modal();">添加图片</button></li>
                        <li> <button type="button" class="btn btn-danger"  onClick="delImg()">删除图片</button></li>
                     </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

     <!-- MENU SECTION END-->

       	 <iframe id="listFrame" src="home1.jsp"  scrolling="yes"  onload="changeFrameHeight(this)"  frameborder="no" width="100%" ></iframe>
       </div>
       </div>
     <!-- CONTENT-WRAPPER SECTION END-->
    <section class="footer-section">
        <div class="container">
            <div class="row">
            <div class="col-md-12">
                   &copy; 2018 信通网易</div>
             </div>
        </div>
        
    </section>
    


    
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					添加图片
				</h4>
			</div>
			<div class="modal-body">
	
            <!--头部，相册选择和格式选择-->

            <div id="uploader">
               <!--  <div class="queueList">
                    <div id="dndArea" class="placeholder">
                        <div id="filePicker"></div>
                        <p>或将照片拖到这里，单次最多可选300张</p>
                    </div>
                </div>
                <div class="statusBar" style="display:none;">
                    <div class="progress">
                        <span class="text">0%</span>
                        <span class="percentage"></span>
                    </div><div class="info"></div>
                    <div class="btns">
                        <div id="filePicker2"></div><div class="uploadBtn">开始上传</div>
                    </div>
                </div> -->
                 <div id="thelist" class="uploader-list"></div>
	    <div class="btns">
	        <div id="picker">选择文件</div>
	    </div>
            </div>
      
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
			</div>
		</div>
	</div>
</div>
    
    <script src="<%=path%>/plug-in/jquery/jquery-1.9.1.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="<%=path%>/plug-in/bootstrap3.3.5/js/bootstrap.js"></script>
    <script type="text/javascript" src="<%=path%>/plug-in/sweet-alert/js/sweetalert2.min.js"></script>
  
	<script type="text/javascript" src="<%=path%>/plug-in/webuploader/webuploader.min.js" ></script>
     
    <script type="text/javascript">
    
  //输入验证码，回车登录
    $(document).keydown(function(e){
    	if(e.keyCode == 13) {
    		searchType();
    	}
    });
  
  
    var path = "<%=path%>";
    function changeFrameHeight(that){
        //电脑屏幕高度-iframe的高度 
        var myClientHeight = document.documentElement.clientHeight+25
        var navbarHeight =$(".navbar").outerHeight(true);
        var sectionHeight =$(".menu-section").outerHeight(true);
    	var footerHeight =$(".footer-section").outerHeight(true);
    	var myIframeHeight =myClientHeight - navbarHeight - sectionHeight - footerHeight -30 +"px";
    	$(that).height(myIframeHeight)
    	
        }

      function searchA(){
 	    $("#listFrame").attr("src", "home1.jsp");
     }

      function searchType(){
   	 //   $("#listFrame").attr("src", "home2.jsp");
    	  var folderName=$("#folderName").val();
    	  console.log(folderName);
    	  var childWindow = $("#listFrame")[0].contentWindow; //表示获取了嵌入在iframe中的子页面的window对象。  []将JQuery对象转成DOM对象，用DOM对象的contentWindow获取子页面window对象。
    	 var length= childWindow.loadFolder(folderName);  // 调用子页面中的subFunction方法。
      	 console.log("length:"+length);
    	 if(length==0){
    		 $("#tips").html("抱歉!未找到"+folderName)
    	 }
    	 childWindow.reloadImg(folderName);
  
       }
      
      function check(){
     	    $("#listFrame").attr("src", "check.jsp");
         }
      function addFolder(){
    	  
    		
    	  swal({
    	    title: '新建类别',
    	    input: 'text',
    	    showCancelButton: true,
    	    inputValidator: function(value) {
    	      return new Promise(function(resolve, reject) {
    	        if (value) {
    	          resolve();
    	        } else {
    	          reject('请输入类别!');
    	        }
    	      });
    	    }
    	  }).then(function(result) {
    		  if(result){
        	  $.ajax({
        	      async : false,
        	      dataType: 'json',
        	      cache : false,
        	      type : 'POST',
        	      data:{folderName:result},
        	      url : "<%=path%>/folderServlet?method=addFolder",// 请求的action路径
        	      success : function(data) {
                      console.log(data);
              	    if (data.code==1) {
              	      swal({
              	        type: 'success',
              	        html: data.message
              	      });
              	    document.getElementById('listFrame').contentWindow.location.reload(true);//添加成功之后刷新子iframe页面
              	    }else{
              	      swal({
                	        type: 'error',
                	        html: data.message
                	      });
              	    }
              	  
        	      }
           });
    		  }
    	  }) 
      }
      
      function deleteType(){//删除文件夹
    	 var delType= $("#listFrame").contents().find("#delLi").attr("data-value");
    	 if(delType==""||delType==null){
	   		  swal(
	   	  		    '文件夹未选择!',
	   	  		     '请重新选择文件夹.'
	   	  		    );
	   		  return;
	   	  }
    	 swal({
    		  title: '删除',
    		  text: "确认删除该类别么？",
    		  type: 'warning',
    		  showCancelButton: true,
    		  confirmButtonColor: '#3085d6',
    		  cancelButtonColor: '#d33',
    		  confirmButtonText: '确定',
    		  cancelButtonText: '取消',
    		}).then(function(isConfirm) {
    			
    		  if (isConfirm) {//点击确定，则删除该文件类别
    			  $.ajax({
            	      async : false,
            	      dataType: 'json',
            	      url : "<%=path%>/folderServlet?method=delete",// 请求的action路径
            	      cache : false,
            	      type : 'POST',
            	      data:{folderName:delType},
            	     
            	      success : function(data) {
                          console.log(data);
                  	    if (data.code==1) {
                  	      swal({
                  	        type: 'success',
                  	        html: data.message
                  	      });
                  	    document.getElementById('listFrame').contentWindow.location.reload(true);//刷新子iframe页面
                  	    }else{
                  	      swal({
                    	        type: 'error',
                    	        html: data.message
                    	      });
                  	    }
            	      }
               }); 
    			  
    		/*     swal(
    		      '删除成功!',
    		      '成功删除文件.',
    		      'success'
    		    ); */
    		   
    		  }
    		});
    	 
      }
      
      //删除选中的图片
      function delImg(){
    	  //
    	  var picName =[];
    	  var picList= $("#listFrame").contents().find("#picList").find("img");
    	  picList.each(function(){
    		var delList = $(this).attr("imgstatus");
    		console.log(delList);
    		if(delList=="selected"){
    			var delImgUrl=  $(this).attr("src");
    			var imgName;
    		   	   if(delImgUrl.indexOf("\\")>0){//如果包含有"/"号 从最后一个"/"号+1的位置开始截取字符串,本地用"\\"
    		   			imgName=delImgUrl.substring(delImgUrl.lastIndexOf("\\")+1,delImgUrl.length);
    		   	   	} else{
    		   	   		imgName=delImgUrl;
    		   	    }
    		   	picName.push(imgName); 
    		}
    		
    	  })
    	  console.log(picName.join(","));
    //	  return; 
    	  var delImgUrl= $("#listFrame").contents().find("#delImg").attr("src");
    	  if(delImgUrl==""||delImgUrl==null){
    		  swal(
    	  		    '图片未选择!',
    	  		     '请选择需要删除的图片.',
    	  		   	'warning'
    	  		    );
    		  return;
    	  }
    	  var imgName;
	   	   if(delImgUrl.indexOf("\\")>0){//如果包含有"/"号 从最后一个"/"号+1的位置开始截取字符串,本地用"\\"
	   			imgName=delImgUrl.substring(delImgUrl.lastIndexOf("\\")+1,delImgUrl.length);
	   	   	} else{
	   	   		imgName=delImgUrl;
	   	  	 }
	   	   var folderName =$("#listFrame").contents().find("#delImg").attr("dataValue");
	   	 if(folderName==""||folderName==null){
	   		  swal(
	   	  		    '文件夹未选择!',
	   	  		     '请重新选择文件夹.'
	   	  		    );
	   		  return;
	   	  }
	   	   
		   	swal({
	  		  title: '删除',
	  		  text: "确认删除该图片么？",
	  		  type: 'warning',
	  		  showCancelButton: true,
	  		  confirmButtonColor: '#3085d6',
	  		  cancelButtonColor: '#d33',
	  		  confirmButtonText: '确定',
	  		  cancelButtonText: '取消',
	  		}).then(function(isConfirm) {
	  			
	  		  if (isConfirm) {//点击确定，则删除该文件类别
	  			  $.ajax({
	          	      async : false,
	          	      dataType: 'json',
	          	      url : "<%=path%>/folderServlet?method=delPic",// 请求的action路径
	          	      cache : false,
	          	      type : 'POST',
	          	      data:{folderName:folderName,picName:imgName},
	          	     
	          	      success : function(data) {
	                        console.log(data);
	                	    if (data.code==1) {
	                	      swal({
	                	        type: 'success',
	                	        html: data.message
	                	      });
	                	     // document.getElementById('listFrame').contentWindow.location.reload(true);//刷新子iframe页面
	                	      document.getElementById("listFrame").contentWindow.reloadImg(folderName);//调用子iframe的方法
	                	    }else{
	                	      swal({
	                  	        type: 'error',
	                  	        html: data.message
	                  	      });
	                	    }
	          	      }
	             }); 
	  		 
	  		  }
	  		});
		   
	      }
     
	
		

			/*-------------------------------------------文件上传----------------------------------------------*/
			var addfolderName="";
			var urlc= '<%=path%>/fileUpServlet?method=saveFiles';
			var BASE_URL="<%=path%>";
			var uploader;
			uploader = WebUploader.create({

				   // swf文件路径
			    swf: BASE_URL+'/plug-in/webuploader/Uploader.swf',
			    // 文件接收服务端。
				server: urlc,
			    // 选择文件的按钮。可选。
			    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
			    pick: '#picker',
			    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			    resize: false,
			    //指明参数名称，后台也用这个参数接收文件
			    duplicate: false,
			    auto: true,
			    //每次上传附带参数
			    formData:{"folderName":addfolderName}
	        
		    });
		    // 当有文件添加进来的时候
				uploader.on( 'fileQueued', function( file ) {
				$("#thelist").append( '<div id="' + file.id + '" class="item">' +
			        '<div class="state">'+file.name+'---等待上传...</div>' +
			    '</div>' );
			}); 
			
			//文件上传过程中创建进度条实时显示.
			 uploader.on( 'uploadProgress', function( file, percentage ) {
			    var $li = $( '#'+file.id ),
			        $percent = $li.find('.progress .progress-bar');
			    // 避免重复创建
			    if ( !$percent.length ) {
			        $percent = $('<div class="progress progress-striped active">' +
			          '<div class="progress-bar" role="progressbar" style="width: 0%">' +
			          '</div>' +
			        '</div>').appendTo( $li ).find('.progress-bar');
			    }
			    $li.find('div.state').html(file.name+'---上传中');
			    $percent.css( 'width', percentage * 100 + '%' );
			});
			uploader.on( 'uploadSuccess', function(file,response) {
			    $( '#'+file.id ).find('div.state').html(file.name+'---'+response.message);
			    document.getElementById("listFrame").contentWindow.reloadImg(addfolderName);//调用子iframe的方法
			});
			uploader.on( 'uploadError', function( file) {
			    $( '#'+file.id ).find('div.state').html(file.name+'---上传出错');
			});
			uploader.on( 'uploadComplete', function( file ) {
			   $( '#'+file.id ).find('.progress').fadeOut('slow');
			}); 

			/*-------------------------------------------文件上传----------------------------------------------*/
			
			$('#myModal').on('shown.bs.modal',function() {//提示框显示时候触发
				
				uploader.refresh();   //刷新当前webUploder
	 		});
		/* 	$('#myModal').on('hide.bs.modal', function () {//模态框隐藏时候触发
				for(var i=0;i<uploader.getFiles().length;i++){
					uploader.removeFile(uploader.getFiles()[i]);
				}
				uploader.reset();
				uploader.destroy();
				}); */
		
			 function show_modal() {//显示模态框
				 addfolderName =  $("#listFrame").contents().find("#delLi").attr("data-value");
		    	 if(addfolderName==""||addfolderName==null){
			   		  swal(
			   	  		    '文件夹未选择!',
			   	  		     '请重新选择文件夹.'
			   	  		    );
			   		  return;
			   	  }
		    	 //初始化以后添加folderName
		    	 uploader.options.formData.folderName = addfolderName;
		         $('#myModal').modal('show');

		        
		         
		    }

</script>
  
</body>
</html>