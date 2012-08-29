package jbpm;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipInputStream;

import org.jbpm.api.ExecutionService;
import org.jbpm.api.ProcessDefinition;
import org.jbpm.api.ProcessDefinitionQuery;
import org.jbpm.api.ProcessEngine;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.TaskService;
import org.jbpm.api.cmd.Command;
import org.jbpm.api.cmd.Environment;
import org.jbpm.api.model.ActivityCoordinates;
import org.jbpm.api.task.Task;
import org.jbpm.pvm.internal.model.ProcessDefinitionImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zz.util.ApplicationContextHelper;

public class JbpmService {
	private static JbpmService jbpmService = new JbpmService();

	private JbpmService() {
	}

	public static JbpmService getInstance() {
		if (jbpmService == null) {
			jbpmService = new JbpmService();
		}
		return jbpmService;
	}

	/**
	 * @FunName: getProcessEngine
	 * @Description: 获取工作流引擎
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-7-2
	 */
	public static ProcessEngine getProcessEngine() {
		ProcessEngine processEngine = (ProcessEngine) ApplicationContextHelper
				.getInstance().getApplicationContext().getBean("processEngine");
		processEngine.getHistoryService();
		processEngine.getIdentityService();
		processEngine.getManagementService();
		return processEngine;
	}

	/********************************** 部署流程/查询流程/删除流程 *****************************************/
	/**
	 * @FunName: deploy
	 * @Description: 部署流程定义
	 * @param path
	 *            :相对于src的路径
	 * @return:返回流程定义的id
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static String deploy(String path) {
		try {
			RepositoryService repositoryService = getProcessEngine()
					.getRepositoryService();
			String basepath = JbpmService.class.getResource("").toString();
			basepath = basepath.replace("file:/", "").split("classes")[0]
					+ "classes/";
			basepath = "";
			String id = repositoryService.createDeployment()
					.addResourceFromClasspath(basepath + path).deploy();
			return id;
		} catch (Exception e) {
		}
		return null;
	}

	/**
	 * @FunName: deploy
	 * @Description: 部署流程定义(压缩包的形式.zip)
	 * @param path
	 *            :相对于src的路径
	 * @return:返回流程定义的id
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static String deployZIP(String path) {
		try {
			RepositoryService repositoryService = getProcessEngine()
					.getRepositoryService();
			String basepath = JbpmService.class.getClass().getResource("")
					.toString();
			basepath = basepath.replace("file:/", "").split("classes")[0]
					+ "classes/";
			FileInputStream fis = new FileInputStream(new File(basepath + path));
			String id = repositoryService.createDeployment()
					.addResourcesFromZipInputStream(new ZipInputStream(fis))
					.deploy();
			return id;
		} catch (Exception e) {
		}
		return null;
	}

	/**
	 * @FunName: deploy
	 * @Description: 部署流程定义(压缩包的形式.zip)
	 * @param path
	 *            :相对于src的路径
	 * @return:返回流程定义的id
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static String deployZIP(File file) {
		try {
			RepositoryService repositoryService = getProcessEngine()
					.getRepositoryService();
			FileInputStream fis = new FileInputStream(file);
			String id = repositoryService.createDeployment()
					.addResourcesFromZipInputStream(new ZipInputStream(fis))
					.deploy();
			return id;
		} catch (Exception e) {
		}
		return null;
	}

	/**
	 * @FunName: getProcessDefinitions
	 * @Description: 获取所有的流程定义
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static List<ProcessDefinition> getProcessDefinitions() {
		RepositoryService repositoryService = getProcessEngine()
				.getRepositoryService();
		List<ProcessDefinition> processDefinitions = repositoryService
				.createProcessDefinitionQuery().orderDesc(
						ProcessDefinitionQuery.PROPERTY_VERSION).list();
		return processDefinitions;
	}

	/**
	 * @FunName: getProcessDefinitionsByKey
	 * @Description: 根据key值查找流程部署
	 * @param key
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-7-4
	 */
	public static List<ProcessDefinition> getProcessDefinitionsByKey(String key) {
		RepositoryService repositoryService = getProcessEngine()
				.getRepositoryService();
		List<ProcessDefinition> processDefinitions = repositoryService
				.createProcessDefinitionQuery().processDefinitionKey(key)
				.orderDesc(ProcessDefinitionQuery.PROPERTY_VERSION).list();
		return processDefinitions;
	}

