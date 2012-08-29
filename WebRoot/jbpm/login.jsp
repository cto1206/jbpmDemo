<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

		<title>用户登录</title>

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
		<form action="jbpm/login.action" method="post">
			<select name="username">
				<option value="张三">
					张三
				</option>
				<option value="项目经理">
					项目经理
				</option>
				<option value="老板">
					老板
				</option>
				<option value="系统管理员">
					系统管理员
				</option>
			</select>
			<input value="登录" type="submit">
		</form>
		<br>
		本项目通过请假流程来演示jbpm4.4工作流的工作过程:
		<br>
		&nbsp;&nbsp;1)本项目共用四个用户,分别是张三、项目经理、老板和系统管理员;
		<br>
		&nbsp;&nbsp;2)主要工作流程是张三提交请假申请,提交后项目经理进行审批,
		<br>
		&nbsp;&nbsp;&nbsp;&nbsp;如果请假天数大于(包括)3天还需提交给老板进行审批,如果小于三天流程就直接结束;
		<br>
		&nbsp;&nbsp;3)系统管理员主要用来部署新的请假流程
		<br>
		&nbsp;&nbsp;4)张三通过开启一个新流程来填写请假申请
		<br>
		&nbsp;&nbsp;5)操作步骤:系统管理员登录-->部署请假流程定义-->张三登录-->开启一个请假流程实例-->填写请假条,提交-->项目经理审批-->老板审批(老板审批的条件是请假天数必须大于等于3天)
	</body>
</html>
