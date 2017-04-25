<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>测试了语言的国际话，通过判断系统信息来显示相应的语言文字</title>
    
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
    <!-- bundle会加载所有messages_*.properties的文件 -->
    <!--  fmt:setLocale value="en" scope="session"/-->
    <fmt:bundle basename="properties.messages" prefix="prompt.">	<!-- prompt.可以使得后面的hello前面少些前缀 -->
    	<fmt:message key="hello">
    		<fmt:param value="fly"></fmt:param>
    	</fmt:message>
    	<br/>
    	<fmt:message key="greeting"></fmt:message>
    </fmt:bundle>
  </body>
</html>
