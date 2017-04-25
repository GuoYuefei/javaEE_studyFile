<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'each.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		.header{
			background-color: #999999;
		}
	
	</style>
  </head>
  
  <body>
  <!-- 其中var只能接收常用类型，而不支持javaBean和map。这两者可以使用target，在show.jsp中有例子 -->
  	<c:set var="allcount" value="${ allcount+1 }" scope="application"></c:set>
  	<c:set var="count" value="${ count+1 }" scope="session"></c:set>
  	本网页访问总人次：${ allcount } <br/>
	其中你访问的人次：${ count } <br/>

  
    普通的循环输出 <br>
    
    <table>
    	<tr>
    		<td class="header" width="30%">Header Name</td>
    		<td class="header" width="70%">Header Value</td>
    	</tr>
    	<c:forEach var="item" items="${ header }">
    		<tr>
    			<td>${ item.key }</td>
    			<td>${ item.value }</td>
    		</tr>
    	</c:forEach>
    </table>
    
   <hr/>
    <h1>这是使用了varStatus进行的循环</h1>
    
    <table>
    	<tr>
    		<td class="header">序号</td>
    		<td class="header" width="300px">Header Name</td>
    		<td class="header" width="700px">Header Value</td>
    	</tr>
    	<c:forEach items="${ header }" varStatus="varStatus">
    	<tr>
    		<td>${ varStatus.count }</td>	<!-- count从一开始，表示遍历的个数，index表示第几个对象，从0开始数 -->
    		<td>${ varStatus.current.key }</td>
    		<td>${ varStatus.current.value }</td>
    	</tr>
    	</c:forEach>
    </table>
    
    
    <hr/>
    <h1>这是forTokens的循环</h1>
    <p>用于字符串输出</p>
    <table>
    <tr>
    	<td>Status.index</td>
    	<td>item</td>
    </tr>
    <c:forTokens items="123,132,231,213,321,312" delims="," var="item" varStatus="Status"
    				begin="1" end="5" step="2">		<!-- 加上这行代码只输出奇数部分 -->
    <tr>
    	<td>${ Status.index }</td>
    	<td>${ item }</td>
    </tr>
    </c:forTokens>
    </table>
    
    
    
  </body>
</html>
