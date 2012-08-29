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

		<title>填写请假条</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>
		填写请假条:
		<br>
		<form action="jbpm/submitLeave.action">
			姓名：
			<input name="username" type="text">
			<br>
			天数：
			<select name="daynum" style="width:80px">
				<option value="1">
					1天
				</option>
				<option value="2">
					2天
				</option>
				<option value="3">
					3天
				</option>
				<option value="4">
					4天
				</option>
				<option value="5">
					5天
				</option>
				<option value="6">
					6天
				</option>
				<option value="7">
					7天
				</option>
				<option value="8">
					8天
				</option>
				<option value="9">
					9天
				</option>
				<option value="10">
					10天
				</option>
			</select>
			<br>
			原因：
			<input name="reason" type="text">
			<br>
			<input name="taskid" value="${param.taskid }" type="hidden">
			<input value="提交" type="submit">
		</form>
	</body>
</html>
