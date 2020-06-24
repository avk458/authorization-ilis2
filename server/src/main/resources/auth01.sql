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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='data_script';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_data_script`
--

LOCK TABLES `t_data_script` WRITE;
/*!40000 ALTER TABLE `t_data_script` DISABLE KEYS */;
INSERT INTO `t_data_script` VALUES (1,'admin',NULL,'2020-06-12 16:57:23',NULL,NULL,NULL,'DDL','CREATE TABLE `t_eq_buy_acceptance` (\n  `id` varchar(36) NOT NULL,\n  `create_by` varchar(255) DEFAULT NULL,\n  `create_date` datetime DEFAULT NULL,\n  `create_name` varchar(255) DEFAULT NULL,\n  `sys_company_code` varchar(255) DEFAULT NULL,\n  `update_by` varchar(255) DEFAULT NULL,\n  `update_date` datetime DEFAULT NULL,\n  `update_name` varchar(255) DEFAULT NULL,\n  `buy_id` varchar(36) NOT NULL,\n  `acceptor` varchar(100) DEFAULT NULL COMMENT \'验收人\',\n  `acceptor_id` varchar(255) DEFAULT NULL COMMENT \'验收人id\',\n  `acceptance_sn` varchar(255) DEFAULT NULL COMMENT \'验收编号\',\n  `specifications` varchar(255) DEFAULT NULL COMMENT \'说明书\',\n  `specifications_amount` int(11) DEFAULT NULL COMMENT \'说明书份数\',\n  `inspection_sheet` varchar(255) DEFAULT NULL COMMENT \'检验单\',\n  `inspection_sheet_amount` int(11) DEFAULT NULL COMMENT \'检验单份数\',\n  `pictures` varchar(255) DEFAULT NULL COMMENT \'图纸资料\',\n  `pictures_amount` int(11) DEFAULT NULL COMMENT \'图纸资料份数\',\n  `attachment` varchar(255) DEFAULT NULL COMMENT \'附件\',\n  `attachment_amount` int(11) DEFAULT NULL COMMENT \'附件份数\',\n  `acceptance_date` datetime DEFAULT NULL COMMENT \'验收日期\',\n  `test_run_date` datetime DEFAULT NULL COMMENT \'试运行日期\',\n  `unpack_check_info` varchar(255) DEFAULT NULL COMMENT \'开箱验收情况\',\n  `install_quality` varchar(255) DEFAULT NULL COMMENT \'安装质量及精度\',\n  `running_status` varchar(255) DEFAULT NULL COMMENT \'运转情况\',\n  `test_run_status` varchar(255) DEFAULT NULL COMMENT \'试运行情况\',\n  PRIMARY KEY (`id`),\n  KEY `t_eq_buy_ibfk_1` (`buy_id`),\n  CONSTRAINT `t_eq_buy_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `t_eq_buy` (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8;','添加表:设备购置验收信息表',0),(2,'admin',NULL,'2020-06-12 16:57:35',NULL,NULL,NULL,'DML','INSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'5\', \'10\', \'设备购置计划审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'6\', \'60\', \'设备期间核查记录审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'7\', \'70\', \'设备购置申请审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'8\', \'80\', \'设备购置信息审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'9\', \'90\', \'设备购置信息验收结果审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);\nINSERT INTO `t_s_business_process` (`id`, `business_type`, `business_name`, `process_instance_key`, `process_name`, `sys_company_code`, `create_name`, `create_by`, `create_date`, `update_by`, `update_date`, `update_name`) VALUES (\'10\', \'100\', \'设备保养计划审批\', NULL, NULL, \'A03\', NULL, NULL, NULL, NULL, NULL, NULL);','通用流程和业务绑定表 添加多条业务实体',1),(3,'admin',NULL,'2020-06-12 17:45:12',NULL,NULL,NULL,'DDL','ALTER TABLE `t_eq_inspect_plan`\nADD COLUMN `plan_depart_id`  varchar(36) NULL COMMENT \'计划部门ID\' AFTER `plan_depart`;','设备期间核查计划表,添加计划部门ID字段',0),(4,'admin',NULL,'2020-06-12 17:45:24',NULL,NULL,NULL,'DML','INSERT INTO t_s_function (ID, functioniframe, functionlevel, functionname, parentfunctionid, function_explain, functionorder, functioncode, functionurl, iconid, desk_iconid, functiontype, function_icon_style, create_by, create_name, update_by, update_date, create_date, update_name) VALUES (\'40288201726d9eea01726dace7ef0001\', null, 2, \'查看本部门项目\', \'402882016c65f1fb016c6687f3680377\', \'设置了该权限的用户，在查看综合检测项目列表能查看本部门所有检测项目\', \'22\', \'view:department:project\', \'view:department:project\', \'8a8ab0b246dc81120146dc8180460000\', \'8a8ab0b246dc81120146dc8180dd001e\', 1, \'\', \'admin\', \'管理员\', null, null, \'2020-06-01 10:19:08\', null);','查看本部门检测项目权限',0),(5,'admin','管理员','2020-06-16 16:56:42','admin','管理员','2020-06-16 17:05:54','DML','INSERT INTO t_s_function (ID, functioniframe, functionlevel, functionname, parentfunctionid, function_explain, functionorder, functioncode, functionurl, iconid, desk_iconid, functiontype, function_icon_style, create_by, create_name, update_by, update_date, create_date, update_name) VALUES (\'40288201726d9eea01726dace7ef0001\', null, 2, \'查看本部门项目\', \'402882016c65f1fb016c6687f3680377\', \'设置了该权限的用户，在查看综合检测项目列表能查看本部门所有检测项目\', \'22\', \'view:department:project\', \'view:department:project\', \'8a8ab0b246dc81120146dc8180460000\', \'8a8ab0b246dc81120146dc8180dd001e\', 1, \'\', \'admin\', \'管理员\', null, null, \'2020-06-01 10:19:08\', null);','查看本部门检测项目权限',0),(6,'admin','管理员','2020-06-16 17:02:21','admin','管理员','2020-06-17 09:16:14','DML','INSERT INTO t_s_function (ID, functioniframe, functionlevel, functionname, parentfunctionid, function_explain, functionorder, functioncode, functionurl, iconid, desk_iconid, functiontype, function_icon_style, create_by, create_name, update_by, update_date, create_date, update_name) VALUES (\'40288201726d9eea01726dace7ef0001\', null, 2, \'查看本部门项目\', \'402882016c65f1fb016c6687f3680377\', \'设置了该权限的用户，在查看综合检测项目列表能查看本部门所有检测项目\', \'22\', \'view:department:project\', \'view:department:project\', \'8a8ab0b246dc81120146dc8180460000\', \'8a8ab0b246dc81120146dc8180dd001e\', 1, \'\', \'admin\', \'管理员\', null, null, \'2020-06-01 10:19:08\', null);','查看本部门检测项目权限1',0),(7,'admin','管理员','2020-06-19 11:21:47','admin','管理员','2020-06-19 11:22:21','DDL','ALTER TABLE `t_eq_scrap`\nADD COLUMN `equipment_name`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT \'设备名称\' AFTER `equipment_id`;','设备报废表 添加 设备名称字段',0);
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
  `create_name` varchar(50) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(50) DEFAULT NULL,
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
INSERT INTO `t_init_file` VALUES ('1255023949408063490','2020-04-28 14:40:01','admin',NULL,NULL,'',NULL,'1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255050822322143233','2020-04-28 16:26:48','admin',NULL,NULL,'',NULL,'1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255051331003138049','2020-04-28 16:28:50','admin',NULL,NULL,'',NULL,'1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255052307558744066','2020-04-28 16:32:43','admin',NULL,NULL,'',NULL,'1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255052432150544386','2020-04-28 16:33:12','admin',NULL,NULL,'',NULL,'1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255052851484475394','2020-04-28 16:34:52','admin',NULL,NULL,'',NULL,'1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1255056652203409410','2020-04-28 16:49:58','admin',NULL,NULL,'',NULL,'1123123','test','C:\\Users\\chenlm\\Desktop\\init.sql','C:\\Users\\chenlm\\Desktop\\error.log',NULL,NULL),('1258634026043985922','2020-05-08 13:45:11','admin',NULL,NULL,'',NULL,'1255410152573734913','p2','E:\\fileShare\\hitek\\init.sql','E:\\fileShare\\hitek\\error.log',NULL,NULL),('1258637658508382209','2020-05-08 13:59:37','admin',NULL,NULL,'',NULL,'1255406271953342466','config','E:\\fileShare\\hitek\\A03\\records\\init.sql','E:\\fileShare\\hitek\\A03\\records\\error.log',NULL,NULL),('1258656694474592257','2020-05-08 15:15:15','admin',NULL,NULL,'',NULL,'1255406508507893761','p1','G:\\迅雷下载\\init.sql','G:\\迅雷下载\\error.log',NULL,NULL),('1258657259225042945','2020-05-08 15:17:30','admin',NULL,NULL,'',NULL,'1255406508507893761','p1','G:\\迅雷下载\\init.sql','G:\\迅雷下载\\error.log',NULL,NULL),('1258662233187241986','2020-05-08 15:37:16','admin',NULL,NULL,'',NULL,'1255406508507893761','p1','G:\\迅雷下载\\init.sql','G:\\迅雷下载\\error.log',NULL,NULL),('1258665695903969282','2020-05-08 15:51:01','admin',NULL,NULL,'',NULL,'1255406508507893761','p1','G:\\迅雷下载\\1588924260816\\init.sql','G:\\迅雷下载\\1588924260816\\process.log',NULL,NULL),('1258678916467552257','2020-05-08 16:43:33','admin',NULL,NULL,NULL,NULL,'1255406508507893761','p1','G:\\迅雷下载\\1588927413053\\init.sql','G:\\迅雷下载\\1588927413053\\process.log','1258632901916073986','ilis2_kfcs'),('1259729066082304002','2020-05-11 14:16:29','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589177761295\\init.sql','G:\\ilis\\1589177761295\\process.log','1258632901916073986','ilis2_kfcs'),('1260399064459239425','2020-05-13 10:38:49','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589337509995\\init.sql','G:\\ilis\\1589337509995\\process.log','1252845307093557250','ilis_dev'),('1260401185594249218','2020-05-13 10:47:14','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589338015980\\init.sql','G:\\ilis\\1589338015980\\process.log','1252845307093557250','ilis_dev'),('1260405508751474690','2020-05-13 11:04:25','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589339049814\\init.sql','G:\\ilis\\1589339049814\\process.log','1252845307093557250','ilis_dev'),('1261101043007295490','2020-05-15 09:08:13','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589504880898\\init.sql','G:\\ilis\\1589504880898\\process.log','1252845307093557250','ilis_dev'),('1261102734804979713','2020-05-15 09:14:57','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589505232664\\init.sql','G:\\ilis\\1589505232664\\process.log','1252845307093557250','ilis_dev'),('1261104013295984642','2020-05-15 09:20:02','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589505590993\\init.sql','G:\\ilis\\1589505590993\\process.log','1252845307093557250','ilis_dev'),('1261104561462157314','2020-05-15 09:22:12','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589505721472\\init.sql','G:\\ilis\\1589505721472\\process.log','1252845307093557250','ilis_dev'),('1261104911107719169','2020-05-15 09:23:36','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589505804078\\init.sql','G:\\ilis\\1589505804078\\process.log','1252845307093557250','ilis_dev'),('1261106607925985281','2020-05-15 09:30:20','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589506196277\\init.sql','G:\\ilis\\1589506196277\\process.log','1252845307093557250','ilis_dev'),('1261117188951212034','2020-05-15 10:12:23','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589508719258\\init.sql','G:\\ilis\\1589508719258\\process.log','1252845307093557250','ilis_dev'),('1261118425440419841','2020-05-15 10:17:18','admin',NULL,NULL,NULL,NULL,'1259683690843455490','开发配置','G:\\ilis\\1589509014511\\init.sql','G:\\ilis\\1589509014511\\process.log','1252845307093557250','ilis_dev'),('1262212878729142273','2020-05-18 10:46:16','admin',NULL,NULL,NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589769965741\\init.sql','G:\\ilis\\1589769965741\\process.log','1261230449180729345','ilis_local'),('1262217318102147074','2020-05-18 11:03:54','admin',NULL,NULL,NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589771009942\\init.sql','G:\\ilis\\1589771009942\\process.log','1261230449180729345','ilis_local'),('1262261856229388289','2020-05-18 14:00:53','admin',NULL,NULL,NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589781640641\\init.sql','G:\\ilis\\1589781640641\\process.log','1261230449180729345','ilis_local'),('1262265334620188673','2020-05-18 14:14:42','admin',NULL,NULL,NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589782472623\\init.sql','G:\\ilis\\1589782472623\\process.log','1261230449180729345','ilis_local'),('1262277844677160962','2020-05-18 15:04:25','admin',NULL,NULL,NULL,NULL,'1261229446503043074','本地环境','G:\\ilis\\1589785441290\\init.sql','G:\\ilis\\1589785441290\\process.log','1261230449180729345','ilis_local'),('1267692348936249345','2020-06-02 13:39:43','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591076372038\\init.sql','G:\\ilis\\1591076372038\\process.log','1261230449180729345','ilis_local'),('1267693581700923394','2020-06-02 13:44:37','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591076659146\\init.sql','G:\\ilis\\1591076659146\\process.log','1261230449180729345','ilis_local'),('1268014065739075586','2020-06-03 10:58:06','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591153068414\\init.sql','G:\\ilis\\1591153068414\\process.log','1268013955210776577','ilis_csdw'),('1268014560310431746','2020-06-03 11:00:04','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591153183266\\init.sql','G:\\ilis\\1591153183266\\process.log','1268014450344169474','ilis_csdw1'),('1268016790711275521','2020-06-03 11:08:56','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591153718055\\init.sql','G:\\ilis\\1591153718055\\process.log','1268016060742995970','ilis_csdw3'),('1268023428901998593','2020-06-03 11:35:19','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591155300429\\init.sql','G:\\ilis\\1591155300429\\process.log','1268021213739061250','ilis_xzddw'),('1268059955732385794','2020-06-03 14:00:28','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591164009738\\init.sql','G:\\ilis\\1591164009738\\process.log','1268059880822116354','ilis_csdw'),('1268420846827040769','2020-06-04 13:54:31','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591250053181\\init.sql','G:\\ilis\\1591250053181\\process.log','1268420462200975362','ilis_csdw'),('1268449763554193409','2020-06-04 15:49:25','admin',NULL,NULL,NULL,NULL,'1261229446503043074','dev -> local','G:\\ilis\\1591256947046\\init.sql','G:\\ilis\\1591256947046\\process.log','1268449687968641027','ilis_csdw'),('1268475673472864258','2020-06-04 17:32:22','admin',NULL,NULL,NULL,NULL,'1259683690843455490','dev','G:\\ilis\\1591263124772\\init.sql','G:\\ilis\\1591263124772\\process.log','1268475335583928321','ilis_htkjzx'),('1268476483300691969','2020-06-04 17:35:35','admin',NULL,NULL,NULL,NULL,'1259683690843455490','dev','G:\\ilis\\1591263327057\\init.sql','G:\\ilis\\1591263327057\\process.log','1268476447938514945','ilis_htfz'),('1268718610500796418','2020-06-05 09:37:43','admin',NULL,NULL,NULL,NULL,'1263747436607909890','local','G:\\ilis\\1591321034737\\init.sql','G:\\ilis\\1591321034737\\process.log','1268718459434549250','ilis_bddw'),('1268735482931691521','2020-06-05 10:44:46','admin',NULL,NULL,NULL,NULL,'1263747436607909890','local','G:\\ilis\\1591325059054\\init.sql','G:\\ilis\\1591325059054\\process.log','1268735370562093059','ilis_csdw1'),('1268735682182103041','2020-06-05 10:45:33','admin',NULL,NULL,NULL,NULL,'1263747436607909890','local','G:\\ilis\\1591325106771\\init.sql','G:\\ilis\\1591325106771\\process.log','1268732413791682563','ilis_csdw');
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
  `create_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `update_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
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
INSERT INTO `t_main_source_profile` VALUES ('1123123',NULL,NULL,NULL,'admin',NULL,'2020-04-30 11:40:56','test','127.0.0.1',3306,'root','123456','C:\\Users\\chenlm\\Desktop',0,1,NULL,NULL),('1255404978065063938','admin',NULL,'2020-04-29 15:54:06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,NULL,NULL),('1255405384501530626','admin',NULL,'2020-04-29 15:55:43','admin',NULL,'2020-04-30 11:56:44','config','127.0.0.1',3306,'root','123456','s',0,1,NULL,NULL),('1255405908336545793','admin',NULL,'2020-04-29 15:57:48','admin',NULL,'2020-04-30 11:52:12','config','127.0.0.1',3306,'root','123456','n',0,1,NULL,NULL),('1255406271953342466','admin',NULL,'2020-04-29 15:59:14','admin',NULL,'2020-04-30 11:56:31','config','127.0.0.1',3306,'root','123456','E:\\fileShare\\hitek\\A03\\records',0,1,NULL,NULL),('1255406508507893761','admin',NULL,'2020-04-29 16:00:11','admin',NULL,'2020-04-30 11:52:08','p1','127.0.0.1',3306,'root','123456','G:\\迅雷下载',0,1,NULL,NULL),('1255410152573734913','admin',NULL,'2020-04-29 16:14:39','admin',NULL,'2020-04-30 15:45:42','p2','127.0.0.1',3306,'root','123456','E:\\fileShare\\hitek',0,1,NULL,NULL),('1255410545412247554','admin',NULL,'2020-04-29 16:16:13','admin',NULL,'2020-04-30 11:48:46','config','127.0.0.1',3306,'root','123456','E:\\fileShare\\hitek',0,1,NULL,NULL),('1255415115072917506','admin',NULL,'2020-04-29 16:34:23','admin',NULL,'2020-04-30 11:48:59','config','192.168.2.3',3306,'root','123456','',0,1,NULL,NULL),('1255415670893658113','admin',NULL,'2020-04-29 16:36:35',NULL,NULL,NULL,'cnfig','192.168.2.3',3306,'root','123456','',0,1,NULL,NULL),('1255771302964469761','admin',NULL,'2020-04-30 16:09:44',NULL,NULL,NULL,'2312324',NULL,NULL,NULL,NULL,NULL,0,1,NULL,NULL),('1259683690843455490','admin',NULL,'2020-05-11 11:16:10','admin',NULL,'2020-05-11 11:16:33','dev','192.168.2.3',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==','G:\\ilis',0,0,'ilis_test','ilis_standard'),('1261229446503043074','admin',NULL,'2020-05-15 17:38:27','admin',NULL,'2020-05-15 17:40:48','dev -> local','192.168.2.3',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==','G:\\ilis',0,0,'ilis_test','ilis_standard'),('1263747436607909890','admin',NULL,'2020-05-22 16:24:03','admin',NULL,'2020-05-27 14:14:19','local','127.0.0.1',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==','G:\\ilis',1,0,'ilis_local','ilis_local'),('1267989510396006402','admin',NULL,'2020-06-03 09:20:32','admin',NULL,'2020-06-03 10:44:13','新的配置','192.168.2.3',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==','E:\\迅雷下载',0,1,NULL,NULL);
/*!40000 ALTER TABLE `t_main_source_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_menu`
--

DROP TABLE IF EXISTS `t_s_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_menu` (
  `id` varchar(50) NOT NULL COMMENT 'id',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(50) DEFAULT NULL COMMENT '修改人姓名',
  `title` varchar(50) NOT NULL COMMENT 'menuName',
  `name` varchar(50) NOT NULL COMMENT 'routeName',
  `parent_id` varchar(50) DEFAULT NULL,
  `parent_title` varchar(50) DEFAULT NULL,
  `path` varchar(255) NOT NULL COMMENT 'routePath',
  `icon` varchar(50) DEFAULT NULL COMMENT 'icon',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'isDeleted',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='t_s_menu';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_menu`
--

LOCK TABLES `t_s_menu` WRITE;
/*!40000 ALTER TABLE `t_s_menu` DISABLE KEYS */;
INSERT INTO `t_s_menu` VALUES ('1275347139395166209','2020-06-23 16:37:07','admin','管理员','2020-06-23 16:48:15','admin','管理员','单位信息管理','unit_list','','','/unit/list','logo-buffer',0),('1275347297935663105','2020-06-23 16:37:45','admin','管理员',NULL,NULL,NULL,'单位用户','customer','','','/customer','md-people',0),('1275347424746250242','2020-06-23 16:38:16','admin','管理员','2020-06-23 16:39:00',NULL,NULL,'用户管理','customer_list','1275347297935663105','单位信息管理','/customer/list','md-people',0),('1275347520904863746','2020-06-23 16:38:38','admin','管理员','2020-06-23 16:39:00',NULL,NULL,'用户管理2','customer_list2','1275347297935663105','单位信息管理','/customer/list2','md-people',0),('1275347781060763650','2020-06-23 16:39:40','admin','管理员',NULL,NULL,NULL,'数据库','database','','','/database','md-analytics',0),('1275347870768537602','2020-06-23 16:40:02','admin','管理员','2020-06-23 16:52:12','admin','管理员','单位数据库信息','database_list','1275347781060763650','数据库','/database/list','md-cube',0),('1275347974699196417','2020-06-23 16:40:27','admin','管理员','2020-06-23 16:58:33','admin','管理员','单位数据管理','database_manage','1275347781060763650','数据库','/database/manage','ios-pulse',0),('1275348058086154242','2020-06-23 16:40:47','admin','管理员','2020-06-23 16:57:11','admin','管理员','数据脚本管理','database_script','1275347781060763650','数据库','/database/script','md-document',0),('1275348143104696321','2020-06-23 16:41:07','admin','管理员',NULL,NULL,NULL,'系统设置','system','','','/system','md-cog',0),('1275348222049886210','2020-06-23 16:41:26','admin','管理员','2020-06-23 17:04:41','admin','管理员','数据源配置管理','source_config','1275348143104696321','系统设置','/source/config','ios-cloud',0),('1275348306518974466','2020-06-23 16:41:46','admin','管理员',NULL,NULL,NULL,'初始化文件管理','init_file','1275348143104696321','系统设置','/init-file','md-albums',0),('1275348427092631554','2020-06-23 16:42:15','admin','管理员','2020-06-24 14:20:44','admin','管理员','系统用户','user_manage','1275348143104696321','系统设置','/user-manage','md-body',0),('1275348515542114306','2020-06-23 16:42:36','admin','管理员','2020-06-24 14:17:44','admin','管理员','角色管理','role_manage','1275348143104696321','系统设置','/role-manage','md-person-add',0),('1275348602544562177','2020-06-23 16:42:56','admin','管理员',NULL,NULL,NULL,'菜单管理','menu_manage','1275348143104696321','系统设置','/menu-manage','md-apps',0);
/*!40000 ALTER TABLE `t_s_menu` ENABLE KEYS */;
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
  `menu_id` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT 'desc',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='t_s_permission';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_permission`
--

LOCK TABLES `t_s_permission` WRITE;
/*!40000 ALTER TABLE `t_s_permission` DISABLE KEYS */;
INSERT INTO `t_s_permission` VALUES ('1275349939688677377','2020-06-23 16:48:15','admin','管理员',NULL,NULL,NULL,'unit:add','1275347139395166209','增加单位信息'),('1275349939688677378','2020-06-23 16:48:15','admin','管理员',NULL,NULL,NULL,'unit:update','1275347139395166209','编辑单位信息'),('1275349939688677379','2020-06-23 16:48:15','admin','管理员',NULL,NULL,NULL,'unit:del','1275347139395166209','删除单位信息'),('1275350931171811329','2020-06-23 16:52:12','admin','管理员',NULL,NULL,NULL,'database:add','1275347870768537602','增加单位数据库信息'),('1275350931171811330','2020-06-23 16:52:12','admin','管理员',NULL,NULL,NULL,'database:update','1275347870768537602','编辑单位数据库信息'),('1275350931171811331','2020-06-23 16:52:12','admin','管理员',NULL,NULL,NULL,'database:del','1275347870768537602','删除单位数据库信息'),('1275350931171811332','2020-06-23 16:52:12','admin','管理员',NULL,NULL,NULL,'database:init','1275347870768537602','初始化单位数据库'),('1275350931171811333','2020-06-23 16:52:12','admin','管理员',NULL,NULL,NULL,'database:active','1275347870768537602','设置单位数据库启用状态'),('1275351237205008385','2020-06-23 16:53:24','admin','管理员',NULL,NULL,NULL,'database:sync','1275347974699196417','同步单位数据库表结构'),('1275352189072941057','2020-06-23 16:57:11','admin','管理员',NULL,NULL,NULL,'script:add','1275348058086154242','添加数据库脚本'),('1275352189072941058','2020-06-23 16:57:11','admin','管理员',NULL,NULL,NULL,'script:update','1275348058086154242','编辑数据库脚本'),('1275352189072941059','2020-06-23 16:57:11','admin','管理员',NULL,NULL,NULL,'script:del','1275348058086154242','删除数据库脚本'),('1275352189072941060','2020-06-23 16:57:11','admin','管理员',NULL,NULL,NULL,'script:export','1275348058086154242','导出数据库脚本'),('1275352189072941061','2020-06-23 16:57:11','admin','管理员',NULL,NULL,NULL,'script:upload','1275348058086154242','上传数据库脚本'),('1275352530514452481','2020-06-23 16:58:33','admin','管理员',NULL,NULL,NULL,'database:update','1275347974699196417','根据数据库脚本升级所选数据库'),('1275354074450337793','2020-06-23 17:04:41','admin','管理员',NULL,NULL,NULL,'profile:main:add','1275348222049886210','新增主数据源配置信息'),('1275354074450337794','2020-06-23 17:04:41','admin','管理员',NULL,NULL,NULL,'profile:main:update','1275348222049886210','编辑主数据源配置信息'),('1275354074450337795','2020-06-23 17:04:41','admin','管理员',NULL,NULL,NULL,'profile:main:del','1275348222049886210','删除主数据源配置信息'),('1275354074450337796','2020-06-23 17:04:41','admin','管理员',NULL,NULL,NULL,'profile:main:active','1275348222049886210','设置主数据源配置启用状态'),('1275354074450337797','2020-06-23 17:04:41','admin','管理员',NULL,NULL,NULL,'profile:target:add','1275348222049886210','新增目标数据源配置信息'),('1275354074450337798','2020-06-23 17:04:41','admin','管理员',NULL,NULL,NULL,'profile:target:update','1275348222049886210','编辑目标数据源配置信息'),('1275354074450337799','2020-06-23 17:04:41','admin','管理员',NULL,NULL,NULL,'prifile:target:del','1275348222049886210','删除目标数据源配置信息'),('1275673932710862850','2020-06-24 14:15:41','admin','管理员',NULL,NULL,NULL,'menu:add','1275348602544562177','新增菜单'),('1275673932710862851','2020-06-24 14:15:41','admin','管理员',NULL,NULL,NULL,'menu:update','1275348602544562177','编辑菜单'),('1275673932731834370','2020-06-24 14:15:41','admin','管理员',NULL,NULL,NULL,'menu:del','1275348602544562177','删除菜单'),('1275674448048218113','2020-06-24 14:17:44','admin','管理员',NULL,NULL,NULL,'role:add','1275348515542114306','新增角色'),('1275674448048218114','2020-06-24 14:17:44','admin','管理员',NULL,NULL,NULL,'role:update','1275348515542114306','编辑角色'),('1275674448048218115','2020-06-24 14:17:44','admin','管理员',NULL,NULL,NULL,'role:del','1275348515542114306','删除角色'),('1275674448048218116','2020-06-24 14:17:44','admin','管理员',NULL,NULL,NULL,'role:active','1275348515542114306','更改角色启用状态'),('1275674448048218117','2020-06-24 14:17:44','admin','管理员',NULL,NULL,NULL,'role:perm','1275348515542114306','更改角色关联权限'),('1275675204251869186','2020-06-24 14:20:44','admin','管理员',NULL,NULL,NULL,'user:add','1275348427092631554','新增用户'),('1275675204251869187','2020-06-24 14:20:44','admin','管理员',NULL,NULL,NULL,'user:update','1275348427092631554','编辑用户'),('1275675204251869188','2020-06-24 14:20:44','admin','管理员',NULL,NULL,NULL,'user:del','1275348427092631554','删除用户'),('1275675204251869189','2020-06-24 14:20:44','admin','管理员',NULL,NULL,NULL,'user:active','1275348427092631554','更改用户启用状态'),('1275675204318978050','2020-06-24 14:20:44','admin','管理员',NULL,NULL,NULL,'user:role','1275348427092631554','设置用户关联角色');
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
  `create_by` varchar(50) COMMENT '创建人',
  `create_name` varchar(50) COMMENT '创建人姓名',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(50) COMMENT '修改人姓名',
  `role` varchar(50) NOT NULL,
  `role_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'roleName',
  `description` varchar(255) DEFAULT '' COMMENT 'desc',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='t_s_role';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_role`
--

LOCK TABLES `t_s_role` WRITE;
/*!40000 ALTER TABLE `t_s_role` DISABLE KEYS */;
INSERT INTO `t_s_role` VALUES ('1','2020-06-22 15:58:03','','管理员','2020-06-23 17:23:21','','','ROLE_ADMIN','管理员','super admin',1,0),('1275358848591609857','2020-06-22 15:58:03','','管理员',NULL,'','','ROLE_DEV','开发','开发人员角色',1,0),('1275358942535630849','2020-06-22 15:58:03','','管理员','2020-06-23 17:31:00','','','ROLE_OPS','运维','运维人员',1,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_role_permission`
--

LOCK TABLES `t_s_role_permission` WRITE;
/*!40000 ALTER TABLE `t_s_role_permission` DISABLE KEYS */;
INSERT INTO `t_s_role_permission` VALUES (24,'1275358848591609857','1275351237205008385'),(25,'1275358848591609857','1275352189072941057'),(26,'1275358848591609857','1275352189072941058'),(27,'1275358848591609857','1275352189072941059'),(28,'1275358848591609857','1275352189072941060'),(29,'1275358848591609857','1275352189072941061'),(30,'1275358848591609857','1275352530514452481'),(74,'1275358942535630849','1275349939688677377'),(75,'1275358942535630849','1275349939688677378'),(76,'1275358942535630849','1275350931171811329'),(77,'1275358942535630849','1275350931171811330'),(78,'1275358942535630849','1275350931171811331'),(79,'1275358942535630849','1275350931171811332'),(80,'1275358942535630849','1275350931171811333'),(81,'1275358942535630849','1275352530514452481'),(82,'1275358942535630849','1275354074450337793'),(83,'1275358942535630849','1275354074450337794'),(84,'1275358942535630849','1275354074450337795'),(85,'1275358942535630849','1275354074450337796'),(86,'1275358942535630849','1275354074450337797'),(87,'1275358942535630849','1275354074450337798'),(88,'1275358942535630849','1275354074450337799'),(124,'1','1275349939688677377'),(125,'1','1275349939688677378'),(126,'1','1275349939688677379'),(127,'1','1275350931171811329'),(128,'1','1275350931171811330'),(129,'1','1275350931171811331'),(130,'1','1275350931171811332'),(131,'1','1275350931171811333'),(132,'1','1275351237205008385'),(133,'1','1275352189072941057'),(134,'1','1275352189072941058'),(135,'1','1275352189072941059'),(136,'1','1275352189072941060'),(137,'1','1275352189072941061'),(138,'1','1275352530514452481'),(139,'1','1275354074450337793'),(140,'1','1275354074450337794'),(141,'1','1275354074450337795'),(142,'1','1275354074450337796'),(143,'1','1275354074450337797'),(144,'1','1275354074450337798'),(145,'1','1275354074450337799'),(146,'1','1275673932710862850'),(147,'1','1275673932710862851'),(148,'1','1275673932731834370'),(149,'1','1275674448048218113'),(150,'1','1275674448048218114'),(151,'1','1275674448048218115'),(152,'1','1275674448048218116'),(153,'1','1275674448048218117'),(154,'1','1275675204251869186'),(155,'1','1275675204251869187'),(156,'1','1275675204251869188'),(157,'1','1275675204251869189'),(158,'1','1275675204318978050');
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
  `avatar` varchar(500) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'isDeleted',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_user`
--

LOCK TABLES `t_s_user` WRITE;
/*!40000 ALTER TABLE `t_s_user` DISABLE KEYS */;
INSERT INTO `t_s_user` VALUES ('1',NULL,NULL,NULL,'2020-06-22 14:19:49','admin','管理员','admin','$2a$10$zrdz3RiY/9LIHX4cYV5JgObS0s2RN/j99hixuWyJ9JHwUhKD/.rW.','管理员','https://i.loli.net/2020/05/13/dzGrXugK6pCqncN.png',1,0),('1274914957220380673','2020-06-22 11:59:47','admin','管理员','2020-06-24 16:24:21','admin','管理员','test','$2a$10$IblNZWXVAR84YIIJlaOnpO3dbuec4euLD4W8QKInNjEbcbegXkszW','测试用户','',1,1),('1274962370069008385','2020-06-22 15:08:11','admin','管理员','2020-06-24 16:24:23',NULL,NULL,'foobar','$2a$10$UDsDB0fjyZBQOF/HdH.7/u6zSYOiVXU/L7AFZtkfZ2V07RV0ooTBO','Foobar','https://i.loli.net/2017/08/21/599a521472424.jpg',1,1),('1275006660136685569','2020-06-22 18:04:11','admin','管理员','2020-06-24 14:05:54','admin','管理员','chenlm','$2a$10$RUrV02bfTowV/Wmul0Zlj.BVC1.SpA8WrKlI9wEymtYXQ1FeC02di','敏帅','https://i.loli.net/2017/08/21/599a521472424.jpg',1,0),('1275707502221365250','2020-06-24 16:29:05','admin','管理员',NULL,NULL,NULL,'lilf','$2a$10$brg6o.2c0AGBLtz9F809EebJ1RDvu6szk4cDr1qePcanKKzeUeJ1S','李立峰','https://i.loli.net/2017/08/21/599a521472424.jpg',1,0),('1275707587873247233','2020-06-24 16:29:25','admin','管理员',NULL,NULL,NULL,'tanghh','$2a$10$.dKlnWY50BTXmcIuNi2Q9eke/ZRLEGRU.BsWCg1iUzqxyBfogytRC','唐珲鸿','https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',1,0),('1275707970913865729','2020-06-24 16:30:56','admin','管理员',NULL,NULL,NULL,'zengxb','$2a$10$6RSmC6VTEKiIghNnlL4ItuHb9ffAcPIZj/6JKSz4l3aPZHOWaIAwq','曾小兵','https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',1,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_user_role`
--

LOCK TABLES `t_s_user_role` WRITE;
/*!40000 ALTER TABLE `t_s_user_role` DISABLE KEYS */;
INSERT INTO `t_s_user_role` VALUES (5,'1275006660136685569','1275358848591609857'),(6,'1','1'),(8,'1275707502221365250','1275358848591609857'),(9,'1275707587873247233','1275358848591609857'),(10,'1275707970913865729','1');
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
  `create_name` varchar(50) DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(50) DEFAULT NULL,
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
INSERT INTO `t_target_source_profile` VALUES ('12','2020-06-04 09:15:31','admin',NULL,'2020-06-04 02:29:47',NULL,NULL,'insert','127.0.0.1',3306,'root','123456',0,1),('1268369201669812225','2020-06-04 10:29:17','admin',NULL,'2020-06-04 02:29:17','admin',NULL,'local','127.0.0.1',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==',1,0),('1268385106915209218','2020-06-04 11:32:30','admin',NULL,'2020-06-04 03:32:29','admin',NULL,'dev','192.168.2.3',3306,'root','RzSds5mCFkrQU9fO+jJfMQ==',1,0);
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
  `create_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `update_by` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
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
INSERT INTO `t_unit` VALUES ('1261169726878621698','2020-05-15 13:41:09','admin',NULL,'2020-06-04 17:16:49','admin',NULL,0,'新增单位详情','xzdwxq','2020-06-05 00:00:00',200,200,0,NULL,'新单位','1268369201669812225','local'),('1261230448220233729','2020-05-15 17:42:26','admin',NULL,'2020-06-24 14:41:23','admin','管理员',0,'本地开发环境','local','2022-05-30 00:00:00',2,1,0,NULL,'本地开发','1268369201669812225','local'),('1263734403160588289','2020-05-22 15:32:15','admin',NULL,NULL,NULL,NULL,0,'重庆海特科技','hitek','2022-05-30 00:00:00',50,20,1,NULL,'重庆海特','1268385106915209218','dev');
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
  `create_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `update_by` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
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
INSERT INTO `t_unit_database` VALUES ('1261230449180729345','2020-05-15 17:42:26','admin',NULL,'2020-05-18 10:45:24','admin',NULL,0,'1261230448220233729','本地开发环境','ilis_local','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268369201669812225','local',3),('1263734403215114242','2020-05-22 15:32:15','admin',NULL,NULL,NULL,NULL,0,'1263734403160588289','重庆海特科技','ilis_test','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268385106915209218','dev',NULL),('1263734403215114243','2020-05-22 15:32:15','admin',NULL,NULL,NULL,NULL,0,'1263734403160588289','重庆海特科技','ilis_test3','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268385106915209218','dev',NULL),('1263734403215114244','2020-05-22 15:32:15','admin',NULL,NULL,NULL,NULL,0,'1263734403160588289','重庆海特科技','ilis_test4','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268385106915209218','dev',NULL),('1263734403215114245','2020-05-22 15:32:15','admin',NULL,NULL,NULL,NULL,0,'1263734403160588289','重庆海特科技','ilis_test5','127.0.0.1','5.7','?characterEncoding=utf8&serverTimezone=Asia/Shanghai',3306,'1dmoEbaeVoJeDrkMtO4EeQ==','RzSds5mCFkrQU9fO+jJfMQ==',211,1,'1268385106915209218','dev',NULL);
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

-- Dump completed on 2020-06-24 18:01:36