	/**
	 * @FunName: getProcessDefinitionById
	 * @Description: 根据流程定义id获取流程定义
	 * @param pdid
	 *            :key-version的形式
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static ProcessDefinition getProcessDefinitionById(String pdid) {
		RepositoryService repositoryService = getProcessEngine()
				.getRepositoryService();
		ProcessDefinition processDefinition = repositoryService
				.createProcessDefinitionQuery().processDefinitionId(pdid)
				.uniqueResult();
		return processDefinition;
	}

	/**
	 * @FunName: getProcessDefinitionByDeploymentId
	 * @Description: 根据部署id获取流程定义
	 * @param did
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static ProcessDefinition getProcessDefinitionByDeploymentId(
			String did) {
		RepositoryService repositoryService = getProcessEngine()
				.getRepositoryService();
		ProcessDefinition processDefinition = (ProcessDefinition) repositoryService
				.createProcessDefinitionQuery().deploymentId(did)
				.uniqueResult();
		return processDefinition;
	}

	/**
	 * @FunName: deleteProcessDefinitionById
	 * @Description: 根据流程定义id删除流程定义
	 * @param pdid
	 *            -- deploymentId
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void deleteProcessDefinitionById(String pdid) {
		RepositoryService repositoryService = getProcessEngine()
				.getRepositoryService();
		repositoryService.deleteDeploymentCascade(pdid);
	}

	/*********************** 开启流程实例/查询流程实例/删除流程实例/结束流程实例/向流程实例中设置参数和获取参数 ********************/

	/**
	 * @FunName: startProcessInstance
	 * @Description: 根据流程定义name,开启一个流程实例(jpdl配置文件中的name属性)
	 * @param pdid
	 *            :流程定义name
	 * @return:返回流程实例
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static ProcessInstance startProcessInstanceByName(final String name) {
		List<ProcessDefinition> list = getProcessEngine()
				.getRepositoryService().createProcessDefinitionQuery()
				.orderDesc(ProcessDefinitionQuery.PROPERTY_VERSION).list();
		ProcessDefinition definition = null;
		for (ProcessDefinition processDefinition : list) {
			if (name.equals(processDefinition.getName())) {
				definition = processDefinition;
				break;
			}
		}
		if (definition != null) {
			final String pdid = definition.getId();
			final ProcessEngine processEngine = getProcessEngine();
			ProcessInstance processInstance = processEngine
					.execute(new Command<ProcessInstance>() {
						@Override
						public ProcessInstance execute(Environment environment)
								throws Exception {
							ProcessDefinition processDefinition = processEngine
									.getRepositoryService()
									.createProcessDefinitionQuery()
									.processDefinitionId(pdid).uniqueResult();
							return ((ProcessDefinitionImpl) processDefinition)
									.startProcessInstance();
						}
					});
			return processInstance;

		}
		return null;
	}

	/**
	 * @FunName: startProcessInstance
	 * @Description: 根据流程定义id,开启一个流程实例
	 * @param pdid
	 *            :流程定义id(key-version)
	 * @return:返回流程实例
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static ProcessInstance startProcessInstanceByPdid(final String pdid) {
		final ProcessEngine processEngine = getProcessEngine();
		ProcessInstance processInstance = processEngine
				.execute(new Command<ProcessInstance>() {

					@Override
					public ProcessInstance execute(Environment environment)
							throws Exception {
						ProcessDefinition processDefinition = processEngine
								.getRepositoryService()
								.createProcessDefinitionQuery()
								.processDefinitionId(pdid).uniqueResult();
						return ((ProcessDefinitionImpl) processDefinition)
								.startProcessInstance();
					}
				});
		return processInstance;
	}

	/**
	 * @FunName: startProcessInstanceByDeploymentId
	 * @Description: 根据部署id,开启一个流程实例
	 * @param deploymentId
	 *            :部署id
	 * @return:返回流程实例
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static ProcessInstance startProcessInstanceByDeploymentId(
			final String deploymentId) {
		final ProcessEngine processEngine = getProcessEngine();
		ProcessInstance processInstance = processEngine
				.execute(new Command<ProcessInstance>() {

					@Override
					public ProcessInstance execute(Environment environment)
							throws Exception {
						ProcessDefinition processDefinition = processEngine
								.getRepositoryService()
								.createProcessDefinitionQuery().deploymentId(
										deploymentId).uniqueResult();
						return ((ProcessDefinitionImpl) processDefinition)
								.startProcessInstance();
					}
				});
		return processInstance;
	}

	/**
	 * @FunName: getProcessInstances
	 * @Description: 获取所有的流程实例
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static List<ProcessInstance> getProcessInstances() {
		ExecutionService executionService = getProcessEngine()
				.getExecutionService();
		List<ProcessInstance> processInstances = executionService
				.createProcessInstanceQuery().list();
		return processInstances;
	}

	/**
	 * @FunName: getProcessInstanceById
	 * @Description: 根据id获取流程实例
	 * @param pid
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static ProcessInstance getProcessInstanceById(String pid) {
		ExecutionService executionService = getProcessEngine()
				.getExecutionService();
		ProcessInstance processInstance = executionService
				.findProcessInstanceById(pid);
		return processInstance;
	}

	/**
	 * @FunName: deleteProcessInstanceById
	 * @Description: 根据id删除流程实例
	 * @param pid
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void deleteProcessInstanceById(String pid) {
		ExecutionService executionService = getProcessEngine()
				.getExecutionService();
		executionService.deleteProcessInstanceCascade(pid);
	}

	/**
	 * @FunName: endProcessInstanceById
	 * @Description: 根据id结束流程实例
	 * @param pid
	 * @param state
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void endProcessInstanceById(String pid, String state) {
		ExecutionService executionService = getProcessEngine()
				.getExecutionService();
		executionService.endProcessInstance(pid, state);
	}

	/**
	 * @FunName: setProcessInstanceVariables
	 * @Description: 向流程实例里面添加参数
	 * @param pid
	 * @param map
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void setProcessInstanceVariables(String pid,
			Map<String, Object> map) {
		ExecutionService executionService = getProcessEngine()
				.getExecutionService();
		executionService.setVariables(pid, map);
	}

	/**
	 * @FunName: getProcessInstanceVariables
	 * @Description: 从流程实例里面获取参数
	 * @param pid
	 * @param set
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static Map<String, Object> getProcessInstanceVariables(String pid,
			Set<String> set) {
		ExecutionService executionService = getProcessEngine()
				.getExecutionService();
		Map<String, Object> map = executionService.getVariables(pid, set);
		return map;
	}

	/************************** 获取任务/分配任务/提交任务/删除任务 **************************/

