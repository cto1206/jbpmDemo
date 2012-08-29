<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>审批请假条</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>
		<h3>
			审批请假条:
		</h3>
		<form action="jbpm/approveLeave.action">
			请假人姓名:
			<input name="username" type="text" readonly="readonly"
				value="${username }">
			<br>
			请假天数:
			<input name="daynum" type="text" readonly="readonly" value="${days }">
			<br>
			请假原因:
			<input name="reason" type="text" readonly="readonly"
				value="${reason }">
			<br>
			<input name="taskid" value="${taskid }" type="hidden">
			<input value="提交" type="submit">
		</form>
	</body>
</html>
