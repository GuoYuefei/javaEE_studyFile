<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
 
<html> 
	<head>
		<title>JSP for HelloForm form</title>
	</head>
	<body>
		<html:form action="/hello">
			<label>name : <html:text property="name"/><html:errors property="name"/><br/>
			</label>
			<label>
			passwd : <html:password property="passwd"/><html:errors property="passwd"/><br/>
			</label>
			<html:submit/>
		</html:form>
		
	</body>
</html>

