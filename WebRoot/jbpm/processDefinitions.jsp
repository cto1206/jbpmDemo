<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<title>流程部署</title>
	</head>
	<body>
		<h3>
			${sessionScope.user.name}:
			<a href="<%=basePath + "jbpm/logout.action"%>">注销</a>
		</h3>
		<c:if test="${sessionScope.user.name == '系统管理员'}">
			<form action="jbpm/deployProcess.action" method="post">
				<input type="hidden" name="processName" value="leave.jpdl.xml">
				<input type="submit" value="发布请假流程">
			</form>
		</c:if>
		<c:if test="${sessionScope.user.name != '系统管理员'}">
			<c:if test="${sessionScope.user.name == '张三'}">
				<h3>
					已经部署的请假流程:
				</h3>
				<table cellpadding="1" border="1">
					<tr>
						<th>
							ID
						</th>
						<th>
							deploymentId
						</th>
						<th>
							VERSION
						</th>
						<th>
							NAME
						</th>
						<th>
							KEY
						</th>
						<th>
							开启
						</th>
						<th>
							删除
						</th>
					</tr>
					<c:if test="${processDefinitions != null }">
						<c:forEach items="${processDefinitions}" var="processDefinition">
							<tr>
								<td>
									${processDefinition.id}
								</td>
								<td>
									${processDefinition.deploymentId}
								</td>
								<td>
									${processDefinition.version}
								</td>
								<td>
									${processDefinition.name}
								</td>
								<td>
									${processDefinition.key}
								</td>
								<td>
									<a
										href="jbpm/startProcessInstance.action?pdid=${processDefinition.id }">开启</a>
								</td>
								<td>
									<a
										href="jbpm/deleteProcessDefinition.action?pdid=${processDefinition.deploymentId }">删除</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<tr>
					</tr>
				</table>
			</c:if>
			<h3>
				已开启的请假流程实例:
			</h3>
			<table cellpadding="1" border="1">
				<tr>
					<th>
						ID
					</th>
					<th>
						NAME
					</th>
					<th>
						查看进度
					</th>
				</tr>
				<c:if test="${processInstanceMesList != null }">
					<c:forEach items="${processInstanceMesList}" var="mes">
						<tr>
							<td>
								${fn:split(mes,"-")[1]}
							</td>
							<td>
								${fn:split(mes,"-")[0]}
							</td>
							<td>
								<a
									href="jbpm/processView.action?executionId=${fn:split(mes,'-')[1]}">查看</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<h3>
				我的任务:
			</h3>
			<table cellpadding="1" border="1">
				<tr>
					<th>
						ID
					</th>
					<th>
						NAME
					</th>
				</tr>
				<c:if test="${tasks != null }">
					<c:forEach items="${tasks}" var="task">
						<tr>
							<td>
								${task.id}
							</td>
							<td>
								<a
									href="<%=basePath%>${task.formResourceName}?taskid=${task.id}">${task.name}</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<tr>
				</tr>
			</table>
		</c:if>
	</body>
</html>