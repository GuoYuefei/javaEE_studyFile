<%@page import="cn.becomegood.web.test2.Pagination"%>
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
    
    <title>查询结果</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
		.tab{
			border: 1px solid  #ff0;
		}
		td{
			border: 1px dashed  #999;
		}
		th{
			border: 1px solid;
		}
	</style>
  </head>
  
  <body>
    This is my JSP page. <br>
    <!-- 注释调，改用JNDI配置数据库 -->
       

	 
	 <sql:setDataSource var="dataSource" dataSource="jdbc/jstl"  /> 

    <sql:query var="rs" dataSource="${ dataSource }" >
    	select * from users
    </sql:query>
    
    <table>
    	<tr>
    		<th>id</th>
    		<th>sex</th>
    		<th>phone</th>
    		<th>name</th>
    		<th>age</th>
    	</tr>
    	<c:forEach var="row" items="${ rs.rows }">
    		<tr>
    			<td>${ row.user_id }</td>
    			<td>${ row.user_sex }</td>
    			<td>${ row.user_phone }</td>
    			<td>${ row.user_name }</td>
    			<td>${ row.user_age }</td>
    		</tr>
    	</c:forEach>
    </table>
    
    
    
    <% 
    	request.setAttribute("pagination", new Pagination(request,response));
     %>
    
    <sql:setDataSource driver="com.mysql.jdbc.Driver"
    	user="root" password="123456"
    	url="jdbc:mysql://127.0.0.1:3306/mysql"
    	var="datamysql"/>
    
    <!-- 查询总数 -->
    <sql:query var="rs" dataSource="${ datamysql }">
    	select count(*) count from help_topic
    </sql:query>
    
	<!-- 设置pagination属性 -->    
    <c:forEach items="${ rs.rows }" var="row">
    	<c:set target="${ pagination }" property="recordCount" value="${ row.count }"/>
    </c:forEach>
	
	<!-- 分页查询数据 -->    
    <sql:query var="rs" dataSource="${ datamysql }" startRow="${ pagination.firstResult }"
    	maxRows="${ pagination.pageSize }"
    >
    	SELECT *FROM help_topic
    </sql:query>
	
	<table>
		<tr>
			<td> help_id</td>
			<td>Name</td>
			<td>Description</td>
		</tr>
		<!-- 显示数据 -->
	<c:forEach items="${ rs.rows }" var="row">
		<tr>
			<td>${ row['help_topic_id'] }</td>
			<td>${ row.name }</td>
			<td>${ row.description }</td>
		</tr>
	</c:forEach>
	</table>    
    <br/>
    
    <!-- 输出上一页、下一页等 -->
    ${ pagination }
    
    
  </body>
</html>
