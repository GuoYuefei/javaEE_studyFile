<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>输出内容</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<style type="text/css">
		.source{
			white-space: pre;
			width: 100%;
			height: 200px;
			overflow: scroll;
			border: 1px solid #999999;
			padding: 2px;
			margin-bottom: 20px;
		}
	</style>
	
  </head>
  
  <body>
	<c:import charEncoding="UTF-8" url="/WEB-INF/web.xml" var="file" />
	
	<div class="source">
		<c:out value="${ file }"/>
	</div>	

	<x:parse var="doc" doc="${ file }"></x:parse>

	<h2>自己网站的web.xml </h2><br/>
	<h5>servlet的内容</h5>
	<x:forEach var="node" select="$doc/web-app/servlet" varStatus="status">
		${ status.count }.<br/>
		servlet.name: <x:out select="$node/servlet-name"/><br/>
		display.name: <x:out select="$node/display-name"/><br/>
		description: <x:out select="$node/description"/><br/>
		class所在位置：<x:out select="$node/servlet-class"/><br/>
	</x:forEach>










  </body>
</html>
