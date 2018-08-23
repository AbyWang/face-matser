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
	<link href="<%=path%>/plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
	
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
	 .panel-body img{
     	margin:8px;
     	width:auto;
     	height:200px;
     	border: 2px solid #00ba8b;
     }
	.menuLi{background:#eee;border-bottom:2px solid #00ba8b;}
	</style>
  </head>
<body> 
<input type="hidden" id="pathVal" value="<%=path%>"></input>
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
					     <a href="#" onClick="logout()" style="color:#ffffff;font-size:16px">
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
                        <ul id="menu-top" class="nav navbar-nav navbar-left mainMenu">
                            <li><a href="javascript:void(0);" class="menuLi">浏览</a></li>
                           
                          <!--  <li><a href="javascript:void(0);" onclick="searchB()">搜索</a></li>  -->
                            <li ><a href="javascript:void(0);" >测试</a></li>
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

     <!-- 具体实现内容 -->  	
     <div class="box">
     	<!-- 浏览  主页面 -->
     		<div id="home1" class="homeContent0">
     			 <div class="content">
			       <div class="container-fluid">
			             <div class="row"> 
			                <div class="col-md-3 myscrollable" >
			                  <!--   Kitchen Sink -->
			                    <div class="panel panel-default">
			                        <div class="panel-heading">
			                            类别列表
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
     	<!-- 浏览 主页面end -->
     	
     	<!-- 测试 主页面 -->
     	
     		 <div class="content homeContent1" style="display:none;">
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
     	<!-- 测试 主页面 end-->
     	</div>
     <!-- 具体实现内容end -->   	
       
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
	 <script type="text/javascript" src="<%=path%>/plug-in/jquery.nicescroll.js"></script>
	<script type="text/javascript" src="<%=path%>/plug-in/webuploader/webuploader.min.js" ></script>
     <script type="text/javascript" src="<%=path%>/js/view/main.js" ></script>
   
</body>
</html>