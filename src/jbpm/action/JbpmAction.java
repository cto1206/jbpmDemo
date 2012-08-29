package jbpm.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.ServletActionContext;
import org.jbpm.api.ProcessDefinition;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.TaskService;
import org.jbpm.api.model.ActivityCoordinates;
import org.jbpm.api.task.Task;

import jbpm.JbpmService;
import jbpm.vo.Position;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zz.po.User;
import com.zz.service.IUserService;
import com.zz.util.ApplicationContextHelper;

public class JbpmAction extends ActionSupport {
	private IUserService userService;

	// 用户登录
	public String login() {
		String username = ServletActionContext.getRequest().getParameter(
				"username");
		IUserService userService = (IUserService) ApplicationContextHelper
				.getInstance().getApplicationContext().getBean("userService");
		User user = userService.getUserByName(username);
		ActionContext.getContext().getSession().put("user", user);
		return SUCCESS;
	}

	// 用户注销
	public String logout() {
		ActionContext.getContext().getSession().clear();
		return SUCCESS;
	}

	// 显示已经部署的流程、已开启的流程实例、用户的任务
	public String showProcess() {
		List<ProcessDefinition> processDefinitions = JbpmService.getInstance()
				.getProcessDefinitions();
		List<ProcessInstance> processInstances = JbpmService.getInstance()
				.getProcessInstances();
		List<String> processInstanceMesList = new ArrayList<String>();
		for (ProcessInstance processInstance : processInstances) {
			processInstanceMesList.add(processInstance
					.findActiveActivityNames()
					+ "-" + processInstance.getId());
		}
		User user = (User) ActionContext.getContext().getSession().get("user");
		List<Task> tasks = JbpmService.getInstance().getUserTasks(user.getId());
		ActionContext.getContext().getSession().put("processDefinitions",
				processDefinitions);
		ActionContext.getContext().getSession().put("processInstanceMesList",
				processInstanceMesList);
		ActionContext.getContext().getSession().put("tasks", tasks);
		return SUCCESS;
	}

	// 部署流程
	public String deployProcess() {
		String processName = ServletActionContext.getRequest().getParameter(
				"processName");
		if (processName != null && !"".equals(processName.trim())) {
			JbpmService.getInstance().deploy(processName);
		}
		return SUCCESS;
	}

	// 删除部署的流程
	public String deleteProcessDefinition() {
		String pdid = ServletActionContext.getRequest().getParameter("pdid");
		if (pdid != null) {
			JbpmService.getInstance().deleteProcessDefinitionById(pdid);
		}
		return SUCCESS;
	}

	// 启动流程
	public String startProcessInstance() {
		String pdid = ServletActionContext.getRequest().getParameter("pdid");
		if (pdid != null) {
			// 开启流程
			Map<String, String> map = new HashMap<String, String>();
			User user = (User) ActionContext.getContext().getSession().get(
					"user");
			map.put("userId", user.getId());
			JbpmService.getInstance().getProcessEngine().getExecutionService()
					.startProcessInstanceById(pdid, map);
		}
		return SUCCESS;
	}

	// 显示所有的流程实例
	public String showProcessInstance() {
		List<ProcessInstance> processInstances = JbpmService.getInstance()
				.getProcessInstances();
		for (ProcessInstance processInstance : processInstances) {
			System.out.println(processInstance.getId() + ", "
					+ processInstance.getName() + ", "
					+ processInstance.getKey() + ", "
					+ processInstance.findActiveActivityNames());
		}
		return SUCCESS;
	}

	// 提交请假申请
	public String submitLeave() {
		String username = ServletActionContext.getRequest().getParameter(
				"username");
		String days = ServletActionContext.getRequest().getParameter("daynum");
		String reason = ServletActionContext.getRequest()
				.getParameter("reason");
		String taskid = ServletActionContext.getRequest()
				.getParameter("taskid");
		Task task = JbpmService.getInstance().getProcessEngine()
				.getTaskService().getTask(taskid);
		TaskService taskService = JbpmService.getInstance().getProcessEngine()
				.getTaskService();
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		map.put("days", days);
		map.put("reason", reason);
		// 将任务提交给项目记录审批
		map.put("manager", userService.getUserByName("项目经理").getId());
		// 向该任务中添加一些参数
		taskService.setVariables(taskid, map);
		taskService.completeTask(taskid);
		return SUCCESS;
	}

	// 跳转到审核页面
	public String approvePage() {
		String taskid = ServletActionContext.getRequest()
				.getParameter("taskid");
		TaskService taskService = JbpmService.getInstance().getProcessEngine()
				.getTaskService();
		// 从任务中获取请假内容
		Set<String> set = new HashSet<String>();
		set.add("username");
		set.add("reason");
		set.add("days");
		Map<String, Object> map = taskService.getVariables(taskid, set);
		ActionContext.getContext().put("username", map.get("username"));
		ActionContext.getContext().put("reason", map.get("reason"));
		ActionContext.getContext().put("days", map.get("days"));
		ActionContext.getContext().put("taskid", taskid);
		return SUCCESS;
	}

	// 项目经理或者老板审批请假申请
	public String approveLeave() {
		User user = (User) ActionContext.getContext().getSession().get("user");
		String username = ServletActionContext.getRequest().getParameter(
				"username");
		String days = ServletActionContext.getRequest().getParameter("daynum");
		String reason = ServletActionContext.getRequest()
				.getParameter("reason");
		String taskid = ServletActionContext.getRequest()
				.getParameter("taskid");
		Task task = JbpmService.getInstance().getProcessEngine()
				.getTaskService().getTask(taskid);
		TaskService taskService = JbpmService.getInstance().getProcessEngine()
				.getTaskService();
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		map.put("days", days);
		map.put("reason", reason);
		// 如果当前用户是项目经理,在提交任务时,在任务参数中添加老板的id
		if ("项目经理".equals(user.getName())) {
			// 将任务提交给项目记录审批
			map.put("boss", userService.getUserByName("老板").getId());
		}
		// 向该任务中添加一些参数
		taskService.setVariables(taskid, map);
		taskService.completeTask(taskid);
		return SUCCESS;
	}

	// 显示流程进度
	public String processView() {
		String executionId = ServletActionContext.getRequest().getParameter(
				"executionId");
		ActivityCoordinates ac = JbpmService.getInstance()
				.getActivityCoordinates(executionId);
		Position position = new Position();
		if (ac != null) {
			position.setX(ac.getX());
			position.setY(ac.getY());
			position.setWidth(ac.getWidth());
			position.setHeight(ac.getHeight());
		} else {
		}
		ActionContext.getContext().put("position", position);
		return SUCCESS;
	}

	public IUserService getUserService() {
		return userService;
	}

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

}
