<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>TOP</title>
    
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
  <table width="100%" bgcolor="#999999">
  	<tr>
  		<td bgcolor="#666666" colspan=7 style="color: #FFFFFF;font-size: 40px;height: 60px;">
  			Hellow Word!</td>
  	</tr>
  	</tr bgcolor="#DDDDDD" align="center">
  		<td>首页</td>
  		<td>资源</td>
  		<td>文档</td>
  		<td>下载</td>
  		<td>关于</td>
  		<td>邮件</td>
  		<td>社区</td>
  </table>
  
  </body>
</html>
