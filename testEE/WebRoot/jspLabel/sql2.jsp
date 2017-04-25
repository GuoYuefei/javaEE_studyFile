<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>更新数据</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<% request.setAttribute("method", request.getMethod()); %>
  </head>
  
  <body>
  	<c:if test="${ requestScope.method eq 'POST' }">
		  	<!-- 设置数据源用的是context.xml中设置的数据源 -->
		<c:catch var="e">
			<sql:setDataSource dataSource="jdbc/jstl" var="dataSource"/>
			<sql:update	dataSource="${ dataSource }">
				insert into users values(?,?,?,?,?)
				<sql:param value="${ param.id }"></sql:param>
				<sql:param value="${ param.sex }"></sql:param>
				<sql:param value="${ param.phone }"></sql:param>
				<sql:param value="${ param.username }"></sql:param>
				<sql:param value="${ param.age }"></sql:param>
			</sql:update>
		</c:catch>
		<c:choose>
			<c:when test="${ e != null }">
				插入数据库失败，异常信息：${ e.message }
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					alert("数据记录成功！！");
				</script>
			</c:otherwise>		
		</c:choose>
  	</c:if>

	<form action="<%=request.getRequestURI() %>" method="post">
		<fieldset>
		<legend>增加记录</legend>
		<table>
			<tr>
				<td>学号:</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>性别:</td>
				<td><input type="radio" name="sex" value="男">男
				<input type="radio" name="sex" value="女">女</td>
			</tr>
			<tr>
				<td>手机号码:</td>
				<td><input type="text" name="phone"></td>
			</tr>
			<tr>
				<td>姓名：</td>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td>年龄:</td>
				<td><input type="text" name="age"></td>
			</tr>
			<tr>
				<td><input type="submit" value="添加"></td>
			</tr>
		</table>
		</fieldset>
	</form>
  </body>
</html>
