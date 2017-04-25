<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 	<base href="<%=basePath%>">   
    
    <title>greeting的显示</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<!-- <link rel="stylesheet" type="text/css" href="styles.css"> -->
  </head>
  
  <body><br/>
  <!-- 使用bean接收数据 -->
  <jsp:useBean id="login" class="cn.becomegood.web.test2.LoginMessage" scope="page"></jsp:useBean>
  <jsp:setProperty property="*" name="login"/>
  <table>
  	<tr>
  		<td align="left">姓名：</td>
  		<td>
  			<jsp:getProperty property="name" name="login"/>
  		</td>
  	</tr>
  	<tr>
  		<td align="left">性别：</td>
  		<td>
  			<jsp:getProperty property="sex" name="login"/>
  		</td>
  	</tr>
  	<tr>
  		<td align="left">密码：</td>
  		<td>
  			<jsp:getProperty property="passwd" name="login"/>
  		</td>
  	</tr>
  	<tr>
  	<td>
  	 	<% Enumeration enumeration=request.getParameterNames();
  			while(enumeration.hasMoreElements()){
  				out.println(enumeration.nextElement());	
  			}
  		%>
  	</td>
  	<td>
  		<c:set target="${ login }" property="name" value="${ login.name }被我修改了"></c:set>
  		修改之后：<jsp:getProperty property="name" name="login"/>
  	</td>
  	</tr>
  </table>
  
    This is my JSP page. <br>
  </body>
</html>
