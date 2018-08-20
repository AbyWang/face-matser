  //输入类别，回车搜索
    $(document).keydown(function(e){
    	if(e.keyCode == 13) {
    		searchType();
    	}
    });
  
  
    var path =$("#pathVal").val();
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
    	  $("#tips").empty();
    	  var folderName=$("#folderName").val();
    	  console.log(folderName);
    	 var length= loadFolder(folderName);  // 调用子页面中的subFunction方法。
      	 console.log("length:"+length);
    	 if(length==0){
    		 $("#tips").html("抱歉!未找到"+folderName);
    		 return;
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
        	      url : path+"/folderServlet?method=addFolder",// 请求的action路径
        	      success : function(data) {
                      console.log(data);
              	    if (data.code==1) {
              	      swal({
              	        type: 'success',
              	        html: data.message
              	      });
              	    /* document.getElementById('listFrame').contentWindow.location.reload(true);//添加成功之后刷新子iframe页面 */
              		 loadFolder();//刷新文件类别
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
    	 var delType= $("#home1").find("#delLi").attr("data-value");
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
            	      url : path+"/folderServlet?method=delete",// 请求的action路径
            	      cache : false,
            	      type : 'POST',
            	      data:{folderName:delType},
            	     
            	      success : function(data) {
                  	    if (data.code==1) {
                  	      swal({
                  	        type: 'success',
                  	        html: data.message
                  	      });
                  	  //  document.getElementById('listFrame').contentWindow.location.reload(true);//刷新子iframe页面
                  	    loadFolder();//刷新文件类别
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
      
      //删除选中的图片
      function delImg(){
    	  //
    	  var picName =[];
    	  var picList= $("#home1").find("#picList").find("img");
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
    		
    	  });
    	  picName = picName.join(",");
    	  if(picName==""||picName==null){
    		  swal(
    	  		    '图片未选择!',
    	  		     '请选择需要删除的图片.',
    	  		   	'warning'
    	  		    );
    		  return;
    	  }
    	
	   	   var folderName =$("#home1").find("img").first().attr("dataValue");
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
	          	      url : path+"/folderServlet?method=delPic",// 请求的action路径
	          	      cache : false,
	          	      type : 'POST',
	          	      data:{folderName:folderName,picName:picName},
	          	     
	          	      success : function(data) {
	                        console.log(data);
	                	    if (data.code==1) {
	                	      swal({
	                	        type: 'success',
	                	        html: data.message
	                	      });
	                	     // document.getElementById('listFrame').contentWindow.location.reload(true);//刷新子iframe页面
	                	      reloadImg(folderName);//刷新图片
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
			var urlc= path+'/fileUpServlet?method=saveFiles';
			var BASE_URL=path;
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
			    idImg=file.id;
			    reloadImg(addfolderName);//调用子iframe的方法
			});
			uploader.on( 'uploadError', function( file) {
			    $( '#'+file.id ).find('div.state').html(file.name+'---上传出错');
			});
			uploader.on( 'uploadComplete', function( file ) {
			   $( '#'+file.id ).find('.progress').fadeOut('slow');
			}); 
			

			/*-------------------------------------------文件上传end----------------------------------------------*/
			
			$('#myModal').on('shown.bs.modal',function() {//提示框显示时候触发
				
				uploader.refresh();   //刷新当前webUploder
	 		});
		/*	$('#myModal').on('hide.bs.modal',function() {//提示框关闭时候触发
				uploader.removeFile( idImg, true ); 
				    //清空队列
//				     uploader.reset();
						
			 });*/
	
		
			 function show_modal() {//显示模态框
				 addfolderName =  $("#home1").find("#delLi").attr("data-value");
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
			function logout(){//退出登录
				//清空用户信息
				  $.ajax({
	          	      async : false,
	          	      dataType: 'json',
	          	      url : path+"/loginServlet?method=logout",// 请求的action路径
	          	      cache : false,
	          	      type : 'POST',
	   
	          	      success : function(data) {
	                        console.log(data);
	                        if (data.code==1) {
	                        	location.href=path+"/index.html";
	                        }else{
		                	   swal({
			                  	   type: 'error',
			                  	   html: data.message
			                  	  });
			                }
	                        
	          	      }
	             }); 
				
			}
			
			 function loadFolder(folderName){//加载文件列表
				   $("#list-group").empty();//清空列表
			 	   $("#picList").empty();//清空图片列表
				   var folderHtml="";
				   var length=0;
				   $.ajax({
					      async : false,
					      dataType: 'json',
					      cache : false,
					      type : 'POST',
					      data:{folderName:folderName},
					      url : path+"/folderServlet?method=getFolderList",// 请求的action路径
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
			  function getPicture(){//点击文件列表，添加id几加载对应图片
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
					reloadImg(dataValue);    //加载图片
			  }
			  
			   function reloadImg(dataValue){//加载文件列表下图片
				   console.log("调用刷新img方法"+dataValue);
				   $("#picList").empty();
				   var picName="";
					 $.ajax({
					      async : false,
					      dataType: 'json',
					      cache : false,
					      type : 'POST',
					      url : path+"/folderServlet?method=getPicsByFolderName",// 请求的action路径
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
			   
			   $("#home1").on('click','.img-fluid',function(){   //选择需要删除的图片
				   var imgStatus = $(this).attr("imgStatus");
			   		if(imgStatus=="noSelected"){
			   		 $(this).css("border","4px solid #da542e");
			   		 $(this).attr("imgStatus","selected");
			   		 
			   		}else{
			   		 $(this).attr("imgStatus","noSelected");
			   		 $(this).css("border","2px solid #00ba8b");
			   		}
	
			      });
			   
			   $(function(){
				   $(".homeContent1").hide();
				   var myClientHeight = document.documentElement.clientHeight+25;
			        var navbarHeight =$(".navbar").outerHeight(true);
			        var sectionHeight =$(".menu-section").outerHeight(true);
			    	var footerHeight =$(".footer-section").outerHeight(true);
			    	var myIframeHeight =myClientHeight - navbarHeight - sectionHeight - footerHeight -30 +"px";
			    	$(".box").css("min-height",myIframeHeight);
			    	$(".myscrollable").css("height",myIframeHeight);
					  loadFolder();//加载文件列表
					  
				    	
					  $(".myscrollable").niceScroll({cursorcolor:"#FF6D3D"});
					  $(".mainMenu li a").click(function(){
						 $(this).addClass('menuLi').parent().siblings().find("a").removeClass('menuLi');
						 var order = $(".mainMenu li a").index(this);
						 if(order=="0"){//如果不是浏览页面，则类别搜索不展示
							 $(".searchType").show();
						 }else{
							 $(".searchType").hide();
						 }
						 $(".homeContent" + order).show().siblings("div").hide();//显示class中homeContent加上返回值所对应的DIV
						
					 });
				  }); 