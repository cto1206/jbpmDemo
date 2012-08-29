/*
Navicat MySQL Data Transfer
Source Host     : localhost:3306
Source Database : myssh
Target Host     : localhost:3306
Target Database : myssh
Date: 2012-08-28 14:26:13
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for jbpm_group
-- ----------------------------
DROP TABLE IF EXISTS `jbpm_group`;
CREATE TABLE `jbpm_group` (
  `gid` varchar(255) NOT NULL,
  `name` varchar(30) default NULL,
  `type` varchar(30) default NULL,
  PRIMARY KEY  (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm_group
-- ----------------------------
INSERT INTO `jbpm_group` VALUES ('40288148396abf6a01396abf72690003', '开发部', null);
INSERT INTO `jbpm_group` VALUES ('40288148396b4fb801396b4fc0690003', '领导', null);
INSERT INTO `jbpm_group` VALUES ('40288148396bc7da01396bc7e2fd0003', '管理员', null);

-- ----------------------------
-- Table structure for jbpm_membership
-- ----------------------------
DROP TABLE IF EXISTS `jbpm_membership`;
CREATE TABLE `jbpm_membership` (
  `uid` varchar(255) NOT NULL,
  `gid` varchar(255) NOT NULL,
  PRIMARY KEY  (`gid`,`uid`),
  KEY `FK3CB34D206E3968A9` (`uid`),
  KEY `FK3CB34D2057F8DF73` (`gid`),
  CONSTRAINT `FK3CB34D2057F8DF73` FOREIGN KEY (`gid`) REFERENCES `jbpm_group` (`gid`),
  CONSTRAINT `FK3CB34D206E3968A9` FOREIGN KEY (`uid`) REFERENCES `jbpm_user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm_membership
-- ----------------------------
INSERT INTO `jbpm_membership` VALUES ('40288148396abf6a01396abf72490002', '40288148396abf6a01396abf72690003');
INSERT INTO `jbpm_membership` VALUES ('40288148396b4fb801396b4fc05a0002', '40288148396b4fb801396b4fc0690003');
INSERT INTO `jbpm_membership` VALUES ('40288148396b4fb801396b4fc0d70004', '40288148396b4fb801396b4fc0690003');
INSERT INTO `jbpm_membership` VALUES ('40288148396bc7da01396bc7e2fd0002', '40288148396bc7da01396bc7e2fd0003');

-- ----------------------------
-- Table structure for jbpm_user
-- ----------------------------
DROP TABLE IF EXISTS `jbpm_user`;
CREATE TABLE `jbpm_user` (
  `uid` varchar(255) NOT NULL,
  `name` varchar(30) default NULL,
  PRIMARY KEY  (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm_user
-- ----------------------------
INSERT INTO `jbpm_user` VALUES ('40288148396abf6a01396abf72490002', '张三');
INSERT INTO `jbpm_user` VALUES ('40288148396b4fb801396b4fc05a0002', '项目经理');
INSERT INTO `jbpm_user` VALUES ('40288148396b4fb801396b4fc0d70004', '老板');
INSERT INTO `jbpm_user` VALUES ('40288148396bc7da01396bc7e2fd0002', '系统管理员');

-- ----------------------------
-- Table structure for jbpm4_deployment
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_deployment`;
CREATE TABLE `jbpm4_deployment` (
  `DBID_` bigint(20) NOT NULL,
  `NAME_` longtext,
  `TIMESTAMP_` bigint(20) default NULL,
  `STATE_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_deployprop
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_deployprop`;
CREATE TABLE `jbpm4_deployprop` (
  `DBID_` bigint(20) NOT NULL,
  `DEPLOYMENT_` bigint(20) default NULL,
  `OBJNAME_` varchar(255) default NULL,
  `KEY_` varchar(255) default NULL,
  `STRINGVAL_` varchar(255) default NULL,
  `LONGVAL_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_DEPLPROP_DEPL` (`DEPLOYMENT_`),
  KEY `FK_DEPLPROP_DEPL` (`DEPLOYMENT_`),
  CONSTRAINT `FK_DEPLPROP_DEPL` FOREIGN KEY (`DEPLOYMENT_`) REFERENCES `jbpm4_deployment` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_deployprop
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_execution
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_execution`;
CREATE TABLE `jbpm4_execution` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ACTIVITYNAME_` varchar(255) default NULL,
  `PROCDEFID_` varchar(255) default NULL,
  `HASVARS_` bit(1) default NULL,
  `NAME_` varchar(255) default NULL,
  `KEY_` varchar(255) default NULL,
  `ID_` varchar(255) default NULL,
  `STATE_` varchar(255) default NULL,
  `SUSPHISTSTATE_` varchar(255) default NULL,
  `PRIORITY_` int(11) default NULL,
  `HISACTINST_` bigint(20) default NULL,
  `PARENT_` bigint(20) default NULL,
  `INSTANCE_` bigint(20) default NULL,
  `SUPEREXEC_` bigint(20) default NULL,
  `SUBPROCINST_` bigint(20) default NULL,
  `PARENT_IDX_` int(11) default NULL,
  PRIMARY KEY  (`DBID_`),
  UNIQUE KEY `ID_` (`ID_`),
  KEY `IDX_EXEC_SUPEREXEC` (`SUPEREXEC_`),
  KEY `IDX_EXEC_INSTANCE` (`INSTANCE_`),
  KEY `IDX_EXEC_SUBPI` (`SUBPROCINST_`),
  KEY `IDX_EXEC_PARENT` (`PARENT_`),
  KEY `FK_EXEC_PARENT` (`PARENT_`),
  KEY `FK_EXEC_SUBPI` (`SUBPROCINST_`),
  KEY `FK_EXEC_INSTANCE` (`INSTANCE_`),
  KEY `FK_EXEC_SUPEREXEC` (`SUPEREXEC_`),
  CONSTRAINT `FK_EXEC_INSTANCE` FOREIGN KEY (`INSTANCE_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_PARENT` FOREIGN KEY (`PARENT_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_SUBPI` FOREIGN KEY (`SUBPROCINST_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_SUPEREXEC` FOREIGN KEY (`SUPEREXEC_`) REFERENCES `jbpm4_execution` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_execution
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_hist_actinst
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_actinst`;
CREATE TABLE `jbpm4_hist_actinst` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `HPROCI_` bigint(20) default NULL,
  `TYPE_` varchar(255) default NULL,
  `EXECUTION_` varchar(255) default NULL,
  `ACTIVITY_NAME_` varchar(255) default NULL,
  `START_` datetime default NULL,
  `END_` datetime default NULL,
  `DURATION_` bigint(20) default NULL,
  `TRANSITION_` varchar(255) default NULL,
  `NEXTIDX_` int(11) default NULL,
  `HTASK_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_HACTI_HPROCI` (`HPROCI_`),
  KEY `IDX_HTI_HTASK` (`HTASK_`),
  KEY `FK_HACTI_HPROCI` (`HPROCI_`),
  KEY `FK_HTI_HTASK` (`HTASK_`),
  CONSTRAINT `FK_HACTI_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HTI_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_hist_actinst
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_hist_detail
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_detail`;
CREATE TABLE `jbpm4_hist_detail` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `USERID_` varchar(255) default NULL,
  `TIME_` datetime default NULL,
  `HPROCI_` bigint(20) default NULL,
  `HPROCIIDX_` int(11) default NULL,
  `HACTI_` bigint(20) default NULL,
  `HACTIIDX_` int(11) default NULL,
  `HTASK_` bigint(20) default NULL,
  `HTASKIDX_` int(11) default NULL,
  `HVAR_` bigint(20) default NULL,
  `HVARIDX_` int(11) default NULL,
  `MESSAGE_` longtext,
  `OLD_STR_` varchar(255) default NULL,
  `NEW_STR_` varchar(255) default NULL,
  `OLD_INT_` int(11) default NULL,
  `NEW_INT_` int(11) default NULL,
  `OLD_TIME_` datetime default NULL,
  `NEW_TIME_` datetime default NULL,
  `PARENT_` bigint(20) default NULL,
  `PARENT_IDX_` int(11) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_HDET_HACTI` (`HACTI_`),
  KEY `IDX_HDET_HPROCI` (`HPROCI_`),
  KEY `IDX_HDET_HVAR` (`HVAR_`),
  KEY `IDX_HDET_HTASK` (`HTASK_`),
  KEY `FK_HDETAIL_HPROCI` (`HPROCI_`),
  KEY `FK_HDETAIL_HACTI` (`HACTI_`),
  KEY `FK_HDETAIL_HTASK` (`HTASK_`),
  KEY `FK_HDETAIL_HVAR` (`HVAR_`),
  CONSTRAINT `FK_HDETAIL_HACTI` FOREIGN KEY (`HACTI_`) REFERENCES `jbpm4_hist_actinst` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HVAR` FOREIGN KEY (`HVAR_`) REFERENCES `jbpm4_hist_var` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_hist_detail
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_hist_procinst
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_procinst`;
CREATE TABLE `jbpm4_hist_procinst` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) default NULL,
  `PROCDEFID_` varchar(255) default NULL,
  `KEY_` varchar(255) default NULL,
  `START_` datetime default NULL,
  `END_` datetime default NULL,
  `DURATION_` bigint(20) default NULL,
  `STATE_` varchar(255) default NULL,
  `ENDACTIVITY_` varchar(255) default NULL,
  `NEXTIDX_` int(11) default NULL,
  PRIMARY KEY  (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_hist_procinst
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_hist_task
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_task`;
CREATE TABLE `jbpm4_hist_task` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `EXECUTION_` varchar(255) default NULL,
  `OUTCOME_` varchar(255) default NULL,
  `ASSIGNEE_` varchar(255) default NULL,
  `PRIORITY_` int(11) default NULL,
  `STATE_` varchar(255) default NULL,
  `CREATE_` datetime default NULL,
  `END_` datetime default NULL,
  `DURATION_` bigint(20) default NULL,
  `NEXTIDX_` int(11) default NULL,
  `SUPERTASK_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_HSUPERT_SUB` (`SUPERTASK_`),
  KEY `FK_HSUPERT_SUB` (`SUPERTASK_`),
  CONSTRAINT `FK_HSUPERT_SUB` FOREIGN KEY (`SUPERTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_hist_task
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_hist_var
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_var`;
CREATE TABLE `jbpm4_hist_var` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `PROCINSTID_` varchar(255) default NULL,
  `EXECUTIONID_` varchar(255) default NULL,
  `VARNAME_` varchar(255) default NULL,
  `VALUE_` varchar(255) default NULL,
  `HPROCI_` bigint(20) default NULL,
  `HTASK_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_HVAR_HPROCI` (`HPROCI_`),
  KEY `IDX_HVAR_HTASK` (`HTASK_`),
  KEY `FK_HVAR_HPROCI` (`HPROCI_`),
  KEY `FK_HVAR_HTASK` (`HTASK_`),
  CONSTRAINT `FK_HVAR_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HVAR_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_hist_var
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_id_group
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_id_group`;
CREATE TABLE `jbpm4_id_group` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) default NULL,
  `NAME_` varchar(255) default NULL,
  `TYPE_` varchar(255) default NULL,
  `PARENT_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_GROUP_PARENT` (`PARENT_`),
  KEY `FK_GROUP_PARENT` (`PARENT_`),
  CONSTRAINT `FK_GROUP_PARENT` FOREIGN KEY (`PARENT_`) REFERENCES `jbpm4_id_group` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_id_group
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_id_membership`;
CREATE TABLE `jbpm4_id_membership` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `USER_` bigint(20) default NULL,
  `GROUP_` bigint(20) default NULL,
  `NAME_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_MEM_USER` (`USER_`),
  KEY `IDX_MEM_GROUP` (`GROUP_`),
  KEY `FK_MEM_GROUP` (`GROUP_`),
  KEY `FK_MEM_USER` (`USER_`),
  CONSTRAINT `FK_MEM_GROUP` FOREIGN KEY (`GROUP_`) REFERENCES `jbpm4_id_group` (`DBID_`),
  CONSTRAINT `FK_MEM_USER` FOREIGN KEY (`USER_`) REFERENCES `jbpm4_id_user` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_id_membership
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_id_user
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_id_user`;
CREATE TABLE `jbpm4_id_user` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) default NULL,
  `PASSWORD_` varchar(255) default NULL,
  `GIVENNAME_` varchar(255) default NULL,
  `FAMILYNAME_` varchar(255) default NULL,
  `BUSINESSEMAIL_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_id_user
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_job
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_job`;
CREATE TABLE `jbpm4_job` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `DUEDATE_` datetime default NULL,
  `STATE_` varchar(255) default NULL,
  `ISEXCLUSIVE_` bit(1) default NULL,
  `LOCKOWNER_` varchar(255) default NULL,
  `LOCKEXPTIME_` datetime default NULL,
  `EXCEPTION_` longtext,
  `RETRIES_` int(11) default NULL,
  `PROCESSINSTANCE_` bigint(20) default NULL,
  `EXECUTION_` bigint(20) default NULL,
  `CFG_` bigint(20) default NULL,
  `SIGNAL_` varchar(255) default NULL,
  `EVENT_` varchar(255) default NULL,
  `REPEAT_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_JOBRETRIES` (`RETRIES_`),
  KEY `IDX_JOB_CFG` (`CFG_`),
  KEY `IDX_JOB_PRINST` (`PROCESSINSTANCE_`),
  KEY `IDX_JOB_EXE` (`EXECUTION_`),
  KEY `IDX_JOBLOCKEXP` (`LOCKEXPTIME_`),
  KEY `IDX_JOBDUEDATE` (`DUEDATE_`),
  KEY `FK_JOB_CFG` (`CFG_`),
  CONSTRAINT `FK_JOB_CFG` FOREIGN KEY (`CFG_`) REFERENCES `jbpm4_lob` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_job
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_lob
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_lob`;
CREATE TABLE `jbpm4_lob` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `BLOB_VALUE_` longblob,
  `DEPLOYMENT_` bigint(20) default NULL,
  `NAME_` longtext,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_LOB_DEPLOYMENT` (`DEPLOYMENT_`),
  KEY `FK_LOB_DEPLOYMENT` (`DEPLOYMENT_`),
  CONSTRAINT `FK_LOB_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_`) REFERENCES `jbpm4_deployment` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_lob
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_participation
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_participation`;
CREATE TABLE `jbpm4_participation` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `GROUPID_` varchar(255) default NULL,
  `USERID_` varchar(255) default NULL,
  `TYPE_` varchar(255) default NULL,
  `TASK_` bigint(20) default NULL,
  `SWIMLANE_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_PART_TASK` (`TASK_`),
  KEY `FK_PART_SWIMLANE` (`SWIMLANE_`),
  KEY `FK_PART_TASK` (`TASK_`),
  CONSTRAINT `FK_PART_SWIMLANE` FOREIGN KEY (`SWIMLANE_`) REFERENCES `jbpm4_swimlane` (`DBID_`),
  CONSTRAINT `FK_PART_TASK` FOREIGN KEY (`TASK_`) REFERENCES `jbpm4_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_participation
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_property
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_property`;
CREATE TABLE `jbpm4_property` (
  `KEY_` varchar(255) NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `VALUE_` varchar(255) default NULL,
  PRIMARY KEY  (`KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_property
-- ----------------------------
INSERT INTO `jbpm4_property` VALUES ('next.dbid', '136', '1360001');

-- ----------------------------
-- Table structure for jbpm4_swimlane
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_swimlane`;
CREATE TABLE `jbpm4_swimlane` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `NAME_` varchar(255) default NULL,
  `ASSIGNEE_` varchar(255) default NULL,
  `EXECUTION_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_SWIMLANE_EXEC` (`EXECUTION_`),
  KEY `FK_SWIMLANE_EXEC` (`EXECUTION_`),
  CONSTRAINT `FK_SWIMLANE_EXEC` FOREIGN KEY (`EXECUTION_`) REFERENCES `jbpm4_execution` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_swimlane
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_task
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_task`;
CREATE TABLE `jbpm4_task` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` char(1) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `NAME_` varchar(255) default NULL,
  `DESCR_` longtext,
  `STATE_` varchar(255) default NULL,
  `SUSPHISTSTATE_` varchar(255) default NULL,
  `ASSIGNEE_` varchar(255) default NULL,
  `FORM_` varchar(255) default NULL,
  `PRIORITY_` int(11) default NULL,
  `CREATE_` datetime default NULL,
  `DUEDATE_` datetime default NULL,
  `PROGRESS_` int(11) default NULL,
  `SIGNALLING_` bit(1) default NULL,
  `EXECUTION_ID_` varchar(255) default NULL,
  `ACTIVITY_NAME_` varchar(255) default NULL,
  `HASVARS_` bit(1) default NULL,
  `SUPERTASK_` bigint(20) default NULL,
  `EXECUTION_` bigint(20) default NULL,
  `PROCINST_` bigint(20) default NULL,
  `SWIMLANE_` bigint(20) default NULL,
  `TASKDEFNAME_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_TASK_SUPERTASK` (`SUPERTASK_`),
  KEY `FK_TASK_SWIML` (`SWIMLANE_`),
  KEY `FK_TASK_SUPERTASK` (`SUPERTASK_`),
  CONSTRAINT `FK_TASK_SUPERTASK` FOREIGN KEY (`SUPERTASK_`) REFERENCES `jbpm4_task` (`DBID_`),
  CONSTRAINT `FK_TASK_SWIML` FOREIGN KEY (`SWIMLANE_`) REFERENCES `jbpm4_swimlane` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_task
-- ----------------------------

-- ----------------------------
-- Table structure for jbpm4_variable
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_variable`;
CREATE TABLE `jbpm4_variable` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `KEY_` varchar(255) default NULL,
  `CONVERTER_` varchar(255) default NULL,
  `HIST_` bit(1) default NULL,
  `EXECUTION_` bigint(20) default NULL,
  `TASK_` bigint(20) default NULL,
  `LOB_` bigint(20) default NULL,
  `DATE_VALUE_` datetime default NULL,
  `DOUBLE_VALUE_` double default NULL,
  `CLASSNAME_` varchar(255) default NULL,
  `LONG_VALUE_` bigint(20) default NULL,
  `STRING_VALUE_` varchar(255) default NULL,
  `TEXT_VALUE_` longtext,
  `EXESYS_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_VAR_EXESYS` (`EXESYS_`),
  KEY `IDX_VAR_TASK` (`TASK_`),
  KEY `IDX_VAR_EXECUTION` (`EXECUTION_`),
  KEY `IDX_VAR_LOB` (`LOB_`),
  KEY `FK_VAR_LOB` (`LOB_`),
  KEY `FK_VAR_EXECUTION` (`EXECUTION_`),
  KEY `FK_VAR_EXESYS` (`EXESYS_`),
  KEY `FK_VAR_TASK` (`TASK_`),
  CONSTRAINT `FK_VAR_EXECUTION` FOREIGN KEY (`EXECUTION_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_VAR_EXESYS` FOREIGN KEY (`EXESYS_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_VAR_LOB` FOREIGN KEY (`LOB_`) REFERENCES `jbpm4_lob` (`DBID_`),
  CONSTRAINT `FK_VAR_TASK` FOREIGN KEY (`TASK_`) REFERENCES `jbpm4_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbpm4_variable
-- ----------------------------

-- ----------------------------
-- View structure for user_detail
-- ----------------------------
DROP VIEW IF EXISTS `user_detail`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_detail` AS select distinct `users`.`id` AS `id`,`users`.`username` AS `username`,`users`.`create_date` AS `create_date`,`users`.`last_login` AS `last_login`,`users`.`realname` AS `realname`,`users`.`group_id` AS `group_id`,`role`.`id` AS `role_id`,`role`.`role_name` AS `role_name`,`groups`.`group_name` AS `group_name`,`privlege`.`id` AS `pri_id`,`privlege`.`pri_name` AS `pri_name`,`prires`.`operate` AS `operate`,`prires`.`table_id` AS `table_id`,`tableresource`.`table_name` AS `table_name`,`tableresource`.`table_status` AS `table_status` from (((((((`tms_sec_users` `users` join `tms_sec_userrole` `userrole`) join `tms_sec_role` `role`) join `tms_sec_group` `groups`) join `tms_sec_prirole` `privrole`) join `tms_sec_privilege` `privlege`) join `tms_sec_pri_res` `prires`) join `tms_table_resource` `tableresource`) where (`role`.`id` in (select `myssh`.`tms_sec_userrole`.`role_id` AS `role_id` from `tms_sec_userrole` where ((`myssh`.`tms_sec_userrole`.`user_id` = `users`.`id`) or (`myssh`.`tms_sec_userrole`.`group_id` = `users`.`group_id`))) and (`groups`.`id` = `users`.`group_id`) and `privlege`.`id` in (select `myssh`.`tms_sec_prirole`.`pri_id` AS `pri_id` from `tms_sec_prirole` where `tms_sec_prirole`.`role_id` in (select `myssh`.`tms_sec_userrole`.`role_id` AS `role_id` from `tms_sec_userrole` where ((`myssh`.`tms_sec_userrole`.`user_id` = `users`.`id`) or (`myssh`.`tms_sec_userrole`.`group_id` = `users`.`group_id`)))) and (`prires`.`pid` = `privlege`.`id`) and (`tableresource`.`id` = `prires`.`table_id`)) order by `users`.`username`;
