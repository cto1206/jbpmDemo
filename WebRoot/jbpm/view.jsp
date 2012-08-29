<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<%
			String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
		%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>任务进度</title>
	</head>
	<body>
		<img src="<%=basePath%>jbpm/leave.png"
			style="position: absolute; left: 0px; top: 0px;">
		<div
			style="position:absolute;border:1px solid red;left:${position.x }px;top:${position.y }px;width:${position.width }px;height:${position.height}px;"></div>
	</body>
</html>