<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>				<!-- 本网页启用EL表达式 -->
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">				<!-- 默认的连接地址，就是该网页地址 -->
    
    <title>core标签的第一个测试</title>
    
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
    action的参数为：<c:out value="${param.action}" default="你没有输入action！！！" escapeXml="true"></c:out>
    
    <form action="<%= request.getRequestURI() %>?action=add" method="post">
    <fieldset>
    <c:if test="${ param.action=='add' }">
    	<legend>添加操作</legend>
    	<table>
    		<tr>
    			<td>帐号</td>
    			<td><input type="text" name="login"/></td>
    		</tr>
    		<tr>
    			<td>真实姓名</td>
    			<td><input type="text" name="name"/></td>
    		</tr>
    	</table>
    	<table>
		<tr>
 			<td>
 				<input type="submit" formaction="<%= request.getRequestURI() %>?action=edit"/>
 			</td>
 		</tr>
 		</table>
    </c:if>
    
    <c:if test="${ param.action=='edit' }">
		<legend>修改操作</legend>
		<table>
			<tr>
				<td>帐号</td>
				<td><c:out value="${ param.login }" default="login is undefault"></c:out></td>
			</tr>
			<tr>
				<td>真实姓名</td>
				<td><input type="text" name="name"></td>
			</tr>
		</table>
		<table>
		<tr>
 			<td>
 				<input type="submit"/>
 			</td>
 		</tr>
 		</table> 
    </c:if>    
 	
 	<c:if test="${ param.action!='add' && param.action!='edit' }">
		<table>
		<tr>
 			<td>
 				<input type="submit"/>
 			</td>
 		</tr>
 		</table>  		
    </c:if>
    
    </fieldset>
    </form>
    <hr/>
    <br/>
    
    <c:catch var="e">
    	<c:set target="someBean" property="name" value="weqwe">
    	</c:set>    
    </c:catch>
    <!-- 如果错误e不为空，也就是发生错误了，那就提示错误 -->
    <c:if test="${ e != null }">
    	错误原因是：${ e.message }			<!-- 抛出错误原因，或者做一些事情 -->
    </c:if>
    
    
    
  </body>
</html>
