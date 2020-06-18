-- MySQL dump 10.13  Distrib 5.7.27, for Win64 (x86_64)
--
-- Host: localhost    Database: auth01
-- ------------------------------------------------------
-- Server version	5.7.27-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_data_script`
--

DROP TABLE IF EXISTS `t_data_script`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_script` (
  `id` bigint(15) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_by` varchar(50) NOT NULL COMMENT 'createBy',
  `create_name` varchar(50) DEFAULT NULL,
  `create_time` datetime NOT NULL COMMENT 'createTime',
  `update_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `type` varchar(50) NOT NULL COMMENT 'type',
  `script` text NOT NULL COMMENT 'script',
  `remark` varchar(1024) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='data_script';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_data_script`
--

LOCK TABLES `t_data_script` WRITE;
/*!40000 ALTER TABLE `t_data_script` DISABLE KEYS */;
INSERT INTO `t_data_script` VALUES (1,'admin',NULL,'2020-06-12 16:57:23',NULL,NULL,NULL,'DDL','CREATE TABLE `t_eq_buy_acceptance` (\n  `id` varchar(36) NOT NULL,\n  `create_by` varchar(255) DEFAULT NULL,\n  `create_date` datetime DEFAULT NULL,\n  `create_name` varchar(255) DEFAULT NULL,\n  `sys_company_code` varchar(255) DEFAULT NULL,\n  `update_by` varchar(255) DEFAULT NULL,\n  `update_date` datetime DEFAULT NULL,\n  `update_name` varchar(255) DEFAULT NULL,\n  `buy_id` varchar(36) NOT NULL,\n  `acceptor` varchar(100) DEFAULT NULL COMMENT \'验收人\',\n  `acceptor_id` varchar(255) DEFAULT NULL COMMENT \'验收人id\',\n  `acceptance_sn` varchar(255) DEFAULT NULL COMMENT \'验收编号\',\n  `specifications` varchar(255) DEFAULT NULL COMMENT \'说明书\',\n  `specifications_amount` int(11) DEFAULT NULL COMMENT \'说明书份数\',\n  `inspection_sheet` varchar(255) DEFAULT NULL COMMENT \'检验单\',\n  `inspection_sheet_amount` int(11) DEFAULT NULL COMMENT \'检验单份数\',\n  `pictures` varchar(255) DEFAULT NULL COMMENT \'图纸资料\',\n  `pictures_amount` int(11) DEFAULT NULL COMMENT \'图纸资料份数\',\n  `attachment` varchar(255) DEFAULT NULL COMMENT \'附件\',\n  `attachment_amount` int(11) DEFAULT NULL COMMENT \'附件份数\',\n  `acceptance_date` datetime DEFAULT NULL COMMENT \'验收日期\',\n  `test_run_date` datetime DEFAULT NULL COMMENT \'试运行日期\',\n  `unpack_check_info` varchar(255) DEFAULT NULL COMMENT \'开箱验收情况\',\n  `install_quality` varchar(255) DEFAULT NULL COMMENT \'安装质量及精度\',\n  `running_status` varchar(255) DEFAULT NULL COMMENT \'运转情况\',\n  `test_run_status` varchar(255) DEFAULT NULL COMMENT \'试运行情况\',\n  PRIMARY KEY (`id`),\n  KEY `t_eq_buy_ibfk_1` (`buy_id`),\n  CONSTRAINT `t_eq_buy_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `t_eq_buy` (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8;','添加表:设备购置验收信息表',0),(2,'admin',NULL,'2020-06-12 16:57:35',NULL,NULL,NULL,'DML','INSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'5\', \'10\', \'设备购置计划审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'6\', \'60\', \'设备期间核查记录审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'7\', \'70\', \'设备购置申请审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'8\', \'80\', \'设备购置信息审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'9\', \'90\', \'设备购置信息验收结果审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'10\', \'100\', \'设备保养计划审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);','通用流程和业务绑定表 添加多条业务实体',1),(3,'admin',NULL,'2020-06-12 17:45:12',NULL,NULL,NULL,'DDL','ALTER TABLE `t_eq_inspect_plan`\nADD COLUMN `plan_depart_id`  varchar(36) NULL COMMENT \'计划部门ID\' AFTER `plan_depart`;','设备期间核查计划表,添加计划部门ID字段',0),(4,'admin',NULL,'2020-06-12 17:45:24',NULL,NULL,NULL,'DML','INSERT INTO t_s_function (ID, functioniframe, functionlevel, functionname, parentfunctionid, function_explain, functionorder, functioncode, functionurl, iconid, desk_iconid, functiontype, function_icon_style, create_by, create_name, update_by, update_date, create_date, update_name) VALUES (\'40288201726d9eea01726dace7ef0001\', null, 2, \'查看本部门项目\', \'402882016c65f1fb016c6687f3680377\', \'设置了该权限的用户，在查看综合检测项目列表能查看本部门所有检测项目\', \'22\', \'view:department:project\', \'view:department:project\', \'8a8ab0b246dc81120146dc8180460000\', \'8a8ab0b246dc81120146dc8180dd001e\', 1, \'\', \'admin\', \'管理员\', null, null, \'2020-06-01 10:19:08\', null);','查看本部门检测项目权限',0),(5,'admin','管理员','2020-06-16 16:56:42','admin','管理员','2020-06-16 17:05:54','DML','INSERT INTO t_s_function (ID, functioniframe, functionlevel, functionname, parentfunctionid, function_explain, functionorder, functioncode, functionurl, iconid, desk_iconid, functiontype, function_icon_style, create_by, create_name, update_by, update_date, create_date, update_name) VALUES (\'40288201726d9eea01726dace7ef0001\', null, 2, \'查看本部门项目\', \'402882016c65f1fb016c6687f3680377\', \'设置了该权限的用户，在查看综合检测项目列表能查看本部门所有检测项目\', \'22\', \'view:department:project\', \'view:department:project\', \'8a8ab0b246dc81120146dc8180460000\', \'8a8ab0b246dc81120146dc8180dd001e\', 1, \'\', \'admin\', \'管理员\', null, null, \'2020-06-01 10:19:08\', null);','查看本部门检测项目权限',0),(6,'admin','管理员','2020-06-16 17:02:21','admin','管理员','2020-06-17 09:16:14','DML','INSERT INTO t_s_function (ID, functioniframe, functionlevel, functionname, parentfunctionid, function_explain, functionorder, functioncode, functionurl, iconid, desk_iconid, functiontype, function_icon_style, create_by, create_name, update_by, update_date, create_date, update_name) VALUES (\'40288201726d9eea01726dace7ef0001\', null, 2, \'查看本部门项目\', \'402882016c65f1fb016c6687f3680377\', \'设置了该权限的用户，在查看综合检测项目列表能查看本部门所有检测项目\', \'22\', \'view:department:project\', \'view:department:project\', \'8a8ab0b246dc81120146dc8180460000\', \'8a8ab0b246dc81120146dc8180dd001e\', 1, \'\', \'admin\', \'管理员\', null, null, \'2020-06-01 10:19:08\', null);','查看本部门检测项目权限1',0);
/*!40000 ALTER TABLE `t_data_script` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_init_file`
--

DROP TABLE IF EXISTS `t_init_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_init_file` (
  `id` varchar(20) NOT NULL COMMENT 'id',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人',
  `config_id` varchar(50) NOT NULL COMMENT 'configId',
  `config_name` varchar(50) NOT NULL COMMENT 'configName',
  `sql_file_path` varchar(255) NOT NULL COMMENT 'sqlFilePath',
  `process_log_path` varchar(255) NOT NULL COMMENT 'errorLogPath',
  `unit_database_id` varchar(20) DEFAULT NULL COMMENT '使用该文件的单位数据库id',
  `unit_database_name` varchar(50) DEFAULT NULL COMMENT '使用该文件的单位数据库',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='t_init_file';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_init_file`
--

LOCK TABLES `t_init_file` WRITE;
/*!40000 ALTER TABLE `t_init_file` DISABLE KEYS */;
INSERT INTO `t_init_file` VALUES ('1255023949408063490','2020-04-28 14:40:01','admin',NULL,'','1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255050822322143233','2020-04-28 16:26:48','admin',NULL,'','1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255051331003138049','2020-04-28 16:28:50','admin',NULL,'','1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255052307558744066','2020-04-28 16:32:43','admin',NULL,'','1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255052432150544386','2020-04-28 16:33:12','admin',NULL,'','1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255052851484475394','2020-04-28 16:34:52','admin',NULL,'','1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255056652203409410','2020-04-28 16:49:58','admin',NULL,'','1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1258634026043985922','2020-05-08 13:45:11','admin',NULL,'','1255410152573734913','p2','E:\\fileShare\\hitek\\init.sql','E:\\fileShare\\hitek\\error.log',NULL,NULL),('1258637658508382209','2020-05-08 13:59:37','admin',NULL,'','1255406271953342466','config','E:\\fileShare\\hitek\\A03\\records\\init.sql','E:\\fileShare\\hitek\\A03\\records\\error.log',NULL,NULL),('1258656694474592257','2020-05-08 15:15:15','admin',NULL,'','1255406508507893761','p1','G:\\迅雷下载\\init.sql','G:\\迅雷下载\\error.log',NULL,NULL),('1258657259225042945','2020-05-08 15:17:30','admin',NULL,'','1255406508507893761','p1','G:\\迅雷下载\\init.sql','G:\\迅雷下载\\error.log',NULL,NULL),('1258662233187241986','2020-05-08 15:37:16','admin',NULL,'','1255406508507893761','p1','G:\\迅雷下载\\init.sql','G:\\迅雷下载\\error.log',NULL,NULL),('1258665695903969282','2020-05-08 15:51:01','admin',NULL,'','1255406508507893761','p1','G:\\迅雷下载\\1588924260816\\init.sql','G:\\迅雷下载\\1588924260816\\process.log',NULL,NULL),('1258678916467552257','2020-05-08 16:43:33','admin',NULL,NULL,'1255406508507893761','p1','G:\\迅雷下载\\1588927413053\\init.sql','G:\\迅雷下载\\1588927413053\\process.log','1258632901916073986','ilis2_kfcs'),('1259729066082304002','2020-05-11 14:16:29','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589177761295\\init.sql','G:\\ilis\\1589177761295\\process.log','1258632901916073986','ilis2_kfcs'),('1260399064459239425','2020-05-13 10:38:49','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589337509995\\init.sql','G:\\ilis\\1589337509995\\process.log','1252845307093557250','ilis_dev'),('1260401185594249218','2020-05-13 10:47:14','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589338015980\\init.sql','G:\\ilis\\1589338015980\\process.log','1252845307093557250','ilis_dev'),('1260405508751474690','2020-05-13 11:04:25','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589339049814\\init.sql','G:\\ilis\\1589339049814\\process.log','1252845307093557250','ilis_dev'),('1261101043007295490','2020-05-15 09:08:13','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589504880898\\init.sql','G:\\ilis\\1589504880898\\process.log','1252845307093557250','ilis_dev'),('1261102734804979713','2020-05-15 09:14:57','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589505232664\\init.sql','G:\\ilis\\1589505232664\\process.log','1252845307093557250','ilis_dev'),('1261104013295984642','2020-05-15 09:20:02','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589505590993\\init.sql','G:\\ilis\\1589505590993\\process.log','1252845307093557250','ilis_dev'),('1261104561462157314','2020-05-15 09:22:12','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589505721472\\init.sql','G:\\ilis\\1589505721472\\process.log','1252845307093557250','ilis_dev'),('1261104911107719169','2020-05-15 09:23:36','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589505804078\\init.sql','G:\\ilis\\1589505804078\\process.log','1252845307093557250','ilis_dev'),('1261106607925985281','2020-05-15 09:30:20','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589506196277\\init.sql','G:\\ilis\\1589506196277\\process.log','1252845307093557250','ilis_dev'),('1261117188951212034','2020-05-15 10:12:23','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589508719258\\init.sql','G:\\ilis\\1589508719258\\process.log','1252845307093557250','ilis_dev'),('1261118425440419841','2020-05-15 10:17:18','admin',NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589509014511\\init.sql','G:\\ilis\\1589509014511\\process.log','1252845307093557250','ilis_dev'),('1262212878729142273','2020-05-18 10:46:16','admin',NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589769965741\\init.sql','G:\\ilis\\1589769965741\\process.log','1261230449180729345','ilis_local'),('1262217318102147074','2020-05-18 11:03:54','admin',NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589771009942\\init.sql','G:\\ilis\\1589771009942\\process.log','1261230449180729345','ilis_local'),('1262261856229388289','2020-05-18 14:00:53','admin',NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589781640641\\init.sql','G:\\ilis\\1589781640641\\process.log','1261230449180729345','ilis_local'),('1262265334620188673','2020-05-18 14:14:42','admin',NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589782472623\\init.sql','G:\\ilis\\1589782472623\\process.log','1261230449180729345','ilis_local'),('1262277844677160962','2020-05-18 15:04:25','admin',NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589785441290\\init.sql','G:\\ilis\\1589785441290\\process.log','1261230449180729345','ilis_local'),('1267692348936249345','2020-06-02 13:39:43','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591076372038\\init.sql','G:\\ilis\\1591076372038\\process.log','1261230449180729345','ilis_local'),('1267693581700923394','2020-06-02 13:44:37','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591076659146\\init.sql','G:\\ilis\\1591076659146\\process.log','1261230449180729345','ilis_local'),('1268014065739075586','2020-06-03 10:58:06','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591153068414\\init.sql','G:\\ilis\\1591153068414\\process.log','1268013955210776577','ilis_csdw'),('1268014560310431746','2020-06-03 11:00:04','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591153183266\\init.sql','G:\\ilis\\1591153183266\\process.log','1268014450344169474','ilis_csdw1'),('1268016790711275521','2020-06-03 11:08:56','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591153718055\\init.sql','G:\\ilis\\1591153718055\\process.log','1268016060742995970','ilis_csdw3'),('1268023428901998593','2020-06-03 11:35:19','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591155300429\\init.sql','G:\\ilis\\1591155300429\\process.log','1268021213739061250','ilis_xzddw'),('1268059955732385794','2020-06-03 14:00:28','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591164009738\\init.sql','G:\\ilis\\1591164009738\\process.log','1268059880822116354','ilis_csdw'),('1268420846827040769','2020-06-04 13:54:31','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591250053181\\init.sql','G:\\ilis\\1591250053181\\process.log','1268420462200975362','ilis_csdw'),('1268449763554193409','2020-06-04 15:49:25','admin',NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591256947046\\init.sql','G:\\ilis\\1591256947046\\process.log','1268449687968641027','ilis_csdw'),('1268475673472864258','2020-06-04 17:32:22','admin',NULL,NULL,'1259683690843455490','dev','G:\\ilis\\1591263124772\\init.sql','G:\\ilis\\1591263124772\\process.log','1268475335583928321','ilis_htkjzx'),('1268476483300691969','2020-06-04 17:35:35','admin',NULL,NULL,'1259683690843455490','dev','G:\\ilis\\1591263327057\\init.sql','G:\\ilis\\1591263327057\\process.log','1268476447938514945','ilis_htfz'),('1268718610500796418','2020-06-05 09:37:43','admin',NULL,NULL,'1263747436607909890','local','G:\\ilis\\1591321034737\\init.sql','G:\\ilis\\1591321034737\\process.log','1268718459434549250','ilis_bddw'),('1268735482931691521','2020-06-05 10:44:46','admin',NULL,NULL,'1263747436607909890','local','G:\\ilis\\1591325059054\\init.sql','G:\\ilis\\1591325059054\\process.log','1268735370562093059','ilis_csdw1'),('1268735682182103041','2020-06-05 10:45:33','admin',NULL,NULL,'1263747436607909890','local','G:\\ilis\\1591325106771\\init.sql','G:\\ilis\\1591325106771\\process.log','1268732413791682563','ilis_csdw');
/*!40000 ALTER TABLE `t_init_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_main_source_profile`
--

DROP TABLE IF EXISTS `t_main_source_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_main_source_profile` (
  `id` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `create_by` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `profile_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '配置名称',
  `host` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '地址',
  `port` int(10) DEFAULT NULL COMMENT '端口',
  `username` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '密码',
  `path` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据库文件存放地址',
  `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用标记',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `source_schema` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `standard_schema` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='主数据源配置信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_main_source_profile`
--

LOCK TABLES `t_main_source_profile` WRITE;
/*!40000 ALTER TABLE `t_main_source_profile` DISABLE KEYS */;
INSERT INTO `t_main_source_profile` VALUES ('1123123',NULL,NULL,'admin','2020-04-30 11:40:56','test','127.0.0.1',3306,'root','123456','C:\\Users\\chenlm\\Desktop',0,1,NULL,NULL),('1255404978065063938','admin','2020-04-29 15:54:06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,NULL,NULL),('1255405384501530626','admin','2020-04-29 15:55:43','admin','2020-04-30 11:56:44','config','127.0.0.1',3306,'root','123456','s',0,1,NULL,NULL),('1255405908336545793','admin','2020-04-29 15:57:48','admin','2020-04-30 11:52:12','config','127.0.0.1',3306,'root','123456','n',0,1,NULL,NULL),('1255406271953342466','admin','2020-04-29 15:59:14','admin','2020-04-30 11:56:31','config','127.0.0.1',3306,'root','123456','E:\\fileShare\\hitek\\A03\\records',0,1,NULL,NULL),('1255406508507893761','admin','2020-04-29 16:00:11','admin','2020-04-30 11:52:08','p1','127.0.0.1',3306,'root','123456','G:\\迅雷下载',0,1,NULL,NULL),('1255410152573734913','admin','2020-04-29 16:14:39','admin','2020-04-30 15:45:42','p2','127.0.0.1',3306,'root','123456','E:\\fileShare\\hitek',0,1,NULL,NULL),('1255410545412247554','admin','2020-04-29 16:16:13','admin','2020-04-30 11:48:46','config','127.0.0.1',3306,'root','123456','E:\\fileShare\\hitek',0,1,NULL,NULL),('1255415115072917506','admin','2020-04-29 16:34:23','admin','2020-04-30 11:48:59','config','192.168.2.3',3306,'root','123456','',0,1,NULL,NULL),('1255415670893658113','admin','2020-04-29 16:36:35',NULL,NULL,'cnfig','192.168.2.3',3306,'root','123456','',0,1,NULL,NULL),('1255771302964469761','admin','2020-04-30 16:09:44',NULL,NULL,'2312324',NULL,NULL,NULL,NULL,NULL,0,1,NULL,NULL),('1259683690843455490','admin','2020-05-11 11:16:10','admin','2020-05-11 11:16:33','dev','192.168.2.3',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==','G:\\ilis',0,0,'ilis_test','ilis_standard'),('1261229446503043074','admin','2020-05-15 17:38:27','admin','2020-05-15 17:40:48','dev -> local','192.168.2.3',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==','G:\\ilis',0,0,'ilis_test','ilis_standard'),('1263747436607909890','admin','2020-05-22 16:24:03','admin','2020-05-27 14:14:19','local','127.0.0.1',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==','G:\\ilis',1,0,'ilis_local','ilis_local'),('1267989510396006402','admin','2020-06-03 09:20:32','admin','2020-06-03 10:44:13','新的配置','192.168.2.3',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==','E:\\迅雷下载',0,1,NULL,NULL);
/*!40000 ALTER TABLE `t_main_source_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_permission`
--

DROP TABLE IF EXISTS `t_s_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_permission` (
  `id` varchar(50) NOT NULL COMMENT 'id',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(50) DEFAULT NULL COMMENT '修改人姓名',
  `authority` varchar(50) NOT NULL COMMENT 'authority',
  `desc` varchar(255) DEFAULT NULL COMMENT 'desc',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='t_s_permission';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_permission`
--

LOCK TABLES `t_s_permission` WRITE;
/*!40000 ALTER TABLE `t_s_permission` DISABLE KEYS */;
INSERT INTO `t_s_permission` VALUES ('1',NULL,NULL,NULL,NULL,NULL,NULL,'user:info','获取用户信息');
/*!40000 ALTER TABLE `t_s_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_role`
--

DROP TABLE IF EXISTS `t_s_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_role` (
  `id` varchar(50) NOT NULL COMMENT 'id',
  `create_time` datetime COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT '' COMMENT '创建人',
  `create_name` varchar(50) DEFAULT '' COMMENT '创建人姓名',
  `update_time` datetime COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT '' COMMENT '修改人',
  `update_name` varchar(50) DEFAULT '' COMMENT '修改人姓名',
  `role_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'roleName',
  `desc` varchar(255) DEFAULT '' COMMENT 'desc',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='t_s_role';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_role`
--

LOCK TABLES `t_s_role` WRITE;
/*!40000 ALTER TABLE `t_s_role` DISABLE KEYS */;
INSERT INTO `t_s_role` VALUES ('1',NULL,'','',NULL,'','','ROLE_ADMIN','super admin');
/*!40000 ALTER TABLE `t_s_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_role_permission`
--

DROP TABLE IF EXISTS `t_s_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `permission_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_s_role_permission_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_role_permission`
--

LOCK TABLES `t_s_role_permission` WRITE;
/*!40000 ALTER TABLE `t_s_role_permission` DISABLE KEYS */;
INSERT INTO `t_s_role_permission` VALUES (1,'1','1');
/*!40000 ALTER TABLE `t_s_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_user`
--

DROP TABLE IF EXISTS `t_s_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_user` (
  `id` varchar(50) NOT NULL COMMENT 'id',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(50) DEFAULT NULL COMMENT '修改人姓名',
  `username` varchar(50) NOT NULL COMMENT 'username',
  `password` varchar(255) NOT NULL COMMENT 'password',
  `real_name` varchar(50) NOT NULL COMMENT 'realName',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'isDeleted',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_user`
--

LOCK TABLES `t_s_user` WRITE;
/*!40000 ALTER TABLE `t_s_user` DISABLE KEYS */;
INSERT INTO `t_s_user` VALUES ('1',NULL,NULL,NULL,'2020-06-18 14:38:13',NULL,NULL,'admin','$2a$10$iuWCiDhkJ/GgXro9Dnh2b.l.sokfeptK2pBYw9.gD15zPPnR1XSUu','管理员',0);
/*!40000 ALTER TABLE `t_s_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_user_role`
--

DROP TABLE IF EXISTS `t_s_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `role_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_s_user_role_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_user_role`
--

LOCK TABLES `t_s_user_role` WRITE;
/*!40000 ALTER TABLE `t_s_user_role` DISABLE KEYS */;
INSERT INTO `t_s_user_role` VALUES (1,'1','1');
/*!40000 ALTER TABLE `t_s_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_target_source_profile`
--

DROP TABLE IF EXISTS `t_target_source_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_target_source_profile` (
  `id` varchar(50) NOT NULL COMMENT 'id',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `create_by` varchar(50) NOT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人',
  `profile_name` varchar(255) DEFAULT NULL COMMENT 'profileName',
  `host` varchar(100) NOT NULL COMMENT 'host',
  `port` int(11) NOT NULL COMMENT 'port',
  `username` varchar(50) NOT NULL COMMENT 'username',
  `password` varchar(50) NOT NULL COMMENT 'password',
  `available` tinyint(1) DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL COMMENT 'isDeleted',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='t_target_source_profile';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_target_source_profile`
--

LOCK TABLES `t_target_source_profile` WRITE;
/*!40000 ALTER TABLE `t_target_source_profile` DISABLE KEYS */;
INSERT INTO `t_target_source_profile` VALUES ('12','2020-06-04 09:15:31','admin','2020-06-04 02:29:47',NULL,'insert','127.0.0.1',3306,'root','123456',0,1),('1268369201669812225','2020-06-04 10:29:17','admin','2020-06-04 02:29:17','admin','local','127.0.0.1',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==',1,0),('1268385106915209218','2020-06-04 11:32:30','admin','2020-06-04 03:32:29','admin','dev','192.168.2.3',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==',1,0);
/*!40000 ALTER TABLE `t_target_source_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_unit`
--

DROP TABLE IF EXISTS `t_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_unit` (
  `id` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `update_by` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '单位名称',
  `uniq_code` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '单位编码，使用数据源识别',
  `expire_date` datetime DEFAULT NULL COMMENT '有效截止日期',
  `max_account` int(11) DEFAULT NULL COMMENT '最大用户数',
  `max_online_account` int(11) DEFAULT NULL COMMENT '最大在线用户数',
  `is_authorized` tinyint(1) DEFAULT '0' COMMENT '是否授权',
  `authorization_code` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '授权码',
  `unit_short_name` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '单位简称',
  `target_source_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '目标数据源',
  `target_source` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='单位信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_unit`
--

LOCK TABLES `t_unit` WRITE;
/*!40000 ALTER TABLE `t_unit` DISABLE KEYS */;
INSERT INTO `t_unit` VALUES ('1261169726878621698','2020-05-15 13:41:09','admin','2020-06-04 17:16:49','admin',0,'新增单位详情','xzdwxq','2020-06-05 00:00:00',200,200,0,NULL,'新单位','1268369201669812225','local'),('1261230448220233729','2020-05-15 17:42:26','admin','2020-06-04 17:16:44','admin',0,'本地开发环境','local','2022-05-30 00:00:00',2,1,0,NULL,'本地开发','1268369201669812225','local'),('1263734403160588289','2020-05-22 15:32:15','admin',NULL,NULL,0,'重庆海特科技','hitek','2022-05-30 00:00:00',50,20,1,NULL,'重庆海特','1268385106915209218','dev');
/*!40000 ALTER TABLE `t_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_unit_database`
--

DROP TABLE IF EXISTS `t_unit_database`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_unit_database` (
  `id` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `update_by` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `unit_id` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '所属单位',
  `unit_name` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL,
  `database_name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '数据库名',
  `host` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '数据库ip',
  `database_version` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据库版本',
  `params` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '连接参数',
  `port` int(11) NOT NULL COMMENT '数据库端口',
  `database_username` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `database_pwd` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `database_type` int(20) DEFAULT NULL COMMENT '数据库类型 DatabaseType.enums',
  `is_initialized` tinyint(1) DEFAULT '0' COMMENT '是否初始化',
  `target_profile_id` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '使用初始化配置',
  `target_profile` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `data_version` bigint(20) DEFAULT NULL COMMENT '当前数据版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='单位数据库信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_unit_database`
--

LOCK TABLES `t_unit_database` WRITE;
/*!40000 ALTER TABLE `t_unit_database` DISABLE KEYS */;
INSERT INTO `t_unit_database` VALUES ('1261230449180729345','2020-05-15 17:42:26','admin','2020-05-18 10:45:24','admin',0,'1261230448220233729','本地开发环境','ilis_local','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268369201669812225','local',3),('1263734403215114242','2020-05-22 15:32:15','admin',NULL,NULL,0,'1263734403160588289','重庆海特科技','ilis_test','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268385106915209218','dev',NULL),('1263734403215114243','2020-05-22 15:32:15','admin',NULL,NULL,0,'1263734403160588289','重庆海特科技','ilis_test3','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268385106915209218','dev',NULL),('1263734403215114244','2020-05-22 15:32:15','admin',NULL,NULL,0,'1263734403160588289','重庆海特科技','ilis_test4','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268385106915209218','dev',NULL),('1263734403215114245','2020-05-22 15:32:15','admin',NULL,NULL,0,'1263734403160588289','重庆海特科技','ilis_test5','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268385106915209218','dev',NULL);
/*!40000 ALTER TABLE `t_unit_database` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-18 17:58:14
