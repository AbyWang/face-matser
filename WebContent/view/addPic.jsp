<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<%response.setHeader("Pragma","No-cache");  response.setHeader("Cache-Control","no-cache");  response.setDateHeader("Expires", 0);  response.flushBuffer();%> 

<!DOCTYPE html>

  <link rel="stylesheet" type="text/css" href="<%=path%>/plug-in/webuploader/css/webuploader.css" />
  <link rel="stylesheet" type="text/css" href="<%=path%>/plug-in/webuploader/css/style.css" />
<script type="text/javascript">
var path = "<%=path%>";
</script>
<body>
    <div id="wrapper">
        <div id="container">
            <!--头部，相册选择和格式选择-->

            <div id="uploader">
                <div class="queueList">
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
                </div>
            </div>
        </div>
    </div>
   <script src="<%=path%>/plug-in/jquery/jquery-1.9.1.js"></script>

     <script type="text/javascript" src="<%=path%>/plug-in/webuploader/js/webuploader.js"></script>
    <script type="text/javascript" src="<%=path%>/js/upload.js"></script>
</body>
<script>



</script>
</html>
