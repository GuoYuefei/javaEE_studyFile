<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.becomegood.cn/tag" prefix="tag"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    This is my JSP page. <br>
    
    <tag:Hello name="郭月飞"></tag:Hello>
    <br/>
    <tag:ToLow>OUR SCHOOL!</tag:ToLow>
    <tag:Dyn  name="中国个公司收益额柱状图" 
    	中国石油="30" 工商银行="50" 建设银行="18" 中国石化="14" 万科A="1" 中国中铁="2" 费超宇="20">
    	<tag:title/>	
    </tag:Dyn>
								<!-- 一个失败的标签，只能输出图片，无法输出正常的文本，
    	<%//<tag:core var="zf"/>%>	已有替换方法，我把这种替换方式直接写在canglian的项目中了 -->
    
    <!-- 替换的原理大概就是这个，但是我把它写成了标签封装起来 -->
    <img alt="验证码" src="/testEE/servlet/Code">
    <tag:copyright/>
  </body>
</html>
