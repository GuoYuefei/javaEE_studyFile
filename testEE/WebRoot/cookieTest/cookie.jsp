<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder" %>
<!-- errorPage链接加参数“?action=logout”,能够清除空cookie -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" errorPage="login.jsp?action=logout"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	request.setCharacterEncoding("UTF-8");
	String username="";
	int visittimes = 0;
	int timeout = -1;
	Cookie[] cookies = request.getCookies();

	for(Cookie cookie:cookies){
		if("username".equals(cookie.getName())){			//获取username的cookie
			username = URLDecoder.decode(cookie.getValue(),"UTF-8");	//解码
		}else if("visittimes".equals(cookie.getName())){		//获取visittimes的cookie
			visittimes = Integer.parseInt(cookie.getValue());
		}else if("timeout".equals(cookie.getName())){
			timeout=Integer.parseInt(cookie.getValue());		//获取有效时间
		}
	}
	if(username == null || username.trim().equals("")){			//判断是否已经登陆
		throw new Exception("您还未登录，请登录！");
	}
	Cookie visittimesCookie = new Cookie("visittimes",Integer.toString(++visittimes));
	visittimesCookie.setMaxAge(timeout);				//给予有效时间
	response.addCookie(visittimesCookie);				//覆盖之前的Cookie

 %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'cookie.jsp' starting page</title>
    
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
	<div align="center">
		<fieldset>
			<legend>登陆信息</legend>
			<form action="login.jsp" method="post">
				<table>
					<tr>
						<td>您的账号：</td>
						<td><%=URLDecoder.decode(username, "UTF-8") %>
					</tr>
					<tr>
						<td>登陆次数：</td>
						<td><%=visittimes %></td>
					</tr>
					<tr>
						<td><input type="button" value="刷       新" onclick="
						location='<%= request.getRequestURI() %>?ts='+new Date().getTime();" 
						class="button">
						</td>
					</tr>
					<tr>
						<td><input type="button" value="注      销" onclick="location= '<%= 
							new File(request.getRequestURI()).getParent()+"/login.jsp?action=logout" %>'">
						</td>
					</tr>
				</table>
			</form>
		</fieldset>
	
	
	
	</div>
	
  </body>
</html>
