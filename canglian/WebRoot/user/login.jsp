<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://www.becomegood.cn/fly" prefix="my"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<%
		request.setAttribute("method", request.getMethod());//得到提交方式
		request.setAttribute("uri", request.getRequestURI());//将本网站的uri放入request属性中
	 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>user/css/form1.css"/>



	
  </head>
  	
  <body>
  <!-- 不论有无，都收取数据 -->
	<jsp:useBean id="login" class="cn.becomegood.canglian.bean.LoginBean" scope="request"/>
	<jsp:setProperty property="*" name="login"/>
	
	<form action=<%=request.getRequestURI()+"?action=login"%> method="post">
	<fieldset>
	<legend align="center">登录</legend>
	<table align="center">
		<tr>
			<th>帐号：</th>
			<td><input type="text" name="username" value=
			<c:if test="${ method eq 'POST' }">
				<jsp:getProperty property="username" name="login"/>			
			</c:if>
			></input>
			</td>
			<td><span id="error"></span></td>
		</tr>
		<tr>
			<th>密码：</th>
			<td><input type="password" name="passwd"/></td>
		</tr>
		<tr>
			<th>有效期：</th>
			<td><select name="timeout">
					<option value="-1">关闭游览器即失效</option>
					<option value="<%= 30*24*60*60 %>">30天有效</option>
					<option value="<%= Integer.MAX_VALUE%>">永久有效（不建议）</option>
				</select>
			</td>
		</tr>	
		<tr>
			<th><my:code var="code"/></th>
			<td><input type="text" name="code"/></td>
		</tr>	
		<tr>
			<th colspan="2" align="right">
				<input class="button1" type="submit" value="登录"/>
			</th>
		</tr> 
	</table>
	</fieldset>
	</form>
	
	<%
		String action = request.getParameter("action");
		//必须要action!=null的判断，不然会出错。原因，null是无法使用比较函数的
	 	if(action!=null&&action.equalsIgnoreCase("login")){
	 %>
		
	<sql:setDataSource dataSource="jdbc/jstl" var="source"/>
	<c:catch var="e">
		<sql:query var="pw" dataSource="source">select user_pw from users where user_id='
							<jsp:getProperty property="username" name="login"/>'
		</sql:query>
	</c:catch>
	<!-- 如果有错误的话就发出提示 -->
	<c:if test="${ e!=null }">
		<script type="text/javascript">
			document.getElementById("error").innerHTML="无此用户名！";
		</script>
	</c:if>
	<!-- 我的打算是在确定没有e是为null之后转到一个servlet中处理业务逻辑，如果密码和code不正确的话
			就重新定向到该网页，不然就显示个人登录后的主页
		 -->
	<%} %>
  </body>
</html>
