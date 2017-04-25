<%@page import="cn.becomegood.web.test2.SafeUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@page import="cn.becomegood.web.test1.Login"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String action = request.getParameter("action");
	if("login".equals(action)){
		int timeout=Integer.parseInt(request.getParameter("timeout"));
		String username = URLEncoder.encode(request.getParameter("username"), "UTF-8");
		Cookie usernameCookie = new Cookie("username",username);
		Cookie ssidUsernameCookie = new Cookie("ssid",SafeUtil.calcMD5(username));
		Cookie visittimesCookie = new Cookie("visittimes","0");
		Cookie timeoutCookie = new Cookie("timeout",String.valueOf(timeout));
//		usernameCookie.setSecure(true);
//		设置cookie失效时间，默认-1表示关闭游览器就失效。0表示移除cookie，正数表示多少秒后失效
		usernameCookie.setMaxAge(timeout);
		ssidUsernameCookie.setMaxAge(timeout);
		visittimesCookie.setMaxAge(timeout);
		timeoutCookie.setMaxAge(timeout);
			
		response.addCookie(usernameCookie);
		response.addCookie(ssidUsernameCookie);
		response.addCookie(visittimesCookie);
		response.addCookie(timeoutCookie);
		//利用file类的getparent（）得到除去文件名的路径
		response.sendRedirect(new File(request.getRequestURI()).getParent()+"/cookie.jsp");	//跳转页面
		return;
	}else if("logout".equals(action)){
		Cookie usernameCookie = new Cookie("username","");
		Cookie ssidUsernameCookie = new Cookie("ssid","");
		Cookie visittimesCookie = new Cookie("visittimes","");
			
		//置零删除
		usernameCookie.setMaxAge(0);
		ssidUsernameCookie.setMaxAge(0);
		visittimesCookie.setMaxAge(0);
		
		response.addCookie(usernameCookie);
		response.addCookie(ssidUsernameCookie);
		response.addCookie(visittimesCookie);
	}
	//该部分判断是否登录，如果登录就跳转页面
	String username = null;
	String ssid = null;
	if(request.getCookies() != null){
		for(Cookie cookie:request.getCookies()){
			if("username".equals(cookie.getName())) username=cookie.getValue();
			
			if("ssid".equals(cookie.getName())) ssid=cookie.getValue();
		}
		if(username!=null&&ssid!=null){
			if(SafeUtil.calcMD5(username).equals(ssid)){	//如果加密后等于加密过的cookie值就算登录
				response.sendRedirect(new File(request.getRequestURI()).getParent()+"/cookie.jsp");
				return;	
			}
		}
	}
 %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>请先登录</title>
    
    
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
  <div align="center" style="margin:10px">
  	<fieldset>
  		<legend>登陆</legend>
  		<form action=<%= path+request.getServletPath()+"?action=login"%> method="post">
  			<table>
  				<tr>
  					<td>账号：</td>
  					<td><input type="text" name="username" style="width: 200px"></td>
  				</tr>
  				<tr>
  					<td>密码：</td>
  					<td><input type="password" name="passwd" style="width:200px"></td>
  				</tr>
  				<tr>
  					<td>有效期：</td>
  					<td><select name="timeout">
  							<option value="-1">关闭游览器即失效</option>
  							<option value="<%= 30*24*60*60 %>">30天有效</option>
  							<option value="<%= Integer.MAX_VALUE%>">永久有效</option>
  						</select>
  					</td>
  				</tr>
  				<tr>
  					<td>
  					<input type="submit" value="登      陆" class="button" 
  							style="height: 30px;color: #FF0000;background-color: #00ff00">
  					</td>
  				</tr>
   			</table>
  		</form>
  	</fieldset>
  </div>
  
  </body>
</html>
