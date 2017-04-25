<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.becomegood.cn/fly" prefix="my"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8"/>	
    
    <title>注册页面</title>
  	<link rel="stylesheet"type="text/css"href="<%=basePath%>user/css/form1.css"/>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<!-- 提交表单时检验并提交的js方法 -->
	<script type="text/javascript">
         function check(form) {
         
			if(form.passwd.value != form.passwd2.value){
				alert("两次密码不一致，请检查");
				form.passwd.focus();
				return false;
			}
			if(form.passwd.value.length<6){
				alert("密码至少大于六位");
				form.passwd.focus();
				return false;
			}
          	if(form.id.value=='') {
                alert("请输入用户帐号!");
                form.id.focus();
                return false;
           	}
           	if(form.username.value==''){
           		alert("请输入使用的昵称!");
                form.username.focus();
                return false;
           	}
         	return true;
         }
	</script>
	<%
		request.setAttribute("method", request.getMethod());//得到提交方式
		request.setAttribute("uri", request.getRequestURI());//将本网站的uri放入request属性中
	 %>
  </head>
  
  <body>
	<sql:setDataSource dataSource="jdbc/jstl" var="source"/>	
  	<c:if test="${ requestScope.method eq 'POST' }">
  		<% //检查验证码是否正确，正确就继续执行注册操作，否则提示 %>
  	<c:choose>
  		<c:when test="${ fn:toLowerCase(param.code) eq fn:toLowerCase(sessionScope.code) }">
		  	<c:catch var="e">
				<sql:update dataSource="${ source }">
					insert into users(user_id,user_pw,user_name) values(?,?,?)				
					<sql:param value="${ param.id }"/>
					<sql:param value="${ param.passwd }"/>
					<sql:param value="${ param.username }"/>
				</sql:update>
			</c:catch>
	  		<!-- 处理必要信息插入失败 -->
		  	<c:choose>
		  		<c:when test="${ e != null }">
		  			注册失败！<br/>异常信息：${ e.message }
		  		</c:when>
		  		<c:otherwise>
		  			<script type="text/javascript">
		  				alert("注册成功");
		  			</script>
					<%// 不必要元素选择插入数据库,这是发生在注册成功的情况下，也就是必要元素已经插入进数据库 %>
					<c:catch var="e1">
					  	<c:if test="${ param.trueName != '' && param.trueName != null }">
					  		<sql:update dataSource="${ source }">
						  		UPDATE users SET user_true=? WHERE user_id='${ param.id }'
						  		<sql:param value="${ param.trueName }"/>
					  		</sql:update>
					  	</c:if>
					  	<c:if test="${ param.sex != '' && param.sex != null }">
					  		<sql:update dataSource="${ source }">
					  			UPDATE users SET sex=?  WHERE user_id='${ param.id }'  
					  			<sql:param value="${ param.sex }"/>
					  		</sql:update>
					  	</c:if>
					  	<c:if test="${ param.age != '' && param.age != null }">
					  		<sql:update dataSource="${ source }">
					  			UPDATE users SET user_age=? WHERE user_id='${ param.id }'
					  			<sql:param value="${ param.age }"/>
					  		</sql:update>
					  	</c:if>		
					  	<c:if test="${ param.phone != '' && param.phone != null }">
					 	 	<sql:update dataSource="${ source }">
					  			UPDATE users SET user_phone=? WHERE user_id='${ param.id }'
					  			<sql:param value="${ param.phone }"/>
					  		</sql:update>
					  	</c:if>	  	
				  	</c:catch>
					<c:if test="${ e1 != null }">
						在插入某些信息的时候失败咯，但不影响注册。<br/>
						失败原因:${ e1.message }
					</c:if>
		  		</c:otherwise>
		  	</c:choose>	
		 </c:when>
	  	<c:otherwise>
	  		<script type="text/javascript">
	  			alert("验证码输入有误！！");
	  		</script>
	  	</c:otherwise>	
  	</c:choose>
  	</c:if>
	
	
	<div class="navigation"></div>
	<form action="<%=request.getRequestURI() %>" name="register" method="post" onsubmit="return check(this)">
		<fieldset>
		<legend align="center" class="word1"><span class="word2">注</span>册</legend>
		<table align="center">
			<tr>
				<td>学号:</td>
				<td><input type="text" name="id" value="${ param.id }"/></td>
			</tr>
			<!-- 设计密码，不予提交失败后返回 -->
			<tr>
				<td>密码：</td>
				<td><input type="password" name="passwd"/></td>
			</tr>
			<tr>
				<td>确认密码：</td>
				<td><input type="password" name="passwd2"/></td>
			</tr>
			<tr>
				<td>昵称</td>
				<td><input type="text" name="username" value="${ param.username }"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center">以下选填</td>
			</tr>
			<tr>
				<td>姓名：</td>
				<td><input type="text" name="trueName" value="${ param.trueName }"></td>
			</tr>
			<tr>
				<td>性别:</td>
				<td>
					<% //以下代码是为了找到提交失败后原来用户选择的性别，比起文本，单选需要判断 %>
					<c:if test="${ param.sex eq '男' }">
						<c:set var="male" value="checked"></c:set>
					</c:if>
					<c:if test="${ param.sex eq '女' }">
						<c:set var="female" value="checked"></c:set>
					</c:if>
					<input type="radio" name="sex" value="男" ${ male }>男
					<input type="radio" name="sex" value="女" ${ female }>女
				</td>
			</tr>
			<tr>
				<td>年龄:</td>
				<td><input type="text" name="age" value="${ param.age }"></td>
			</tr>
			<tr>
				<td>手机号码:</td>
				<td><input type="text" name="phone" value="${ param.phone }"></td>
			</tr>
			<tr>
				<td><my:code var="code"/></td>
				<td><input class="code" type="text" name="code"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input class="button1" type="submit" value="确认注册">
				</td>
			</tr>
		</table>		
		</fieldset>
	</form>
  </body>
</html>
