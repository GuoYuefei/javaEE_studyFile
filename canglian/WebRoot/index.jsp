<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.becomegood.cn/fly" prefix="my" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<% 
		if(request.getMethod()=="POST"){
			if(request.getParameter("yzm").equalsIgnoreCase(session.getAttribute("zf").toString())){
				out.print("验证码输入正确！<br/>");
				out.print("你输入的是"+request.getParameter("yzm"));
			}else{
				out.print("输入验证码不正确。<br/>");
				out.print("你输入了"+request.getParameter("yzm")+"<br/>");
				out.print("你应该输入："+session.getAttribute("zf"));
			}
		}
	
	 %>
  </head>
  
  <body>
  	
  	<br/>
  	自定的验证码
	<my:code var="zf"/><br/>
	<form action="<%= request.getRequestURI() %>?act=tijiao" method="post">
		请输入验证码：<input type="text" name="yzm"/>
	
		<input type="submit"/>
	</form>
	
	
	
  	验证码中的字符串=
  	${ sessionScope.zf }
  </body>
</html>
