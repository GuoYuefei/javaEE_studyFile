<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Locale" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>'fmt1.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<% request.setAttribute("localeList", Locale.getAvailableLocales()); //获取所有国家的信息并放入集合%>
  </head>
  
  <body>
    <table>
    	<tr>
    		<th align="left">id</th>
    		<th align="left">Locale</th>
    		<th align="left">Language</th>
    		<th>Date and Time</th>
    		<th> Number</th>
    		<th>currency</th>
    	</tr>
    	<jsp:useBean id="date" class="java.util.Date"></jsp:useBean>
    	<!-- 拿取所有的本地信息 -->
    	<c:forEach var="locale" items="${ localeList }" varStatus="status">
    		<fmt:setLocale value="${ locale }"/> 		<!-- 设置当年循环到的本地环境，用于之后的不同地区显示 -->
    		<tr>
    			<td>${ status.count }</td>
    			<td align="left">${ locale.displayName }</td>
    			<td align="left">${ locale.displayLanguage }</td>
    			<td><fmt:formatDate value="${ date }" type="both"/></td>
    			<td><fmt:formatNumber>10000.5</fmt:formatNumber> 
    			<td><fmt:formatNumber type="currency">10000.5</fmt:formatNumber>
    		</td>   	
    	</c:forEach>
    </table>
    
  </body>
</html>