	/**
	 * @FunName: getUserTasks
	 * @Description: 获取我的任务
	 * @param uid
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static List<Task> getUserTasks(String uid) {
		TaskService taskService = getProcessEngine().getTaskService();
		List<Task> tasks = taskService.findPersonalTasks(uid);
		return tasks;
	}

	/**
	 * @FunName: getGroupTask
	 * @Description: 获取我所在组的任务
	 * @param uid
	 * @return
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static List<Task> getGroupTask(String uid) {
		TaskService taskService = getProcessEngine().getTaskService();
		List<Task> tasks = taskService.findGroupTasks(uid);
		return tasks;
	}

	/**
	 * @FunName: assignTask
	 * @Description: 将某个任务分配给某个用户
	 * @param taskid
	 * @param uid
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void assignTask(String taskid, String uid) {
		TaskService taskService = getProcessEngine().getTaskService();
		taskService.assignTask(taskid, uid);
	}

	/**
	 * @FunName: completeTask
	 * @Description: 提交任务
	 * @param taskid
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void completeTask(String taskid) {
		TaskService taskService = getProcessEngine().getTaskService();
		taskService.completeTask(taskid);
	}

	/**
	 * @FunName: completeTask
	 * @Description: 提交任务
	 * @param taskid
	 * @param map
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void completeTask(String taskid, Map<String, Object> map) {
		TaskService taskService = getProcessEngine().getTaskService();
		taskService.setVariables(taskid, map);
		taskService.completeTask(taskid);
	}

	/**
	 * @FunName: completeTask
	 * @Description: 提交任务
	 * @param taskid
	 * @param key
	 * @param value
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void completeTask(String taskid, String key, Object value) {
		TaskService taskService = getProcessEngine().getTaskService();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(key, value);
		taskService.setVariables(taskid, map);
		taskService.completeTask(taskid);
	}

	/**
	 * @FunName:deleteTask
	 * @Description: 删除任务(级联)
	 * @param task
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void deleteTask(String task) {
		TaskService taskService = getProcessEngine().getTaskService();
		taskService.deleteTaskCascade(task);
	}

	/**
	 * @FunName: deleteTask
	 * @Description: 删除任务
	 * @param task
	 * @param reason
	 * @Author: 张震
	 * @CreateDate: 2012-6-25
	 */
	public static void deleteTask(String task, String reason) {
		TaskService taskService = getProcessEngine().getTaskService();
		taskService.deleteTask(task, reason);
	}

	// 获取当前流程运行到一步的信息
	public ActivityCoordinates getActivityCoordinates(String processInstanceId) {
		ExecutionService executionService = getProcessEngine()
				.getExecutionService();
		RepositoryService repositoryService = getProcessEngine()
				.getRepositoryService();
		ProcessInstance processInstance = executionService
				.findProcessInstanceById(processInstanceId);
		if (processInstance != null) {
			Set<String> activityNames = processInstance
					.findActiveActivityNames();
			ActivityCoordinates activityCoordinates = repositoryService
					.getActivityCoordinates(processInstance
							.getProcessDefinitionId(), activityNames.iterator()
							.next());
			return activityCoordinates;
		}
		return null;
	}
}