-- MySQL dump 10.13  Distrib 5.7.27, for Win64 (x86_64)
--
-- Host: 192.168.2.3    Database: ilis_test
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `act_evt_log`
--

DROP TABLE IF EXISTS `act_evt_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_ge_bytearray`
--

DROP TABLE IF EXISTS `act_ge_bytearray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`) USING BTREE,
  CONSTRAINT `act_ge_bytearray_ibfk_1` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_ge_property`
--

DROP TABLE IF EXISTS `act_ge_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_hi_actinst`
--

DROP TABLE IF EXISTS `act_hi_actinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`) USING BTREE,
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`) USING BTREE,
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_hi_attachment`
--

DROP TABLE IF EXISTS `act_hi_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_hi_comment`
--

DROP TABLE IF EXISTS `act_hi_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_hi_detail`
--

DROP TABLE IF EXISTS `act_hi_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`) USING BTREE,
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_hi_identitylink`
--

DROP TABLE IF EXISTS `act_hi_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_hi_procinst`
--

DROP TABLE IF EXISTS `act_hi_procinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`) USING BTREE,
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_hi_taskinst`
--

DROP TABLE IF EXISTS `act_hi_taskinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_TASK_INST_ASSIGNEE` (`ASSIGNEE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_hi_varinst`
--

DROP TABLE IF EXISTS `act_hi_varinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`) USING BTREE,
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_id_group`
--

DROP TABLE IF EXISTS `act_id_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_id_info`
--

DROP TABLE IF EXISTS `act_id_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_id_membership`
--

DROP TABLE IF EXISTS `act_id_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`) USING BTREE,
  CONSTRAINT `act_id_membership_ibfk_1` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `act_id_membership_ibfk_2` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_id_user`
--

DROP TABLE IF EXISTS `act_id_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_procdef_info`
--

DROP TABLE IF EXISTS `act_procdef_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`) USING BTREE,
  CONSTRAINT `act_procdef_info_ibfk_1` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `act_procdef_info_ibfk_2` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_re_deployment`
--

DROP TABLE IF EXISTS `act_re_deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_re_model`
--

DROP TABLE IF EXISTS `act_re_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`) USING BTREE,
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) USING BTREE,
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`) USING BTREE,
  CONSTRAINT `act_re_model_ibfk_1` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `act_re_model_ibfk_2` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `act_re_model_ibfk_3` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_re_procdef`
--

DROP TABLE IF EXISTS `act_re_procdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_ru_event_subscr`
--

DROP TABLE IF EXISTS `act_ru_event_subscr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_ru_execution`
--

DROP TABLE IF EXISTS `act_ru_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`) USING BTREE,
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`) USING BTREE,
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`) USING BTREE,
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `act_ru_execution_ibfk_1` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `act_ru_execution_ibfk_2` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `act_ru_execution_ibfk_3` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `act_ru_execution_ibfk_4` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_ru_identitylink`
--

DROP TABLE IF EXISTS `act_ru_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`) USING BTREE,
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`) USING BTREE,
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`) USING BTREE,
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`) USING BTREE,
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  CONSTRAINT `act_ru_identitylink_ibfk_1` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `act_ru_identitylink_ibfk_2` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `act_ru_identitylink_ibfk_3` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_ru_job`
--

DROP TABLE IF EXISTS `act_ru_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`) USING BTREE,
  CONSTRAINT `act_ru_job_ibfk_1` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_ru_task`
--

DROP TABLE IF EXISTS `act_ru_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(1024) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`) USING BTREE,
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`) USING BTREE,
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
  CONSTRAINT `act_ru_task_ibfk_1` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `act_ru_task_ibfk_2` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `act_ru_task_ibfk_3` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `act_ru_variable`
--

DROP TABLE IF EXISTS `act_ru_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`) USING BTREE,
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`) USING BTREE,
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`) USING BTREE,
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`) USING BTREE,
  CONSTRAINT `act_ru_variable_ibfk_1` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `act_ru_variable_ibfk_2` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `act_ru_variable_ibfk_3` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activemq_acks`
--

DROP TABLE IF EXISTS `activemq_acks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activemq_acks` (
  `CONTAINER` varchar(250) NOT NULL,
  `SUB_DEST` varchar(250) DEFAULT NULL,
  `CLIENT_ID` varchar(250) NOT NULL,
  `SUB_NAME` varchar(250) NOT NULL,
  `SELECTOR` varchar(250) DEFAULT NULL,
  `LAST_ACKED_ID` bigint(20) DEFAULT NULL,
  `PRIORITY` bigint(20) NOT NULL DEFAULT '5',
  `XID` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`CONTAINER`,`CLIENT_ID`,`SUB_NAME`,`PRIORITY`),
  KEY `ACTIVEMQ_ACKS_XIDX` (`XID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activemq_lock`
--

DROP TABLE IF EXISTS `activemq_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activemq_lock` (
  `ID` bigint(20) NOT NULL,
  `TIME` bigint(20) DEFAULT NULL,
  `BROKER_NAME` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activemq_msgs`
--

DROP TABLE IF EXISTS `activemq_msgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activemq_msgs` (
  `ID` bigint(20) NOT NULL,
  `CONTAINER` varchar(250) NOT NULL,
  `MSGID_PROD` varchar(250) DEFAULT NULL,
  `MSGID_SEQ` bigint(20) DEFAULT NULL,
  `EXPIRATION` bigint(20) DEFAULT NULL,
  `MSG` longblob,
  `PRIORITY` bigint(20) DEFAULT NULL,
  `XID` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ACTIVEMQ_MSGS_MIDX` (`MSGID_PROD`,`MSGID_SEQ`),
  KEY `ACTIVEMQ_MSGS_CIDX` (`CONTAINER`),
  KEY `ACTIVEMQ_MSGS_EIDX` (`EXPIRATION`),
  KEY `ACTIVEMQ_MSGS_PIDX` (`PRIORITY`),
  KEY `ACTIVEMQ_MSGS_XIDX` (`XID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_gather_attachment`
--

DROP TABLE IF EXISTS `data_gather_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_gather_attachment` (
  `id` varchar(36) NOT NULL,
  `object_id` varchar(36) DEFAULT NULL COMMENT '主id',
  `name` varchar(500) DEFAULT NULL COMMENT '附件名称',
  `attachment_id` varchar(50) DEFAULT NULL COMMENT '通用附件id',
  `url` varchar(500) DEFAULT NULL COMMENT 'url',
  `is_delete` char(2) NOT NULL COMMENT '删除标记:0:未删除,1:已删除',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据采集附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_gather_test_digital`
--

DROP TABLE IF EXISTS `data_gather_test_digital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_gather_test_digital` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `is_report` char(2) NOT NULL DEFAULT '0' COMMENT '是否已出报告 0-未出 1-已出',
  `company_code` varchar(50) DEFAULT NULL COMMENT '公司编码',
  `until_code` varchar(50) DEFAULT NULL COMMENT '单位编码',
  `yangpbh` varchar(100) DEFAULT NULL COMMENT '样品编号',
  `sbbianhao` varchar(100) DEFAULT NULL COMMENT '设备编号',
  `sbmingcheng` varchar(100) DEFAULT NULL COMMENT '设备名称',
  `gongcbw` varchar(200) DEFAULT NULL COMMENT '工程部位',
  `jcshijian` datetime DEFAULT NULL COMMENT '检测时间',
  `xUnit` varchar(50) DEFAULT NULL COMMENT '单试块力值曲线的X轴名称',
  `yUnit` varchar(50) DEFAULT NULL COMMENT '单试块力值曲线的Y轴名称',
  `dots` varchar(1000) DEFAULT NULL COMMENT '单试块的力学曲线数据',
  `uuid` varchar(100) DEFAULT NULL COMMENT '一组试验的唯一标识',
  `test_type_code` varchar(50) DEFAULT NULL COMMENT '试验类型code',
  `test_type` varchar(50) DEFAULT NULL COMMENT '试验类型',
  `task_id` varchar(50) DEFAULT NULL COMMENT '采集数据的任务id',
  `json_data` varchar(5000) DEFAULT NULL COMMENT '其他数据json格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据采集力学试验数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_gather_test_filed`
--

DROP TABLE IF EXISTS `data_gather_test_filed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_gather_test_filed` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `test_type_code` varchar(20) DEFAULT NULL COMMENT '试验类型值',
  `test_type` varchar(100) DEFAULT NULL COMMENT '试验类型',
  `test_type_id` varchar(36) DEFAULT NULL COMMENT '试验类型id',
  `order_num` int(4) DEFAULT NULL COMMENT '字段排序',
  `filed_name` varchar(100) DEFAULT NULL COMMENT '字段名',
  `filed_chinese_name` varchar(100) DEFAULT NULL COMMENT '字段中文名',
  `is_show` varchar(2) DEFAULT NULL COMMENT '前端是否展示字段 0-展示 1-不展示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据采集试验字段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_gather_test_site`
--

DROP TABLE IF EXISTS `data_gather_test_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_gather_test_site` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `yangpbh` varchar(100) DEFAULT NULL COMMENT '样品编号',
  `sbbianhao` varchar(100) DEFAULT NULL COMMENT '设备编号',
  `sbmingcheng` varchar(100) DEFAULT NULL COMMENT '设备名称',
  `gongcbw` varchar(200) DEFAULT NULL COMMENT '工程部位',
  `upload_time` datetime DEFAULT NULL COMMENT '上传时间',
  `uuid` varchar(50) DEFAULT NULL COMMENT '唯一标识',
  `test_type_code` varchar(50) DEFAULT NULL COMMENT '试验类型code',
  `test_type` varchar(50) DEFAULT NULL COMMENT '试验类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据采集现场试验表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_archive`
--

DROP TABLE IF EXISTS `t_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_archive` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `report_id` varchar(36) NOT NULL COMMENT '报告id',
  `archive_sn` varchar(255) NOT NULL COMMENT '档案编号',
  `archive_type` varchar(255) NOT NULL COMMENT '档案类型( 0:用户自定义, 1:报告, 2:委托, 3:记录, 4:任务)',
  `related_object_id` varchar(36) DEFAULT NULL COMMENT '关联的对象id,主要是委托/任务/记录/报告的对象id,用户自定义类型没得id',
  `related_object_sn` varchar(255) DEFAULT NULL COMMENT '关联对象编码',
  `user_archive_title` varchar(255) DEFAULT NULL COMMENT '用户自定义归档文件的名称',
  `save_type` varchar(20) NOT NULL COMMENT '存放类型: 0:统一存放, 1:分开存放',
  `archive_site_id` varchar(36) NOT NULL COMMENT '归档地址,关联archive_site表的id',
  `archive_person_name` varchar(255) NOT NULL COMMENT '归档人员姓名(可以是手动填写的)',
  `archive_person_id` varchar(36) DEFAULT NULL COMMENT '归档人员id(归档人员是从系统选的时就有id)',
  `archive_date` datetime NOT NULL COMMENT '归档日期',
  `remark` varchar(255) DEFAULT NULL COMMENT '归档备注(预留字段)',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料归档记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_archive_material`
--

DROP TABLE IF EXISTS `t_archive_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_archive_material` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(255) DEFAULT NULL COMMENT '归档资料名称',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `is_delete` varchar(5) NOT NULL DEFAULT '0' COMMENT '是否删除 0:否, 1:是',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告归档资料';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_archive_site`
--

DROP TABLE IF EXISTS `t_archive_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_archive_site` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(255) DEFAULT NULL COMMENT '归档地址名称',
  `site` varchar(512) NOT NULL COMMENT '归档地点',
  `remark` varchar(512) DEFAULT NULL COMMENT '归档地址描述',
  `is_delete` varchar(5) NOT NULL DEFAULT '0' COMMENT '是否已废弃 0:否, 1:是',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_attachment`
--

DROP TABLE IF EXISTS `t_bidding_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_attachment` (
  `id` varchar(36) NOT NULL,
  `folder_id` varchar(36) DEFAULT NULL COMMENT '目录id',
  `object_id` varchar(36) DEFAULT NULL COMMENT '主id',
  `name` varchar(500) DEFAULT NULL COMMENT '附件名称',
  `attachment_id` varchar(36) DEFAULT NULL COMMENT '通用附件id',
  `url` varchar(500) DEFAULT NULL COMMENT 'url',
  `is_delete` char(2) NOT NULL COMMENT '删除标记:0:未删除,1:已删除',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_customize_column`
--

DROP TABLE IF EXISTS `t_bidding_customize_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_customize_column` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `column_index` int(10) DEFAULT NULL COMMENT '字段序号',
  `column_name` varchar(100) DEFAULT NULL COMMENT '字段名称',
  `column_type` varchar(50) DEFAULT NULL COMMENT '字段类型',
  `customize_type` varchar(50) DEFAULT NULL COMMENT '自定义类型 performance-业绩自定义字段 person-人员自定义字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标自定义字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_customize_value`
--

DROP TABLE IF EXISTS `t_bidding_customize_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_customize_value` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `custom_column_id` varchar(36) DEFAULT NULL COMMENT '自定义字段id',
  `custom_column_value` varchar(100) DEFAULT NULL COMMENT '值',
  `object_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标自定义值';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_folder`
--

DROP TABLE IF EXISTS `t_bidding_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_folder` (
  `id` varchar(36) NOT NULL,
  `folder_type` varchar(50) DEFAULT NULL COMMENT '类型 performance-业绩',
  `folder_name` varchar(100) DEFAULT NULL COMMENT '目录名称',
  `is_delete` char(2) NOT NULL COMMENT '删除标记:0:未删除,1:已删除',
  `pid` varchar(36) DEFAULT NULL COMMENT '父级id',
  `main_id` varchar(36) DEFAULT NULL COMMENT '主id',
  `is_default` char(2) DEFAULT NULL COMMENT '是否默认目录 0-默认目录  ',
  `create_type` varchar(10) DEFAULT NULL COMMENT '创建类型',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标附件目录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_performance`
--

DROP TABLE IF EXISTS `t_bidding_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_performance` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `performance_name` varchar(256) DEFAULT '0' COMMENT '业绩名称',
  `performance_type` varchar(256) DEFAULT NULL COMMENT '业绩类型',
  `performance_amount` double(32,2) DEFAULT NULL COMMENT '合同金额',
  `grade` varchar(50) DEFAULT NULL COMMENT '的翁及',
  `year_limit` varchar(200) DEFAULT NULL COMMENT '年限',
  `area` varchar(500) DEFAULT NULL COMMENT '地区',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标业绩';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_person`
--

DROP TABLE IF EXISTS `t_bidding_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_person` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `person_name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `identity_number` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别',
  `date_of_birth` date DEFAULT NULL COMMENT '出生日期',
  `department` varchar(100) DEFAULT NULL COMMENT '部门',
  `position` varchar(100) DEFAULT NULL COMMENT '职务',
  `job_title` varchar(100) DEFAULT NULL COMMENT '职称',
  `entry_time` date DEFAULT NULL COMMENT '入职时间',
  `person_status` char(2) DEFAULT NULL COMMENT '人员状态 0-在职 1-离职',
  `year_of_work` varchar(10) DEFAULT NULL COMMENT '从事检测工作年份',
  `education` varchar(100) DEFAULT NULL COMMENT '学历',
  `graduated_school` varchar(100) DEFAULT NULL COMMENT '毕业院校',
  `profession` varchar(100) DEFAULT NULL COMMENT '专业',
  `graduated_date` date DEFAULT NULL COMMENT '毕业时间',
  `contract_start_time` date DEFAULT NULL COMMENT '劳动合同开始时间',
  `contract_end_time` date DEFAULT NULL COMMENT '劳动合同结束时间',
  `social_security_category` varchar(100) DEFAULT NULL COMMENT '社会保险种类',
  `work_record` text COMMENT '工作记录',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标人员信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_person_certificate`
--

DROP TABLE IF EXISTS `t_bidding_person_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_person_certificate` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `certificate_number` varchar(100) DEFAULT NULL COMMENT '证书编号',
  `bidding_person_id` varchar(36) DEFAULT NULL COMMENT '招标人员id',
  `certificate_type` varchar(256) DEFAULT NULL COMMENT '证书类型',
  `certificate_professional` varchar(256) DEFAULT NULL COMMENT '证书专业',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标人员证书表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_person_performance`
--

DROP TABLE IF EXISTS `t_bidding_person_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_person_performance` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `project_name` varchar(100) DEFAULT NULL COMMENT '项目名称',
  `position` varchar(100) DEFAULT NULL COMMENT '担任职务',
  `position_date` varchar(50) DEFAULT NULL COMMENT '时间',
  `bidding_person_id` varchar(36) DEFAULT NULL COMMENT '投标人员id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标人员业绩表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_record`
--

DROP TABLE IF EXISTS `t_bidding_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_record` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `project_name` varchar(200) DEFAULT NULL COMMENT '项目名称',
  `bid_unit` varchar(200) DEFAULT NULL COMMENT '招标单位',
  `announcement_time` datetime DEFAULT NULL COMMENT '招标公告时间',
  `bid_time` datetime DEFAULT NULL COMMENT '开标时间',
  `win_bid_unit_name` varchar(200) DEFAULT NULL COMMENT '中标单位名称',
  `win_bid_unit_id` varchar(36) DEFAULT NULL COMMENT '中标单位id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招投标记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_record_performance_quote`
--

DROP TABLE IF EXISTS `t_bidding_record_performance_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_record_performance_quote` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `record_id` varchar(36) DEFAULT NULL COMMENT '记录id',
  `bidding_performance_id` varchar(36) DEFAULT NULL COMMENT '投标业绩id',
  `unit_id` varchar(36) DEFAULT NULL COMMENT '单位id',
  `quote_index` int(10) DEFAULT NULL COMMENT '引用序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投标记录业绩引用表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_record_person_quote`
--

DROP TABLE IF EXISTS `t_bidding_record_person_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_record_person_quote` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `record_id` varchar(36) DEFAULT NULL COMMENT '记录id',
  `bidding_person_id` varchar(36) DEFAULT NULL COMMENT '投标人员id',
  `bidding_person_name` varchar(100) DEFAULT NULL COMMENT '投标人员name',
  `reference_role` varchar(100) DEFAULT NULL COMMENT '本次引用角色',
  `unit_id` varchar(36) DEFAULT NULL COMMENT '单位id',
  `quote_index` int(10) DEFAULT NULL COMMENT '引用序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投标记录人员引用表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_bidding_record_unit`
--

DROP TABLE IF EXISTS `t_bidding_record_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bidding_record_unit` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `unit_name` varchar(100) DEFAULT NULL COMMENT '单位名称',
  `quote_amount` double(32,2) DEFAULT NULL COMMENT '报价',
  `other_description` text COMMENT '其他说明',
  `unit_type` char(2) DEFAULT NULL COMMENT '单位类型 0-本单位 1-竞争单位',
  `is_win_bid` char(2) DEFAULT NULL COMMENT '是否中标 0-未中标 1-中标',
  `tender_time` datetime DEFAULT NULL COMMENT '投标时间',
  `record_id` varchar(36) DEFAULT NULL COMMENT '记录id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投标记录单位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_attachment`
--

DROP TABLE IF EXISTS `t_consign_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_attachment` (
  `id` varchar(50) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `consign_id` varchar(50) DEFAULT NULL,
  `attachment_id` varchar(50) DEFAULT NULL,
  `type` int(10) DEFAULT NULL COMMENT 'ilis委托100/预委托200',
  `path` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `attachment_name` varchar(512) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托附件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_bill_template`
--

DROP TABLE IF EXISTS `t_consign_bill_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_bill_template` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `file_src` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `remark` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_custom_attribute`
--

DROP TABLE IF EXISTS `t_consign_custom_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_custom_attribute` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `attribute_name` varchar(255) NOT NULL,
  `is_blind` varchar(1) DEFAULT '0' COMMENT '是否盲样：1.是 0.否',
  `is_deleted` varchar(255) DEFAULT NULL,
  `seq` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_custom_attribute_value`
--

DROP TABLE IF EXISTS `t_consign_custom_attribute_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_custom_attribute_value` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `attribute_name` varchar(255) DEFAULT NULL,
  `attribute_value` varchar(255) DEFAULT NULL,
  `consign_custom_attribute_id` varchar(36) DEFAULT NULL,
  `consign_info_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC7BCD46B47D7E38D` (`consign_info_id`) USING BTREE,
  KEY `FKC7BCD46BF04B49FD` (`consign_custom_attribute_id`) USING BTREE,
  CONSTRAINT `t_consign_custom_attribute_value_ibfk_1` FOREIGN KEY (`consign_info_id`) REFERENCES `t_consign_info` (`id`),
  CONSTRAINT `t_consign_custom_attribute_value_ibfk_2` FOREIGN KEY (`consign_custom_attribute_id`) REFERENCES `t_consign_custom_attribute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_department_version`
--

DROP TABLE IF EXISTS `t_consign_department_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_department_version` (
  `id` varchar(36) NOT NULL,
  `consign_id` varchar(36) NOT NULL COMMENT '委托id',
  `department_id` varchar(36) DEFAULT NULL COMMENT '委托单位id',
  PRIMARY KEY (`id`),
  KEY `t_consign_department_version_consign_id_index` (`consign_id`),
  KEY `t_consign_department_version_department_id_index` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托保存时，启动的单位信息，命名很怪 来自t_depart_version.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_info`
--

DROP TABLE IF EXISTS `t_consign_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_info` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `check_type_id` varchar(50) DEFAULT NULL COMMENT '检测类型ID',
  `consign_code` varchar(255) DEFAULT NULL COMMENT '委托编号',
  `consign_date` date DEFAULT NULL COMMENT '委托时间',
  `consign_big_type` varchar(10) DEFAULT NULL COMMENT '委托大类',
  `consign_type` varchar(2) DEFAULT NULL COMMENT '0：原材料检测 1：现场检测',
  `consign_unit_name` varchar(255) DEFAULT NULL COMMENT '委托单位名称',
  `project_part_and_use` varchar(255) DEFAULT NULL COMMENT '工程部位/用途',
  `project_tender_name` varchar(255) DEFAULT NULL COMMENT '工程名称（该值来至于委托单位）',
  `qualification_type_id` varchar(50) DEFAULT NULL COMMENT '资质类型ID',
  `remark` text COMMENT '备注',
  `sample_send_date` date DEFAULT NULL COMMENT '送样时间',
  `sample_send_unit_name` varchar(255) DEFAULT NULL COMMENT '送样单位名称',
  `sample_sender_name` varchar(255) DEFAULT NULL COMMENT '实际送样认姓名',
  `sample_sender_phone` varchar(255) DEFAULT NULL COMMENT '实际送样人电话',
  `sn_type_id` varchar(255) DEFAULT NULL COMMENT '编号类别ID（生成编号时采用那一套编号）',
  `standard_provider` varchar(255) DEFAULT NULL COMMENT '规程提供方',
  `rollback_from` varchar(255) DEFAULT NULL COMMENT '回退来源,详见BusinessRollbackVo.java',
  `status` varchar(2) DEFAULT NULL COMMENT '委托状态',
  `test_nature` varchar(255) DEFAULT NULL COMMENT '检测性质 委托检验（给出结论）、委托检验（只出数据）',
  `consign_unit_id` varchar(36) DEFAULT NULL COMMENT '委托单位ID',
  `project_id` varchar(36) DEFAULT NULL COMMENT '工程项目ID',
  `sample_sender_id` varchar(36) DEFAULT NULL COMMENT '送样人员ID',
  `test_type` varchar(2) DEFAULT NULL COMMENT '检测形式 1、初检 2、复检 3、整改后检测',
  `appointment_date` date DEFAULT NULL COMMENT '预约时间',
  `build_unit_name` varchar(255) DEFAULT NULL COMMENT '建设单位',
  `build_unit_witness` varchar(255) DEFAULT NULL COMMENT '建设单位见证人',
  `construction_unit_name` varchar(255) DEFAULT NULL COMMENT '施工单位',
  `inspection_unit_name` varchar(255) DEFAULT NULL COMMENT '受检单位',
  `invoicing_unit_name` varchar(255) DEFAULT NULL,
  `is_confidentiality` varchar(255) DEFAULT NULL COMMENT '是否保密1：是、0：否',
  `payment_unit_name` varchar(255) DEFAULT NULL COMMENT '缴费单位',
  `post_form_id` varchar(255) DEFAULT NULL,
  `pre_consign_code` varchar(255) DEFAULT NULL,
  `report_hand_over_type` int(11) DEFAULT NULL COMMENT '报告交接方式（ 1:自取,2:代领,3:邮寄,4:传真等）',
  `require_report_date` date DEFAULT NULL COMMENT '要求报告完成时间',
  `require_report_days` int(11) DEFAULT NULL COMMENT '要求报告完成时间类型，交费后多少个工作日',
  `sample_receiver_license_number` varchar(255) DEFAULT NULL,
  `sample_receiver_name` varchar(255) DEFAULT NULL,
  `fee_status` varchar(255) DEFAULT NULL COMMENT '收费状态（冗余字段）： 3未收费 2 部分收费 1 完成收费',
  `task_name` varchar(255) DEFAULT NULL COMMENT '流程状态（冗余字段）',
  `is_simple_model` varchar(255) DEFAULT NULL COMMENT '简易模式的标记',
  `big_category_id` varchar(255) DEFAULT NULL,
  `report_print_num` int(11) DEFAULT '1' COMMENT '报告打印份数',
  `sample_source` int(11) DEFAULT NULL COMMENT '样品来源：1.委托送样 2.委托收样 3.现场取样',
  `take_sample_address` varchar(255) DEFAULT NULL COMMENT '取样地点',
  `dead_line_report` date DEFAULT NULL,
  `dead_line_record` date DEFAULT NULL,
  `dead_line_assigne` date DEFAULT NULL,
  `is_preconsign` int(1) DEFAULT '0' COMMENT '是否预委托：1. 是  0. 否',
  `pre_consign_id` varchar(40) DEFAULT NULL COMMENT '预委托id',
  `is_delete` int(1) DEFAULT '0' COMMENT '是否删除:0未删除,1已删除',
  `sample_acceptor_name` varchar(50) DEFAULT NULL COMMENT '收样人姓名（冗余字段）',
  `sample_acceptor` varchar(32) DEFAULT NULL COMMENT '收样人ID，关联t_s_user.id',
  `manual_fee_total` decimal(10,2) DEFAULT '0.00' COMMENT '用户手动输入的 总价格',
  `notice_object_id` varchar(36) DEFAULT NULL COMMENT '发起通知修改对象ID',
  `notify_modify_opinion` varchar(1000) DEFAULT NULL COMMENT '通知修改委托意见',
  `extract_sample_unit` varchar(200) DEFAULT NULL COMMENT '抽样单位',
  `extract_sample_person` varchar(50) DEFAULT NULL COMMENT '抽样人',
  `extract_sample_person_tel` varchar(15) DEFAULT NULL COMMENT '抽样人电话',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '计费合同ID',
  `contract_name` varchar(2000) DEFAULT NULL COMMENT '合同名称（冗余字段）',
  `consign_object_name` varchar(2048) NOT NULL COMMENT '收样样品名称(冗余字段,保存委托时维护)',
  `unit_project_type` varchar(10) DEFAULT NULL COMMENT '单位工程类型,来源于综合检测项目管理,1:工程项目,2:合同段,3:单位工程',
  `unit_project_obj_id` varchar(36) DEFAULT NULL COMMENT '单位工程对应的综合项目模块的对象id,配合unit_project_type的值可以确定对象',
  `unit_project_name` varchar(255) DEFAULT NULL COMMENT '单位工程名称,来源于综合检测项目模块,可能是工程项目/合同段/单位工程之一的名称',
  `param_version_id` varchar(36) DEFAULT NULL COMMENT '检测参数版本id',
  `random_code` varchar(20) DEFAULT NULL COMMENT '宏信创达需求，随机码',
  `random_pickup` varchar(10) DEFAULT NULL COMMENT '随机码随机截取用于任务分配单',
  PRIMARY KEY (`id`),
  KEY `FKB4F23E69D98C2234` (`sample_sender_id`) USING BTREE,
  KEY `FKB4F23E694A66DD3B` (`project_id`) USING BTREE,
  KEY `FKB4F23E69D1E253BA` (`consign_unit_id`) USING BTREE,
  KEY `sample_acceptor` (`sample_acceptor`) USING BTREE,
  CONSTRAINT `t_consign_info_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `t_consign_project` (`id`),
  CONSTRAINT `t_consign_info_ibfk_2` FOREIGN KEY (`consign_unit_id`) REFERENCES `t_consign_unit` (`id`),
  CONSTRAINT `t_consign_info_ibfk_3` FOREIGN KEY (`sample_sender_id`) REFERENCES `t_consign_sample_sender` (`id`),
  CONSTRAINT `t_consign_info_ibfk_4` FOREIGN KEY (`sample_acceptor`) REFERENCES `t_s_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_meta_data`
--

DROP TABLE IF EXISTS `t_consign_meta_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_meta_data` (
  `id` varchar(36) NOT NULL,
  `is_using` varchar(255) DEFAULT NULL,
  `meta_data` mediumtext,
  `consign_info_id` varchar(36) DEFAULT NULL,
  `data_version` int(11) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK842A089947D7E38D` (`consign_info_id`) USING BTREE,
  CONSTRAINT `t_consign_meta_data_ibfk_1` FOREIGN KEY (`consign_info_id`) REFERENCES `t_consign_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_modify_notification`
--

DROP TABLE IF EXISTS `t_consign_modify_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_modify_notification` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `content` text,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `consign_info_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK512050547D7E38D` (`consign_info_id`) USING BTREE,
  CONSTRAINT `t_consign_modify_notification_ibfk_1` FOREIGN KEY (`consign_info_id`) REFERENCES `t_consign_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_post`
--

DROP TABLE IF EXISTS `t_consign_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_post` (
  `id` varchar(36) NOT NULL,
  `postconsigncode` varchar(36) DEFAULT NULL COMMENT '委托单位编号',
  `postid` varchar(36) DEFAULT NULL COMMENT '邮寄id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_project`
--

DROP TABLE IF EXISTS `t_consign_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_project` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '工程项目名称',
  `construction_unit_name` varchar(255) DEFAULT NULL COMMENT '施工单位',
  `build_unit_name` varchar(255) DEFAULT NULL COMMENT '建设单位名称',
  `build_project_name` varchar(255) DEFAULT NULL COMMENT '建设项目名称',
  `witness_unit_name` varchar(255) DEFAULT NULL COMMENT '见证单位名称',
  `remark` text COMMENT '备注',
  `is_deleted` varchar(255) DEFAULT NULL COMMENT '是否已删除 0：否、1：是',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `is_synthesis_project` varchar(10) DEFAULT 'normal' COMMENT '是否是综合检测工程项目 普通项目 normal/ 综合检测项目 synthesis',
  `province` varchar(200) DEFAULT NULL COMMENT '所在省份',
  `description` mediumtext COMMENT '项目描述',
  `project_code` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `is_completed` int(1) DEFAULT '1' COMMENT '针对综合检测管理项目 是否结束\r\n：1是 0否',
  `depart_ids` varchar(500) DEFAULT NULL COMMENT '所属部门id，多选以半角逗号拼接',
  `depart_names` varchar(500) DEFAULT NULL COMMENT '所属部门名称多选以半角分号拼接',
  `verify_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工程项目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_random_code`
--

DROP TABLE IF EXISTS `t_consign_random_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_random_code` (
  `id` varchar(50) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `config_name` varchar(20) NOT NULL COMMENT '配置名称',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用标记',
  `code_length` int(11) NOT NULL COMMENT '随机码长度',
  `pickup_indexes` varchar(20) NOT NULL COMMENT '从随机码中抽取的下标以半角逗号分隔',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='宏信创达要求委托单随机码';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_report`
--

DROP TABLE IF EXISTS `t_consign_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_report` (
  `id` varchar(36) NOT NULL,
  `consign_id` varchar(36) DEFAULT NULL,
  `report_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CONSIGN_REPORT_REPORT_ID` (`report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_sample_sender`
--

DROP TABLE IF EXISTS `t_consign_sample_sender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_sample_sender` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '送样人员姓名',
  `account` varchar(255) NOT NULL COMMENT '远程平台登录账号',
  `contact_phone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `contact_address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(255) DEFAULT NULL COMMENT '邮编',
  `password` varchar(255) DEFAULT NULL COMMENT '登录密码',
  `status` varchar(255) DEFAULT NULL COMMENT '账号状态 1、锁定、0：正常',
  `verify_status` varchar(255) DEFAULT NULL COMMENT '账号审核状态 00：待审核 10、审核不通过 20、审核通过',
  `signature_image_src` varchar(255) DEFAULT NULL COMMENT '签名图片',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='送样人员（远程平台登录者）表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_specification_config`
--

DROP TABLE IF EXISTS `t_consign_specification_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_specification_config` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `sample_id` varchar(36) NOT NULL COMMENT '样品id',
  `sample_system_id` varchar(36) DEFAULT NULL COMMENT '样品系统id',
  `sample_name` varchar(50) DEFAULT NULL COMMENT '样品名称',
  `config_data` text NOT NULL COMMENT '配置json array',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托样品规格型号拼接规则';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_unit`
--

DROP TABLE IF EXISTS `t_consign_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_unit` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '委托单位名称',
  `pay_unit_name` varchar(255) DEFAULT NULL COMMENT '缴费单位名称',
  `contact_address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `qualification_type_id` varchar(255) DEFAULT NULL COMMENT '资质类型ID',
  `remark` text COMMENT '备注',
  `is_deleted` varchar(255) DEFAULT NULL COMMENT '是否删除 1：是、0：否',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `card_number` varchar(255) DEFAULT NULL COMMENT '卡号/账号',
  `construction_unit_name` varchar(255) DEFAULT NULL COMMENT '施工单位名称(旧版)',
  `contact_person` varchar(255) DEFAULT NULL COMMENT '联系人(旧版)',
  `contact_phone` varchar(255) DEFAULT NULL COMMENT '联系人电话(旧版)',
  `included_area` varchar(255) DEFAULT NULL COMMENT '收录地区(旧版)',
  `is_quality_supervise` varchar(255) DEFAULT NULL COMMENT '是否是质量监督单位(旧版)',
  `project_tender_name` varchar(255) DEFAULT NULL COMMENT '项目标段名称(旧版)',
  `zip_code` varchar(255) DEFAULT NULL COMMENT '邮编(旧版)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='委托单位表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_unit_project`
--

DROP TABLE IF EXISTS `t_consign_unit_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_unit_project` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `consign_unit_id` varchar(36) DEFAULT NULL,
  `project_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAA8EAC494A66DD3B` (`project_id`) USING BTREE,
  KEY `FKAA8EAC49D1E253BA` (`consign_unit_id`) USING BTREE,
  CONSTRAINT `t_consign_unit_project_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `t_consign_project` (`id`),
  CONSTRAINT `t_consign_unit_project_ibfk_2` FOREIGN KEY (`consign_unit_id`) REFERENCES `t_consign_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_unit_sample_sender`
--

DROP TABLE IF EXISTS `t_consign_unit_sample_sender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_unit_sample_sender` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `consign_unit_id` varchar(36) DEFAULT NULL,
  `sample_sender_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKF6EF8B9AD98C2234` (`sample_sender_id`) USING BTREE,
  KEY `FKF6EF8B9AD1E253BA` (`consign_unit_id`) USING BTREE,
  CONSTRAINT `t_consign_unit_sample_sender_ibfk_1` FOREIGN KEY (`consign_unit_id`) REFERENCES `t_consign_unit` (`id`),
  CONSTRAINT `t_consign_unit_sample_sender_ibfk_2` FOREIGN KEY (`sample_sender_id`) REFERENCES `t_consign_sample_sender` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_consign_witness`
--

DROP TABLE IF EXISTS `t_consign_witness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_consign_witness` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `is_deleted` varchar(255) DEFAULT NULL,
  `witness` varchar(255) DEFAULT NULL,
  `witness_license_number` varchar(255) DEFAULT NULL,
  `witness_phone` varchar(255) DEFAULT NULL,
  `witness_unit_name` varchar(255) DEFAULT NULL,
  `consign_info_id` varchar(36) DEFAULT NULL,
  `witness_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKD052496E3AC51B74` (`consign_info_id`) USING BTREE,
  CONSTRAINT `t_consign_witness_ibfk_1` FOREIGN KEY (`consign_info_id`) REFERENCES `t_consign_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_customize_column`
--

DROP TABLE IF EXISTS `t_customize_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_customize_column` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `column_index` int(10) DEFAULT NULL COMMENT '字段序号',
  `column_name` varchar(100) DEFAULT NULL COMMENT '字段名称',
  `column_type` varchar(50) DEFAULT NULL COMMENT '字段类型',
  `customize_type` varchar(50) DEFAULT NULL COMMENT '自定义类型 performance-业绩自定义字段 person-人员自定义字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_customize_value`
--

DROP TABLE IF EXISTS `t_customize_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_customize_value` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `custom_column_id` varchar(36) DEFAULT NULL COMMENT '自定义字段id',
  `custom_column_value` varchar(100) DEFAULT NULL COMMENT '值',
  `object_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义字段值';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collection`
--

DROP TABLE IF EXISTS `t_data_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_collection` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `theme_name` varchar(50) DEFAULT NULL COMMENT '主题名称',
  `theme_type` varchar(100) DEFAULT NULL COMMENT '主题类型',
  `start_date` datetime DEFAULT NULL COMMENT '启动日期',
  `theme_introduction` text COMMENT '主题简介',
  `theme_status` char(2) DEFAULT NULL COMMENT '主题状态 0-进行中 1-已结束',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料收集主题';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collection_configuration`
--

DROP TABLE IF EXISTS `t_data_collection_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_collection_configuration` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `type_id` varchar(36) DEFAULT NULL COMMENT '配置类别id',
  `type_name` varchar(100) DEFAULT NULL COMMENT '配置类别名称',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上报资料配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collection_content`
--

DROP TABLE IF EXISTS `t_data_collection_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_collection_content` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `data_collection_id` varchar(50) DEFAULT NULL COMMENT '资料收集主题ID',
  `data_collection_node_id` varchar(50) DEFAULT NULL COMMENT '资料收集主题节点ID',
  `data_collection_node_date` datetime DEFAULT NULL COMMENT '资料收集主题节点时间',
  `remind_date` datetime DEFAULT NULL COMMENT '资料上报提醒时间',
  `content` varchar(255) DEFAULT NULL COMMENT '资料上传内容',
  `report_deadline_date` datetime DEFAULT NULL COMMENT '上报截止时间',
  `is_complete` char(2) DEFAULT '0' COMMENT '是否完成 0-未完成 1-已完成',
  PRIMARY KEY (`id`),
  KEY `t_data_collection_content_index` (`data_collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料收集主题节点内容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collection_content_attachment`
--

DROP TABLE IF EXISTS `t_data_collection_content_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_collection_content_attachment` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `data_collection_content_id` varchar(36) DEFAULT NULL COMMENT '资料收集主题内容ID',
  `attachment_id` varchar(36) NOT NULL COMMENT '文件id',
  `attachment_name` varchar(500) NOT NULL COMMENT '文件名',
  `path` varchar(255) NOT NULL COMMENT '文件路径',
  `upload_person_name` varchar(255) NOT NULL COMMENT '上传人',
  `upload_person_id` varchar(255) NOT NULL COMMENT '上传人id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料收集主题内容附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collection_content_person`
--

DROP TABLE IF EXISTS `t_data_collection_content_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_collection_content_person` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `person_name` varchar(50) DEFAULT NULL COMMENT '名字',
  `person_id` varchar(50) DEFAULT NULL COMMENT '人员ID',
  `data_collection_content_id` varchar(50) DEFAULT NULL COMMENT '资料收集主题内容ID',
  `person_status` char(2) DEFAULT '0' COMMENT '是否上传已上传 0-未上传 1-已上传',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料收集主题内容负责人';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collection_node`
--

DROP TABLE IF EXISTS `t_data_collection_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_collection_node` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `data_collection_id` varchar(50) DEFAULT NULL COMMENT '资料收集主题ID',
  `node_date` date DEFAULT NULL COMMENT '节点时间',
  `remind_date` datetime DEFAULT NULL COMMENT '资料上报提醒时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料收集主题内容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_data_collection_person`
--

DROP TABLE IF EXISTS `t_data_collection_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_data_collection_person` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `person_name` varchar(50) DEFAULT NULL COMMENT '名字',
  `person_id` varchar(50) DEFAULT NULL COMMENT '人员ID',
  `person_type` char(2) DEFAULT NULL COMMENT '人员类型 1-负责人 2-参与人',
  `data_collection_id` varchar(50) DEFAULT NULL COMMENT '资料收集主题ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料主题人员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_design_grade_range`
--

DROP TABLE IF EXISTS `t_design_grade_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_design_grade_range` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `screen_size` varchar(50) NOT NULL COMMENT '筛孔尺寸',
  `upper_limit` varchar(20) DEFAULT NULL COMMENT '上限',
  `lower_limit` varchar(20) DEFAULT NULL COMMENT '下限',
  `standard` varchar(20) DEFAULT NULL COMMENT '标准',
  `type_id` varchar(36) NOT NULL COMMENT '设计级配类型id',
  `order_num` int(11) DEFAULT NULL COMMENT '顺序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设计级配范围';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_design_grade_type`
--

DROP TABLE IF EXISTS `t_design_grade_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_design_grade_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `type_name` varchar(100) DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设计级配类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document`
--

DROP TABLE IF EXISTS `t_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document` (
  `id` varchar(36) NOT NULL,
  `group_id` varchar(36) NOT NULL COMMENT '档案分组ID',
  `name` varchar(255) NOT NULL COMMENT '归档名称',
  `status` varchar(255) NOT NULL COMMENT '归档状态 0: 进行中, 1:已完成',
  `intro` varchar(1024) DEFAULT NULL COMMENT '简介',
  `consign_unit_id` varchar(36) DEFAULT NULL COMMENT '工程项目ID',
  `consign_unit_name` varchar(255) DEFAULT NULL COMMENT '工程项目名称',
  `is_deleted` tinyint(1) NOT NULL COMMENT '是否已删除 1:是,0:否',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `idx_document_group_id` (`group_id`),
  CONSTRAINT `idx_document_group_id` FOREIGN KEY (`group_id`) REFERENCES `t_document_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料归档实体';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_depart`
--

DROP TABLE IF EXISTS `t_document_depart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_depart` (
  `id` varchar(36) NOT NULL,
  `document_id` varchar(36) NOT NULL COMMENT '归档ID',
  `depart_id` varchar(36) NOT NULL COMMENT '部门ID',
  `depart_name` varchar(255) NOT NULL COMMENT '部门名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `idx_doc_depart_doc_id` (`document_id`),
  CONSTRAINT `idx_doc_depart_doc_id` FOREIGN KEY (`document_id`) REFERENCES `t_document` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='归档部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_detail_folder`
--

DROP TABLE IF EXISTS `t_document_detail_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_detail_folder` (
  `id` varchar(36) NOT NULL COMMENT '目录ID',
  `pid` varchar(36) DEFAULT NULL COMMENT '父级目录ID',
  `name` varchar(255) NOT NULL COMMENT '模板目录名称',
  `order_number` int(11) DEFAULT NULL COMMENT '排序号',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` tinyint(1) NOT NULL COMMENT '是否已删除 1:是,0:否',
  `document_id` varchar(36) NOT NULL COMMENT '资料归档实体ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料归档详情目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_detail_item`
--

DROP TABLE IF EXISTS `t_document_detail_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_detail_item` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `detail_folder_id` varchar(36) NOT NULL COMMENT '详情目录ID',
  `name` varchar(255) NOT NULL COMMENT '资料项名称',
  `cycle_type` varchar(255) NOT NULL COMMENT '归档周期类型 1: 仅归档一次, 2:按周期归档, 3:随时归档',
  `cycle` int(11) DEFAULT NULL COMMENT '周期',
  `cycle_unit` varchar(255) DEFAULT NULL COMMENT '周期单位: Y:年, M:月, D:日, W:周',
  `cycle_time_start` datetime DEFAULT NULL COMMENT '首次要求归档日期',
  `cycle_time_end` datetime DEFAULT NULL COMMENT '归档截止时间',
  `is_deleted` tinyint(1) NOT NULL COMMENT '是否已删除 1:是,0:否',
  `is_archived` char(2) DEFAULT NULL COMMENT '是否已归档 0-未归档 1-已归档',
  `archive_source` varchar(50) DEFAULT NULL COMMENT '归档来源 mark-标记归档 normal-普通正常归档',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料归档资料项';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_detail_item_cycle`
--

DROP TABLE IF EXISTS `t_document_detail_item_cycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_detail_item_cycle` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `cycle_time` datetime DEFAULT NULL COMMENT '周期时间',
  `is_deleted` tinyint(1) NOT NULL COMMENT '是否已删除 1:是,0:否',
  `is_archived` char(2) NOT NULL DEFAULT '0' COMMENT '是否已归档 0-未归档 1-已归档',
  `archive_source` varchar(50) DEFAULT NULL COMMENT '归档来源 mark-标记归档 normal-普通正常归档',
  `item_id` varchar(36) DEFAULT NULL COMMENT '分组id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料归档资料项周期';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_detail_item_data`
--

DROP TABLE IF EXISTS `t_document_detail_item_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_detail_item_data` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `is_deleted` tinyint(1) NOT NULL COMMENT '是否已删除 1:是,0:否',
  `object_id` varchar(36) DEFAULT NULL COMMENT '所属对象id',
  `p_type` varchar(20) DEFAULT NULL COMMENT '所属类型 1-资料项 2-资料项周期',
  `data_type` varchar(20) DEFAULT NULL COMMENT '资料类型 ele-电子档案 paper-纸质档',
  `data_from` varchar(20) DEFAULT NULL COMMENT '资料类型 0-上传 1-引用 2-新增纸质档案',
  `data_url` varchar(100) DEFAULT NULL COMMENT '文件地址',
  `attach_id` varchar(36) DEFAULT NULL COMMENT '文件地址',
  `archive_time` datetime DEFAULT NULL COMMENT '归档日期',
  `data_name` varchar(500) DEFAULT NULL COMMENT '资料名称',
  `archive_address` varchar(500) DEFAULT NULL COMMENT '归档地址',
  `archive_user_id` varchar(36) DEFAULT NULL COMMENT '上传人id',
  `archive_user_name` varchar(100) DEFAULT NULL COMMENT '上传人name',
  `data_no` varchar(100) DEFAULT NULL COMMENT '档案编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料归档资料项';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_group`
--

DROP TABLE IF EXISTS `t_document_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_group` (
  `id` varchar(36) NOT NULL,
  `pid` varchar(36) DEFAULT NULL COMMENT '父级ID',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `order_number` int(11) DEFAULT NULL COMMENT '顺序号',
  `is_deleted` tinyint(1) NOT NULL COMMENT '是否已删除 1:是,0:否',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资料归档的档案分组';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_person`
--

DROP TABLE IF EXISTS `t_document_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_person` (
  `id` varchar(36) NOT NULL,
  `document_id` varchar(36) NOT NULL COMMENT '归档ID',
  `person_id` varchar(36) NOT NULL COMMENT '人员ID',
  `person_name` varchar(255) NOT NULL COMMENT '人员姓名',
  `person_type` varchar(255) NOT NULL COMMENT '人员类型 1:负责人, 2:参与人',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `idx_doc_person_doc_id` (`document_id`),
  CONSTRAINT `idx_doc_person_doc_id` FOREIGN KEY (`document_id`) REFERENCES `t_document` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='归档人员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_project`
--

DROP TABLE IF EXISTS `t_document_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_project` (
  `id` varchar(36) NOT NULL,
  `document_id` varchar(36) NOT NULL COMMENT '归档ID',
  `consign_project_id` varchar(36) NOT NULL COMMENT '工程项目ID',
  `consign_project_name` varchar(255) NOT NULL COMMENT '工程项目名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `idx_doc_consign_project_doc_id` (`document_id`),
  CONSTRAINT `idx_doc_consign_project_doc_id` FOREIGN KEY (`document_id`) REFERENCES `t_document` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='归档的工程项目';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_template`
--

DROP TABLE IF EXISTS `t_document_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_template` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '模板名称',
  `order_number` int(11) DEFAULT NULL COMMENT '排序号',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='归档模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_template_folder`
--

DROP TABLE IF EXISTS `t_document_template_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_template_folder` (
  `id` varchar(36) NOT NULL COMMENT '目录ID',
  `pid` varchar(36) DEFAULT NULL COMMENT '父级目录ID',
  `template_id` varchar(36) NOT NULL COMMENT '模板ID',
  `name` varchar(255) NOT NULL COMMENT '模板目录名称',
  `order_number` int(11) DEFAULT NULL COMMENT '排序号',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `idx_doc_template_folder_template_id` (`template_id`),
  CONSTRAINT `idx_doc_template_folder_template_id` FOREIGN KEY (`template_id`) REFERENCES `t_document_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='归档模板的目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_document_template_item`
--

DROP TABLE IF EXISTS `t_document_template_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_template_item` (
  `id` varchar(36) NOT NULL,
  `template_folder_id` varchar(36) NOT NULL COMMENT '模板目录ID',
  `name` varchar(255) NOT NULL COMMENT '资料项名称',
  `cycle_type` varchar(255) NOT NULL COMMENT '归档周期类型 1: 仅归档一次, 2:按周期归档, 3:随时归档',
  `cycle` int(11) DEFAULT NULL COMMENT '周期',
  `cycle_unit` varchar(255) DEFAULT NULL COMMENT '周期单位: Y:年, M:月, D:日, W:周',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `idx_doc_template_item_folder_id` (`template_folder_id`),
  CONSTRAINT `idx_doc_template_item_folder_id` FOREIGN KEY (`template_folder_id`) REFERENCES `t_document_template_folder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='归档模板资料项';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_allot`
--

DROP TABLE IF EXISTS `t_eq_allot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_allot` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `equipment_name` varchar(255) DEFAULT NULL,
  `out_org` varchar(255) NOT NULL COMMENT '调出机构',
  `out_org_id` varchar(36) DEFAULT NULL,
  `in_org` varchar(255) NOT NULL COMMENT '调入机构',
  `in_org_id` varchar(36) DEFAULT NULL,
  `allot_time` datetime DEFAULT NULL COMMENT '调拨时间',
  `allot_explain` varchar(500) DEFAULT NULL COMMENT '调拨说明',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `apply_person` varchar(36) DEFAULT NULL COMMENT '申请人',
  `apply_status` varchar(10) DEFAULT NULL COMMENT '申请状态:10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备调拨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_buy`
--

DROP TABLE IF EXISTS `t_eq_buy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_buy` (
  `id` varchar(36) NOT NULL,
  `buy_plan_id` varchar(36) DEFAULT NULL COMMENT '购置计划id',
  `buy_apply_id` varchar(36) DEFAULT NULL COMMENT '购置申请ID',
  `equipment_name` varchar(200) DEFAULT NULL COMMENT '设备名称',
  `standard` varchar(200) DEFAULT NULL COMMENT '规格型号',
  `manufacturer` varchar(512) DEFAULT NULL COMMENT '生产厂家',
  `reason` varchar(512) DEFAULT NULL COMMENT '购置原因及用途',
  `apply_depart` varchar(512) DEFAULT NULL COMMENT '申请部门',
  `apply_depart_id` varchar(36) DEFAULT NULL COMMENT '申请部门ID',
  `applicant` varchar(100) DEFAULT NULL COMMENT '申请人',
  `applicant_id` varchar(36) DEFAULT NULL COMMENT '申请人ID',
  `buy_person` varchar(50) DEFAULT NULL COMMENT '购买人',
  `buy_person_id` varchar(36) DEFAULT NULL COMMENT '购买人ID',
  `buy_time` datetime DEFAULT NULL COMMENT '购买时间',
  `price` double DEFAULT NULL COMMENT '单价',
  `amount` int(11) DEFAULT NULL COMMENT '数量',
  `total_fee` double DEFAULT NULL COMMENT '总价',
  `contract_sn` varchar(100) DEFAULT NULL COMMENT '合同编号',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `status` varchar(10) DEFAULT NULL COMMENT '状态,较多,见程序常量TEqBuyEntity.java',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备购置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_buy_acceptance`
--

DROP TABLE IF EXISTS `t_eq_buy_acceptance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_buy_acceptance` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `buy_id` varchar(36) NOT NULL,
  `acceptor` varchar(100) DEFAULT NULL COMMENT '验收人',
  `acceptor_id` varchar(255) DEFAULT NULL COMMENT '验收人id',
  `acceptance_sn` varchar(255) DEFAULT NULL COMMENT '验收编号',
  `specifications` varchar(255) DEFAULT NULL COMMENT '说明书',
  `specifications_amount` int(11) DEFAULT NULL COMMENT '说明书份数',
  `inspection_sheet` varchar(255) DEFAULT NULL COMMENT '检验单',
  `inspection_sheet_amount` int(11) DEFAULT NULL COMMENT '检验单份数',
  `pictures` varchar(255) DEFAULT NULL COMMENT '图纸资料',
  `pictures_amount` int(11) DEFAULT NULL COMMENT '图纸资料份数',
  `attachment` varchar(255) DEFAULT NULL COMMENT '附件',
  `attachment_amount` int(11) DEFAULT NULL COMMENT '附件份数',
  `acceptance_date` datetime DEFAULT NULL COMMENT '验收日期',
  `test_run_date` datetime DEFAULT NULL COMMENT '试运行日期',
  `unpack_check_info` varchar(255) DEFAULT NULL COMMENT '开箱验收情况',
  `install_quality` varchar(255) DEFAULT NULL COMMENT '安装质量及精度',
  `running_status` varchar(255) DEFAULT NULL COMMENT '运转情况',
  `test_run_status` varchar(255) DEFAULT NULL COMMENT '试运行情况',
  PRIMARY KEY (`id`),
  KEY `t_eq_buy_ibfk_1` (`buy_id`),
  CONSTRAINT `t_eq_buy_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `t_eq_buy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_buy_apply`
--

DROP TABLE IF EXISTS `t_eq_buy_apply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_buy_apply` (
  `id` varchar(36) NOT NULL,
  `applicant` varchar(500) NOT NULL COMMENT '申请人',
  `applicant_id` varchar(36) NOT NULL COMMENT '申请人ID',
  `budget` double DEFAULT NULL COMMENT '预算',
  `apply_explain` varchar(500) DEFAULT NULL COMMENT '申请说明',
  `status` varchar(10) NOT NULL COMMENT '申请状态:10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备购置申请';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_buy_apply_detail`
--

DROP TABLE IF EXISTS `t_eq_buy_apply_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_buy_apply_detail` (
  `id` varchar(36) NOT NULL,
  `buy_apply_id` varchar(36) NOT NULL COMMENT '购置申请id',
  `name` varchar(200) DEFAULT NULL COMMENT '设备名称',
  `standard` varchar(500) DEFAULT NULL COMMENT '规格型号',
  `manufacturer` varchar(500) DEFAULT NULL COMMENT '生产厂家',
  `depart` varchar(500) NOT NULL COMMENT '申请科室',
  `depart_id` varchar(36) NOT NULL COMMENT '申请部门ID',
  `price` double DEFAULT NULL COMMENT '单价',
  `amount` int(11) DEFAULT NULL COMMENT '数量',
  `total_price` double DEFAULT NULL COMMENT '总价',
  `reason` varchar(500) DEFAULT NULL COMMENT '原因及用途',
  `use_rule` varchar(500) DEFAULT NULL COMMENT '使用规范',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_buy_apply` (`buy_apply_id`) USING BTREE,
  CONSTRAINT `t_eq_buy_apply_detail_ibfk_1` FOREIGN KEY (`buy_apply_id`) REFERENCES `t_eq_buy_apply` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备购置申请明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_buy_plan`
--

DROP TABLE IF EXISTS `t_eq_buy_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_buy_plan` (
  `id` varchar(36) NOT NULL,
  `applicant` varchar(250) DEFAULT NULL COMMENT '申请人',
  `applicant_id` varchar(36) DEFAULT NULL COMMENT '申请人ID',
  `budget` double DEFAULT NULL COMMENT '预算',
  `apply_explain` varchar(500) DEFAULT NULL COMMENT '申请说明',
  `status` varchar(10) NOT NULL COMMENT '计划状态:10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备购置计划';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_buy_plan_detail`
--

DROP TABLE IF EXISTS `t_eq_buy_plan_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_buy_plan_detail` (
  `id` varchar(36) NOT NULL,
  `buy_plan_id` varchar(36) NOT NULL COMMENT '购置计划id',
  `name` varchar(200) DEFAULT NULL COMMENT '设备名称',
  `standard` varchar(500) DEFAULT NULL COMMENT '规格型号',
  `manufacturer` varchar(500) DEFAULT NULL COMMENT '生产厂商',
  `depart` varchar(500) DEFAULT NULL COMMENT '申请科室',
  `depart_id` varchar(36) DEFAULT NULL COMMENT '申请科室(部门)ID',
  `price` double DEFAULT NULL COMMENT '设备单价',
  `amount` int(11) DEFAULT NULL COMMENT '申购数量',
  `total_price` double DEFAULT NULL COMMENT '总价',
  `reason` varchar(500) DEFAULT NULL COMMENT '原因及用途',
  `use_rule` varchar(500) DEFAULT NULL COMMENT '使用规范',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_buy_plan` (`buy_plan_id`) USING BTREE,
  CONSTRAINT `t_eq_buy_plan_detail_ibfk_1` FOREIGN KEY (`buy_plan_id`) REFERENCES `t_eq_buy_plan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='购置计划明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_check`
--

DROP TABLE IF EXISTS `t_eq_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_check` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `check_unit` varchar(200) DEFAULT NULL COMMENT '检校单位',
  `check_time` datetime DEFAULT NULL COMMENT '检校时间',
  `validity_date` datetime DEFAULT NULL COMMENT '检校有效期',
  `certificate_sn` varchar(100) DEFAULT NULL COMMENT '资质证书编号',
  `verdict` varchar(500) DEFAULT NULL COMMENT '检校结论',
  `gist` varchar(500) DEFAULT NULL COMMENT '检校备注',
  `remark` varchar(500) DEFAULT NULL COMMENT '检校状态',
  `status` varchar(10) DEFAULT NULL COMMENT '10.待确认,20:确认不通过,30:确认通过',
  `confirmer_name` varchar(200) DEFAULT NULL COMMENT '确认人',
  `confirmer_id` varchar(50) DEFAULT NULL COMMENT '确认人id',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备检校记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_check_item`
--

DROP TABLE IF EXISTS `t_eq_check_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_check_item` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `name` varchar(200) NOT NULL COMMENT '检查项名称',
  `check_type` varchar(20) DEFAULT NULL COMMENT '检校类别:1.校准,2.自校,3.检校或自校(1&2)',
  `skill_limit` varchar(500) DEFAULT NULL COMMENT '技术要求',
  `check_period` int(11) DEFAULT NULL COMMENT '检校周期',
  `check_period_unit` varchar(10) DEFAULT NULL COMMENT '检校周期单位:Y:年,M:月,D:日',
  `pre_check_date` datetime DEFAULT NULL COMMENT '上次检校日期',
  `next_check_date` datetime DEFAULT NULL COMMENT '下次检校日期',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注说明',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_equipment` (`equipment_id`) USING BTREE,
  CONSTRAINT `t_eq_check_item_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `t_s_equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检校项目';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_check_plan`
--

DROP TABLE IF EXISTS `t_eq_check_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_check_plan` (
  `id` varchar(36) NOT NULL,
  `plan_type` varchar(10) NOT NULL COMMENT '计划类型:1:年度计划,2:月度计划',
  `plan_year` varchar(20) DEFAULT NULL COMMENT '计划年度',
  `plan_mouth` varchar(20) DEFAULT NULL COMMENT '计划月份',
  `plan_time` datetime DEFAULT NULL COMMENT '计划时间(根据年份和月份结合类型计算得出)',
  `plan_depart` varchar(200) DEFAULT NULL COMMENT '计划科室',
  `plan_status` varchar(10) DEFAULT NULL COMMENT '计划状态:10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `is_deleted` varchar(10) NOT NULL COMMENT '是否已删除:1是0否',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备检校计划';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_check_plan_detail`
--

DROP TABLE IF EXISTS `t_eq_check_plan_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_check_plan_detail` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `check_plan_id` varchar(36) NOT NULL COMMENT '检校计划id',
  `plan_check_time` datetime DEFAULT NULL COMMENT '计划检校时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` varchar(10) NOT NULL COMMENT '是否已逻辑删除1是0否',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_check_plan` (`check_plan_id`) USING BTREE,
  CONSTRAINT `t_eq_check_plan_detail_ibfk_1` FOREIGN KEY (`check_plan_id`) REFERENCES `t_eq_check_plan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检校计划明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_checked_item`
--

DROP TABLE IF EXISTS `t_eq_checked_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_checked_item` (
  `id` varchar(36) NOT NULL,
  `check_id` varchar(36) NOT NULL COMMENT '检校记录id',
  `check_item_id` varchar(36) NOT NULL COMMENT '检校项目id',
  `use_equipment` varchar(200) DEFAULT NULL COMMENT '检校用设备',
  `last_check_time` datetime DEFAULT NULL COMMENT '前次检校时间',
  `check_time` datetime DEFAULT NULL COMMENT '本次检校时间',
  `next_check_time` datetime DEFAULT NULL COMMENT '下次检校时间',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_check` (`check_id`) USING BTREE,
  CONSTRAINT `t_eq_checked_item_ibfk_1` FOREIGN KEY (`check_id`) REFERENCES `t_eq_check` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检校项目记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_consumables`
--

DROP TABLE IF EXISTS `t_eq_consumables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_consumables` (
  `id` varchar(36) NOT NULL,
  `name` varchar(200) NOT NULL COMMENT '耗材名称',
  `standard` varchar(200) DEFAULT NULL COMMENT '规格型号',
  `site` varchar(200) DEFAULT NULL COMMENT '存放地点',
  `amount` double DEFAULT NULL COMMENT '库存数量',
  `amount_unit` varchar(20) DEFAULT NULL COMMENT '数量单位',
  `operator_id` varchar(36) DEFAULT NULL COMMENT '经手人',
  `operator_name` varchar(255) DEFAULT NULL COMMENT '经手人姓名',
  `manager_id` varchar(36) DEFAULT NULL COMMENT '保管人',
  `manager_name` varchar(255) DEFAULT NULL COMMENT '部门保管人姓名',
  `audit_person_id` varchar(36) DEFAULT NULL COMMENT '核查人',
  `audit_person_name` varchar(255) DEFAULT NULL COMMENT '核查人姓名',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='低值易耗品(耗材)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_consumables_inventory`
--

DROP TABLE IF EXISTS `t_eq_consumables_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_consumables_inventory` (
  `id` varchar(36) NOT NULL,
  `consumables_id` varchar(36) NOT NULL COMMENT '耗材id',
  `name` varchar(200) NOT NULL COMMENT '耗材明层',
  `standard` varchar(200) DEFAULT NULL COMMENT '规格型号',
  `amount` double DEFAULT NULL COMMENT '库存数量',
  `amount_unit` varchar(10) NOT NULL COMMENT '数量单位',
  `site` varchar(100) DEFAULT NULL COMMENT '存放地点',
  `operator_id` varchar(36) DEFAULT NULL COMMENT '经手人',
  `operator_name` varchar(255) DEFAULT NULL COMMENT '经手人姓名',
  `manager_id` varchar(36) DEFAULT NULL COMMENT '保管人',
  `manager_name` varchar(255) DEFAULT NULL COMMENT '保管人姓名',
  `audit_person_id` varchar(36) DEFAULT NULL COMMENT '核查人',
  `audit_person_name` varchar(255) DEFAULT NULL COMMENT '核查人姓名',
  `record_type` varchar(10) DEFAULT NULL COMMENT '记录类型:1:入库,2:出库',
  `record_count` double DEFAULT NULL COMMENT '记录数量',
  `record_person_id` varchar(36) DEFAULT NULL COMMENT '记录人id',
  `record_person_name` varchar(255) DEFAULT NULL COMMENT '记录人姓名',
  `record_date` datetime DEFAULT NULL COMMENT '记录时间',
  `out_type` varchar(10) DEFAULT NULL COMMENT '出库类型(用途)',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注    ',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_consumables` (`consumables_id`) USING BTREE,
  CONSTRAINT `t_eq_consumables_inventory_ibfk_1` FOREIGN KEY (`consumables_id`) REFERENCES `t_eq_consumables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='低值易耗品进出库记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_egress`
--

DROP TABLE IF EXISTS `t_eq_egress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_egress` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `equipment_name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `asset_sn` varchar(255) DEFAULT NULL COMMENT '资产编号',
  `status` varchar(200) DEFAULT NULL COMMENT '外出状态',
  `test_task_sn` varchar(4096) DEFAULT NULL COMMENT '试验任务编号,多个以半角逗号分隔',
  `borrow_user` varchar(255) DEFAULT NULL COMMENT '借取人',
  `Borrow_user_id` varchar(36) DEFAULT NULL COMMENT '借取人',
  `borrow_time` datetime DEFAULT NULL COMMENT '借取时间',
  `egress_time` datetime DEFAULT NULL COMMENT '外出时间',
  `expect_return_time` datetime DEFAULT NULL COMMENT '预还时间',
  `return_person` varchar(36) DEFAULT NULL COMMENT '归还人',
  `return_time` datetime DEFAULT NULL COMMENT '归还时间',
  `before_status` varchar(200) DEFAULT NULL COMMENT '外出前状态',
  `return_status` varchar(200) DEFAULT NULL COMMENT '归还时设备状态',
  `egress_audit_user` varchar(255) DEFAULT NULL COMMENT '外出确认人',
  `return_audit_user` varchar(255) DEFAULT NULL COMMENT '归还确认人',
  `remark` varchar(1024) DEFAULT NULL COMMENT '外出备注',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备外出';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_egress_operation`
--

DROP TABLE IF EXISTS `t_eq_egress_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_egress_operation` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `egress_id` varchar(36) NOT NULL COMMENT '外出id',
  `operation_type` varchar(255) DEFAULT NULL COMMENT '操作类型: 10:外出确认, 20:归还, 30:归还确认',
  `operator` varchar(255) DEFAULT NULL COMMENT '操作人',
  `operator_id` varchar(36) DEFAULT NULL COMMENT '操作人id',
  `operation_time` datetime DEFAULT NULL COMMENT '操作时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `equipment_status` varchar(255) DEFAULT NULL COMMENT '设备状态',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`),
  KEY `FK_egress_id` (`egress_id`),
  CONSTRAINT `FK_egress_id` FOREIGN KEY (`egress_id`) REFERENCES `t_eq_egress` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_file`
--

DROP TABLE IF EXISTS `t_eq_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_file` (
  `id` varchar(36) NOT NULL,
  `folder_id` varchar(36) NOT NULL COMMENT '目录id',
  `main_entity_id` varchar(36) NOT NULL COMMENT '模块主体对象id(设备模块:设备id)',
  `name` varchar(100) NOT NULL COMMENT '附件名称',
  `attachment_id` varchar(36) NOT NULL COMMENT '通用附件id',
  `url` varchar(500) DEFAULT NULL COMMENT 'url',
  `is_delete` varchar(10) NOT NULL COMMENT '删除标记:0:未删除,1:已删除',
  `relation_function` varchar(10) DEFAULT NULL COMMENT '关联设备模块功能',
  `relation_function_file_type` varchar(10) DEFAULT NULL COMMENT '关联功能中的文件细分类',
  `relation_entity_id` varchar(36) DEFAULT NULL COMMENT '关联模块对象id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_folder`
--

DROP TABLE IF EXISTS `t_eq_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_folder` (
  `id` varchar(36) NOT NULL,
  `main_entity_id` varchar(36) NOT NULL COMMENT '模块主体对象id(设备模块:设备id)',
  `name` varchar(100) NOT NULL COMMENT '目录名称',
  `is_delete` varchar(10) NOT NULL COMMENT '删除标记:0:未删除,1:已删除',
  `pid` varchar(36) DEFAULT NULL COMMENT '父级目录id',
  `relation_function` varchar(10) DEFAULT NULL COMMENT '关联设备模块功能',
  `relation_function_file_type` varchar(10) DEFAULT NULL COMMENT '关联功能中的目录细分类',
  `create_type` varchar(10) NOT NULL COMMENT '创建类型:1:系统,2:用户, 详见ConstantsEqFile.java 系统目录不能删除',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `t_eq_folder_parent_id` (`pid`),
  CONSTRAINT `t_eq_folder_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `t_eq_folder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备附件目录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_inspect`
--

DROP TABLE IF EXISTS `t_eq_inspect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_inspect` (
  `id` varchar(36) NOT NULL,
  `inspect_plan_id` varchar(36) NOT NULL COMMENT '期间核查计划id',
  `inspect_plan_detail_id` varchar(36) NOT NULL COMMENT '期间核查计划详情id',
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `depart_id` varchar(36) NOT NULL COMMENT '检查部门id',
  `depart_name` varchar(255) DEFAULT NULL COMMENT '核查部门名',
  `person_id` varchar(36) NOT NULL COMMENT '检查人员id',
  `person_name` varchar(255) DEFAULT NULL COMMENT '核查人员姓名',
  `plan_times` varchar(512) DEFAULT NULL COMMENT '计划时间',
  `inspect_time` datetime DEFAULT NULL COMMENT '核查时间',
  `inspect_content` varchar(200) DEFAULT NULL COMMENT '核查内容',
  `inspect_result` varchar(500) DEFAULT NULL COMMENT '核查结果及评价',
  `result_person_id` varchar(36) DEFAULT NULL COMMENT '评价人',
  `result_person_name` varchar(255) DEFAULT NULL COMMENT '评价人姓名',
  `inspect_explain` varchar(512) DEFAULT NULL COMMENT '说明/备注',
  `status` varchar(10) DEFAULT NULL COMMENT '审批状态',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='期间核查记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_inspect_plan`
--

DROP TABLE IF EXISTS `t_eq_inspect_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_inspect_plan` (
  `id` varchar(36) NOT NULL,
  `plan_type` varchar(10) NOT NULL COMMENT '计划类型:1:年度计划, 2:月度计划',
  `plan_year` varchar(20) DEFAULT NULL COMMENT '计划年份',
  `plan_mouth` varchar(20) DEFAULT NULL COMMENT '计划月份',
  `plan_depart` varchar(200) DEFAULT NULL COMMENT '计划科室',
  `plan_depart_id` varchar(36) DEFAULT NULL COMMENT '计划部门ID',
  `plan_status` varchar(10) DEFAULT NULL COMMENT '计划状态:10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='期间核查计划';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_inspect_plan_detail`
--

DROP TABLE IF EXISTS `t_eq_inspect_plan_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_inspect_plan_detail` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `inspect_plan_id` varchar(36) NOT NULL COMMENT '期间核查计划id',
  `inspect_times` varchar(512) DEFAULT NULL COMMENT '期间核查时间,多个以逗号分隔',
  `inspect_way` varchar(10) DEFAULT NULL COMMENT '核查方式:建议做成字典:1:试验比对',
  `inspect_items` varchar(1024) DEFAULT NULL COMMENT '核查参数,存参数名称逗号分隔(已沟通确认这样做,不参关联查询且基于工期妥协)',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_inspect_plan` (`inspect_plan_id`) USING BTREE,
  CONSTRAINT `t_eq_inspect_plan_detail_ibfk_1` FOREIGN KEY (`inspect_plan_id`) REFERENCES `t_eq_inspect_plan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='期间核查计划详情';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_rent`
--

DROP TABLE IF EXISTS `t_eq_rent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_rent` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) DEFAULT NULL COMMENT '设备id',
  `equipment_name` varchar(255) NOT NULL,
  `equipment_sn` varchar(255) DEFAULT NULL COMMENT '设备编号',
  `eq_standard` varchar(255) DEFAULT NULL COMMENT '设备规格型号',
  `rent_type` varchar(10) DEFAULT NULL COMMENT '借用类型:1:对外出租(出借);2:租借外部设备3内部借用',
  `out_org` varchar(255) NOT NULL COMMENT '借出机构',
  `out_org_id` varchar(36) DEFAULT NULL COMMENT '借出机构ID',
  `out_org_contacts` varchar(255) DEFAULT NULL COMMENT '借出机构联系人',
  `in_org` varchar(255) NOT NULL COMMENT '借入机构',
  `in_org_id` varchar(36) DEFAULT NULL COMMENT '借入机构ID',
  `in_org_contacts` varchar(255) DEFAULT NULL COMMENT '借入机构联系人',
  `rent_start_time` datetime DEFAULT NULL COMMENT '租借开始时间',
  `rent_end_time` datetime DEFAULT NULL COMMENT '租借结束时间',
  `return_time` datetime DEFAULT NULL COMMENT '实际归还时间',
  `equipment_price` double DEFAULT NULL COMMENT '设备单价',
  `agreement_content` varchar(500) DEFAULT NULL COMMENT '双方协商内容',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `apply_reason` varchar(500) DEFAULT NULL COMMENT '申请说明',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `apply_person` varchar(255) DEFAULT NULL COMMENT '申请人',
  `apply_status` varchar(10) DEFAULT NULL COMMENT '申请状态:10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备借用';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_repair`
--

DROP TABLE IF EXISTS `t_eq_repair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_repair` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `equipment_name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `repair_sn` varchar(100) DEFAULT NULL COMMENT '维修单号',
  `repair_service_end_time` datetime DEFAULT NULL COMMENT '保修期至',
  `phenomenon` varchar(500) DEFAULT NULL COMMENT '故障现象',
  `reason` varchar(500) DEFAULT NULL COMMENT '原因分析',
  `dispose_way` varchar(500) DEFAULT NULL COMMENT '处理方案',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `status` varchar(10) NOT NULL COMMENT '维修状态: 10:填写中,20:审批中,30:审批拒绝,40:审批通过,50:送修中,60:维修完成检验中,70:已完成,80:已取消',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备维修';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_repair_contact`
--

DROP TABLE IF EXISTS `t_eq_repair_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_repair_contact` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `repair_id` varchar(36) NOT NULL COMMENT '维修记录id',
  `repair_contacts` varchar(36) DEFAULT NULL COMMENT '维修联系人',
  `contact_time` datetime DEFAULT NULL COMMENT '维修联系时间',
  `contact_detail` varchar(200) DEFAULT NULL COMMENT '维修联系情况',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_repair_contact_repair` (`repair_id`) USING BTREE,
  CONSTRAINT `t_eq_repair_contact_ibfk_1` FOREIGN KEY (`repair_id`) REFERENCES `t_eq_repair` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备维修-联系记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_repair_detail`
--

DROP TABLE IF EXISTS `t_eq_repair_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_repair_detail` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `repair_id` varchar(36) NOT NULL COMMENT '维修记录id',
  `repair_man` varchar(50) DEFAULT NULL COMMENT '承修人',
  `repair_man_id` varchar(36) DEFAULT NULL COMMENT '承修人ID',
  `repair_unit` varchar(200) DEFAULT NULL COMMENT '承修单位',
  `repair_unit_id` varchar(36) DEFAULT NULL COMMENT '承修单位ID',
  `material_fee` double(32,2) DEFAULT NULL COMMENT '材料费',
  `labor_fee` double(32,2) DEFAULT NULL COMMENT '人工费',
  `other_fee` double(32,2) DEFAULT NULL COMMENT '其他费用',
  `total_fee` double(32,2) DEFAULT NULL COMMENT '费用合计',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_repair_detail_repair` (`repair_id`) USING BTREE,
  CONSTRAINT `t_eq_repair_detail_ibfk_1` FOREIGN KEY (`repair_id`) REFERENCES `t_eq_repair` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备维修-维修情况 ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_repair_verify`
--

DROP TABLE IF EXISTS `t_eq_repair_verify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_repair_verify` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `repair_id` varchar(36) DEFAULT NULL COMMENT '维修记录id',
  `person_id` varchar(36) DEFAULT NULL COMMENT '检验人id',
  `person_name` varchar(255) DEFAULT NULL COMMENT '检验人',
  `verify_time` datetime DEFAULT NULL COMMENT '检验时间',
  `content` varchar(500) DEFAULT NULL COMMENT '恢复程度检验结果',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_repair_verify_repair` (`repair_id`) USING BTREE,
  CONSTRAINT `t_eq_repair_verify_ibfk_1` FOREIGN KEY (`repair_id`) REFERENCES `t_eq_repair` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备维修-维修检验';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_scrap`
--

DROP TABLE IF EXISTS `t_eq_scrap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_scrap` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `equipment_name` varchar(500) DEFAULT NULL COMMENT '设备名称',
  `scrap_type` varchar(100) DEFAULT NULL COMMENT '报废类型:1:设备资产报废,2:设备实体报废.参考字典',
  `scrap_sn` varchar(100) DEFAULT NULL COMMENT '报废编号',
  `file_sn` varchar(100) DEFAULT NULL COMMENT '文件号',
  `scrap_time` datetime DEFAULT NULL COMMENT '报废时间',
  `gist` varchar(500) DEFAULT NULL COMMENT '处理依据',
  `reason` varchar(500) DEFAULT NULL COMMENT '报废原因',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `apply_person` varchar(36) DEFAULT NULL COMMENT '申请人',
  `apply_status` varchar(10) DEFAULT NULL COMMENT '申请状态:10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备报废';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_snapshot`
--

DROP TABLE IF EXISTS `t_eq_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_snapshot` (
  `id` varchar(36) NOT NULL,
  `name` varchar(200) NOT NULL COMMENT '设备名称',
  `equipment_sn` varchar(200) DEFAULT NULL COMMENT '设备编号',
  `archive_sn` varchar(200) NOT NULL COMMENT '档案编号',
  `asset_sn` varchar(200) DEFAULT NULL COMMENT '资产编号',
  `test_manage_sn` varchar(200) DEFAULT NULL COMMENT '检测管理编号',
  `standard` varchar(200) DEFAULT NULL COMMENT '规格型号',
  `eq_range` varchar(500) DEFAULT NULL COMMENT '量程',
  `accuracy` varchar(200) DEFAULT NULL COMMENT '精度',
  `size` varchar(200) DEFAULT NULL COMMENT '外形尺寸',
  `keeper_id` varchar(36) DEFAULT NULL COMMENT '保管人',
  `user_id` varchar(36) DEFAULT NULL COMMENT '使用人',
  `unit_id` varchar(36) DEFAULT NULL COMMENT '所属单位',
  `depart_id` varchar(36) NOT NULL COMMENT '所属部门',
  `storage_site` varchar(200) DEFAULT NULL COMMENT '存放地点(配置位置)',
  `status` varchar(10) NOT NULL COMMENT '设备状态',
  `type` varchar(10) NOT NULL COMMENT '设备类别',
  `check_type` varchar(10) DEFAULT NULL COMMENT '检校类型',
  `check_period` int(11) DEFAULT NULL COMMENT '检校周期',
  `check_period_unit` varchar(10) DEFAULT NULL COMMENT '检校周期单位',
  `pre_check_date` datetime DEFAULT NULL COMMENT '上次检校日期',
  `next_check_date` datetime DEFAULT NULL COMMENT '下次检校日期',
  `quantity` varchar(200) DEFAULT NULL COMMENT '数量',
  `net_value` varchar(200) DEFAULT NULL COMMENT '净值',
  `power` varchar(200) DEFAULT NULL COMMENT '功率',
  `coefficient_machine` varchar(1000) DEFAULT NULL COMMENT '复杂系数(机)',
  `coefficient_electronic` varchar(1000) DEFAULT NULL COMMENT '复杂系数(电)',
  `coefficient_hot` varchar(1000) DEFAULT NULL COMMENT '复杂系数(热)',
  `buy_id` varchar(36) DEFAULT NULL COMMENT '购置记录id',
  `buy_date` datetime DEFAULT NULL COMMENT '购置日期',
  `operation_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `supplier_id` varchar(36) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(200) DEFAULT NULL COMMENT '供应商',
  `supplier_tel` varchar(20) DEFAULT NULL COMMENT '供应商电话',
  `repair_service_end_time` datetime DEFAULT NULL COMMENT '保修期至',
  `factory` varchar(200) DEFAULT NULL COMMENT '生产厂家',
  `factory_sn` varchar(200) DEFAULT NULL COMMENT '出厂编号',
  `factory_price` double DEFAULT NULL COMMENT '出厂价',
  `production_date` datetime DEFAULT NULL COMMENT '出厂日期',
  `transport_fee` double DEFAULT NULL COMMENT '运杂费',
  `install_fee` double DEFAULT NULL COMMENT '安装费',
  `depreciation_fee` double DEFAULT NULL COMMENT '折旧费',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_eq_snapshot_buy` (`buy_id`) USING BTREE,
  CONSTRAINT `t_eq_snapshot_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `t_eq_buy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_startstop`
--

DROP TABLE IF EXISTS `t_eq_startstop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_startstop` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `equipment_name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `ss_type` varchar(10) DEFAULT NULL COMMENT '启停类型:0:设备停用,1:设备启用',
  `ss_time` datetime DEFAULT NULL COMMENT '启停时间',
  `site` varchar(200) DEFAULT NULL COMMENT '地点',
  `keeper` varchar(255) DEFAULT NULL COMMENT '保管人',
  `keeper_id` varchar(36) DEFAULT NULL COMMENT '保管人',
  `technical_status` varchar(500) DEFAULT NULL COMMENT '技术状况',
  `apply_explain` varchar(500) DEFAULT NULL COMMENT '申请说明',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `apply_person` varchar(36) DEFAULT NULL COMMENT '申请人',
  `apply_status` varchar(10) DEFAULT NULL COMMENT '申请状态:10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备启停';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_supplier`
--

DROP TABLE IF EXISTS `t_eq_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_supplier` (
  `id` varchar(36) NOT NULL,
  `name` varchar(512) NOT NULL,
  `site` varchar(1024) DEFAULT NULL COMMENT '联系地址',
  `contacts` varchar(200) DEFAULT NULL COMMENT '联系人',
  `tel` varchar(500) DEFAULT NULL COMMENT '联系电话',
  `mobile` varchar(500) DEFAULT NULL COMMENT '手机',
  `postcode` varchar(200) DEFAULT NULL COMMENT '邮编',
  `operation_content` varchar(2048) DEFAULT NULL COMMENT '经营范围',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `is_deleted` varchar(10) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记:0:未删除,1:已删除',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备供应商';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_supplier_snapshot`
--

DROP TABLE IF EXISTS `t_eq_supplier_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_supplier_snapshot` (
  `id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `buy_id` varchar(36) DEFAULT NULL COMMENT '购置记录id',
  `supplier_id` varchar(36) NOT NULL COMMENT '供应商ID',
  `name` varchar(200) NOT NULL COMMENT '供应商名称',
  `site` varchar(36) DEFAULT NULL COMMENT '联系地址',
  `contacts` varchar(200) DEFAULT NULL COMMENT '联系人',
  `tel` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机',
  `postcode` varchar(20) DEFAULT NULL COMMENT '邮编',
  `operation_content` varchar(500) DEFAULT NULL COMMENT '经营范围',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_supplier_snapshot_buy` (`buy_id`) USING BTREE,
  CONSTRAINT `t_eq_supplier_snapshot_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `t_eq_buy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商快照';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_upkeep`
--

DROP TABLE IF EXISTS `t_eq_upkeep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_upkeep` (
  `id` varchar(36) NOT NULL,
  `upkeep_plan_id` varchar(36) NOT NULL COMMENT '保养计划id',
  `upkeep_plan_sn` varchar(255) DEFAULT NULL COMMENT '保养计划编号',
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `upkeep_time` datetime DEFAULT NULL COMMENT '保养时间',
  `upkeep_way` varchar(200) DEFAULT NULL COMMENT '保养措施',
  `upkeep_person` varchar(255) DEFAULT NULL COMMENT '保养人',
  `upkeep_person_id` varchar(36) DEFAULT NULL COMMENT '保养人ID',
  `upkeep_depart` varchar(255) DEFAULT NULL COMMENT '保养部门',
  `upkeep_depart_id` varchar(36) DEFAULT NULL COMMENT '保养部门ID',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备保养';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_upkeep_plan`
--

DROP TABLE IF EXISTS `t_eq_upkeep_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_upkeep_plan` (
  `id` varchar(36) NOT NULL,
  `sn` varchar(100) DEFAULT NULL COMMENT '保养计划编号',
  `type` varchar(10) DEFAULT NULL COMMENT '计划类型:1:年度计划, 2:月度计划',
  `explain` varchar(200) DEFAULT NULL COMMENT '计划说明',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `upkeep_time` datetime DEFAULT NULL COMMENT '保养时间',
  `status` varchar(10) DEFAULT NULL COMMENT '计划状态10:填写中,20:审批中,30:审批拒绝,40:审批通过',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备保养计划';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_eq_upkeep_plan_detail`
--

DROP TABLE IF EXISTS `t_eq_upkeep_plan_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_eq_upkeep_plan_detail` (
  `id` varchar(36) NOT NULL,
  `upkeep_plan_id` varchar(36) NOT NULL COMMENT '保养计划id',
  `equipment_id` varchar(36) NOT NULL COMMENT '设备id',
  `upkeep_time` datetime DEFAULT NULL COMMENT '保养时间',
  `person_id` varchar(36) DEFAULT NULL COMMENT '保养人',
  `upkeep_way` varchar(200) DEFAULT NULL COMMENT '保养措施',
  `explain` varchar(255) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `is_deleted` varchar(10) NOT NULL COMMENT '是否已删除:1是0否',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_upkeep_plan` (`upkeep_plan_id`) USING BTREE,
  CONSTRAINT `t_eq_upkeep_plan_detail_ibfk_1` FOREIGN KEY (`upkeep_plan_id`) REFERENCES `t_eq_upkeep_plan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备保养计划明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_equipment`
--

DROP TABLE IF EXISTS `t_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_equipment` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `type` varchar(255) DEFAULT NULL COMMENT '类别名称',
  `mask` varchar(255) DEFAULT NULL COMMENT '默认编码',
  `remark` longtext COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_equipment_authority`
--

DROP TABLE IF EXISTS `t_equipment_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_equipment_authority` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `depart_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCD3C567B708C0A3D` (`user_id`) USING BTREE,
  KEY `FKCD3C567B306A0DD` (`depart_id`) USING BTREE,
  CONSTRAINT `t_equipment_authority_ibfk_1` FOREIGN KEY (`depart_id`) REFERENCES `t_s_depart` (`ID`),
  CONSTRAINT `t_equipment_authority_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_s_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_equipment_manage`
--

DROP TABLE IF EXISTS `t_equipment_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_equipment_manage` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `type_id` varchar(36) DEFAULT NULL COMMENT '设备类别Id',
  `buy_date` datetime DEFAULT NULL COMMENT '购置时间',
  `manage_type` varchar(36) DEFAULT NULL COMMENT '管理类别',
  `allot_status` varchar(36) DEFAULT NULL COMMENT '调拨状态',
  `take_person_id` varchar(36) DEFAULT NULL COMMENT '保管人',
  `eq_user_id` varchar(36) DEFAULT NULL COMMENT '使用人',
  `eq_status` varchar(1) NOT NULL DEFAULT '0' COMMENT '状态：0.普通 1.停用 2.外借 3.报废留用 4.报废 5.维修',
  `qualification_seal` varchar(36) DEFAULT NULL COMMENT '档案编号',
  `test_manage_report` varchar(36) DEFAULT NULL COMMENT '检测管理编号',
  `examination` varchar(36) DEFAULT NULL COMMENT '检校周期月',
  `next_examination_time` datetime DEFAULT NULL COMMENT '下次检校日期',
  `pre_examination_time` datetime DEFAULT NULL COMMENT '前次检校日期',
  `check_type` varchar(36) DEFAULT NULL COMMENT '检校类型',
  `my_range` varchar(128) DEFAULT NULL COMMENT '量程',
  `standard` varchar(128) DEFAULT NULL COMMENT '规格型号',
  `my_precision` varchar(128) DEFAULT NULL COMMENT '精度',
  `size` varchar(128) DEFAULT NULL COMMENT '外形尺寸',
  `power` varchar(128) DEFAULT NULL COMMENT '总功率',
  `quality` varchar(128) DEFAULT NULL COMMENT '总质量',
  `coefficient_m` varchar(128) DEFAULT NULL COMMENT '复杂系数机',
  `coefficient_e` varchar(128) DEFAULT NULL COMMENT '复杂系数电',
  `coefficient_thermal` varchar(128) DEFAULT NULL COMMENT '复杂系数热',
  `value` varchar(128) DEFAULT NULL COMMENT '原值',
  `level` varchar(128) DEFAULT NULL COMMENT '等级',
  `about_quilification` varchar(128) DEFAULT NULL COMMENT '资质相关',
  `qualification` varchar(128) DEFAULT NULL COMMENT '适用资质',
  `relevant_info` varchar(128) DEFAULT NULL COMMENT '相关信息',
  `supplier` varchar(128) DEFAULT NULL COMMENT '供应商',
  `collocating` varchar(128) DEFAULT NULL COMMENT '配置位置',
  `factory_price` varchar(128) DEFAULT NULL COMMENT '出厂价',
  `installation_cost` varchar(128) DEFAULT NULL COMMENT '安装费',
  `quantity` varchar(36) DEFAULT NULL COMMENT '数量',
  `accessory_ids` text,
  `depart_id` varchar(36) DEFAULT NULL COMMENT '所属部门',
  PRIMARY KEY (`id`),
  KEY `FK871F592DB1442249` (`type_id`) USING BTREE,
  CONSTRAINT `t_equipment_manage_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `t_equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_equipment_manage_attachment`
--

DROP TABLE IF EXISTS `t_equipment_manage_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_equipment_manage_attachment` (
  `id` varchar(55) NOT NULL,
  `equipment_manage_id` varchar(55) NOT NULL,
  `attachment_id` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_equipment_testparam_last`
--

DROP TABLE IF EXISTS `t_equipment_testparam_last`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_equipment_testparam_last` (
  `id` varchar(36) NOT NULL,
  `test_param_id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3FBF2CE29B710D9F` (`equipment_id`) USING BTREE,
  CONSTRAINT `t_equipment_testparam_last_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `t_equipment_manage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_experience_user`
--

DROP TABLE IF EXISTS `t_experience_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_experience_user` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  `user_name` varchar(255) NOT NULL COMMENT '体验用户名称',
  `company_name` varchar(255) NOT NULL COMMENT '体验用户企业名称',
  `cellphone_num` varchar(255) NOT NULL COMMENT '体验用户联系电话',
  `img_code` varchar(10) DEFAULT NULL COMMENT '录入时的图片验证码',
  `sms_code` varchar(10) DEFAULT NULL COMMENT '录入时填写的短信验证码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='在线体验用户表 - 收集的客户资料';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_contract_attachment`
--

DROP TABLE IF EXISTS `t_fee_contract_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_contract_attachment` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `file_src` longtext COMMENT '地址 - 弃用该字段，改由attachment_id代替 20190426 weiheng',
  `attachment_id` varchar(36) NOT NULL COMMENT '附件ID，关联 t_s_attachment.id',
  `remarks` longtext COMMENT '备注',
  `name` longtext COMMENT '名称',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同ID',
  PRIMARY KEY (`id`),
  KEY `FK_T_FEE_CONTRACT_ATT_ATTID` (`attachment_id`) USING BTREE,
  CONSTRAINT `t_fee_contract_attachment_ibfk_1` FOREIGN KEY (`attachment_id`) REFERENCES `t_s_attachment` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_contract_content`
--

DROP TABLE IF EXISTS `t_fee_contract_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_contract_content` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `start_date` datetime DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `params_id` varchar(32) DEFAULT NULL COMMENT '参数ID',
  `name` longtext COMMENT '名称',
  `amount` int(11) DEFAULT NULL COMMENT '数量',
  `big_category_id` varchar(36) DEFAULT NULL COMMENT '大类ID，关联 t_s_big_category.id',
  `big_category_name` varchar(200) DEFAULT NULL COMMENT '大类名称',
  `qualification_type_id` varchar(36) DEFAULT NULL COMMENT '资质ID，关联t_s_qualification_type.id',
  `qualification_type_name` varchar(200) DEFAULT NULL COMMENT '资质类型名称',
  `deposit_rate` double DEFAULT '0' COMMENT '折扣率',
  `status` varchar(32) DEFAULT NULL COMMENT '状态',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同ID',
  `price` double unsigned DEFAULT '0' COMMENT '折后价格',
  `stock` double DEFAULT NULL COMMENT '存量，冗余字段，用于记录当前合同剩余参数数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_contract_deductions`
--

DROP TABLE IF EXISTS `t_fee_contract_deductions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_contract_deductions` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同ID，t_fee_contract_main.id',
  `fee` double(32,2) NOT NULL COMMENT '扣款金额',
  `total_fee` double(32,2) DEFAULT NULL COMMENT '累计扣款（截止当前日期）',
  `record_date` datetime DEFAULT NULL COMMENT '登记日期',
  `status` int(1) DEFAULT '1' COMMENT '状态：1.正常 0.已删除',
  `audit_status` int(1) DEFAULT '1' COMMENT '审核状态：1.正常 2.审核中 3.审核不通过（默认审核通过/不需要审批）',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同扣款登记';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_contract_main`
--

DROP TABLE IF EXISTS `t_fee_contract_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_contract_main` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `name` varchar(2000) DEFAULT NULL COMMENT '合同名称',
  `owner` varchar(36) DEFAULT NULL COMMENT '负责人',
  `owner_name` varchar(50) DEFAULT NULL,
  `unit_id` varchar(36) NOT NULL COMMENT '合同方单位ID（收款合同就是甲方/付款合同就是乙方），启用甲方乙方丙方的概念 - 20190424 weiheng',
  `unit_name` varchar(255) NOT NULL COMMENT '合同方单位名称（冗余字段）',
  `first_party` varchar(36) DEFAULT NULL COMMENT '甲方（委托单位ID）',
  `second_party` varchar(500) DEFAULT NULL COMMENT '乙方',
  `third_party` varchar(500) DEFAULT NULL COMMENT '丙方',
  `no` varchar(500) DEFAULT NULL COMMENT '编号',
  `availability_date` datetime DEFAULT NULL COMMENT '生效日期',
  `signing_date` datetime DEFAULT NULL COMMENT '签字日期',
  `expiry_date` datetime DEFAULT NULL COMMENT '失效日期',
  `total_fee` double(32,2) DEFAULT NULL COMMENT '总费用，单位：元',
  `type` varchar(32) DEFAULT NULL COMMENT '费用执行方式：1.全包合同  2.折扣合同  3.指定参数折扣合同  4.指定参数价格合同',
  `fee_type` int(1) NOT NULL COMMENT '费用类型：1.收款合同 2.付款合同',
  `contract_type` int(1) NOT NULL COMMENT '合同类别：1.检测合同 2.非检测合同',
  `phone` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `is_delete` varchar(32) DEFAULT NULL COMMENT '删除',
  `scope` int(1) NOT NULL DEFAULT '1' COMMENT '作用域：1.收费/计费 2.仅用于计费  ',
  `status` varchar(2) DEFAULT NULL COMMENT '状态：0.合同终止 1.正常（审核通过/执行中）2.合同录入中 3.待审核  4.审核不通过',
  `remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  `content` varchar(4000) DEFAULT NULL COMMENT '内容',
  `deposit_rate` double(32,2) DEFAULT NULL COMMENT '折扣',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`),
  KEY `FK_CONSIGN_UNIT_ID` (`first_party`) USING BTREE,
  CONSTRAINT `t_fee_contract_main_ibfk_1` FOREIGN KEY (`first_party`) REFERENCES `t_consign_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_contract_project`
--

DROP TABLE IF EXISTS `t_fee_contract_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_contract_project` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `contract_id` varchar(32) DEFAULT NULL COMMENT '合同ID',
  `project_id` varchar(32) DEFAULT NULL COMMENT '工程ID',
  `project_name` varchar(500) DEFAULT NULL COMMENT '工程名称',
  `unit_id` varchar(36) DEFAULT NULL COMMENT '委托单位ID',
  `unit_name` varchar(255) DEFAULT NULL COMMENT '委托单位名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_contract_quantities`
--

DROP TABLE IF EXISTS `t_fee_contract_quantities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_contract_quantities` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同ID，t_fee_contract_main.id',
  `quantities` double(6,2) NOT NULL COMMENT '本期完成工程量，单位：%',
  `total_quantities` double(6,2) DEFAULT NULL COMMENT '累计完成工程量（截止当前日期），单位：%，最多不超过100%',
  `record_date` datetime DEFAULT NULL COMMENT '登记日期',
  `status` int(1) DEFAULT '1' COMMENT '状态：1.正常 0.已删除',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同工程量登记';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_credit`
--

DROP TABLE IF EXISTS `t_fee_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_credit` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `unit` varchar(32) NOT NULL COMMENT '委托单位名称 冗余',
  `unit_id` varchar(500) NOT NULL COMMENT '单位ID',
  `credit_line` double(32,2) NOT NULL COMMENT '信用额度',
  `credit_limit` datetime DEFAULT NULL COMMENT '信用期限',
  `deposit` double(32,2) DEFAULT '0.00' COMMENT '预存款',
  `used_fee` double(32,2) NOT NULL,
  `banlance` double(32,2) NOT NULL COMMENT '余额',
  `status` varchar(32) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fee_credit_unit_id` (`unit_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_credit_record`
--

DROP TABLE IF EXISTS `t_fee_credit_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_credit_record` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `credit_id` varchar(32) NOT NULL COMMENT '信用id',
  `old_credit_line` double DEFAULT NULL COMMENT '改变前信用额度',
  `credit_line` double NOT NULL COMMENT '改变后信用额度',
  `old_credit_limit` datetime DEFAULT NULL COMMENT '改变前信用期限',
  `credit_limit` datetime DEFAULT NULL COMMENT '改变后信用期限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_credit_use_detail`
--

DROP TABLE IF EXISTS `t_fee_credit_use_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_credit_use_detail` (
  `id` varchar(36) NOT NULL,
  `credit_id` varchar(36) NOT NULL COMMENT '信用记录id',
  `fee_detail_base_id` varchar(36) NOT NULL COMMENT 't_fee_details_base收费记录表的id,通过它可以找到fee_model进而找到关联对象的信息',
  `fee_object_sn` varchar(200) DEFAULT NULL COMMENT '费用关联对象的编号(如委托编号/报告编号等)',
  `payable` double(32,2) NOT NULL DEFAULT '0.00' COMMENT '应付款',
  `wait_payment` double(32,2) NOT NULL DEFAULT '0.00' COMMENT '待付款',
  `is_cleared` varchar(10) NOT NULL DEFAULT '0' COMMENT '是否已结清: 0:否, 1:是',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='挂账明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_detail_extend`
--

DROP TABLE IF EXISTS `t_fee_detail_extend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_detail_extend` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `value` decimal(32,2) DEFAULT NULL COMMENT '费用',
  `value_desc` varchar(100) DEFAULT NULL COMMENT '金额描述，储存计算公式用于前台显示',
  `model_id` varchar(32) DEFAULT NULL COMMENT '费用ID',
  `detail_base_id` varchar(32) DEFAULT NULL COMMENT '费用明细ID',
  `extend_object_id` varchar(32) DEFAULT NULL COMMENT '扩展对象ID',
  `share_identity` varchar(255) DEFAULT NULL COMMENT '实验参数共享单价分组标识',
  `amount` int(32) DEFAULT NULL COMMENT '数量',
  `discount_price` decimal(32,2) DEFAULT NULL COMMENT '折后价',
  `discount` decimal(32,2) DEFAULT NULL COMMENT '折扣',
  `fee_type` int(2) DEFAULT '1' COMMENT '费用类型：1.试验参数  2.附加费用  3.其他',
  `price_id` varchar(36) DEFAULT NULL COMMENT '价格ID（取原价时用） t_s_test_param_price_working_hour.id',
  `price` decimal(32,2) DEFAULT NULL COMMENT '单价',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同ID，冗余',
  `contract_name` varchar(2000) DEFAULT NULL COMMENT '合同Name，冗余',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态：1.正常 0.已作废',
  `version` int(3) DEFAULT '1' COMMENT '版本信息：费用调整/修改时自增',
  `test_sample_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='费用明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_details_base`
--

DROP TABLE IF EXISTS `t_fee_details_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_details_base` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `charge_date` date DEFAULT NULL COMMENT '收费日期',
  `value` decimal(32,2) NOT NULL DEFAULT '0.00' COMMENT '费用',
  `remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  `type` varchar(32) DEFAULT NULL COMMENT '1.收费 2.退费',
  `model_id` varchar(32) DEFAULT NULL COMMENT '费用ID',
  `check_no` varchar(200) DEFAULT NULL COMMENT '支票号',
  `check_agent` varchar(32) DEFAULT NULL COMMENT '支票经办人',
  `credit_record_id` varchar(32) DEFAULT NULL COMMENT '信用记录ID',
  `operator` varchar(32) DEFAULT NULL COMMENT '转账操作人',
  `transfer_suc_time` varchar(32) DEFAULT NULL COMMENT '到账时间',
  `check_type` varchar(20) DEFAULT NULL COMMENT '支票类型',
  `transfer_time` varchar(32) DEFAULT NULL COMMENT '转账时间',
  `operator_tel` varchar(32) DEFAULT NULL COMMENT '现金支付人电话',
  `transfer_account` varchar(32) DEFAULT NULL COMMENT '转入帐号',
  `transfer_out_account` varchar(32) DEFAULT NULL COMMENT '转出账户',
  `contract_name` varchar(2000) DEFAULT NULL COMMENT '合同编号（冗余字段，用于详细信息展示）',
  `contract_no` varchar(500) DEFAULT NULL COMMENT '合同编号（冗余字段）',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同ID，关联 t_fee_contract_main.id',
  `paid_type` varchar(32) DEFAULT NULL COMMENT '支付方式，由这个字段决定是什么类型的子类，这个关系是由hibernate维护的.具体的值查看实体类的@DiscriminatorValue注解',
  PRIMARY KEY (`id`),
  KEY `t_fee_details_base_model_id_index` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='缴费记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_model`
--

DROP TABLE IF EXISTS `t_fee_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_model` (
  `id` varchar(36) NOT NULL,
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `fee_origin` double(32,2) DEFAULT NULL COMMENT '原始价格合计（折扣/优惠前）',
  `fee_total` double(32,2) NOT NULL DEFAULT '0.00' COMMENT '待缴费用',
  `fee_paid` double(32,2) DEFAULT '0.00' COMMENT '已缴费用',
  `status` varchar(32) DEFAULT NULL COMMENT '状态：0.已作废 1.已结清 2.部分缴费 3.未缴费',
  `payment_company` varchar(1024) NOT NULL COMMENT '缴费单位名称_冗余',
  `unit_id` varchar(500) DEFAULT NULL COMMENT '委托单位ID',
  `object_type` varchar(32) NOT NULL COMMENT '缴费类型：FeeReType 重打费用，FeeConsign 委托费用，FeeContract 合同费用, FeeReport 报告费用, FeeUpdateReport 报告修改费用',
  `object_id` varchar(36) DEFAULT NULL COMMENT '关联对象',
  `fee_contract_id` varchar(36) DEFAULT NULL COMMENT '合同ID（t_fee_model.id）',
  `version` int(3) DEFAULT '1' COMMENT '版本信息：费用调整/修改时自增',
  `code` varchar(255) DEFAULT NULL COMMENT '费用编号，没有关联费用对象时，用户输入',
  PRIMARY KEY (`id`),
  KEY `IDX_FEE_MODEL_OBJECT_ID` (`object_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_receipt`
--

DROP TABLE IF EXISTS `t_fee_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_receipt` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `heading` varchar(500) DEFAULT NULL COMMENT '台头',
  `money` double DEFAULT NULL COMMENT '开票金额',
  `content` text COMMENT '开票内容',
  `type` varchar(32) DEFAULT NULL COMMENT '发票类型',
  `status` varchar(32) DEFAULT NULL COMMENT '发票状态',
  `operator` varchar(32) DEFAULT NULL COMMENT '开票人冗余',
  `reviewer` varchar(32) DEFAULT NULL COMMENT '审核人冗余',
  `approver` varchar(32) DEFAULT NULL COMMENT '批准人冗余',
  `company_code` varchar(200) DEFAULT NULL COMMENT '单位码',
  `company_id` varchar(36) DEFAULT NULL,
  `company_name` varchar(200) DEFAULT NULL COMMENT '单位名称冗余',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_receipt_detail`
--

DROP TABLE IF EXISTS `t_fee_receipt_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_receipt_detail` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `fee_detail_id` varchar(32) DEFAULT NULL COMMENT '费用明细ID',
  `value` double(32,0) DEFAULT NULL COMMENT '金额',
  `fee_create_time` datetime DEFAULT NULL COMMENT '费用发生时间',
  `fee_type` varchar(32) DEFAULT NULL COMMENT '费用类型',
  `remarks` varchar(32) DEFAULT NULL COMMENT '备注',
  `fee_receipt_id` varchar(32) DEFAULT NULL COMMENT '发票ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_repayment`
--

DROP TABLE IF EXISTS `t_fee_repayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_repayment` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `date` datetime NOT NULL COMMENT '回款日期',
  `fee` double(32,2) NOT NULL COMMENT '回款金额',
  `way` varchar(10) NOT NULL COMMENT '支付方式',
  `total_fee` double(32,2) DEFAULT NULL COMMENT '到目前为止的回款总额',
  `relation_type` varchar(10) NOT NULL COMMENT '关联类型 1:合同回款, 2:信用回款',
  `relation_id` varchar(36) NOT NULL COMMENT '关联类型的对象id(如合同或信用)',
  `pay_unit` varchar(500) DEFAULT NULL COMMENT '缴费单位',
  `transfer_into_account` varchar(100) DEFAULT NULL COMMENT '转入账户',
  `transfer_out_account` varchar(100) DEFAULT NULL COMMENT '转出账户',
  `transfer_date` datetime DEFAULT NULL COMMENT '转账时间',
  `cheque_code` varchar(100) DEFAULT NULL COMMENT '支票号',
  `cheque_operator` varchar(100) DEFAULT NULL COMMENT '支票经办人',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `status` int(1) DEFAULT '1' COMMENT '状态：1.正常 0.已删除',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='回款记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_fee_repayment_plan`
--

DROP TABLE IF EXISTS `t_fee_repayment_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fee_repayment_plan` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `appoint_back_date` datetime NOT NULL COMMENT '约定回款日期',
  `appoint_fee` double(32,2) NOT NULL COMMENT '约定回款金额',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `contract_id` varchar(36) NOT NULL COMMENT '合同ID，t_fee_contract_main.id',
  `status` int(1) DEFAULT '1' COMMENT '状态：1.正常 0.已删除',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='回款计划登记';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_file_comment`
--

DROP TABLE IF EXISTS `t_file_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_file_comment` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `comment_id` varchar(32) NOT NULL COMMENT '批注ID - 对应Word/Excel/UDR文件解析得到',
  `text` varchar(2000) DEFAULT NULL COMMENT '引用正文',
  `comment` varchar(2000) DEFAULT NULL COMMENT '批注内容',
  `author` varchar(50) DEFAULT NULL COMMENT '批注人（Word/Excel文件解析得到）',
  `type` varchar(1) DEFAULT NULL COMMENT '批注类型：2.Word 3.Excel 1.UDR（这个看以后要不要迁移过来吧，现在是在 t_udr_comments）',
  `attach_id` varchar(36) DEFAULT NULL COMMENT '文件ID（解析的文件对象），对应 t_s_attachment.id',
  `source_type` varchar(1) DEFAULT NULL COMMENT '来源分类：1.复核 2.审核 3.批准',
  `object_type` varchar(1) DEFAULT '1' COMMENT '关联业务对象类型：1.报告',
  `object_id` varchar(36) DEFAULT NULL COMMENT '对象ID',
  `status` varchar(1) DEFAULT NULL COMMENT '数据状态：1.正常 0.已删除',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件批注信息表（目前用于报告文件Word批注信息解析存储 - 20190828 weiheng）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_folder`
--

DROP TABLE IF EXISTS `t_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_folder` (
  `id` varchar(55) NOT NULL,
  `folder_name` varchar(255) NOT NULL,
  `parent_folder_id` varchar(55) DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `folderName` varchar(255) DEFAULT NULL,
  `parentFolderId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_folder_attachment`
--

DROP TABLE IF EXISTS `t_folder_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_folder_attachment` (
  `id` varchar(55) NOT NULL,
  `attachment_name` varchar(512) DEFAULT NULL,
  `folder_id` varchar(55) NOT NULL,
  `attachment_id` varchar(55) NOT NULL,
  `attachment_realpath` varchar(255) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acccc` (`attachment_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_holiday_record`
--

DROP TABLE IF EXISTS `t_holiday_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_holiday_record` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_deleted` char(2) DEFAULT '0' COMMENT '是否删除 0-未删除 1-删除',
  `day_name` varchar(200) DEFAULT NULL COMMENT '节假日日期*名字 *-代表放假节日 不放假为空格',
  `holiday_type` varchar(50) DEFAULT NULL COMMENT 'lunar-农历节日 gregorian-公历节日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节假日表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_object_log`
--

DROP TABLE IF EXISTS `t_object_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_object_log` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` date DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `object_id` varchar(200) DEFAULT NULL COMMENT '样品编号',
  `status` varchar(32) DEFAULT NULL COMMENT '样品状态',
  `remark` longtext COMMENT '备注',
  `reserved_person` varchar(32) DEFAULT NULL COMMENT '留样人',
  `taking_person` varchar(32) DEFAULT NULL COMMENT '领取人',
  `operator` varchar(32) DEFAULT NULL COMMENT '处理人',
  `stock_person` varchar(32) DEFAULT NULL COMMENT '入库人',
  `deadline` varchar(32) DEFAULT NULL COMMENT '留样时间',
  `site` varchar(50) DEFAULT NULL COMMENT '留样地点',
  `reason` varchar(32) DEFAULT NULL COMMENT '留样原因',
  `way` varchar(32) DEFAULT NULL COMMENT '处理方式',
  `reserved_quantity` int(32) DEFAULT NULL COMMENT '留样数量',
  `taking_quantity` int(32) DEFAULT NULL COMMENT '领取数量',
  `operator_quantity` int(32) DEFAULT NULL COMMENT '处理数量',
  `sample_name` varchar(255) DEFAULT NULL COMMENT '样品名称',
  `consign_date` date DEFAULT NULL COMMENT '委托日期',
  `sample_num` varchar(255) DEFAULT NULL,
  `standard` varchar(2000) DEFAULT NULL COMMENT '规格型号',
  `auditing` varchar(32) DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_object_manage`
--

DROP TABLE IF EXISTS `t_object_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_object_manage` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `object_id` varchar(36) DEFAULT NULL COMMENT '样品ID',
  `quantity` varchar(32) DEFAULT NULL COMMENT '样品数量',
  `remark` longtext COMMENT '备注',
  `object_code` varchar(36) DEFAULT NULL COMMENT '样品编号',
  PRIMARY KEY (`id`),
  KEY `FKB6B099DA3674D9F7` (`object_id`) USING BTREE,
  CONSTRAINT `t_object_manage_ibfk_1` FOREIGN KEY (`object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_param_version_management`
--

DROP TABLE IF EXISTS `t_param_version_management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_param_version_management` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0-未删除 1-已删除',
  `is_enable` char(2) NOT NULL DEFAULT '0' COMMENT '是否启用 0-未启用 1-启用',
  `version_name` varchar(50) DEFAULT NULL COMMENT '版本名称',
  `copy_param_version_id` varchar(36) DEFAULT NULL COMMENT '复制的检测参数版本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检查参数版本管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_post_info`
--

DROP TABLE IF EXISTS `t_post_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_post_info` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `info_subject` varchar(255) NOT NULL COMMENT '邮寄单配置名称',
  `receiver` varchar(50) NOT NULL COMMENT '收件人',
  `phone` varchar(30) NOT NULL COMMENT '电话',
  `address` varchar(255) NOT NULL COMMENT '收件地址',
  `express_company` varchar(50) NOT NULL COMMENT '邮寄公司',
  `express_company_code` varchar(50) NOT NULL COMMENT '邮寄公司编码',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮寄配置单信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_pre_consign_system_info`
--

DROP TABLE IF EXISTS `t_pre_consign_system_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_pre_consign_system_info` (
  `id` varchar(36) NOT NULL,
  `deploy_addr` varchar(100) DEFAULT NULL COMMENT '部署地址，端口号',
  `auth_code` varchar(10) DEFAULT NULL COMMENT '授权码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_pre_consign_api_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预委托平台部署地址以及授权码';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_print_record`
--

DROP TABLE IF EXISTS `t_print_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_print_record` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `print_num` int(3) unsigned zerofill NOT NULL COMMENT '打印份数',
  `print_type` varchar(10) DEFAULT NULL COMMENT '打印类型：report - 检测报告; record - 原始记录; consign - 委托单; taskAssign - 任务分配单;',
  `object_id` varchar(36) DEFAULT NULL COMMENT '对象ID，根据 print_type 判断对象（注：记录对象存的是报告ID）',
  PRIMARY KEY (`id`),
  KEY `IDX_PRINT_RECORD_OBJECT_ID` (`object_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_process_person_group`
--

DROP TABLE IF EXISTS `t_process_person_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_process_person_group` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `name` varchar(255) NOT NULL COMMENT '组名称',
  `process_type_id` varchar(50) NOT NULL COMMENT '流程类型(1:重打修改审批, 后续添加记得写注释)',
  `is_delete` varchar(10) DEFAULT '0' COMMENT '是否逻辑删除(废弃)',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_process_person_preset`
--

DROP TABLE IF EXISTS `t_process_person_preset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_process_person_preset` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `group_id` varchar(50) NOT NULL COMMENT '流程类型(1:重打修改审批, 后续添加记得写注释)',
  `user_id` varchar(36) NOT NULL COMMENT '用户ID',
  `user_sequence` int(11) NOT NULL COMMENT '先后顺序,从1开始',
  `is_delete` varchar(10) DEFAULT '0' COMMENT '是否逻辑删除(废弃)',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_process_type`
--

DROP TABLE IF EXISTS `t_process_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_process_type` (
  `id` varchar(36) NOT NULL COMMENT '流程分类id',
  `name` varchar(255) NOT NULL COMMENT '流程分类名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注,描述等',
  `is_delete` varchar(255) DEFAULT '0' COMMENT '是否已废弃',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report`
--

DROP TABLE IF EXISTS `t_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态：0.回退 1.正常',
  `submit_date` datetime DEFAULT NULL COMMENT '报告提交时间',
  `report_number` varchar(64) DEFAULT NULL COMMENT '报告编号',
  `history_id` varchar(36) DEFAULT NULL COMMENT '打印历史',
  `handover_way` varchar(36) DEFAULT NULL COMMENT '报告交接方式',
  `print_status` varchar(36) DEFAULT NULL COMMENT '打印状态',
  `issue_status` varchar(10) DEFAULT '0' COMMENT '发放状态:0:未发放, 1:已发放',
  `archive_status` varchar(10) DEFAULT '0' COMMENT '归档状态: 0: 未归档, 1: 已归档',
  `charge_status` varchar(36) DEFAULT NULL COMMENT '收费状态',
  `report_type` varchar(36) DEFAULT NULL COMMENT '报告类型 formal:正式报告, temporary:临时报告, synthesis:综合报告, synthesis_temp:综合临时报告',
  `report_status` varchar(36) DEFAULT NULL COMMENT '报告状态',
  `back_from` varchar(2) DEFAULT NULL COMMENT '回退节点：20.批准	30.打印	  -- 重打、发放、归档阶段不会回归  20181011 曾继强回复',
  `been_modified` varchar(1) DEFAULT '0' COMMENT '报告是否被修改过：1.是  0.否',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `sys_company_code` varchar(50) DEFAULT NULL,
  `is_scrap` varchar(1) DEFAULT NULL COMMENT '废弃状态: 0:false, 1:true(已经废弃)',
  `is_delete` varchar(1) DEFAULT '0',
  `period_id` varchar(36) DEFAULT NULL COMMENT '龄期记录id(只有临时报告才有)',
  `consign_unit_id` varchar(36) DEFAULT NULL COMMENT '委托单位ID',
  `consign_project_id` varchar(36) DEFAULT NULL COMMENT '工程项目ID',
  `contract_id` varchar(36) DEFAULT NULL COMMENT '合同ID',
  `copies` int(11) DEFAULT NULL COMMENT '份数',
  `test_time_begin` datetime DEFAULT NULL COMMENT '检测时间开始点',
  `test_time_end` datetime DEFAULT NULL COMMENT '检测时间结束点',
  `sign_date` datetime DEFAULT NULL COMMENT '签发日期',
  `is_qualified` varchar(1) DEFAULT NULL COMMENT '是否合格 0:不合格  1:合格  2:不做判定',
  `verdict` varchar(4094) DEFAULT NULL COMMENT '检测结论',
  `verdict_remark` varchar(511) DEFAULT NULL COMMENT '结论备注',
  `sn_category_id` varchar(36) DEFAULT NULL COMMENT '报告的编号类型id,综合报告为自选类型,常规报告来源于委托时选的类型',
  `noticed_receive` varchar(1) DEFAULT NULL COMMENT '是否已通知领取：1.是 0.否',
  `is_mark_print` char(2) DEFAULT NULL COMMENT '是否标记打印 0-否 1-是',
  `is_stamp` char(2) DEFAULT NULL COMMENT '报告是否盖章 0-否 1-是',
  PRIMARY KEY (`id`),
  KEY `ind_report_status` (`report_status`) USING BTREE,
  KEY `ind_print_status` (`print_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_approval`
--

DROP TABLE IF EXISTS `t_report_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_approval` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `operation_type` varchar(2) DEFAULT NULL COMMENT '操作类型：10.数据复核 20.报告审核 30.报告批准 40.报告打印 50.报告领取',
  `operator_id` varchar(36) DEFAULT NULL COMMENT '操作人ID',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间（因为可能存在用户补录的情况，涉及用户自己选择日期的场景）',
  `result` int(1) DEFAULT NULL COMMENT '结果：1.通过 0.不通过',
  `report_id` varchar(36) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `BPM_STATUS` varchar(32) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `version` varchar(36) DEFAULT NULL,
  `remarks2` varchar(1024) DEFAULT NULL,
  `is_delete` varchar(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_REPORT_APPROVAL_REPORT_ID` (`report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_barcode`
--

DROP TABLE IF EXISTS `t_report_barcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_barcode` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `attachment_id` varchar(36) NOT NULL COMMENT '附件id',
  `attachment_name` varchar(255) NOT NULL COMMENT '附件名称',
  `url` varchar(500) NOT NULL COMMENT '二维码地址',
  `report_id` varchar(36) DEFAULT NULL COMMENT '报告id',
  PRIMARY KEY (`id`),
  KEY `t_report_barcode_t_report_id_fk` (`report_id`),
  CONSTRAINT `t_report_barcode_t_report_id_fk` FOREIGN KEY (`report_id`) REFERENCES `t_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目附录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_commit_record`
--

DROP TABLE IF EXISTS `t_report_commit_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_commit_record` (
  `id` varchar(36) NOT NULL COMMENT '报告确认记录id',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人名字',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `report_id` varchar(36) NOT NULL COMMENT '报告id',
  `commit_user_id` varchar(36) NOT NULL COMMENT '提交人的id',
  `commit_type` varchar(10) DEFAULT NULL COMMENT '提交类型: 0:初次提交, 1:确认提交',
  `commit_result` varchar(1) DEFAULT '1' COMMENT '提交结果：1.同意 0.不同意',
  `commit_opinion` varchar(1000) DEFAULT NULL COMMENT '提交意见',
  `is_delete` varchar(10) DEFAULT '0' COMMENT '是否已逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告提交记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_file`
--

DROP TABLE IF EXISTS `t_report_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_file` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `remarks` varchar(255) DEFAULT NULL,
  `report_id` varchar(36) DEFAULT NULL,
  `attachment_id` varchar(36) NOT NULL,
  `source_type` varchar(1) DEFAULT NULL COMMENT '来源分类: 0:系统  1:用户',
  `open_type` varchar(1) DEFAULT NULL COMMENT '报告查阅方式：1.源文件 2.UDR 3.PDF',
  `sys_company_code` varchar(50) DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL COMMENT '类型：1.报告文件 2.报告附件 3.报告记录',
  `is_delete` varchar(1) DEFAULT '0' COMMENT '是否删除：1.已删除 0.未删除',
  PRIMARY KEY (`id`),
  KEY `IDX_REPORT_FILE_REPORT_ID` (`report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_issue`
--

DROP TABLE IF EXISTS `t_report_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_issue` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `report_id` varchar(36) NOT NULL COMMENT '报告id',
  `issue_way` varchar(10) NOT NULL DEFAULT '1' COMMENT '发放方式:1:自取,2:代领,3:邮寄,4:传真  来源于旧代码',
  `operator_id` varchar(255) NOT NULL COMMENT '经办人id',
  `operator_name` varchar(255) DEFAULT NULL COMMENT '经办人姓名',
  `issue_date` datetime NOT NULL COMMENT '发放日期',
  `receiver` varchar(255) DEFAULT NULL COMMENT '领取人/邮寄方式的收件人(可能不是系统人员,只是描述性字符串)',
  `receiver_signature` varchar(255) DEFAULT NULL COMMENT '领取人签名图片id(t_s_attachment.id)',
  `fax_number` varchar(50) DEFAULT NULL COMMENT '传真号',
  `receiver_phone` varchar(50) DEFAULT NULL COMMENT '收件人电话',
  `mail_address` varchar(1024) DEFAULT NULL COMMENT '邮寄地址',
  `mail_company` varchar(100) DEFAULT NULL COMMENT '邮寄公司',
  `mail_number` varchar(100) DEFAULT NULL COMMENT '邮寄单号',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `attachment_id` varchar(36) DEFAULT NULL COMMENT '附件id',
  `is_delete` varchar(2) NOT NULL DEFAULT '0' COMMENT '是否删除(是否撤销登记)',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_issue_attachment`
--

DROP TABLE IF EXISTS `t_report_issue_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_issue_attachment` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `report_issue_id` varchar(36) NOT NULL COMMENT '报告发放记录id',
  `attachmnet_id` varchar(36) NOT NULL COMMENT '附件id',
  `is_delete` varchar(10) DEFAULT '0' COMMENT '是否已删除',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_object`
--

DROP TABLE IF EXISTS `t_report_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_object` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `report_id` varchar(32) NOT NULL COMMENT '报告ID',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `test_object_id` varchar(32) NOT NULL COMMENT '样品ID',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`),
  KEY `idx_report_object_reportid` (`report_id`) USING BTREE,
  KEY `idx_report_object_objectid` (`test_object_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_other_file`
--

DROP TABLE IF EXISTS `t_report_other_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_other_file` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `sys_company_code` varchar(50) DEFAULT NULL,
  `source_type` varchar(1) DEFAULT NULL COMMENT '来源分类: 0:系统  1:用户',
  `object_type` varchar(50) DEFAULT NULL COMMENT '文件所属对象 委托-consign task-任务 report-报告',
  `file_type` varchar(30) DEFAULT NULL COMMENT '文件类型 reportQuestion-复核审批意见',
  `report_id` varchar(36) DEFAULT NULL COMMENT '报告id',
  `task_id` varchar(36) DEFAULT NULL COMMENT '任务id',
  `consign_id` varchar(36) DEFAULT NULL COMMENT '委托id',
  `test_object_id` varchar(36) DEFAULT NULL COMMENT '样品id',
  `url` varchar(100) DEFAULT NULL COMMENT '附件路径',
  `name` varchar(100) DEFAULT NULL COMMENT '附件名称',
  `convert_status` char(2) DEFAULT NULL COMMENT '转换状态 1-转换中 2-转换成功 3-转换失败',
  `is_delete` char(2) DEFAULT '0' COMMENT '是否删除：1.已删除 0.未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告其他附件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_period`
--

DROP TABLE IF EXISTS `t_report_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_period` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构编码',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人',
  `test_object_id` varchar(36) NOT NULL COMMENT '收样样品id',
  `report_id` varchar(36) NOT NULL COMMENT '报告id',
  `hitek_age_day` varchar(255) DEFAULT NULL COMMENT '海特数据中心龄期天数字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_person`
--

DROP TABLE IF EXISTS `t_report_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_person` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  `type` varchar(50) DEFAULT NULL COMMENT '人员类型0:报告负责人, 1:报告创建人, 2:报告编写人, 3:复核人, 4:审核人, 5:批准人, 6:检测人',
  `user_id` varchar(36) NOT NULL COMMENT '人员id',
  `report_id` varchar(36) NOT NULL COMMENT '报告ID',
  PRIMARY KEY (`id`),
  KEY `IDX_REPORT_PERSON_REPORT_ID` (`report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告人员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_qualification`
--

DROP TABLE IF EXISTS `t_report_qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_qualification` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `report_id` varchar(36) DEFAULT NULL COMMENT '报告ID：t_report.id',
  `qualification_id` varchar(36) DEFAULT NULL COMMENT '资质章ID：t_s_qualification_type.id',
  PRIMARY KEY (`id`),
  KEY `IDX_REPORT_QUALIFICATION_REPORT_ID` (`report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告资质关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_question`
--

DROP TABLE IF EXISTS `t_report_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_question` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `report_id` varchar(36) NOT NULL COMMENT '报告id',
  `test_task_id` varchar(36) DEFAULT NULL COMMENT '任务id(冗余备查)',
  `question_type_id` varchar(36) DEFAULT NULL COMMENT '问题类型id',
  `content` varchar(500) NOT NULL COMMENT '问题内容',
  `status` varchar(10) NOT NULL COMMENT '修正情况: 0:提出未修正, 1: 已修正, 2:打回未修正',
  `source_module` varchar(20) NOT NULL COMMENT '来源模块: 1:复核, 2:审核, 3:批准',
  `source_type` varchar(10) NOT NULL COMMENT '来源类型: 1:UDR批注, 2:Word批注, 3:手动添加',
  `source_obj_id` varchar(50) DEFAULT NULL COMMENT '来源类型关联的对象id(UDR批注表id或报告批注表id)',
  `amend_user_id` varchar(36) DEFAULT NULL COMMENT '修正人id',
  `amend_user_name` varchar(100) DEFAULT NULL COMMENT '修正人姓名(冗余备查)',
  `amend_time` datetime DEFAULT NULL COMMENT '修正时间',
  `is_deleted` varchar(10) NOT NULL COMMENT '逻辑删除标记',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `create_user_id` varchar(36) NOT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告问题表(审批意见/批注处理表)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_question_type`
--

DROP TABLE IF EXISTS `t_report_question_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_question_type` (
  `id` varchar(36) NOT NULL,
  `big_type` varchar(200) DEFAULT NULL COMMENT '问题大类',
  `type` varchar(500) NOT NULL COMMENT '问题类型',
  `severity` varchar(100) DEFAULT NULL COMMENT '严重程度',
  `order_number` int(11) NOT NULL COMMENT '排序号',
  `use_scope` varchar(10) DEFAULT NULL COMMENT '适用范围:1:全部参数,2:指定参数',
  `is_deleted` varchar(10) NOT NULL COMMENT '逻辑删除标记',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告问题类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_question_type_testparam`
--

DROP TABLE IF EXISTS `t_report_question_type_testparam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_question_type_testparam` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `report_question_type_id` varchar(36) NOT NULL COMMENT '报告问题类型id',
  `test_param_id` varchar(36) NOT NULL COMMENT '系统检测参数id',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`),
  KEY `idx_question_type_id` (`report_question_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告问题类型 和 系统试验参数的关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_redo_audit`
--

DROP TABLE IF EXISTS `t_report_redo_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_redo_audit` (
  `id` varchar(36) NOT NULL COMMENT '审核对象ID',
  `report_id` varchar(36) NOT NULL COMMENT '报告ID',
  `report_sn` varchar(255) DEFAULT NULL COMMENT '报告编号',
  `audit_type` varchar(50) NOT NULL COMMENT '审核类型',
  `apply_date` datetime DEFAULT NULL COMMENT '申请时间',
  `apply_user_id` varchar(36) NOT NULL COMMENT '申请人ID',
  `status` varchar(50) DEFAULT NULL COMMENT '流程状态',
  `workflow_task_id` varchar(36) DEFAULT NULL COMMENT '工作流任务ID',
  `report_use` varchar(10) NOT NULL COMMENT '报告用途',
  `reprint_count` int(11) DEFAULT NULL COMMENT '重打份数',
  `reprint_reason` varchar(255) DEFAULT NULL COMMENT '重打原因',
  `modify_content` varchar(1020) DEFAULT NULL COMMENT '修改内容',
  `return_to` varchar(255) DEFAULT NULL COMMENT '报告回退到哪里',
  `return_opinion` varchar(255) DEFAULT NULL COMMENT '回退意见',
  `fee_price` varchar(10) DEFAULT NULL COMMENT '费用价格',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构编码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_redo_audit_file`
--

DROP TABLE IF EXISTS `t_report_redo_audit_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_redo_audit_file` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `report_redo_audit_id` varchar(36) NOT NULL COMMENT '审核实体的id',
  `attachment_id` varchar(36) NOT NULL COMMENT '附件id,对应t_s_attachment表中的id',
  `type` varchar(10) DEFAULT NULL COMMENT '预留分类字段,暂未使用,使用时请说明类型含义',
  `is_delete` varchar(2) DEFAULT NULL COMMENT '是否标记为已删除: 0:未删除, 1:已删除',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_redo_audit_person`
--

DROP TABLE IF EXISTS `t_report_redo_audit_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_redo_audit_person` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `user_id` varchar(36) NOT NULL COMMENT '用户ID',
  `report_redo_audit_id` varchar(36) NOT NULL COMMENT '审核记录id',
  `audit_sequence` int(11) NOT NULL COMMENT '审核顺序',
  `is_pass` varchar(10) DEFAULT NULL COMMENT '是否通过',
  `opinion` varchar(255) DEFAULT NULL COMMENT '意见',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_relation`
--

DROP TABLE IF EXISTS `t_report_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_relation` (
  `id` varchar(36) NOT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构编码',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `formal_report_id` varchar(36) DEFAULT NULL COMMENT '正式报告id',
  `temp_report_id` varchar(36) DEFAULT NULL COMMENT '临时报告id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报告与报告之间的关系,目前提供于正式报告与临时报告之间的关系,后续有其他需求可以添加字段以适应更多的关系记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_reprint`
--

DROP TABLE IF EXISTS `t_report_reprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_reprint` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `report_id` varchar(36) DEFAULT NULL COMMENT '报告id',
  `reprint_cause` text COMMENT '重打原因',
  `quantity` varchar(10) DEFAULT NULL COMMENT 'int',
  `application_user` varchar(36) DEFAULT NULL COMMENT '申请人',
  `update_report` varchar(36) DEFAULT NULL COMMENT '是否修改报告内容',
  `application_form` text COMMENT '申请书',
  `old_content` text COMMENT '原内容',
  `new_content` text COMMENT '新内容',
  `update_info_id` varchar(36) DEFAULT NULL COMMENT '修改字段表id',
  `version` varchar(36) DEFAULT NULL COMMENT '版本',
  `result` varchar(36) DEFAULT NULL COMMENT '处理结果',
  `status` varchar(36) DEFAULT NULL,
  `update_or_not` varchar(10) DEFAULT NULL,
  `charge_or_not` varchar(10) DEFAULT NULL,
  `update_type` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKEF406068A452394` (`report_id`) USING BTREE,
  CONSTRAINT `t_report_reprint_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `t_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_reprint_charge`
--

DROP TABLE IF EXISTS `t_report_reprint_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_reprint_charge` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `reprint_unit_price` varchar(32) DEFAULT NULL COMMENT '重打单价',
  `reprint_quantity` varchar(32) DEFAULT NULL COMMENT '重打数量',
  `update_unit_price` varchar(32) DEFAULT NULL COMMENT '修改单价',
  `update_quantity` varchar(32) DEFAULT NULL COMMENT '修改数量',
  `others_unit_price` varchar(32) DEFAULT NULL COMMENT '其他单价',
  `others_quantity` varchar(32) DEFAULT NULL COMMENT '其他数量',
  `reprint_id` varchar(32) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDCE21719CE5AF9F2` (`reprint_id`) USING BTREE,
  CONSTRAINT `t_report_reprint_charge_ibfk_1` FOREIGN KEY (`reprint_id`) REFERENCES `t_report_reprint` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_signature_config`
--

DROP TABLE IF EXISTS `t_report_signature_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_signature_config` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `sys_company_code` varchar(50) DEFAULT NULL,
  `match_type` int(1) DEFAULT NULL COMMENT '匹配类型：1.按特殊字符 2.按坐标(未配置page_index则通配所有页面)',
  `data_type` int(2) DEFAULT NULL COMMENT '数据类型：10.试验人签名 15.报告编写人 20.复核人 30.审核人 40.批准人/签发人 60.资质章',
  `match_text` varchar(6) DEFAULT NULL COMMENT '匹配的特殊字符，超过3个字符则只读取前3进行匹配',
  `page_index` int(4) DEFAULT NULL COMMENT '页面索引',
  `position_x` float(6,2) DEFAULT NULL COMMENT '横坐标，左上角为0开始计算',
  `position_y` float(6,2) DEFAULT NULL COMMENT '纵坐标，左上角为0开始计算',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_report_update`
--

DROP TABLE IF EXISTS `t_report_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_report_update` (
  `ID` varchar(36) NOT NULL,
  `APPLICATION_FORM` longtext,
  `APPLICATION_USER` varchar(36) DEFAULT NULL,
  `CHARGE` varchar(36) DEFAULT NULL,
  `CONTENT_DESCRIPTION` varchar(255) DEFAULT NULL,
  `CREATE_BY` varchar(50) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `CREATE_NAME` varchar(50) DEFAULT NULL,
  `QUANTITY` varchar(10) DEFAULT NULL,
  `RESULT` varchar(36) DEFAULT NULL,
  `STATUS` varchar(36) DEFAULT NULL,
  `SYS_COMPANY_CODE` varchar(50) DEFAULT NULL,
  `SYS_ORG_CODE` varchar(50) DEFAULT NULL,
  `UPDATE_BY` varchar(50) DEFAULT NULL,
  `Update_CAUSE` longtext,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `UPDATE_INFO_ID` varchar(36) DEFAULT NULL,
  `UPDATE_NAME` varchar(50) DEFAULT NULL,
  `UPDATE_TYPE` varchar(36) DEFAULT NULL,
  `VERSION` varchar(36) DEFAULT NULL,
  `REPORT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK600155A98A452394` (`REPORT_ID`) USING BTREE,
  CONSTRAINT `t_report_update_ibfk_1` FOREIGN KEY (`REPORT_ID`) REFERENCES `t_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_additional_fee`
--

DROP TABLE IF EXISTS `t_s_additional_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_additional_fee` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `price_unit` varchar(255) DEFAULT NULL,
  `remark` text,
  `test_param_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKDB8EBEEA5E6F18A` (`test_param_id`) USING BTREE,
  CONSTRAINT `t_s_additional_fee_ibfk_1` FOREIGN KEY (`test_param_id`) REFERENCES `t_s_test_param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_attachment`
--

DROP TABLE IF EXISTS `t_s_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_attachment` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `attachmentcontent` longblob COMMENT '附件内容',
  `attachmenttitle` varchar(500) DEFAULT NULL COMMENT '附件名称',
  `businesskey` varchar(32) DEFAULT NULL COMMENT '业务类主键',
  `createdate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `extend` varchar(32) DEFAULT NULL COMMENT '扩展名',
  `note` longtext COMMENT 'note',
  `realpath` varchar(1024) DEFAULT NULL COMMENT '附件路径',
  `subclassname` longtext COMMENT '子类名称全路径',
  `swfpath` longtext COMMENT 'swf格式路径',
  `BUSENTITYNAME` varchar(100) DEFAULT NULL COMMENT 'BUSENTITYNAME',
  `INFOTYPEID` varchar(32) DEFAULT NULL COMMENT 'INFOTYPEID',
  `USERID` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`),
  KEY `FK_mnq23hlc835n4ufgjl7nkn3bd` (`USERID`) USING BTREE,
  KEY `FK1BC1BE5A477C4E54` (`USERID`) USING BTREE,
  CONSTRAINT `t_s_attachment_ibfk_1` FOREIGN KEY (`USERID`) REFERENCES `t_s_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_audit_authority`
--

DROP TABLE IF EXISTS `t_s_audit_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_audit_authority` (
  `id` varchar(36) NOT NULL COMMENT '审核权限id',
  `name` varchar(255) NOT NULL COMMENT '审核权限名称',
  `code` varchar(255) NOT NULL COMMENT '权限编码',
  `description` varchar(255) DEFAULT NULL COMMENT '审核权限描述',
  `effective_range` varchar(10) NOT NULL DEFAULT '1' COMMENT '生效范围 0:全部, 1:权限人员所在部门, 2:指定部门',
  `effective_depart_ids` varchar(2000) DEFAULT NULL COMMENT '作用的部门id,逗号分隔储存',
  `is_deleted` varchar(2) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_audit_authority_name` (`name`) USING BTREE,
  UNIQUE KEY `idx_audit_authority_code` (`code`) USING BTREE COMMENT '权限编码唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程审核权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_audit_authority_user`
--

DROP TABLE IF EXISTS `t_s_audit_authority_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_audit_authority_user` (
  `id` varchar(36) NOT NULL COMMENT '用户和审核权限关系id',
  `user_id` varchar(36) NOT NULL COMMENT '用户id',
  `audit_authority_id` varchar(36) NOT NULL COMMENT '审核权限id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和审核权限关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_base_standard`
--

DROP TABLE IF EXISTS `t_s_base_standard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_base_standard` (
  `id` varchar(36) NOT NULL,
  `standard_name` varchar(255) DEFAULT NULL,
  `publish_code` varchar(255) DEFAULT NULL,
  `unique_key` varchar(510) NOT NULL COMMENT '规程唯一标识：通过规程名+颁布号，全角转半角、大写转小写、去掉空格后生成的',
  `clause_code` varchar(255) DEFAULT NULL,
  `execute_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `is_default` varchar(1) DEFAULT '0' COMMENT '是否默认规程：1.是 0.否',
  `is_deleted` varchar(1) DEFAULT '0' COMMENT '是否已删除： 1.是  0.否',
  `publish_date` date DEFAULT NULL,
  `remark` text,
  `standard_id` varchar(255) DEFAULT NULL,
  `standard_type_id` varchar(255) DEFAULT NULL,
  `standard_type_name` varchar(255) DEFAULT NULL,
  `type` varchar(1) DEFAULT '3' COMMENT '作用类型 1：试验依据  2：评定标准 3.依据和标准',
  `source_type` varchar(1) DEFAULT '1' COMMENT '数据源：1.hitek数据中心 2.用户自定义',
  `test_param_id` varchar(36) DEFAULT NULL COMMENT '测试参数ID - 关联t_s_test_param.id',
  `create_by` varchar(255) DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `file_id` varchar(36) DEFAULT NULL COMMENT '规程文件id,关联t_s_attachment.id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_base_standard_type`
--

DROP TABLE IF EXISTS `t_s_base_standard_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_base_standard_type` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `pid` varchar(36) DEFAULT NULL COMMENT '父级id',
  `name` varchar(200) NOT NULL COMMENT '类型名称',
  `source_type` varchar(1) NOT NULL COMMENT '来源类型: 1:系统创建, 2:用户创建',
  `is_deleted` varchar(10) NOT NULL COMMENT '删除标记:0:未删除,1:已删除',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `f_key_pid` (`pid`),
  CONSTRAINT `f_key_pid` FOREIGN KEY (`pid`) REFERENCES `t_s_base_standard_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='规程类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_base_user`
--

DROP TABLE IF EXISTS `t_s_base_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_base_user` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `activitiSync` smallint(6) DEFAULT NULL COMMENT '同步流程',
  `browser` varchar(20) DEFAULT NULL COMMENT '浏览器',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `realname` varchar(50) DEFAULT NULL COMMENT '真实名字',
  `signature` blob COMMENT '签名',
  `status` smallint(6) DEFAULT NULL COMMENT '有效状态',
  `userkey` varchar(200) DEFAULT NULL COMMENT '用户KEY',
  `username` varchar(10) NOT NULL COMMENT '用户账号',
  `departid` varchar(32) DEFAULT NULL COMMENT '部门ID',
  `delete_flag` smallint(6) DEFAULT NULL COMMENT '删除状态',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_username_unique` (`username`) USING BTREE,
  KEY `FK_15jh1g4iem1857546ggor42et` (`departid`) USING BTREE,
  KEY `index_login` (`password`,`username`) USING BTREE,
  KEY `idx_deleteflg` (`delete_flag`) USING BTREE,
  CONSTRAINT `t_s_base_user_ibfk_1` FOREIGN KEY (`departid`) REFERENCES `t_s_depart` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 600064 kB; (`departid`) REFER `jeecg/t_s_depart';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_big_category`
--

DROP TABLE IF EXISTS `t_s_big_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_big_category` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL COMMENT '分类掩码',
  `is_deleted` varchar(255) DEFAULT NULL COMMENT '是否禁用1:是、0：否',
  `name` varchar(255) NOT NULL COMMENT '分类名称',
  `remark` text COMMENT '备注',
  `test_type` varchar(255) DEFAULT NULL COMMENT '试验类型 0:原材料试验检测、1:现场试验检测',
  `pid` varchar(36) DEFAULT NULL COMMENT '父ID',
  `qualification_type_id` varchar(36) DEFAULT NULL COMMENT '资质类型ID',
  `order_num` int(4) DEFAULT '100' COMMENT '大类排序',
  `param_version_id` varchar(36) DEFAULT NULL COMMENT '检测参数版本id',
  PRIMARY KEY (`id`),
  KEY `FKDD8904D4537AC43E` (`pid`) USING BTREE,
  KEY `FKDD8904D424708A8E` (`qualification_type_id`) USING BTREE,
  KEY `param_version_index` (`param_version_id`),
  CONSTRAINT `t_s_big_category_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `t_s_big_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单位自定义分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_data_log`
--

DROP TABLE IF EXISTS `t_s_data_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_data_log` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `table_name` varchar(32) DEFAULT NULL COMMENT '表名',
  `data_id` varchar(32) DEFAULT NULL COMMENT '数据ID',
  `data_content` text COMMENT '数据内容',
  `version_number` int(11) DEFAULT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  KEY `sindex` (`table_name`,`data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_data_rule`
--

DROP TABLE IF EXISTS `t_s_data_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_data_rule` (
  `id` varchar(96) DEFAULT NULL COMMENT 'ID',
  `rule_name` varchar(96) DEFAULT NULL COMMENT '数据权限规则名称',
  `rule_column` varchar(300) DEFAULT NULL COMMENT '字段',
  `rule_conditions` varchar(300) DEFAULT NULL COMMENT '条件',
  `rule_value` varchar(300) DEFAULT NULL COMMENT '规则值',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(96) DEFAULT NULL,
  `create_name` varchar(96) DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(96) DEFAULT NULL COMMENT '修改人',
  `update_name` varchar(96) DEFAULT NULL COMMENT '修改人名字',
  `functionId` varchar(96) DEFAULT NULL COMMENT '菜单ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_data_source`
--

DROP TABLE IF EXISTS `t_s_data_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_data_source` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `db_key` varchar(50) NOT NULL COMMENT '多数据源KEY',
  `description` varchar(50) NOT NULL COMMENT '描述',
  `driver_class` varchar(50) NOT NULL COMMENT '驱动class',
  `url` varchar(200) NOT NULL COMMENT 'db链接',
  `db_user` varchar(50) NOT NULL COMMENT '用户名',
  `db_password` varchar(50) DEFAULT NULL COMMENT '密码',
  `db_type` varchar(50) DEFAULT NULL COMMENT '数据库类型',
  `db_name` varchar(50) DEFAULT NULL COMMENT '数据源名字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_depart`
--

DROP TABLE IF EXISTS `t_s_depart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_depart` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `departname` varchar(500) NOT NULL COMMENT '部门名称',
  `extendname` varchar(500) DEFAULT NULL COMMENT '别名',
  `description` longtext COMMENT '描述',
  `parentdepartid` varchar(32) DEFAULT NULL COMMENT '父部门ID',
  `org_code` varchar(64) NOT NULL COMMENT '机构编码',
  `org_type` varchar(1) DEFAULT NULL COMMENT '机构类型',
  `phone` varchar(50) DEFAULT NULL COMMENT '联系电话',
  `complaint_phone` varchar(50) DEFAULT NULL COMMENT '投诉电话',
  `contacts` varchar(50) DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机号',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `address` varchar(500) DEFAULT NULL COMMENT '地址',
  `postcode` varchar(50) DEFAULT NULL COMMENT '邮编',
  `depart_order` varchar(5) DEFAULT '0' COMMENT '排序',
  `bank_name` varchar(50) DEFAULT '' COMMENT '开户银行',
  `bank_account` varchar(50) DEFAULT '' COMMENT '开户银行账号',
  `is_test_org` varchar(10) NOT NULL DEFAULT '0' COMMENT '是否检测科室',
  `is_deleted` varchar(10) NOT NULL DEFAULT '0' COMMENT '是否已被删除',
  PRIMARY KEY (`ID`),
  KEY `FK_knnm3wb0bembwvm0il7tf6686` (`parentdepartid`) USING BTREE,
  KEY `FKB2ABE0AB5C2D250` (`parentdepartid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_depart_version`
--

DROP TABLE IF EXISTS `t_s_depart_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_depart_version` (
  `id` varchar(36) NOT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `departname` varchar(32) NOT NULL COMMENT '名称',
  `extendname` varchar(32) DEFAULT NULL COMMENT '别名',
  `description` varchar(32) DEFAULT NULL COMMENT '描述',
  `address` varchar(32) DEFAULT NULL COMMENT '地址',
  `postcode` varchar(32) DEFAULT NULL COMMENT '邮编',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `email` varchar(500) DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(32) DEFAULT NULL COMMENT '电话',
  `query_phone` varchar(20) DEFAULT NULL COMMENT '查询电话',
  `explain_phone` varchar(20) DEFAULT NULL COMMENT '申述电话',
  `contacts` varchar(32) DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '银行账户',
  `bank_account_name` varchar(50) DEFAULT NULL COMMENT '开户名',
  `bank_name` varchar(256) DEFAULT NULL COMMENT '银行名称',
  `bank_address` varchar(255) DEFAULT NULL COMMENT '银行地址',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '信息版本号',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '截止时间',
  `status` varchar(32) DEFAULT NULL COMMENT '状态',
  `complaint_phone` varchar(32) DEFAULT NULL COMMENT '投诉电话',
  `org_type` varchar(32) DEFAULT NULL COMMENT '组织类型',
  `org_code` varchar(32) DEFAULT NULL COMMENT '组织码',
  `depart_id` varchar(32) DEFAULT NULL COMMENT '部门树关联ID',
  `parentdepartid` varchar(32) DEFAULT NULL COMMENT '父ID',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `company_short_name` varchar(20) DEFAULT NULL COMMENT '用于二维码扫描信息title展示等等',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_equipment`
--

DROP TABLE IF EXISTS `t_s_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_equipment` (
  `id` varchar(36) NOT NULL,
  `name` varchar(200) NOT NULL COMMENT '设备名称',
  `equipment_sn` varchar(200) DEFAULT NULL COMMENT '设备编号',
  `archive_sn` varchar(200) NOT NULL COMMENT '档案编号',
  `asset_sn` varchar(200) DEFAULT NULL COMMENT '资产编号',
  `test_manage_sn` varchar(200) DEFAULT NULL COMMENT '检测管理编号',
  `standard` varchar(200) DEFAULT NULL COMMENT '规格型号',
  `eq_range` varchar(500) DEFAULT NULL COMMENT '量程',
  `accuracy` varchar(200) DEFAULT NULL COMMENT '精度',
  `size` varchar(200) DEFAULT NULL COMMENT '外形尺寸',
  `keeper_id` varchar(36) DEFAULT NULL COMMENT '保管人id',
  `keeper_name` varchar(200) NOT NULL COMMENT '保管人id',
  `user_id` varchar(36) DEFAULT NULL COMMENT '使用人id',
  `user_name` varchar(200) DEFAULT NULL,
  `manager_id` varchar(36) DEFAULT NULL COMMENT '综合管理员id',
  `manager_name` varchar(200) DEFAULT NULL COMMENT '综合管理员姓名',
  `unit_name` varchar(200) NOT NULL COMMENT '所属单位',
  `depart_id` varchar(36) NOT NULL COMMENT '所属部门',
  `storage_site` varchar(200) DEFAULT NULL COMMENT '存放地点',
  `laboratory_id` varchar(36) DEFAULT NULL COMMENT '检测室id',
  `laboratory_name` varchar(255) DEFAULT NULL COMMENT '检测室名称',
  `status` varchar(10) NOT NULL COMMENT '待定',
  `rent_status` varchar(10) DEFAULT NULL COMMENT '设备租借状态',
  `type` varchar(10) NOT NULL COMMENT '建议开发一个设备类别管理, 或使用数据字典',
  `manage_type` varchar(50) DEFAULT NULL COMMENT '管理类别,来源于数据字典,id写入这里',
  `check_type` varchar(10) DEFAULT NULL COMMENT '1.校准,2:自校',
  `check_period` int(11) DEFAULT NULL COMMENT '检校周期',
  `check_period_unit` varchar(10) DEFAULT NULL COMMENT '检校周期单位:Y:年,M:月,D:日',
  `pre_check_date` datetime DEFAULT NULL COMMENT '上次检校日期',
  `next_check_date` datetime DEFAULT NULL COMMENT '下次检校日期',
  `quantity` varchar(200) DEFAULT NULL COMMENT '数量',
  `net_value` varchar(200) DEFAULT NULL COMMENT '净值',
  `power` varchar(200) DEFAULT NULL COMMENT '功率',
  `coefficient_machine` varchar(1000) DEFAULT NULL COMMENT '复杂系数(机)',
  `coefficient_electronic` varchar(1000) DEFAULT NULL COMMENT '复杂系数(电)',
  `coefficient_hot` varchar(1000) DEFAULT NULL COMMENT '复杂系数(热)',
  `supplier_id` varchar(36) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(200) DEFAULT NULL COMMENT '供应商',
  `supplier_tel` varchar(20) DEFAULT NULL COMMENT '供应商电话',
  `buy_date` datetime DEFAULT NULL COMMENT '购买日期',
  `operation_date` datetime DEFAULT NULL COMMENT '投产日期',
  `repair_service_end_time` datetime DEFAULT NULL COMMENT '保修期至',
  `factory` varchar(200) DEFAULT NULL COMMENT '生产厂家',
  `factory_sn` varchar(200) DEFAULT NULL COMMENT '出厂编号',
  `factory_price` double DEFAULT NULL COMMENT '出厂价',
  `production_date` datetime DEFAULT NULL COMMENT '出厂日期',
  `transport_fee` double DEFAULT NULL COMMENT '运杂费',
  `install_fee` double DEFAULT NULL COMMENT '安装费',
  `depreciation_fee` double DEFAULT NULL COMMENT '折旧费',
  `buy_id` varchar(36) DEFAULT NULL COMMENT '购置记录id',
  `is_deleted` varchar(10) NOT NULL DEFAULT '0' COMMENT '是否已删除:1是0否',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `egress_status` varchar(10) DEFAULT NULL COMMENT '外出状态',
  `check_unit` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_supplier` (`supplier_id`) USING BTREE,
  KEY `FK_Reference_buy` (`buy_id`) USING BTREE,
  CONSTRAINT `t_s_equipment_ibfk_1` FOREIGN KEY (`buy_id`) REFERENCES `t_eq_buy` (`id`),
  CONSTRAINT `t_s_equipment_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `t_eq_supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_equipment_authority`
--

DROP TABLE IF EXISTS `t_s_equipment_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_equipment_authority` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `depart_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCD3C567B708C0A3D` (`user_id`) USING BTREE,
  KEY `FKCD3C567B306A0DD` (`depart_id`) USING BTREE,
  CONSTRAINT `t_s_equipment_authority_ibfk_1` FOREIGN KEY (`depart_id`) REFERENCES `t_s_depart` (`ID`),
  CONSTRAINT `t_s_equipment_authority_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_s_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_equipment_manage`
--

DROP TABLE IF EXISTS `t_s_equipment_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_equipment_manage` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `type_id` varchar(36) DEFAULT NULL COMMENT '设备类别Id',
  `manage_type` varchar(36) DEFAULT NULL COMMENT '管理类别',
  `allot_status` varchar(36) DEFAULT NULL COMMENT '调拨状态',
  `take_person_id` varchar(36) DEFAULT NULL COMMENT '保管人',
  `eq_user_id` varchar(36) DEFAULT NULL COMMENT '使用人',
  `eq_status` varchar(36) DEFAULT NULL COMMENT '状态',
  `qualification_seal` varchar(36) DEFAULT NULL COMMENT '档案编号',
  `test_manage_report` varchar(36) DEFAULT NULL COMMENT '检测管理编号',
  `examination` varchar(36) DEFAULT NULL COMMENT '检校周期月',
  `next_examination_time` datetime DEFAULT NULL COMMENT '下次检校日期',
  `pre_examination_time` datetime DEFAULT NULL COMMENT '前次检校日期',
  `check_type` varchar(36) DEFAULT NULL COMMENT '检校类型',
  `my_range` varchar(128) DEFAULT NULL COMMENT '量程',
  `standard` varchar(128) DEFAULT NULL COMMENT '规格型号',
  `my_precision` varchar(128) DEFAULT NULL COMMENT '精度',
  `size` varchar(128) DEFAULT NULL COMMENT '外形尺寸',
  `power` varchar(128) DEFAULT NULL COMMENT '总功率',
  `quality` varchar(128) DEFAULT NULL COMMENT '总质量',
  `coefficient_m` varchar(128) DEFAULT NULL COMMENT '复杂系数机',
  `coefficient_e` varchar(128) DEFAULT NULL COMMENT '复杂系数电',
  `coefficient_thermal` varchar(128) DEFAULT NULL COMMENT '复杂系数热',
  `value` varchar(128) DEFAULT NULL COMMENT '原值',
  `level` varchar(128) DEFAULT NULL COMMENT '等级',
  `about_quilification` varchar(128) DEFAULT NULL COMMENT '资质相关',
  `qualification` varchar(128) DEFAULT NULL COMMENT '适用资质',
  `relevant_info` varchar(128) DEFAULT NULL COMMENT '相关信息',
  `supplier` varchar(128) DEFAULT NULL COMMENT '供应商',
  `collocating` varchar(128) DEFAULT NULL COMMENT '配置位置',
  `factory_price` varchar(128) DEFAULT NULL COMMENT '出厂价',
  `installation_cost` varchar(128) DEFAULT NULL COMMENT '安装费',
  `quantity` varchar(36) DEFAULT NULL COMMENT '数量',
  `accessory_ids` text,
  `depart_id` varchar(36) DEFAULT NULL COMMENT '所属部门',
  PRIMARY KEY (`id`),
  KEY `FK871F592DB1442249` (`type_id`) USING BTREE,
  CONSTRAINT `t_s_equipment_manage_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `t_s_equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_equipment_testparam_last`
--

DROP TABLE IF EXISTS `t_s_equipment_testparam_last`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_equipment_testparam_last` (
  `id` varchar(36) NOT NULL,
  `test_param_id` varchar(36) NOT NULL,
  `equipment_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3FBF2CE29B710D9F` (`equipment_id`) USING BTREE,
  CONSTRAINT `t_s_equipment_testparam_last_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `t_s_equipment_manage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_lab_environment`
--

DROP TABLE IF EXISTS `t_s_lab_environment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_lab_environment` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `laboratory_id` varchar(36) NOT NULL COMMENT '检测室id',
  `test_task_id` varchar(36) NOT NULL COMMENT '试验检测任务id',
  `test_task_sn` varchar(255) DEFAULT NULL COMMENT '试验检测任务编号(冗余)',
  `min_temperature` double(32,2) DEFAULT NULL COMMENT '要求温度下限',
  `max_temperature` double(32,2) DEFAULT NULL COMMENT '要求温度上限',
  `temperature_when_test` double(32,2) NOT NULL COMMENT '检测时温度',
  `min_humidity` double(32,2) DEFAULT NULL COMMENT '要求湿度下限',
  `max_humidity` double(32,2) DEFAULT NULL COMMENT '要求湿度上限',
  `humidity_when_test` double(32,2) NOT NULL COMMENT '检测时湿度',
  `begin_use_time` datetime NOT NULL COMMENT '开始使用时间',
  `end_use_time` datetime DEFAULT NULL COMMENT '结束使用时间',
  `record_time` datetime NOT NULL COMMENT '记录时间',
  `is_deleted` varchar(10) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`),
  KEY `idx_environment_laboratory_id` (`laboratory_id`) USING BTREE,
  KEY `idx_environment_test_task_id` (`test_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验检测环境记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_laboratory`
--

DROP TABLE IF EXISTS `t_s_laboratory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_laboratory` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '检测室名称',
  `min_temperature` double(32,2) DEFAULT NULL COMMENT '要求温度下限',
  `max_temperature` double(32,2) DEFAULT NULL COMMENT '要求温度上限',
  `min_humidity` double(32,2) DEFAULT NULL COMMENT '要求湿度下限',
  `max_humidity` double(32,2) DEFAULT NULL COMMENT '要求湿度上限',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_deleted` varchar(10) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测室/实验室';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log`
--

DROP TABLE IF EXISTS `t_s_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `broswer` varchar(100) DEFAULT NULL COMMENT '浏览器',
  `logcontent` longtext NOT NULL COMMENT '日志内容',
  `loglevel` smallint(6) DEFAULT NULL COMMENT '日志级别 - 1.info 2.warn 3.error',
  `note` longtext COMMENT 'IP',
  `operatetime` datetime NOT NULL COMMENT '操作时间',
  `operatetype` smallint(6) DEFAULT NULL COMMENT '操作类型',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`),
  KEY `FK_oe64k4852uylhyc5a00rfwtay` (`userid`) USING BTREE,
  KEY `FKA0F09DED477C4E54` (`userid`) USING BTREE,
  CONSTRAINT `t_s_log_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `t_s_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_approval`
--

DROP TABLE IF EXISTS `t_s_log_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_approval` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `remarks` longtext COMMENT '批语',
  `result` varchar(64) DEFAULT NULL COMMENT '审批结果',
  `type` varchar(32) DEFAULT NULL COMMENT '审批内容类型',
  `id_object_approvaled` varchar(36) DEFAULT NULL COMMENT '被审批内容id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_data_save`
--

DROP TABLE IF EXISTS `t_s_log_data_save`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_data_save` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(64) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `description` varchar(255) DEFAULT NULL COMMENT '说明',
  `object_saved` varchar(36) DEFAULT NULL,
  `info_id` varchar(36) DEFAULT NULL COMMENT '数据修改详情id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_data_save_info`
--

DROP TABLE IF EXISTS `t_s_log_data_save_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_data_save_info` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(64) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `before_save` text COMMENT '修改前',
  `after_save` text COMMENT '修改后',
  `description` varchar(1024) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名',
  `table_schema` varchar(255) DEFAULT NULL COMMENT '数据库名',
  PRIMARY KEY (`id`),
  KEY `ind_table_name` (`table_name`) USING BTREE,
  KEY `ind_table_schema` (`table_schema`) USING BTREE,
  KEY `ind_table` (`table_schema`,`table_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_entity`
--

DROP TABLE IF EXISTS `t_s_log_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_entity` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `entity_name` varchar(500) DEFAULT NULL COMMENT '实体名称',
  `entity_id` varchar(36) DEFAULT NULL COMMENT '实体ID',
  `detail` varchar(4000) DEFAULT NULL COMMENT '变更内容',
  `action` varchar(32) DEFAULT NULL COMMENT '操作',
  `entity_value` text COMMENT '变更后的内容',
  `trace_info` text COMMENT '对特殊操作（代码标记的操作）记录堆栈信息，方便开发人员跟踪代码路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_login`
--

DROP TABLE IF EXISTS `t_s_log_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_login` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `login_id` varchar(36) DEFAULT NULL COMMENT '登录账号',
  `login_ip` varchar(64) DEFAULT NULL COMMENT '登录ip',
  `operation` varchar(36) DEFAULT NULL COMMENT '操作',
  `result` varchar(32) DEFAULT NULL COMMENT '结果',
  `msg` varchar(255) DEFAULT NULL COMMENT '登录信息',
  `OPTIONS` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ind_login_id` (`login_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_operation`
--

DROP TABLE IF EXISTS `t_s_log_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_operation` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `user_id` varchar(36) DEFAULT NULL COMMENT '用户id',
  `model_name` varchar(64) DEFAULT NULL COMMENT '操作模块',
  `msg` varchar(32) DEFAULT NULL COMMENT '日志信息',
  PRIMARY KEY (`id`),
  KEY `ind_modal` (`model_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_process`
--

DROP TABLE IF EXISTS `t_s_log_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_process` (
  `id` varchar(36) NOT NULL COMMENT '日志记录的id',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '组织机构编码',
  `create_name` varchar(100) DEFAULT NULL COMMENT '创建人姓名',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建人登陆名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `content` varchar(1000) NOT NULL COMMENT '日志内容(事务内容)',
  `opinion` varchar(1000) DEFAULT NULL COMMENT '处理意见',
  `object_type` varchar(10) NOT NULL COMMENT '日志关联的对象类型 0:委托,1:样品,2:任务,3:报告',
  `object_id` varchar(36) NOT NULL COMMENT '关联对象id',
  `object_sn` varchar(255) DEFAULT NULL COMMENT '关联对象编码',
  `source_class` varchar(255) DEFAULT NULL COMMENT '来源class',
  `source_method` varchar(255) DEFAULT NULL COMMENT '来源方法',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注(预留字段)',
  `action_type` varchar(10) NOT NULL DEFAULT '1' COMMENT '操作类型 0:节点更新, 1:节点完成   其他以后用到再加',
  PRIMARY KEY (`id`),
  KEY `idx_object_id` (`object_id`) USING BTREE,
  KEY `idx_action_type` (`action_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_sendmsg`
--

DROP TABLE IF EXISTS `t_s_log_sendmsg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_sendmsg` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(50) NOT NULL COMMENT '创建人登录名称',
  `sended_msg` varchar(2048) NOT NULL COMMENT '发送的消息',
  `send_to` varchar(255) NOT NULL COMMENT '发送目标',
  `log_msg` varchar(1024) NOT NULL COMMENT '日志信息',
  `send_date` datetime NOT NULL COMMENT '创建日期',
  `company_id` varchar(50) NOT NULL COMMENT '所属公司',
  `task_name` varchar(100) NOT NULL COMMENT '任务名',
  `task_code` varchar(36) DEFAULT NULL COMMENT '任务code',
  `company_name` varchar(255) DEFAULT NULL COMMENT '公司名',
  `result` varchar(36) NOT NULL COMMENT '推送请求结果',
  `type` varchar(36) DEFAULT NULL COMMENT '发送类型',
  `http_status` varchar(36) DEFAULT NULL COMMENT 'http返回码',
  `is_resend` varchar(36) DEFAULT NULL COMMENT '是否是重发',
  PRIMARY KEY (`id`),
  KEY `ind_create_by` (`user_id`) USING BTREE,
  KEY `ind_task_code` (`task_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_log_test`
--

DROP TABLE IF EXISTS `t_s_log_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_log_test` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(64) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `step_info` longtext COMMENT '步骤信息',
  `details` longtext COMMENT '详细信息',
  `test_id` varchar(36) DEFAULT NULL COMMENT '检测任务',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_message`
--

DROP TABLE IF EXISTS `t_s_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_message` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `title` varchar(255) DEFAULT NULL COMMENT '消息主题',
  `content` varchar(4000) DEFAULT NULL COMMENT '消息内容',
  `send_way` varchar(10) NOT NULL COMMENT '发送渠道',
  `receiver` varchar(255) DEFAULT NULL COMMENT '接收人(姓名)',
  `receiver_id` varchar(50) DEFAULT NULL COMMENT '接收人在系统内的用户id',
  `receiver_mobile_num` varchar(20) DEFAULT NULL COMMENT '接收人手机号',
  `receiver_email` varchar(1000) DEFAULT NULL COMMENT '接收人',
  `sender_id` varchar(36) DEFAULT NULL COMMENT '发送用户id',
  `sender_name` varchar(255) DEFAULT NULL COMMENT '发送用户名称',
  `msg_json` varchar(5000) DEFAULT NULL COMMENT '消息基类json',
  `send_content` varchar(5000) DEFAULT NULL COMMENT '消息json(发送出去的消息对象json)',
  `send_status` varchar(10) DEFAULT NULL COMMENT '消息发送状态：1.未发送 2.已发送 3.发送失败',
  `send_time` datetime DEFAULT NULL COMMENT '消息发送时间',
  `send_result` varchar(2000) DEFAULT NULL COMMENT '消息发送反馈/接口响应信息',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统消息记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_message_user_switch`
--

DROP TABLE IF EXISTS `t_s_message_user_switch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_message_user_switch` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `user_id` varchar(36) NOT NULL COMMENT '系统用户ID',
  `message_type_id` varchar(36) NOT NULL COMMENT '消息类型id,见t_s_message_type表',
  `way` varchar(255) NOT NULL COMMENT '发送渠道,见系统枚举MessageWay',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_msg_sending_list`
--

DROP TABLE IF EXISTS `t_s_msg_sending_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_msg_sending_list` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '公司',
  `msg` longtext COMMENT '消息内容',
  `send_to` varchar(36) DEFAULT NULL COMMENT '发送目标',
  `business_type` varchar(36) DEFAULT NULL COMMENT '业务类型',
  `send_type` varchar(36) DEFAULT NULL COMMENT '推送类型',
  `user_id` varchar(36) DEFAULT NULL COMMENT '推送者',
  `begin_date` datetime DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `send_status` varchar(36) DEFAULT NULL,
  `send_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_muti_lang`
--

DROP TABLE IF EXISTS `t_s_muti_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_muti_lang` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `lang_key` varchar(50) DEFAULT NULL COMMENT '语言主键',
  `lang_context` varchar(500) DEFAULT NULL COMMENT '内容',
  `lang_code` varchar(50) DEFAULT NULL COMMENT '语言',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人编号',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人编号',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_langkey_langcode` (`lang_key`,`lang_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_notice`
--

DROP TABLE IF EXISTS `t_s_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_notice` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_title` varchar(255) DEFAULT NULL COMMENT '通知标题',
  `notice_content` longtext COMMENT '通知公告内容',
  `notice_type` varchar(2) DEFAULT NULL COMMENT '通知公告类型（1：通知，2:公告）',
  `notice_level` varchar(2) DEFAULT NULL COMMENT '通告授权级别（1:全员，2：角色，3：用户）',
  `notice_term` datetime DEFAULT NULL COMMENT '阅读期限',
  `create_user` varchar(32) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_notice_authority_role`
--

DROP TABLE IF EXISTS `t_s_notice_authority_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_notice_authority_role` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `role_id` varchar(32) DEFAULT NULL COMMENT '授权角色ID',
  PRIMARY KEY (`id`),
  KEY `FKC73592A2CB61465D` (`role_id`) USING BTREE,
  CONSTRAINT `t_s_notice_authority_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `t_s_role` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通告授权角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_notice_authority_user`
--

DROP TABLE IF EXISTS `t_s_notice_authority_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_notice_authority_user` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '授权用户ID',
  PRIMARY KEY (`id`),
  KEY `FKC736FDF7708C0A3D` (`user_id`) USING BTREE,
  CONSTRAINT `t_s_notice_authority_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_s_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通告授权用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_notice_read_user`
--

DROP TABLE IF EXISTS `t_s_notice_read_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_notice_read_user` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `notice_id` varchar(36) DEFAULT NULL COMMENT '通告ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `is_read` smallint(2) NOT NULL DEFAULT '0' COMMENT '是否已阅读',
  `del_flag` smallint(2) NOT NULL DEFAULT '0' COMMENT '是否已删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `notice_id_index` (`notice_id`) USING BTREE,
  KEY `user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通告已读用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_object_disposed_approval`
--

DROP TABLE IF EXISTS `t_s_object_disposed_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_object_disposed_approval` (
  `id` varchar(36) NOT NULL,
  `time` datetime DEFAULT NULL,
  `type` varchar(36) DEFAULT NULL,
  `target_approval_status` varchar(255) DEFAULT NULL,
  `pre_approval_status` varchar(36) DEFAULT NULL,
  `operation` varchar(36) DEFAULT NULL,
  `remark` varchar(2048) DEFAULT NULL,
  `dispose_info_id` varchar(36) DEFAULT NULL,
  `approval_status` varchar(36) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `create_name` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE102671449D41A8` (`dispose_info_id`) USING BTREE,
  CONSTRAINT `t_s_object_disposed_approval_ibfk_1` FOREIGN KEY (`dispose_info_id`) REFERENCES `t_s_object_disposed_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_object_disposed_info`
--

DROP TABLE IF EXISTS `t_s_object_disposed_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_object_disposed_info` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `object_id` varchar(36) DEFAULT NULL COMMENT '样品',
  `operator_id` varchar(36) DEFAULT NULL COMMENT '处理人',
  `quantity` varchar(36) DEFAULT NULL COMMENT '数量',
  `time` datetime DEFAULT NULL COMMENT '处理时间',
  `reason` longtext COMMENT '处理理由',
  `way` varchar(32) DEFAULT NULL COMMENT '处理方式',
  `approval_status` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK928975FF3674D9F7` (`object_id`) USING BTREE,
  CONSTRAINT `t_s_object_disposed_info_ibfk_1` FOREIGN KEY (`object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_operation`
--

DROP TABLE IF EXISTS `t_s_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_operation` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `operationcode` varchar(50) DEFAULT NULL COMMENT '页面控件code',
  `operationicon` varchar(100) DEFAULT NULL COMMENT '图标',
  `operationname` varchar(50) DEFAULT NULL COMMENT '页面名字',
  `status` smallint(6) DEFAULT NULL COMMENT '状态',
  `functionid` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `iconid` varchar(32) DEFAULT NULL COMMENT '图标ID',
  `operationtype` smallint(6) DEFAULT NULL COMMENT '规则类型：1/禁用 0/隐藏',
  PRIMARY KEY (`ID`),
  KEY `FK_pceuy41wr2fjbcilyc7mk3m1f` (`functionid`) USING BTREE,
  KEY `FK_ny5de7922l39ta2pkhyspd5f` (`iconid`) USING BTREE,
  CONSTRAINT `t_s_operation_ibfk_1` FOREIGN KEY (`iconid`) REFERENCES `t_s_icon` (`ID`),
  CONSTRAINT `t_s_operation_ibfk_2` FOREIGN KEY (`functionid`) REFERENCES `t_s_function` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 599040 kB; (`iconid`) REFER `jeecg/t_s_icon`(`I';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_process_copy_to`
--

DROP TABLE IF EXISTS `t_s_process_copy_to`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_process_copy_to` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `process_instance_id` varchar(36) NOT NULL COMMENT '流程实例id',
  `business_key` varchar(36) NOT NULL COMMENT '业务主键',
  `process_type_id` varchar(36) NOT NULL COMMENT '流程类型id,详见AuditType.class',
  `process_type_name` varchar(255) DEFAULT NULL COMMENT '流程类型,详见AuditType.class',
  `process_name` varchar(255) DEFAULT NULL COMMENT '流程名称',
  `process_summary` varchar(1024) DEFAULT NULL COMMENT '流程摘要',
  `process_start_user_name` varchar(255) DEFAULT NULL COMMENT '发起人姓名',
  `process_start_time` datetime DEFAULT NULL COMMENT '流程发起时间',
  `process_end_time` datetime DEFAULT NULL COMMENT '流程办结时间',
  `audit_result` varchar(255) DEFAULT NULL COMMENT '流程审核结果',
  `audit_records` text COMMENT '流程审核记录',
  `copy_to_user_id` varchar(36) DEFAULT NULL COMMENT '抄送人id',
  `copy_to_user_name` varchar(255) DEFAULT NULL COMMENT '抄送人账号(登录名)',
  `copy_to_user_real_name` varchar(255) DEFAULT NULL COMMENT '抄送人真实姓名',
  PRIMARY KEY (`id`),
  KEY `idx_process_copy_to_user_id` (`copy_to_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程抄送表, 为本项目定制的抄送功能需要的表(非activiti原生的)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_process_guide`
--

DROP TABLE IF EXISTS `t_s_process_guide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_process_guide` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `module_name` varchar(100) NOT NULL COMMENT '模块名称:(委托收样/检测收费/任务分配/实验检测/复核确认/报告审核/报告批准/报告打印/报告领取)',
  `sort_num` int(10) NOT NULL DEFAULT '0' COMMENT '排序号',
  `icon_url` varchar(1024) NOT NULL COMMENT '图标地址',
  `jump_url` varchar(1024) NOT NULL COMMENT '点击后的跳转地址(一般是菜单地址)',
  `statistics_url` varchar(1024) DEFAULT NULL COMMENT '当前人员在该模块下的任务量统计地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程引导,主要提供homepage的流程引导节点配置和查询';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_process_problem`
--

DROP TABLE IF EXISTS `t_s_process_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_process_problem` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `description` varchar(1024) DEFAULT NULL COMMENT '问题描述',
  `severity` varchar(100) DEFAULT NULL COMMENT '严重程度',
  `creator_id` varchar(36) DEFAULT NULL COMMENT '问题提出人id',
  `is_recovered` tinyint(1) DEFAULT NULL COMMENT '是否已修正',
  `recover_user` varchar(255) DEFAULT NULL COMMENT '修正问题的用户',
  `recover_user_id` varchar(36) DEFAULT NULL COMMENT '修正问题的用户id',
  `recover_time` datetime DEFAULT NULL COMMENT '问题修正时间',
  `business_type` varchar(50) DEFAULT NULL COMMENT '业务类型,同通用流程的审核类型,见auditType.class',
  `business_id` varchar(36) DEFAULT NULL COMMENT '业务类型对应的业务数据ID',
  `process_instance_id` varchar(256) DEFAULT NULL COMMENT 'activiti流程实例ID',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`),
  KEY `idx_process_instance_id` (`process_instance_id`) USING BTREE,
  KEY `idx_business_id` (`business_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_process_problem_file`
--

DROP TABLE IF EXISTS `t_s_process_problem_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_process_problem_file` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `name` varchar(1024) DEFAULT NULL COMMENT '文件名,从t_s_attachment冗余过来的',
  `file_url` varchar(1024) NOT NULL COMMENT '文件地址,从t_s_attachment中冗余过来的',
  `use_type` varchar(10) DEFAULT NULL COMMENT '使用分类,待定',
  `system_attachment_id` varchar(36) NOT NULL COMMENT '系统附件ID',
  `process_problem_id` varchar(36) NOT NULL COMMENT '流程审批意见/问题ID',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`),
  KEY `process_problem_id` (`process_problem_id`),
  CONSTRAINT `process_problem_id` FOREIGN KEY (`process_problem_id`) REFERENCES `t_s_process_problem` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_qualification_authority`
--

DROP TABLE IF EXISTS `t_s_qualification_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_qualification_authority` (
  `id` varchar(36) NOT NULL,
  `qualification_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `type` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCDDE4D1CB3131E09` (`qualification_id`) USING BTREE,
  KEY `FKCDDE4D1C708C0A3D` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_qualification_type`
--

DROP TABLE IF EXISTS `t_s_qualification_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_qualification_type` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '资质名称',
  `code` varchar(255) DEFAULT NULL COMMENT '掩码',
  `remark` text COMMENT '备注',
  `system_id` varchar(50) DEFAULT NULL COMMENT 'hitek系统中的ID',
  `system_name` varchar(255) DEFAULT NULL COMMENT '资质系统名称',
  `is_default` varchar(255) DEFAULT NULL COMMENT '是否默认资质',
  `is_deleted` varchar(255) NOT NULL DEFAULT '0' COMMENT '逻辑删除标识,0未1已',
  `depart_id` varchar(36) DEFAULT NULL COMMENT '组织机构ID',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_qualification_version`
--

DROP TABLE IF EXISTS `t_s_qualification_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_qualification_version` (
  `id` varchar(36) NOT NULL COMMENT '版本id',
  `qualificatio_type_id` varchar(36) NOT NULL COMMENT '资质类型id',
  `name` varchar(255) NOT NULL COMMENT '资质名称',
  `start_date` datetime NOT NULL COMMENT '启用时间',
  `end_date` datetime NOT NULL COMMENT '停用时间',
  `qual_stamp_file_id` varchar(36) DEFAULT NULL COMMENT '资质章图片id(图片在t_s_attachment的id)',
  `qual_stamp` varchar(512) DEFAULT NULL COMMENT '资质章图片地址',
  `qual_certificate_file_id` varchar(36) DEFAULT NULL COMMENT '证书图片id(图片在t_s_attachment的id)',
  `qual_certificate` varchar(512) DEFAULT NULL COMMENT '资质证书图片地址',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_region`
--

DROP TABLE IF EXISTS `t_s_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_region` (
  `ID` varchar(10) NOT NULL COMMENT 'ID',
  `NAME` varchar(50) NOT NULL COMMENT '城市名',
  `PID` varchar(10) NOT NULL COMMENT '父ID',
  `NAME_EN` varchar(100) NOT NULL COMMENT '英文名',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_report`
--

DROP TABLE IF EXISTS `t_s_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_report` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `report_number` varchar(64) DEFAULT NULL COMMENT '报告编号',
  `history_id` varchar(36) DEFAULT NULL COMMENT '打印历史',
  `handover_way` varchar(36) DEFAULT NULL COMMENT '报告交接方式',
  `print_status` varchar(36) DEFAULT NULL COMMENT '打印状态',
  `charge_status` varchar(36) DEFAULT NULL COMMENT '收费状态',
  `report_type` varchar(36) DEFAULT NULL COMMENT '报告类型',
  `report_status` varchar(36) DEFAULT NULL COMMENT '报告状态',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  PRIMARY KEY (`id`),
  KEY `ind_report_status` (`report_status`) USING BTREE,
  KEY `ind_print_status` (`print_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_report_approval`
--

DROP TABLE IF EXISTS `t_s_report_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_report_approval` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `examination_person_id` varchar(36) DEFAULT NULL COMMENT '报告审核人ID',
  `approval_person_id` varchar(36) DEFAULT NULL COMMENT '报告批准人ID',
  `examination_time` datetime DEFAULT NULL COMMENT '审核时间',
  `approval_time` datetime DEFAULT NULL COMMENT '批准时间',
  `report_id` varchar(36) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  `BPM_STATUS` varchar(32) DEFAULT NULL,
  `SYS_COMPANY_CODE` varchar(50) DEFAULT NULL,
  `SYS_ORG_CODE` varchar(50) DEFAULT NULL,
  `VERSION` varchar(36) DEFAULT NULL,
  `remarks2` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_report_examination_history`
--

DROP TABLE IF EXISTS `t_s_report_examination_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_report_examination_history` (
  `id` varchar(36) NOT NULL,
  `report_id` varchar(36) NOT NULL,
  `comment` text,
  `examination_person` varchar(36) NOT NULL,
  `examination_time` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_report_file`
--

DROP TABLE IF EXISTS `t_s_report_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_report_file` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `company_id` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `version` int(11) DEFAULT NULL COMMENT '版本',
  `remarks` varchar(255) DEFAULT NULL,
  `report_id` varchar(36) DEFAULT NULL,
  `attachment_id` varchar(36) NOT NULL,
  `companyId` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `createName` varchar(255) DEFAULT NULL,
  `fileUrl` varchar(255) DEFAULT NULL,
  `isAcceptFile` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `reportId` varchar(255) DEFAULT NULL,
  `updateBy` varchar(255) DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_report_reprint`
--

DROP TABLE IF EXISTS `t_s_report_reprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_report_reprint` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `report_id` varchar(36) DEFAULT NULL COMMENT '报告id',
  `reprint_cause` text COMMENT '重打原因',
  `quantity` varchar(10) DEFAULT NULL COMMENT 'int',
  `application_user` varchar(36) DEFAULT NULL COMMENT '申请人',
  `update_report` varchar(36) DEFAULT NULL COMMENT '是否修改报告内容',
  `application_form` text COMMENT '申请书',
  `old_content` text COMMENT '原内容',
  `new_content` text COMMENT '新内容',
  `update_info_id` varchar(36) DEFAULT NULL COMMENT '修改字段表id',
  `version` varchar(36) DEFAULT NULL COMMENT '版本',
  `result` varchar(36) DEFAULT NULL COMMENT '处理结果',
  `status` varchar(36) DEFAULT NULL,
  `update_or_not` varchar(10) DEFAULT NULL,
  `charge_or_not` varchar(10) DEFAULT NULL,
  `update_type` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKEF406068A452394` (`report_id`) USING BTREE,
  CONSTRAINT `t_s_report_reprint_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `t_s_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_report_update`
--

DROP TABLE IF EXISTS `t_s_report_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_report_update` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `report_id` varchar(36) DEFAULT NULL COMMENT '报告id',
  `update_cause` text COMMENT '重打原因',
  `quantity` varchar(10) DEFAULT NULL COMMENT 'int',
  `application_user` varchar(36) DEFAULT NULL COMMENT '申请人',
  `update_report` varchar(36) DEFAULT NULL COMMENT '是否修改报告内容',
  `application_form` text COMMENT '申请书',
  `update_description` text COMMENT '原内容',
  `charge` varchar(36) DEFAULT NULL COMMENT '重打申请费用',
  `update_info_id` varchar(36) DEFAULT NULL COMMENT '修改字段表id',
  `version` varchar(36) DEFAULT NULL COMMENT '版本',
  `result` varchar(36) DEFAULT NULL COMMENT '处理结果',
  `status` varchar(36) DEFAULT NULL,
  `content_description` text,
  `update_type` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK483FD99D8A452394` (`report_id`) USING BTREE,
  CONSTRAINT `t_s_report_update_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `t_s_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_reserved_object`
--

DROP TABLE IF EXISTS `t_s_reserved_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_reserved_object` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `object_id` varchar(36) DEFAULT NULL COMMENT '留样样品',
  `reserved_person_id` varchar(36) DEFAULT NULL COMMENT '留样人',
  `remark` varchar(36) DEFAULT NULL COMMENT '备注',
  `deadline` varchar(36) DEFAULT NULL COMMENT '留样期限',
  `reason` varchar(1024) DEFAULT NULL COMMENT '留样原因',
  `site` longtext COMMENT '留样地点',
  `reserved_date` datetime DEFAULT NULL,
  `quantity` varchar(32) DEFAULT NULL COMMENT '留样数量',
  `type` varchar(36) DEFAULT NULL COMMENT '留样类型',
  PRIMARY KEY (`id`),
  KEY `FKC206FD5F3674D9F7` (`object_id`) USING BTREE,
  CONSTRAINT `t_s_reserved_object_ibfk_1` FOREIGN KEY (`object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_role`
--

DROP TABLE IF EXISTS `t_s_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_role` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `rolecode` varchar(10) DEFAULT NULL COMMENT '角色编码',
  `rolename` varchar(100) NOT NULL COMMENT '角色名字',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_role_backlog`
--

DROP TABLE IF EXISTS `t_s_role_backlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_role_backlog` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `role_id` varchar(36) NOT NULL COMMENT '角色id',
  `backlog_id` varchar(36) NOT NULL COMMENT '待办事项id',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和代办事项提醒的关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_role_function`
--

DROP TABLE IF EXISTS `t_s_role_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_role_function` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `operation` varchar(2000) DEFAULT NULL COMMENT '页面控件权限编码',
  `functionid` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `datarule` varchar(1000) DEFAULT NULL COMMENT '数据权限规则ID',
  PRIMARY KEY (`ID`),
  KEY `FK_fvsillj2cxyk5thnuu625urab` (`functionid`) USING BTREE,
  KEY `FK_9dww3p4w8jwvlrgwhpitsbfif` (`roleid`) USING BTREE,
  KEY `FK8681C4EA5486A5AE` (`functionid`) USING BTREE,
  KEY `FK8681C4EA4226F8EA` (`roleid`) USING BTREE,
  CONSTRAINT `t_s_role_function_ibfk_1` FOREIGN KEY (`roleid`) REFERENCES `t_s_role` (`ID`),
  CONSTRAINT `t_s_role_function_ibfk_2` FOREIGN KEY (`functionid`) REFERENCES `t_s_function` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 599040 kB; (`roleid`) REFER `jeecg/t_s_role`(`I';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_role_org`
--

DROP TABLE IF EXISTS `t_s_role_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_role_org` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `org_id` varchar(32) DEFAULT NULL COMMENT '机构ID',
  `role_id` varchar(32) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`ID`),
  KEY `FK6FE17A92CB61465D` (`role_id`) USING BTREE,
  KEY `FK6FE17A92F9893ED` (`org_id`) USING BTREE,
  CONSTRAINT `t_s_role_org_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `t_s_role` (`ID`),
  CONSTRAINT `t_s_role_org_ibfk_2` FOREIGN KEY (`org_id`) REFERENCES `t_s_depart` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_role_user`
--

DROP TABLE IF EXISTS `t_s_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_role_user` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`),
  KEY `FK_n2ucxeorvpjy7qhnmuem01kbx` (`roleid`) USING BTREE,
  KEY `FK_d4qb5xld2pfb0bkjx9iwtolda` (`userid`) USING BTREE,
  CONSTRAINT `t_s_role_user_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `t_s_user` (`id`),
  CONSTRAINT `t_s_role_user_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `t_s_role` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 599040 kB; (`userid`) REFER `jeecg/t_s_user`(`i';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_sms`
--

DROP TABLE IF EXISTS `t_s_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_sms` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `es_title` varchar(32) DEFAULT NULL COMMENT '消息标题',
  `es_type` varchar(1) DEFAULT NULL COMMENT '消息类型：1.短信 2.邮件 3.系统首页消息',
  `es_sender` varchar(50) DEFAULT NULL COMMENT '发送人',
  `es_receiver` varchar(50) DEFAULT NULL COMMENT '接收人',
  `es_content` longtext COMMENT '内容',
  `es_sendtime` datetime DEFAULT NULL COMMENT '发送时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `es_status` varchar(1) DEFAULT NULL COMMENT '发送状态 1.未提醒 2.已提醒 3.发送失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_sms_sql`
--

DROP TABLE IF EXISTS `t_s_sms_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_sms_sql` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `sql_name` varchar(32) DEFAULT NULL COMMENT 'SQL名称',
  `sql_content` varchar(1000) DEFAULT NULL COMMENT 'SQL内容',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_sms_template`
--

DROP TABLE IF EXISTS `t_s_sms_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_sms_template` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `template_type` varchar(1) DEFAULT NULL COMMENT '模板类型',
  `template_name` varchar(50) DEFAULT NULL COMMENT '模板名称',
  `template_content` varchar(1000) DEFAULT NULL COMMENT '模板内容',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_sms_template_sql`
--

DROP TABLE IF EXISTS `t_s_sms_template_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_sms_template_sql` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `code` varchar(32) DEFAULT NULL COMMENT '配置CODE',
  `name` varchar(32) DEFAULT NULL COMMENT '配置名称',
  `sql_id` varchar(32) DEFAULT NULL COMMENT '业务SQLID',
  `template_id` varchar(32) DEFAULT NULL COMMENT '消息模本ID',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_task_report`
--

DROP TABLE IF EXISTS `t_s_task_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_task_report` (
  `id` varchar(36) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `report_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_object_take`
--

DROP TABLE IF EXISTS `t_s_test_object_take`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_object_take` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `object_id` varchar(36) DEFAULT NULL,
  `taking_person_id` varchar(36) DEFAULT NULL COMMENT '领取人',
  `quantity` varchar(36) DEFAULT NULL COMMENT '领取数量',
  `taked_date` datetime DEFAULT NULL,
  `remark` varchar(36) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `FK469731513674D9F7` (`object_id`) USING BTREE,
  CONSTRAINT `t_s_test_object_take_ibfk_1` FOREIGN KEY (`object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param`
--

DROP TABLE IF EXISTS `t_s_test_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `accept_require_content` text COMMENT '收样要求文本内容',
  `accept_require_image_src` varchar(255) DEFAULT NULL COMMENT '收样要求图片内容',
  `display_name` varchar(255) DEFAULT NULL COMMENT '试验参数显示名称',
  `is_deleted` varchar(255) DEFAULT NULL COMMENT '是否禁用1：是、0：否',
  `is_temp_param` varchar(255) DEFAULT NULL COMMENT '是否是临时参数 1：是、0：否（临时参数在收样时，不能被看到），临时参数只在配合比试验时参数选择设备时用到',
  `is_locale_item` varchar(10) DEFAULT NULL COMMENT '是否现场检测',
  `is_build_sample_code` varchar(10) DEFAULT NULL COMMENT '现场试验是否创建样品编号,非现场试验此字段无意义',
  `generate_accept_sample_info_by_count` tinyint(1) DEFAULT NULL COMMENT '是否按检测组数生成样品对象（和sample_mum_by_group不同）',
  `name` varchar(255) DEFAULT NULL COMMENT '试验参数名称',
  `remark` text COMMENT '备注',
  `system_id` varchar(255) DEFAULT NULL COMMENT '试验参数在Hitek基础数据中心的ID',
  `test_item_id` varchar(255) DEFAULT NULL COMMENT '所属试验项目ID',
  `test_item_name` varchar(255) DEFAULT NULL COMMENT '所属试验项目名称',
  `big_category_id` varchar(36) NOT NULL COMMENT '所属分类ID',
  `order_num` int(4) DEFAULT '100' COMMENT '排序',
  `code` varchar(30) DEFAULT NULL COMMENT '参数掩码',
  `param_work_day` bigint(20) DEFAULT NULL COMMENT '检测参数用时(天)',
  PRIMARY KEY (`id`),
  KEY `FKBFFEFD78ABC19F0` (`big_category_id`) USING BTREE,
  CONSTRAINT `t_s_test_param_ibfk_1` FOREIGN KEY (`big_category_id`) REFERENCES `t_s_big_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_group`
--

DROP TABLE IF EXISTS `t_s_test_param_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_group` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '打包名称',
  `big_category_id` varchar(36) DEFAULT NULL COMMENT '单位自定义分类ID',
  `test_sample_id` varchar(36) DEFAULT NULL COMMENT '样品id',
  `param_data` text COMMENT 'see ParamDataGroupData obj',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKD769CC178ABC19F0` (`big_category_id`) USING BTREE,
  CONSTRAINT `t_s_test_param_group_ibfk_1` FOREIGN KEY (`big_category_id`) REFERENCES `t_s_big_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验参数打包表（收样时打包试验参数，用于快速选择收样参数）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_group_item`
--

DROP TABLE IF EXISTS `t_s_test_param_group_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_group_item` (
  `test_param_group_id` varchar(36) NOT NULL COMMENT '试验参数打包ID',
  `test_param_id` varchar(36) NOT NULL COMMENT '试验参数ID',
  KEY `FKAB815E3BA5E6F18A` (`test_param_id`) USING BTREE,
  KEY `FKAB815E3BDDC7A26F` (`test_param_group_id`) USING BTREE,
  CONSTRAINT `t_s_test_param_group_item_ibfk_1` FOREIGN KEY (`test_param_id`) REFERENCES `t_s_test_param` (`id`),
  CONSTRAINT `t_s_test_param_group_item_ibfk_2` FOREIGN KEY (`test_param_group_id`) REFERENCES `t_s_test_param_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验参数打包明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_intermediate_result`
--

DROP TABLE IF EXISTS `t_s_test_param_intermediate_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_intermediate_result` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `default_value` varchar(255) DEFAULT NULL COMMENT '中间检测结果默认值',
  `is_deleted` varchar(255) DEFAULT NULL COMMENT '是否禁用1:是、0：否',
  `result_name` varchar(255) DEFAULT NULL COMMENT '中间检测结果名称',
  `test_param_id` varchar(36) DEFAULT NULL COMMENT '试验参数ID',
  PRIMARY KEY (`id`),
  KEY `FK4ABFD5BBA5E6F18A` (`test_param_id`) USING BTREE,
  CONSTRAINT `t_s_test_param_intermediate_result_ibfk_1` FOREIGN KEY (`test_param_id`) REFERENCES `t_s_test_param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验参数中间检测结果项表 - 即试验试验有哪些中间检测结果项';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_price_working_hour`
--

DROP TABLE IF EXISTS `t_s_test_param_price_working_hour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_price_working_hour` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `identity` varchar(255) DEFAULT NULL COMMENT 'type=1试验参数共价标识、type=2子价格名称标识',
  `price` decimal(10,2) DEFAULT NULL COMMENT '试验参数单价',
  `remark` text COMMENT '备注',
  `script_price` varchar(255) DEFAULT NULL COMMENT '试验参数脚本单价（该值由脚本计算得出）',
  `share_price` decimal(10,2) DEFAULT NULL COMMENT '试验参数共价单价',
  `type` varchar(255) DEFAULT NULL COMMENT '价格类型 0：和样品结合设置价格、1：按参数设置价格、2：子价格（每个试验参数type = 1的记录最多只有一条，type=0，2的记录可以有多条）',
  `working_hour` int(11) DEFAULT NULL COMMENT '试验参数工时数',
  `test_param_id` varchar(36) DEFAULT NULL COMMENT '所属试验参数ID',
  `test_sample_id` varchar(36) DEFAULT NULL COMMENT '试验样品ID（不是指的收样的真实样品）',
  PRIMARY KEY (`id`),
  KEY `FK4EB2B2D078F2FB06` (`test_sample_id`) USING BTREE,
  KEY `FK4EB2B2D0A5E6F18A` (`test_param_id`) USING BTREE,
  CONSTRAINT `t_s_test_param_price_working_hour_ibfk_1` FOREIGN KEY (`test_param_id`) REFERENCES `t_s_test_param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验参数单价和工时表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_qualification`
--

DROP TABLE IF EXISTS `t_s_test_param_qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_qualification` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `test_param_id` varchar(36) NOT NULL COMMENT '系统id非数据中心id',
  `qualification_id` varchar(36) NOT NULL COMMENT '资质id',
  PRIMARY KEY (`id`),
  KEY `t_s_test_param_qualification_t_s_test_param__fk` (`test_param_id`),
  KEY `t_s_test_param_qualification_t_s_qualification_type__fk` (`qualification_id`),
  CONSTRAINT `t_s_test_param_qualification_t_s_qualification_type__fk` FOREIGN KEY (`qualification_id`) REFERENCES `t_s_qualification_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_s_test_param_qualification_t_s_test_param__fk` FOREIGN KEY (`test_param_id`) REFERENCES `t_s_test_param` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验参数资质';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_role`
--

DROP TABLE IF EXISTS `t_s_test_param_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_role` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `rolecode` varchar(10) DEFAULT NULL COMMENT '角色编码',
  `rolename` varchar(100) NOT NULL COMMENT '角色名字',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_role_authority`
--

DROP TABLE IF EXISTS `t_s_test_param_role_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_role_authority` (
  `id` varchar(36) NOT NULL,
  `role_id` varchar(36) NOT NULL,
  `test_param_id` varchar(36) NOT NULL,
  `authority_id` varchar(36) NOT NULL,
  `depart_id` varchar(32) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8A26DC22E87D1632` (`role_id`) USING BTREE,
  KEY `FK8A26DC22A5E6F18A` (`test_param_id`) USING BTREE,
  KEY `FK8A26DC22D5AC691D` (`authority_id`) USING BTREE,
  KEY `FK8A26DC22708C0A3D` (`user_id`) USING BTREE,
  KEY `FK8A26DC22306A0DD` (`depart_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_role_user`
--

DROP TABLE IF EXISTS `t_s_test_param_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_role_user` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `roleid` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `userid` varchar(32) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`),
  KEY `FKA37C478C593ACCDF` (`roleid`) USING BTREE,
  KEY `FKA37C478C477C4E54` (`userid`) USING BTREE,
  CONSTRAINT `t_s_test_param_role_user_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `t_s_user` (`id`),
  CONSTRAINT `t_s_test_param_role_user_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `t_s_test_param_role` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_param_table_info`
--

DROP TABLE IF EXISTS `t_s_test_param_table_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_param_table_info` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `test_param_id` varchar(36) NOT NULL COMMENT '单位参数id',
  `record_uniq_code` varchar(50) NOT NULL COMMENT '记录唯一标识码',
  `record_table_name` varchar(255) NOT NULL COMMENT '记录表单名称',
  `report_uniq_code` varchar(50) NOT NULL COMMENT '报告唯一标识码',
  `report_table_name` varchar(255) NOT NULL COMMENT '报告表单名称',
  `version` int(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `t_s_test_param_table_info_t_s_test_param__fk` (`test_param_id`),
  KEY `t_s_test_param_table_info_record_uniq_code_index` (`record_uniq_code`),
  KEY `t_s_test_param_table_info_report_uniq_code_index` (`report_uniq_code`),
  CONSTRAINT `t_s_test_param_table_info_t_s_test_param__fk` FOREIGN KEY (`test_param_id`) REFERENCES `t_s_test_param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='参数记录、报告唯一识别码及表单名称，表命名同数据中心';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_qualification`
--

DROP TABLE IF EXISTS `t_s_test_qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_qualification` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `type` varchar(200) DEFAULT NULL COMMENT '类型，取自服务器的资质类型',
  `res_simple_days` varchar(32) DEFAULT NULL COMMENT '留样天数',
  `qual_stamp` text COMMENT '资质章',
  `qual_certificate` text COMMENT '资质证书',
  `status` varchar(36) DEFAULT '1' COMMENT '状态 1是正常 2 是停用',
  `is_default` varchar(36) DEFAULT '0' COMMENT '是否默认 0是否 1是',
  `depart_id` varchar(36) DEFAULT NULL COMMENT '组织ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_sample`
--

DROP TABLE IF EXISTS `t_s_test_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_sample` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `is_deleted` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sample_tag_count` int(11) DEFAULT NULL COMMENT '一组样品的标签数量',
  `is_build_sample_code` tinyint(1) DEFAULT NULL COMMENT '是否生成样品编号',
  `is_retention_sample` tinyint(1) NOT NULL DEFAULT '0' COMMENT '样品是否要求留样',
  `retention_how_long` int(11) DEFAULT '90' COMMENT '留样时长',
  `retention_time_unit` varchar(10) DEFAULT 'D' COMMENT '留样时长单位 D:天, M:月, Y:年',
  `sample_mum_by_group` tinyint(1) DEFAULT NULL COMMENT '是否根据组数（计价数量）生成多个样品编号，也就是收样只有一个样品对象，但是会按组数生成多个样品编号',
  `sample_state` varchar(256) DEFAULT NULL COMMENT '样品默认状态描述',
  `sample_requirement` varchar(4000) DEFAULT NULL COMMENT '收样要求',
  `sample_level_name` varchar(36) DEFAULT NULL COMMENT '样品层次名称',
  `big_category_id` varchar(36) DEFAULT NULL COMMENT '大类ID',
  `sample_level_id` varchar(255) DEFAULT NULL,
  `seq` int(11) DEFAULT NULL,
  `system_id` varchar(255) DEFAULT NULL,
  `pid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK94815315C35A80F5` (`pid`) USING BTREE,
  KEY `t_s_test_sample_big_category_id_index` (`big_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_test_sample_param`
--

DROP TABLE IF EXISTS `t_s_test_sample_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_test_sample_param` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(32) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `test_sample_id` varchar(36) NOT NULL COMMENT '单位样品ID',
  `test_param_id` varchar(36) NOT NULL COMMENT '单位参数ID',
  `is_delete` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除:0未删除,1已删除',
  `order_num` int(4) DEFAULT '100' COMMENT '参数排序',
  `test_param_name` varchar(128) NOT NULL COMMENT '参数名称Ry',
  `test_param_remark` varchar(128) NOT NULL COMMENT '参数名称备注Ry',
  `test_param_system_name` varchar(50) DEFAULT NULL COMMENT '参数系统名称',
  `is_temp_param` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否临时参数',
  `test_item_name` varchar(50) DEFAULT NULL COMMENT '检测项目',
  PRIMARY KEY (`id`),
  KEY `t_s_test_sample_param_test_param_id_index` (`test_param_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单位检测样品持有检测参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_third_party_user`
--

DROP TABLE IF EXISTS `t_s_third_party_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_third_party_user` (
  `id` varchar(36) CHARACTER SET utf8mb4 NOT NULL,
  `user_id` varchar(36) NOT NULL COMMENT '用户id,关联t_s_user.id',
  `third_type` varchar(50) NOT NULL COMMENT '三方平台类型  wechat: 微信',
  `union_id` varchar(128) DEFAULT NULL COMMENT '用户在该平台下的唯一ID',
  `open_id` varchar(128) DEFAULT NULL COMMENT '用户在该平台下,当前针对当前应用/开发者账号的唯一ID',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `head_img_url` varchar(255) DEFAULT NULL COMMENT '头像',
  `sex` int(255) NOT NULL DEFAULT '0' COMMENT '性别 1:男, 2:女, 0:未说明',
  `country` varchar(255) DEFAULT '' COMMENT '所在国家',
  `province` varchar(255) DEFAULT NULL COMMENT '所在省份',
  `city` varchar(255) DEFAULT NULL COMMENT '所在城市',
  `is_valid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效 0: 无效, 1:有效',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`),
  KEY `idx_third_user_id` (`user_id`) USING BTREE,
  KEY `idx_third_union_id` (`union_id`) USING BTREE,
  KEY `idx_third_open_id` (`open_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_user`
--

DROP TABLE IF EXISTS `t_s_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_user` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `mobilePhone` varchar(30) DEFAULT NULL COMMENT '手机号',
  `officePhone` varchar(20) DEFAULT NULL COMMENT '办公座机',
  `signatureFile` varchar(100) DEFAULT NULL COMMENT '签名文件',
  `sign_photo` varchar(2048) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL COMMENT '职务',
  `certificate_no` varchar(50) DEFAULT NULL COMMENT '证书编号',
  `login_times` int(8) DEFAULT '0' COMMENT '登陆次数',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `birth_day` datetime DEFAULT NULL COMMENT '用户生日',
  `icon_url` varchar(1024) DEFAULT NULL COMMENT '头像地址',
  PRIMARY KEY (`id`),
  KEY `FK_2cuji5h6yorrxgsr8ojndlmal` (`id`) USING BTREE,
  CONSTRAINT `t_s_user_ibfk_1` FOREIGN KEY (`id`) REFERENCES `t_s_base_user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 599040 kB; (`id`) REFER `jeecg/t_s_base_user`(`';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_user_org`
--

DROP TABLE IF EXISTS `t_s_user_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_user_org` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id',
  `org_id` varchar(32) DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`ID`),
  KEY `index_user_id` (`user_id`) USING BTREE,
  KEY `index_org_id` (`org_id`) USING BTREE,
  KEY `FK6FE33367708C0A3D` (`user_id`) USING BTREE,
  KEY `FK6FE333679694CB2E` (`user_id`) USING BTREE,
  KEY `FK6FE33367F9893ED` (`org_id`) USING BTREE,
  CONSTRAINT `t_s_user_org_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_s_user` (`id`),
  CONSTRAINT `t_s_user_org_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_s_base_user` (`ID`),
  CONSTRAINT `t_s_user_org_ibfk_3` FOREIGN KEY (`org_id`) REFERENCES `t_s_depart` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_user_project_all_authority`
--

DROP TABLE IF EXISTS `t_s_user_project_all_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_user_project_all_authority` (
  `id` varchar(36) NOT NULL,
  `all_authority_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKF1EC6D42D8B636DB` (`all_authority_id`) USING BTREE,
  CONSTRAINT `t_s_user_project_all_authority_ibfk_1` FOREIGN KEY (`all_authority_id`) REFERENCES `t_s_project_all_authority` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_user_project_part_authority`
--

DROP TABLE IF EXISTS `t_s_user_project_part_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_user_project_part_authority` (
  `ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `ALL_AUTHORITY_ID` varchar(36) DEFAULT NULL,
  `TEST_PARAM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK5936E7A2B2C6FB` (`ALL_AUTHORITY_ID`) USING BTREE,
  KEY `FK5936E7AA5E6F18A` (`TEST_PARAM_ID`) USING BTREE,
  CONSTRAINT `t_s_user_project_part_authority_ibfk_1` FOREIGN KEY (`ALL_AUTHORITY_ID`) REFERENCES `t_s_project_all_authority` (`id`),
  CONSTRAINT `t_s_user_project_part_authority_ibfk_2` FOREIGN KEY (`TEST_PARAM_ID`) REFERENCES `t_s_test_param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_s_utensil`
--

DROP TABLE IF EXISTS `t_s_utensil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_utensil` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `other1` int(11) DEFAULT NULL COMMENT '预留字段',
  `other2` int(11) DEFAULT NULL COMMENT '预留字段',
  `sn` varchar(255) DEFAULT NULL COMMENT '器具编号（唯一）',
  `type` varchar(255) DEFAULT NULL COMMENT '器具类型（盒质量、试筒质量与体积、环刀质量与容积）',
  `validate_date` date DEFAULT NULL COMMENT '校验日期',
  `volume` double(11,2) DEFAULT NULL COMMENT '容积（cm³）',
  `weight` double(11,2) DEFAULT NULL COMMENT '质量（g）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验器具（盒子量、环刀质量容积等）表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_category`
--

DROP TABLE IF EXISTS `t_sn_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_category` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` text COMMENT '名称',
  `remarks` longtext COMMENT '备注',
  `pid` varchar(36) DEFAULT NULL COMMENT '上级目录',
  `is_default` varchar(32) NOT NULL DEFAULT 'N' COMMENT '默认',
  `is_delete` varchar(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_category_org`
--

DROP TABLE IF EXISTS `t_sn_category_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_category_org` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `org_id` varchar(32) DEFAULT NULL COMMENT '机构ID',
  `sn_category_id` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `is_delete` char(2) DEFAULT NULL COMMENT '是否删除',
  `depart_name` varchar(100) DEFAULT NULL COMMENT '部门名称',
  PRIMARY KEY (`id`),
  KEY `FK6FE17A92CB61465D` (`sn_category_id`) USING BTREE,
  KEY `FK6FE17A92F9893ED` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='编号大类部门关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_history`
--

DROP TABLE IF EXISTS `t_sn_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_history` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `serial_number` int(32) DEFAULT NULL COMMENT '序列号',
  `sequence` varchar(500) DEFAULT NULL COMMENT 'hash码',
  `model_id` varchar(36) DEFAULT NULL COMMENT '编号实体',
  `value` varchar(500) DEFAULT NULL COMMENT '值冗余',
  `real_value` varchar(500) DEFAULT NULL COMMENT '真实值，对象实际使用的编码',
  `object_id` varchar(36) NOT NULL COMMENT '使用对象',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数集',
  `is_manual_create` int(1) DEFAULT '0' COMMENT '是否人工修改的编号：1.是 0.否',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  PRIMARY KEY (`id`),
  KEY `index_sequence` (`sequence`) USING BTREE,
  KEY `t_sn_history_object_id_index` (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_model`
--

DROP TABLE IF EXISTS `t_sn_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_model` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `name` varchar(500) NOT NULL COMMENT '名称',
  `type` varchar(200) DEFAULT NULL COMMENT '用途',
  `remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  `category_id` varchar(36) NOT NULL COMMENT '类型',
  `version` varchar(32) DEFAULT NULL COMMENT '版本',
  `status` varchar(32) DEFAULT NULL COMMENT '状态',
  `start_time` datetime DEFAULT NULL COMMENT '启用时间',
  `end_time` datetime DEFAULT NULL COMMENT '停用时间',
  `is_delete` varchar(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_multiple_code`
--

DROP TABLE IF EXISTS `t_sn_multiple_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_multiple_code` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `consign_info_id` varchar(36) NOT NULL COMMENT '委托id',
  `test_object_id` varchar(36) NOT NULL COMMENT '样品id',
  `test_object_random_id` varchar(36) NOT NULL COMMENT '生成样品编号所使用的id',
  `test_object_code` varchar(80) NOT NULL COMMENT '样品编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按照参数组数生成的多个样品编号记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_serial_num_refresh`
--

DROP TABLE IF EXISTS `t_sn_serial_num_refresh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_serial_num_refresh` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) DEFAULT NULL COMMENT '是否删除',
  `sequence` varchar(500) DEFAULT NULL COMMENT 'hash码',
  `serial_number_old` int(11) DEFAULT NULL COMMENT '序列号',
  `serial_number` int(11) DEFAULT NULL COMMENT '序列号',
  `model_id` varchar(36) DEFAULT NULL COMMENT '编号实体',
  `format_item` varchar(100) DEFAULT NULL COMMENT '格式项',
  `is_refresh` varchar(100) DEFAULT NULL COMMENT '是否刷新 0-否 1-是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='编号流水号刷新表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_store`
--

DROP TABLE IF EXISTS `t_sn_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_store` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `sequence` varchar(500) DEFAULT NULL COMMENT 'hash码',
  `serial_number` int(11) DEFAULT NULL COMMENT '序列号',
  `model_id` varchar(36) NOT NULL COMMENT '编号实体',
  `value` varchar(500) DEFAULT NULL COMMENT '值冗余',
  `format_item` varchar(100) DEFAULT NULL COMMENT '格式项',
  PRIMARY KEY (`id`),
  KEY `index_sequence` (`sequence`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_termcontent`
--

DROP TABLE IF EXISTS `t_sn_termcontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_termcontent` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `term_id` varchar(32) DEFAULT NULL COMMENT '格式项',
  `value` varchar(32) DEFAULT NULL COMMENT '内容',
  `object_id` varchar(36) DEFAULT NULL COMMENT '对象id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_sn_terms`
--

DROP TABLE IF EXISTS `t_sn_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sn_terms` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `name` varchar(500) DEFAULT NULL COMMENT '名称',
  `type` varchar(32) DEFAULT NULL COMMENT '类型',
  `order_no` int(11) DEFAULT NULL COMMENT '排序号',
  `is_associate_sequence` varchar(32) DEFAULT NULL COMMENT '是否参与自增',
  `model_id` varchar(36) DEFAULT NULL COMMENT '编号实体',
  `serial_no_bit` int(32) DEFAULT NULL COMMENT '自增数位数',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_stepwise_audit`
--

DROP TABLE IF EXISTS `t_stepwise_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_stepwise_audit` (
  `id` varchar(36) NOT NULL COMMENT '审核对象ID',
  `type` varchar(255) NOT NULL COMMENT '审批类型: 1:留样样品提前废弃, 2:留样样品提前返还, 3:留样样品利用, 4.留样样品提前利用, 5:新增合同审核, 6:修改合同审核, 7.终止合同审核, 8.合同违约扣款审核',
  `status` varchar(255) NOT NULL COMMENT '审批状态: 10:审核中, 20:审核中断, 30:审核通过, 40审核不通过',
  `relation_obj_id` varchar(36) NOT NULL COMMENT '关联对象id(如:测后样品利用审批则填写[流转样品对象id])',
  `relation_obj_type` varchar(255) NOT NULL COMMENT '关联对象类型：1:样品流转对象(ObjectProcessEntity) 2.合同对象 （FeeContractMainEntity）',
  `apply_reason` varchar(512) DEFAULT NULL COMMENT '申请原因',
  `apply_remark` varchar(512) DEFAULT NULL COMMENT '申请备注',
  `apply_data` varchar(4096) DEFAULT NULL COMMENT '申请的相关数据,json格式存放',
  `apply_user` varchar(255) DEFAULT NULL COMMENT '申请人',
  `apply_user_id` varchar(36) DEFAULT NULL COMMENT '申请人id',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构编码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通用的逐级审批表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_stepwise_audit_person`
--

DROP TABLE IF EXISTS `t_stepwise_audit_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_stepwise_audit_person` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `user_id` varchar(36) NOT NULL COMMENT '用户ID',
  `audit_id` varchar(36) NOT NULL COMMENT '审批对象id',
  `audit_sequence` int(11) NOT NULL COMMENT '审核顺序',
  `is_pass` varchar(10) DEFAULT NULL COMMENT '是否通过 0:否, 1:是',
  `opinion` varchar(255) DEFAULT NULL COMMENT '意见',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_attachment`
--

DROP TABLE IF EXISTS `t_synthesis_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_attachment` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `attachment_id` varchar(36) NOT NULL COMMENT '附件id',
  `attachment_name` varchar(512) DEFAULT NULL,
  `project_id` varchar(36) DEFAULT NULL COMMENT '项目id',
  `unit_project_id` varchar(36) DEFAULT NULL COMMENT '单位工程id',
  `contract_part_id` varchar(36) DEFAULT NULL COMMENT '合同段id',
  `remarks` varchar(20) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目附录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_contacts`
--

DROP TABLE IF EXISTS `t_synthesis_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_contacts` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `belong_unit` varchar(500) DEFAULT NULL COMMENT '所属单位',
  `position` varchar(20) DEFAULT NULL COMMENT '职位',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `mail` varchar(20) DEFAULT NULL COMMENT '邮箱',
  `project_id` varchar(36) NOT NULL COMMENT '项目id',
  `contract_part_id` varchar(36) DEFAULT NULL COMMENT '合同段id',
  `unit_project_id` varchar(36) DEFAULT NULL COMMENT '单位工程id',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目联系人';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_contract`
--

DROP TABLE IF EXISTS `t_synthesis_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_contract` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `project_id` varchar(36) NOT NULL COMMENT '所属综合检测项目id',
  `contract_part_name` varchar(500) DEFAULT NULL COMMENT '合同段名称',
  `contract_part_type` varchar(10) DEFAULT NULL COMMENT '合同段类型',
  `contract_part_code` varchar(500) NOT NULL COMMENT '合同段编号',
  `construction_unit` varchar(500) DEFAULT NULL COMMENT '施工单位',
  `supervising_unit` varchar(500) DEFAULT NULL COMMENT '监理单位',
  `progress_id` varchar(36) DEFAULT NULL COMMENT '进度登记id',
  `description` varchar(2000) DEFAULT NULL COMMENT '说明',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `t_synthesis_contract_project_id_index` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目合同段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_contract_unit_person`
--

DROP TABLE IF EXISTS `t_synthesis_contract_unit_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_contract_unit_person` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `person_id` varchar(36) NOT NULL COMMENT '人员id',
  `person_name` varchar(30) NOT NULL COMMENT '人员姓名',
  `person_type` int(3) NOT NULL COMMENT '人员类型 110/检测人员；111/审核人员；112/签发人员；100/负责人',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0否/1是',
  `contract_part_id` varchar(36) DEFAULT NULL COMMENT '合同段id',
  `unit_project_id` varchar(36) DEFAULT NULL COMMENT '单位工程id',
  PRIMARY KEY (`id`),
  KEY `t_synthesis_contract_unit_person_t_synthesis_contract__fk` (`contract_part_id`),
  KEY `t_synthesis_contract_unit_person_t_synthesis_unit_project__fk` (`unit_project_id`),
  CONSTRAINT `t_synthesis_contract_unit_person_t_synthesis_contract__fk` FOREIGN KEY (`contract_part_id`) REFERENCES `t_synthesis_contract` (`id`),
  CONSTRAINT `t_synthesis_contract_unit_person_t_synthesis_unit_project__fk` FOREIGN KEY (`unit_project_id`) REFERENCES `t_synthesis_unit_project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目合同段/单位工程相关人员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_custom_column`
--

DROP TABLE IF EXISTS `t_synthesis_custom_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_custom_column` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `project_id` varchar(36) DEFAULT NULL COMMENT '项目id',
  `column_index` int(10) DEFAULT NULL COMMENT '字段序号',
  `column_name` varchar(20) NOT NULL COMMENT '字段名称',
  `column_type` int(1) NOT NULL COMMENT '字段类型',
  `is_delete` varchar(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目上报字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_custom_value`
--

DROP TABLE IF EXISTS `t_synthesis_custom_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_custom_value` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `custom_column_id` varchar(36) NOT NULL COMMENT '自定义字段id',
  `custom_column_value` varchar(30) DEFAULT NULL COMMENT '值',
  `progress_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_synthesis_custom_value_t_synthesis_progress__fk` (`progress_id`),
  CONSTRAINT `t_synthesis_custom_value_t_synthesis_progress__fk` FOREIGN KEY (`progress_id`) REFERENCES `t_synthesis_progress` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目上报字段值';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_other_achievement`
--

DROP TABLE IF EXISTS `t_synthesis_other_achievement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_other_achievement` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `unit_project_id` varchar(36) DEFAULT NULL COMMENT '单位工程id',
  `unit_project_name` varchar(500) DEFAULT NULL COMMENT '冗余单位工程名',
  `contract_part_id` varchar(36) DEFAULT NULL COMMENT '合同段id',
  `contract_part_name` varchar(500) DEFAULT NULL COMMENT '冗余合同段名',
  `project_id` varchar(36) DEFAULT NULL COMMENT '项目id',
  `project_name` varchar(500) DEFAULT NULL COMMENT '冗余项目名',
  `achievement_name` varchar(512) DEFAULT NULL,
  `achievement_type` varchar(10) DEFAULT NULL COMMENT '其它成果类型',
  `attachment_id` varchar(36) DEFAULT NULL COMMENT '附件id',
  `status` varchar(20) DEFAULT NULL COMMENT '状态',
  `audit_person_id` varchar(36) DEFAULT NULL COMMENT '审核人员id',
  `audit_person` varchar(20) DEFAULT NULL COMMENT '审核人员',
  `approve_person_id` varchar(36) DEFAULT NULL COMMENT '签发人id',
  `approve_person` varchar(20) DEFAULT NULL COMMENT '签发人',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `product_depart_id` varchar(36) NOT NULL COMMENT '产出部门ID(需求:创建人创建时所登录的部门ID)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目其它成果';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_progress`
--

DROP TABLE IF EXISTS `t_synthesis_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_progress` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `rate_of_progress` int(10) NOT NULL DEFAULT '0' COMMENT '当前进度',
  `rate_increase` int(10) DEFAULT '0' COMMENT '进度增长量',
  `name` varchar(20) DEFAULT NULL COMMENT '方便查询冗余字段',
  `contract_part_Id` varchar(36) DEFAULT NULL COMMENT '合同段id',
  `unit_project_id` varchar(36) DEFAULT NULL COMMENT '单位工程id',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `t_synthesis_progress_contract_part_Id_index` (`contract_part_Id`),
  KEY `t_synthesis_progress_unit_project_id_index` (`unit_project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目进度登记';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_progress_attachment`
--

DROP TABLE IF EXISTS `t_synthesis_progress_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_progress_attachment` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `attachment_id` varchar(36) NOT NULL COMMENT '附件id',
  `attachment_name` varchar(512) DEFAULT NULL,
  `progress_id` varchar(36) NOT NULL COMMENT '进度登记id',
  PRIMARY KEY (`id`),
  KEY `t_synthesis_progress_attachment_t_synthesis_progress__fk` (`progress_id`),
  CONSTRAINT `t_synthesis_progress_attachment_t_synthesis_progress__fk` FOREIGN KEY (`progress_id`) REFERENCES `t_synthesis_progress` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目进度登记附件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_project_person`
--

DROP TABLE IF EXISTS `t_synthesis_project_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_project_person` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `project_id` varchar(36) DEFAULT NULL COMMENT '项目id',
  `person_id` varchar(36) DEFAULT NULL COMMENT '人员id',
  `person_type` int(10) DEFAULT NULL COMMENT '人员类型',
  `person_name` varchar(20) DEFAULT NULL COMMENT '用户姓名',
  `is_deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `t_synthesis_project_person_project_id_index` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目相关人员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_synthesis_unit_project`
--

DROP TABLE IF EXISTS `t_synthesis_unit_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_synthesis_unit_project` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `contract_part_id` varchar(36) DEFAULT NULL COMMENT '合同段id',
  `project_id` varchar(36) DEFAULT NULL COMMENT '未选择合同段，必填项目id',
  `unit_project_type` varchar(20) DEFAULT NULL COMMENT '单位工程类型',
  `unit_project_name` varchar(500) DEFAULT NULL COMMENT '单位工程名称',
  `progress_id` varchar(36) DEFAULT NULL COMMENT '进度登记id',
  `description` varchar(2000) DEFAULT NULL COMMENT '说明',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `t_synthesis_unit_project_contract_part_id_index` (`contract_part_id`),
  KEY `t_synthesis_unit_project_project_id_index` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='综合检测项目单位工程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_task_assign_record`
--

DROP TABLE IF EXISTS `t_task_assign_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_task_assign_record` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `consign_id` varchar(32) DEFAULT NULL COMMENT '委托ID',
  `executor` longtext COMMENT '执行者',
  `objects` longtext COMMENT '样品',
  `params` longtext COMMENT '参数',
  `meta` longtext COMMENT '元数据',
  `executor_ids` longtext COMMENT '执行者ids',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_task_report`
--

DROP TABLE IF EXISTS `t_task_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_task_report` (
  `id` varchar(36) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `report_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_task_report_taskid` (`task_id`) USING BTREE,
  KEY `idx_task_report_reportid` (`report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_alltype`
--

DROP TABLE IF EXISTS `t_test_alltype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_alltype` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) DEFAULT '1' COMMENT '流程状态',
  `string1` varchar(32) DEFAULT '空' COMMENT '文本',
  `stringint2` int(11) DEFAULT '1' COMMENT '整数',
  `stringdouble3` double DEFAULT '0' COMMENT '浮点',
  `stringbigdecimal4` double DEFAULT NULL COMMENT '双精',
  `stringtext5` longtext COMMENT '文本',
  `stringpopup6` varchar(32) DEFAULT NULL COMMENT '弹框',
  `textarea1` longtext COMMENT '多行',
  `textpassword2` longtext COMMENT '密码',
  `tselect` varchar(32) DEFAULT NULL COMMENT '下拉',
  `tradio` varchar(32) DEFAULT NULL COMMENT '单选',
  `tcheckbox` varchar(32) DEFAULT NULL COMMENT '复选',
  `tfile` longtext COMMENT '文件',
  `tue` longtext COMMENT 'ue',
  `tdate` varchar(32) DEFAULT NULL COMMENT '日期',
  `tdatetime` varchar(32) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object`
--

DROP TABLE IF EXISTS `t_test_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object` (
  `id` varchar(36) NOT NULL,
  `consign_info_id` varchar(255) DEFAULT NULL,
  `remark` text,
  `standard` varchar(255) DEFAULT NULL COMMENT '规格型号（由型号、规格、等级、标号 ->组成）',
  `model` varchar(50) DEFAULT NULL COMMENT '型号',
  `specification` varchar(50) DEFAULT NULL COMMENT '规格',
  `grade` varchar(50) DEFAULT NULL COMMENT '等级',
  `label` varchar(50) DEFAULT NULL COMMENT '标号',
  `status` varchar(1) DEFAULT '0' COMMENT '样品状态：0.未分配 1.已分配 2.回退',
  `task_assign_type` varchar(10) DEFAULT NULL COMMENT '实验检测任务分配方案: 0:按样品分配,1:按参数分配',
  `task_assign_date` datetime DEFAULT NULL COMMENT '任务分配时间',
  `project_part_and_use` varchar(255) DEFAULT '' COMMENT '工程部位/用途',
  `level` varchar(200) DEFAULT NULL COMMENT '样品层级（如： [钢筋-热轧带肋钢筋-HRB400]）',
  `sub_project` varchar(255) DEFAULT NULL COMMENT '分项工程（废弃20180808 魏衡）',
  `unit_project` varchar(255) DEFAULT NULL COMMENT '单位工程（废弃20180808 魏衡）',
  `system_test_sample_id` varchar(36) DEFAULT NULL COMMENT '系统样品ID',
  `test_unit_test_sample_id` varchar(36) DEFAULT NULL COMMENT '单位样品ID（区别于testsampleID是hitek的sampleID)',
  `test_sample_name` varchar(255) DEFAULT NULL COMMENT '样品系统名称',
  `mark` varchar(255) DEFAULT NULL COMMENT '样品备注',
  `is_deleted` varchar(255) DEFAULT NULL COMMENT '是否删除 1：是 0：否',
  `part` varchar(255) DEFAULT NULL COMMENT 'part',
  `test_part` varchar(255) DEFAULT '' COMMENT '检测部位',
  `test_sample_display_name` varchar(255) DEFAULT NULL COMMENT '样品显示名称',
  `test_object_code` varchar(255) DEFAULT NULL,
  `test_object_codes` varchar(255) DEFAULT NULL COMMENT '多个样品需要生成多个样品编号',
  `test_sample_level_name` varchar(255) DEFAULT NULL,
  `test_verdict` varchar(4000) DEFAULT NULL COMMENT '试验检测结论',
  `test_verdict_remark` varchar(4000) DEFAULT NULL COMMENT '结论备注',
  `is_qualified` varchar(255) DEFAULT NULL COMMENT '是否合格：0.不合格 1.合格 2.不作判定',
  `days` varchar(255) DEFAULT NULL COMMENT '等待天数',
  `delegates_num` varchar(255) DEFAULT '0' COMMENT '代表数量',
  `sample_num` varchar(255) DEFAULT NULL,
  `parent_sample_id` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT '样品描述',
  `sampling_date` date DEFAULT NULL COMMENT '取样时间',
  `sampling_place` varchar(200) DEFAULT NULL COMMENT '取样地点',
  `sampling_company` varchar(200) DEFAULT NULL COMMENT '取样单位',
  `sample_person` varchar(50) DEFAULT NULL COMMENT '取样人',
  `sample_person_number` varchar(50) DEFAULT NULL COMMENT '取样人证件号',
  `test_start_date` datetime DEFAULT NULL COMMENT '试验开始日期',
  `test_end_date` datetime DEFAULT NULL COMMENT '试验结束日期',
  `test_conditions` varchar(200) DEFAULT NULL COMMENT '试验环境条件',
  `sampling_info` varchar(200) DEFAULT NULL COMMENT '样品抽样信息',
  `big_category_id` varchar(36) DEFAULT NULL COMMENT '自定义大类id',
  `sample_process_method` int(10) DEFAULT NULL COMMENT '测后样品处理方式',
  `sample_amount` int(10) DEFAULT NULL COMMENT '样品计价数量，取绝于数据中心参数设置',
  `is_retention_sample` tinyint(1) NOT NULL COMMENT '样品留样信息，详情看t_s_sample',
  `retention_how_long` int(11) DEFAULT NULL COMMENT '留样时长',
  `retention_time_unit` varchar(5) DEFAULT NULL COMMENT '留样时间单位',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1000' COMMENT '用于区分主样品/子样品 1000=主样品 2000=子样品',
  PRIMARY KEY (`id`),
  KEY `FK_T_TEST_OBJECT_CONSIGN_ID` (`consign_info_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_attachment`
--

DROP TABLE IF EXISTS `t_test_object_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_attachment` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `test_object_id` varchar(36) NOT NULL COMMENT '样品id',
  `attachment_id` varchar(36) NOT NULL COMMENT '文件id',
  `attachment_name` varchar(512) DEFAULT NULL,
  `type` int(10) NOT NULL COMMENT '类型，ilis委托100/预委托200',
  `path` varchar(2000) NOT NULL COMMENT '文件路径',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `t_test_object_attachment_t_test_object__fk` (`test_object_id`),
  CONSTRAINT `t_test_object_attachment_t_test_object__fk` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='样品附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_children`
--

DROP TABLE IF EXISTS `t_test_object_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_children` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `type` int(1) NOT NULL COMMENT '类型：1.引用原材料 2.掺配样品 3.手动录入的原材料',
  `manufacture_date` date DEFAULT NULL COMMENT '生产日期',
  `manufacture_location` varchar(255) DEFAULT NULL COMMENT '生产地',
  `manufacturer` varchar(255) DEFAULT NULL COMMENT '生产厂家',
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `quantity` varchar(255) DEFAULT NULL COMMENT '试样数量',
  `remark` text COMMENT '备注',
  `batch_number` varchar(255) DEFAULT NULL COMMENT '批号',
  `standard` varchar(255) DEFAULT NULL COMMENT '规格型号',
  `quote_test_object_id` varchar(36) DEFAULT NULL COMMENT '引用检测对象id（引用样品id）',
  `test_object_id` varchar(36) DEFAULT NULL COMMENT '试验对象（收样样品）',
  `code` varchar(255) DEFAULT NULL COMMENT '编号',
  `for_use` varchar(255) DEFAULT NULL COMMENT '用途',
  `criterion` varchar(255) DEFAULT NULL COMMENT '规范',
  `production_date` datetime DEFAULT NULL COMMENT '出厂日期',
  `is_deleted` varchar(3) DEFAULT NULL COMMENT '是否已删除 1-是 0-否',
  `mark` varchar(255) DEFAULT NULL COMMENT '手动生成的唯一标识',
  `represent_quantity` varchar(255) DEFAULT NULL COMMENT '代表数量',
  `sampling_place` varchar(255) DEFAULT NULL COMMENT '取样地点',
  `recommended_dosage` varchar(255) DEFAULT NULL COMMENT '推荐掺量',
  `dosage` varchar(255) DEFAULT NULL COMMENT '用量',
  `unit_ratio` varchar(255) DEFAULT NULL COMMENT '单位比',
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7994893498D5F2AD` (`quote_test_object_id`) USING BTREE,
  KEY `FK799489343C550A8A` (`test_object_id`) USING BTREE,
  CONSTRAINT `t_test_object_children_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='引用的关联样品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_other_info_value`
--

DROP TABLE IF EXISTS `t_test_object_other_info_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_other_info_value` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `attribute_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT '' COMMENT '数据中心配置的显示名称',
  `data_type` varchar(255) DEFAULT NULL,
  `system_field_name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `test_object_id` varchar(36) DEFAULT NULL,
  `is_deleted` varchar(255) DEFAULT NULL,
  `info_type` varchar(255) DEFAULT NULL,
  `is_show_test` tinyint(1) DEFAULT '0' COMMENT '数据中心是否盲样字段',
  PRIMARY KEY (`id`),
  KEY `FK5FE3F36D3C550A8A` (`test_object_id`) USING BTREE,
  CONSTRAINT `t_test_object_other_info_value_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_other_material`
--

DROP TABLE IF EXISTS `t_test_object_other_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_other_material` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `manufacture_date` date DEFAULT NULL,
  `manufacture_location` varchar(255) DEFAULT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `remark` text,
  `batch_number` varchar(255) DEFAULT NULL,
  `standard` varchar(255) DEFAULT NULL,
  `quote_test_object_id` varchar(36) DEFAULT NULL,
  `test_object_id` varchar(36) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `for_use` varchar(255) DEFAULT NULL,
  `criterion` varchar(255) DEFAULT NULL,
  `mark` varchar(255) DEFAULT NULL,
  `is_deleted` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7994893498D5F2AD` (`quote_test_object_id`) USING BTREE,
  KEY `FK799489343C550A8A` (`test_object_id`) USING BTREE,
  CONSTRAINT `t_test_object_other_material_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_param`
--

DROP TABLE IF EXISTS `t_test_object_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_param` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `price` decimal(19,2) DEFAULT NULL,
  `share_identity` varchar(255) DEFAULT NULL,
  `test_param_display_name` varchar(255) DEFAULT NULL,
  `test_param_id` varchar(255) NOT NULL,
  `test_object_id` varchar(36) DEFAULT NULL,
  `is_deleted` varchar(255) DEFAULT NULL,
  `is_temp_param` varchar(255) DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `is_locale_item` varchar(10) DEFAULT NULL COMMENT '是否现场检测',
  `is_build_sample_code` varchar(10) DEFAULT NULL COMMENT '现场试验是否创建样品编号,非现场试验此字段无意义',
  PRIMARY KEY (`id`),
  KEY `FKAF634B0F3C550A8A` (`test_object_id`) USING BTREE,
  KEY `IDX_TTESTPARAM_TESTPARAMID` (`test_param_id`) USING BTREE,
  CONSTRAINT `t_test_object_param_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_param_intermediate_result`
--

DROP TABLE IF EXISTS `t_test_object_param_intermediate_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_param_intermediate_result` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `result_name` varchar(255) DEFAULT NULL,
  `test_param_intermediate_result_id` varchar(255) DEFAULT NULL COMMENT '弃用该字段 20180820 weiheng',
  `value` varchar(255) DEFAULT NULL,
  `test_object_param_id` varchar(36) DEFAULT NULL,
  `source_type` varchar(1) DEFAULT NULL COMMENT '来源：1.用户添加 2.hitek数据中心默认值',
  PRIMARY KEY (`id`),
  KEY `FK7F5D64F32B4527D7` (`test_object_param_id`) USING BTREE,
  CONSTRAINT `t_test_object_param_intermediate_result_ibfk_1` FOREIGN KEY (`test_object_param_id`) REFERENCES `t_test_object_param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收样参数中间结果';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_param_period`
--

DROP TABLE IF EXISTS `t_test_object_param_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_param_period` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `test_object_period_id` varchar(36) NOT NULL COMMENT '龄期试件id',
  `test_object_param_id` varchar(36) NOT NULL COMMENT '收样样品参数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收样参数和龄期试件的关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_param_use_standard`
--

DROP TABLE IF EXISTS `t_test_object_param_use_standard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_param_use_standard` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `base_standard_id` varchar(255) DEFAULT '' COMMENT '依据ID',
  `base_standard_name` varchar(255) DEFAULT '' COMMENT '依据名称',
  `test_object_param_id` varchar(36) DEFAULT NULL COMMENT '收样参数',
  `base_standard_use_type` varchar(1) DEFAULT NULL COMMENT '作用类型 1：试验依据  2：评定标准',
  `clause_code` varchar(255) DEFAULT NULL COMMENT '依据条款号',
  `publish_code` varchar(255) DEFAULT NULL COMMENT '依据发布号',
  `execute_date` datetime DEFAULT NULL COMMENT '执行时间',
  `expire_date` datetime DEFAULT NULL COMMENT '过期时间',
  `file_id` varchar(36) DEFAULT NULL COMMENT '规程文件id',
  `file_name` varchar(250) DEFAULT NULL COMMENT '规程文件名称',
  `file_url` varchar(1024) DEFAULT NULL COMMENT '规程文件地址',
  PRIMARY KEY (`id`),
  KEY `FK7DB5A1A52B4527D7` (`test_object_param_id`) USING BTREE,
  CONSTRAINT `t_test_object_param_use_standard_ibfk_1` FOREIGN KEY (`test_object_param_id`) REFERENCES `t_test_object_param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_period`
--

DROP TABLE IF EXISTS `t_test_object_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_period` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `forming_date` datetime DEFAULT NULL,
  `hours` decimal(19,2) DEFAULT NULL,
  `test_object_id` varchar(36) DEFAULT NULL,
  `period_code` varchar(255) DEFAULT NULL,
  `mark` varchar(255) DEFAULT NULL,
  `is_create_report` varchar(255) DEFAULT '0',
  `hitek_age_day` varchar(255) DEFAULT NULL COMMENT '海特数据中心龄期天数字段',
  `test_task_id` varchar(36) DEFAULT NULL COMMENT '实验检测任务id',
  `is_tested` varchar(10) NOT NULL DEFAULT '0' COMMENT '该龄期是否已检测',
  `test_param_id` varchar(1000) DEFAULT NULL COMMENT '冗余字段:系统参数id,多个以逗号分隔',
  `test_param_name` varchar(500) NOT NULL COMMENT '参数名称(取系统参数显示名称,因为委托时指定制件信息时只有系统参数)',
  `process_object_id` varchar(36) DEFAULT NULL COMMENT '流转样品id',
  `process_object_sn` varchar(200) DEFAULT NULL COMMENT '流转样品编号',
  `object_group_num` int(11) NOT NULL COMMENT '样品组别编号(用于在委托阶段一次收取多组样品时,添加的制件信息指定给某组样品的需求)',
  `description` varchar(500) DEFAULT NULL COMMENT '制件描述',
  `source_from` varchar(10) NOT NULL COMMENT '数据来源: 1:委托, 2:任务, 3:样品流转',
  `producer` varchar(100) NOT NULL COMMENT '制件人',
  PRIMARY KEY (`id`),
  KEY `FK3D3E937F3C550A8A` (`test_object_id`) USING BTREE,
  CONSTRAINT `t_test_object_period_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收样样品龄期信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_process`
--

DROP TABLE IF EXISTS `t_test_object_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_process` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `test_object_id` varchar(36) NOT NULL COMMENT '试验样品id',
  `object_get_time` datetime DEFAULT NULL COMMENT '领样日期',
  `amount` varchar(255) DEFAULT NULL COMMENT '本批样品数量(收样处留样或领取数量)',
  `status` varchar(255) NOT NULL COMMENT '当前处理状态',
  `reserve_time` datetime DEFAULT NULL COMMENT '留样时间',
  `reserve_day_limit` int(11) DEFAULT NULL COMMENT '留样天数',
  `reserve_time_unit` varchar(10) DEFAULT 'D' COMMENT '留样期限的时间单位',
  `dispose_way` varchar(255) DEFAULT NULL COMMENT '处理方案',
  `dispose_time` datetime DEFAULT NULL COMMENT '处理时间',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  `test_object_sn` varchar(255) DEFAULT NULL COMMENT '样品编号,当一个样品收样多组时,每组生成一条记录,编号只是本组的编号',
  `parent_object_id` varchar(36) DEFAULT NULL COMMENT '父级流转样品id, 常见于收样处留样的样品, 因为收样处留样是创建正常流转样品的一个副本,所以持有正常流转样品的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_process_record`
--

DROP TABLE IF EXISTS `t_test_object_process_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_process_record` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `test_object_id` varchar(36) NOT NULL COMMENT '样品id',
  `object_process_id` varchar(36) NOT NULL COMMENT '样品流转对象id',
  `operation_type` varchar(255) NOT NULL COMMENT '操作类型 0:领样,1:收样处留样,2:测后留样,3:测后废弃,4:留样到期废弃,5:留样到期返还,6:提前废弃,7:提前返还,8:利用',
  `operator` varchar(255) DEFAULT NULL COMMENT '经办人id',
  `receiver` varchar(36) DEFAULT NULL COMMENT '领样人,留样人,接收人,利用人的id',
  `receiver_id` varchar(36) DEFAULT NULL COMMENT '领样人,留样人,接收人,利用人的id(如果是选择的人员)',
  `operation_date` datetime NOT NULL COMMENT '处理日期:领样,留样,废弃,返还,利用的日期',
  `amount` varchar(255) NOT NULL COMMENT '处理数量',
  `save_site` varchar(255) DEFAULT NULL COMMENT '保存地点,留样地点',
  `save_day_limit` int(11) DEFAULT NULL COMMENT '保存期限,留样期限(天)',
  `reserve_time_unit` varchar(10) DEFAULT 'D' COMMENT '留样期限的时间单位',
  `reason` varchar(512) DEFAULT NULL COMMENT '原因',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_result`
--

DROP TABLE IF EXISTS `t_test_object_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_result` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `conclusion` varchar(255) DEFAULT NULL COMMENT '检测结论',
  `ordain_value` varchar(1000) DEFAULT NULL COMMENT '规定值',
  `test_object_param_id` varchar(36) DEFAULT NULL COMMENT '收样参数ID（如果是UDR数据集来的，则是通过参数名匹配获取的ID，可能不准确）',
  `param_name` varchar(255) DEFAULT NULL COMMENT '参数名称',
  `standard_name` varchar(255) DEFAULT NULL COMMENT '检验指标名称',
  `standard_unit` varchar(255) DEFAULT NULL COMMENT '指标单位',
  `test_count` int(11) DEFAULT NULL COMMENT '检验次数',
  `test_group` int(11) DEFAULT NULL COMMENT '指标单位',
  `test_value` varchar(255) DEFAULT NULL COMMENT '检验值',
  `test_object_id` varchar(36) DEFAULT NULL,
  `group_key` varchar(255) DEFAULT NULL COMMENT 'udr模板分组Key，在一个收样样品跨项目收样时，区分udr模板应该加载的数据集',
  `is_qualified` varchar(255) DEFAULT NULL COMMENT '是否通过： 0.不合格  1.合格  2.不判定',
  `seq` int(11) DEFAULT NULL,
  `seq2` int(11) DEFAULT NULL,
  `test_object_code` varchar(255) DEFAULT NULL,
  `status` varchar(1) DEFAULT '1' COMMENT '状态：0.删除 1.正常',
  `is_main_test_item` varchar(5) DEFAULT '' COMMENT '是否为主试验项目：交由模板组编辑保存',
  `unit_show_position` varchar(50) DEFAULT '' COMMENT '单位显示位置：交由模板组编辑保存',
  `is_custom_param` varchar(2) DEFAULT '' COMMENT '是否自定义参数：交由模板组编辑保存',
  `project_part` varchar(2000) DEFAULT '' COMMENT '工程部位：交由模板组编辑保存（TestResultValue定义该字段长度为MAX，所以这里给2000的长度）',
  `sys_param_name` varchar(255) DEFAULT NULL COMMENT '系统参数名称',
  `sys_indicator` varchar(255) DEFAULT NULL COMMENT '系统指标名称',
  PRIMARY KEY (`id`),
  KEY `FK40A8E5DB3C550A8A` (`test_object_id`) USING BTREE,
  CONSTRAINT `t_test_object_result_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_result_detail`
--

DROP TABLE IF EXISTS `t_test_object_result_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_result_detail` (
  `id` varchar(36) NOT NULL,
  `test_object_id` varchar(36) NOT NULL COMMENT '样品id',
  `test_task_id` varchar(36) DEFAULT NULL COMMENT '任务id',
  `standard_name` varchar(255) DEFAULT NULL COMMENT '指标名称',
  `param_name` varchar(1024) DEFAULT NULL COMMENT '参数名称',
  `test_group` varchar(11) DEFAULT NULL COMMENT '检验组数',
  `test_count` varchar(11) DEFAULT NULL COMMENT '检验次数',
  `test_value` varchar(255) DEFAULT NULL COMMENT '检验值',
  `order_no` varchar(11) DEFAULT NULL COMMENT '排序号',
  `is_deleted` varchar(10) NOT NULL DEFAULT '0' COMMENT '是否已删除: 0否,1是',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测结果数据(test_object_result是报告附加结论, 这个是检测结果,相当于检测过程中的数据记录[结果和结论的区别])';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_use_udr`
--

DROP TABLE IF EXISTS `t_test_object_use_udr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_use_udr` (
  `id` varchar(32) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `group_key` varchar(255) DEFAULT NULL COMMENT '模板分组Key，在一个收样样品跨项目收样时，区分udr模板应该加载的数据集',
  `head_horizontal_id` varchar(255) DEFAULT NULL COMMENT '模板横向表头id',
  `head_horizontal_name` varchar(255) DEFAULT NULL COMMENT '模板横向表头name',
  `head_vertical_id` varchar(255) DEFAULT NULL COMMENT '模板纵向表头id',
  `head_vertical_name` varchar(255) DEFAULT NULL COMMENT '模板纵向表头name',
  `is_deleted` varchar(255) DEFAULT NULL COMMENT '是否已删除1-是、0-否',
  `tail_horizontal_id` varchar(255) DEFAULT NULL COMMENT '模板横向表尾id',
  `tail_horizontal_name` varchar(255) DEFAULT NULL COMMENT '模板横向表尾name',
  `tail_vertical_id` varchar(255) DEFAULT NULL COMMENT '模板纵向表尾id',
  `tail_vertical_name` varchar(255) DEFAULT NULL COMMENT '模板纵向表尾name',
  `name` varchar(255) DEFAULT NULL COMMENT '模板名称',
  `template_id` varchar(255) DEFAULT NULL COMMENT '模板id',
  `template_type` varchar(255) DEFAULT NULL COMMENT '模板类型：1.录入模板 2.记录模板 3.报告模板 ',
  `test_object_id` varchar(32) DEFAULT NULL COMMENT '试验对象（收样样品）',
  `file_type` varchar(2) NOT NULL COMMENT '文件类型：-1 未知类型 1 UDR模板 2 Word模板',
  PRIMARY KEY (`id`),
  KEY `FK8A3B370D3C550A8A` (`test_object_id`) USING BTREE,
  CONSTRAINT `t_test_object_use_udr_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_object_use_udr_record_set`
--

DROP TABLE IF EXISTS `t_test_object_use_udr_record_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_object_use_udr_record_set` (
  `id` varchar(32) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `dynamic_record_sets` varchar(255) DEFAULT NULL COMMENT '需要动态创建的数据集的名称（英文逗号分隔）',
  `group_key` varchar(255) DEFAULT NULL COMMENT '模板分组标识，收样参数跨试验项目时有用',
  `record_set_name` varchar(255) DEFAULT NULL COMMENT '数据集名称',
  `xml_content` mediumblob COMMENT '数据集内容（xml格式），以二进制方式保存在数据库中',
  `test_object_id` varchar(32) DEFAULT NULL COMMENT '试验对象ID',
  `is_deleted` varchar(1) DEFAULT '0' COMMENT '是否已删除：1.是 0.未删除',
  PRIMARY KEY (`id`),
  KEY `FK4E22EBE63C550A8A` (`test_object_id`) USING BTREE,
  CONSTRAINT `t_test_object_use_udr_record_set_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验对象（收样样品）使用数据集表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_param_use_standard`
--

DROP TABLE IF EXISTS `t_test_param_use_standard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_param_use_standard` (
  `id` varchar(36) NOT NULL,
  `base_standard_id` varchar(255) DEFAULT '' COMMENT '依据ID',
  `base_standard_name` varchar(255) DEFAULT '' COMMENT '依据名称',
  `test_param_id` varchar(36) NOT NULL COMMENT '收样参数：t_s_test_param.id',
  `sample_id` varchar(36) NOT NULL COMMENT '样品ID：t_s_test_sample.id',
  `base_standard_use_type` varchar(1) DEFAULT NULL COMMENT '作用类型 1：试验依据  2：评定标准',
  `clause_code` varchar(255) DEFAULT NULL COMMENT '依据条款号',
  `publish_code` varchar(255) DEFAULT NULL COMMENT '依据发布号',
  `execute_date` datetime DEFAULT NULL COMMENT '执行时间',
  `expire_date` datetime DEFAULT NULL COMMENT '过期时间',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL COMMENT '历史记录默认显示',
  `file_name` varchar(50) DEFAULT NULL COMMENT '规程文件名',
  `file_id` varchar(50) DEFAULT NULL COMMENT '规程文件名id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task`
--

DROP TABLE IF EXISTS `t_test_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `alloc_date` datetime DEFAULT NULL,
  `consign_info_id` varchar(255) DEFAULT NULL,
  `finish_date` datetime DEFAULT NULL,
  `pid` varchar(255) DEFAULT NULL,
  `require_completed_date` datetime DEFAULT NULL,
  `test_date` datetime DEFAULT NULL COMMENT '试验检测开始时间 - udr报告填写时录入',
  `test_end_date` datetime DEFAULT NULL COMMENT '试验检测结束时间',
  `status` varchar(255) DEFAULT NULL COMMENT '任务状态：10.待分配 20.已分配，试验检测中 21.已录入部分检测数据 22.复核人确认有误返回修改 30.试验检测完成，等待复核人确认 40.已提交正式报告 50.回退',
  `task_type` varchar(255) DEFAULT NULL,
  `big_type` varchar(10) DEFAULT NULL COMMENT '任务大类 1:正常任务, 2:综合任务',
  `test_task_code` varchar(255) DEFAULT NULL,
  `test_record_code` varchar(255) DEFAULT NULL COMMENT '记录编码',
  `is_deleted` varchar(255) DEFAULT NULL COMMENT '是否已删除 1-是 0-否',
  `report_date` datetime DEFAULT NULL,
  `workflow_status` varchar(1) DEFAULT '3' COMMENT '1、超期  2、回退  3正常 4 作废',
  `test_conclusion` varchar(255) DEFAULT '' COMMENT '试验结论',
  `test_conclusion_remark` varchar(255) DEFAULT '' COMMENT '试验结论备注',
  `assign_type` varchar(10) DEFAULT NULL COMMENT '任务分配类型: 0:按样品分配  1:按参数分配',
  `assigner_id` varchar(36) NOT NULL COMMENT '任务分配人id',
  `norm_finish_time` datetime DEFAULT NULL COMMENT '任务标准完成时间',
  `been_notice_modify` char(2) DEFAULT '0' COMMENT '是否通知修改委托 0-否 1-是',
  PRIMARY KEY (`id`),
  KEY `FKD88AAF07A35703FA` (`consign_info_id`) USING BTREE,
  CONSTRAINT `t_test_task_ibfk_1` FOREIGN KEY (`consign_info_id`) REFERENCES `t_consign_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_attachment`
--

DROP TABLE IF EXISTS `t_test_task_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_attachment` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `is_deleted` varchar(255) DEFAULT NULL,
  `test_object_id` varchar(255) DEFAULT NULL,
  `group_key` varchar(255) DEFAULT NULL COMMENT '模板分组Key，在一个收样样品跨项目收样时，区分udr模板应该加载的数据集',
  `test_task_attachment_folder_id` varchar(36) DEFAULT NULL,
  `test_task_id` varchar(36) DEFAULT NULL,
  `attachment_version` int(11) DEFAULT NULL,
  `name` varchar(512) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '文件类型 udr/word/image',
  `use_type` varchar(50) DEFAULT NULL COMMENT '文件用途分类: 1:报告文件, 2:记录文件, 3:附件, 4:首件报告',
  `source_type` varchar(50) DEFAULT NULL COMMENT '来源分类: 0:系统  1:用户',
  `uri` varchar(255) DEFAULT NULL,
  `comm_attachment_id` varchar(255) DEFAULT NULL,
  `need_resave` varchar(1) DEFAULT '0' COMMENT '是否需要重新保存测试结果 1.是  0.否（针对UDR测试报告，委托更新后需要更新UDR）',
  `order_num` int(3) DEFAULT '100' COMMENT '排序',
  `test_object_use_udr_id` varchar(32) DEFAULT NULL COMMENT 't_test_object_use_udr.id',
  `is_show` char(2) DEFAULT '1' COMMENT '是否展示该文件 0-不展示 1-展示',
  `generate_status` char(2) DEFAULT NULL COMMENT '文件生成状态 2-转换中 3-转换成功 4-装换失败,对应数据中心的转换状态',
  PRIMARY KEY (`id`),
  KEY `FKBEF3255B2E091450` (`test_task_id`) USING BTREE,
  KEY `FKBEF3255BCFE82D36` (`test_task_attachment_folder_id`) USING BTREE,
  CONSTRAINT `t_test_task_attachment_ibfk_1` FOREIGN KEY (`test_task_id`) REFERENCES `t_test_task` (`id`),
  CONSTRAINT `t_test_task_attachment_ibfk_2` FOREIGN KEY (`test_task_attachment_folder_id`) REFERENCES `t_test_task_attachment_folder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_attachment_folder`
--

DROP TABLE IF EXISTS `t_test_task_attachment_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_attachment_folder` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `is_deleted` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source_type` varchar(10) NOT NULL COMMENT '来源:0:系统,1:用户',
  `pid` varchar(36) DEFAULT NULL,
  `test_task_id` varchar(36) DEFAULT NULL,
  `seq` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE80147D22E091450` (`test_task_id`) USING BTREE,
  KEY `FKE80147D29B22DF44` (`pid`) USING BTREE,
  CONSTRAINT `t_test_task_attachment_folder_ibfk_1` FOREIGN KEY (`test_task_id`) REFERENCES `t_test_task` (`id`),
  CONSTRAINT `t_test_task_attachment_folder_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `t_test_task_attachment_folder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_param`
--

DROP TABLE IF EXISTS `t_test_task_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_param` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `test_object_param_id` varchar(255) DEFAULT NULL,
  `test_task_id` varchar(36) DEFAULT NULL,
  `is_deleted` varchar(10) NOT NULL DEFAULT '0' COMMENT '是否已删除, 0:否, 1:是',
  PRIMARY KEY (`id`),
  KEY `FK7F4CD19E2E091450` (`test_task_id`) USING BTREE,
  KEY `FK464B89552B4527D7` (`test_object_param_id`) USING BTREE,
  CONSTRAINT `t_test_task_param_ibfk_1` FOREIGN KEY (`test_object_param_id`) REFERENCES `t_test_object_param` (`id`),
  CONSTRAINT `t_test_task_param_ibfk_2` FOREIGN KEY (`test_task_id`) REFERENCES `t_test_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_person`
--

DROP TABLE IF EXISTS `t_test_task_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_person` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `operate_date` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '0. 实验人员  1. 复核人员  2.报告编写  3.审核  4.批准',
  `user_id` varchar(255) DEFAULT NULL,
  `test_task_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK835E438D2E091450` (`test_task_id`) USING BTREE,
  CONSTRAINT `t_test_task_person_ibfk_1` FOREIGN KEY (`test_task_id`) REFERENCES `t_test_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_prompt`
--

DROP TABLE IF EXISTS `t_test_task_prompt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_prompt` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `prompt_date` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `test_task_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8414019C2E091450` (`test_task_id`) USING BTREE,
  CONSTRAINT `t_test_task_prompt_ibfk_1` FOREIGN KEY (`test_task_id`) REFERENCES `t_test_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_relation`
--

DROP TABLE IF EXISTS `t_test_task_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_relation` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `main_task_id` varchar(36) NOT NULL COMMENT '主任务id',
  `relation_task_id` varchar(36) NOT NULL COMMENT '关联任务id',
  `is_deleted` varchar(10) NOT NULL DEFAULT '0' COMMENT '逻辑删除标记',
  `sys_org_code` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`),
  KEY `idx_task_relation_main_task_id` (`main_task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测任务关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_result`
--

DROP TABLE IF EXISTS `t_test_task_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_result` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `conclusion` varchar(255) DEFAULT NULL,
  `measure_unit` varchar(255) DEFAULT NULL,
  `standard_value` varchar(255) DEFAULT NULL,
  `test_value` varchar(255) DEFAULT NULL,
  `test_object_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK86C870553C550A8A` (`test_object_id`) USING BTREE,
  CONSTRAINT `t_test_task_result_ibfk_1` FOREIGN KEY (`test_object_id`) REFERENCES `t_test_object` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_udr_illustrations`
--

DROP TABLE IF EXISTS `t_test_task_udr_illustrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_udr_illustrations` (
  `id` varchar(36) NOT NULL,
  `test_task_id` varchar(36) DEFAULT NULL COMMENT '任务ID',
  `test_object_id` varchar(36) DEFAULT NULL COMMENT '样品ID',
  `cell_alias` varchar(50) DEFAULT NULL COMMENT '单元格别名',
  `attachment_id` varchar(36) NOT NULL COMMENT '附件ID，对应 t_s_attachment.id',
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='UDR附件/插图';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_test_task_use_equipment`
--

DROP TABLE IF EXISTS `t_test_task_use_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_test_task_use_equipment` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `end_use_time` datetime DEFAULT NULL COMMENT '结束使用时间',
  `equipment_code` varchar(255) DEFAULT NULL COMMENT '设备编号',
  `equipment_id` varchar(255) DEFAULT NULL COMMENT '设备ID',
  `equipment_name` varchar(255) DEFAULT NULL COMMENT '设备名称',
  `standard` varchar(128) DEFAULT NULL COMMENT '型号',
  `start_use_time` datetime DEFAULT NULL COMMENT '开始使用时间',
  `test_task_id` varchar(36) DEFAULT NULL COMMENT '实验任务',
  `test_task_param_id` varchar(36) DEFAULT NULL COMMENT '实验任务参数',
  `next_check_date` datetime DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL COMMENT '使用人',
  `status` varchar(1) NOT NULL DEFAULT '1' COMMENT '状态：1.正常 0.已删除',
  PRIMARY KEY (`id`),
  KEY `FK7F4CD19E68E90385` (`test_task_param_id`) USING BTREE,
  KEY `t_test_task_use_equipment_test_task_id_index` (`test_task_id`),
  CONSTRAINT `t_test_task_use_equipment_ibfk_1` FOREIGN KEY (`test_task_param_id`) REFERENCES `t_test_task_param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试验任务使用设备类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_trigger_log`
--

DROP TABLE IF EXISTS `t_trigger_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trigger_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oldData` varchar(5000) DEFAULT NULL,
  `newData` varchar(5000) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_blank_draw_type`
--

DROP TABLE IF EXISTS `t_udr_blank_draw_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_blank_draw_type` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `is_deleted` char(255) DEFAULT NULL COMMENT '是否已删除 1-是 0-否',
  `draw_type` varchar(255) DEFAULT NULL COMMENT '绘制方式',
  `draw_type_code` varchar(255) DEFAULT NULL COMMENT '绘制方式编码',
  `custom_character` varchar(255) DEFAULT NULL COMMENT '自定义字符',
  `effective_date` datetime DEFAULT NULL COMMENT '启用日期',
  `template_type` varchar(10) DEFAULT NULL COMMENT ' 2-记录 3-报告 ',
  `template_type_name` varchar(50) DEFAULT NULL COMMENT '模板名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='udr空白区域绘制方式';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_commentdetail`
--

DROP TABLE IF EXISTS `t_udr_commentdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_commentdetail` (
  `id` varchar(50) NOT NULL,
  `comment_id` varchar(50) DEFAULT '',
  `comment_context` varchar(200) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `comment_date_time` datetime DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='批注详细内容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_comments`
--

DROP TABLE IF EXISTS `t_udr_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_comments` (
  `id` varchar(50) NOT NULL,
  `test_object_id` varchar(50) NOT NULL COMMENT '收样详细ID',
  `report_id` varchar(36) DEFAULT NULL COMMENT '报告ID',
  `template_type` tinyint(4) NOT NULL,
  `sheet_name` varchar(50) NOT NULL,
  `sub_sheet_name` varchar(50) DEFAULT NULL,
  `cell_name` varchar(50) NOT NULL,
  `cell_bind` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_common_template`
--

DROP TABLE IF EXISTS `t_udr_common_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_common_template` (
  `id` varchar(36) NOT NULL,
  `template_code` varchar(30) DEFAULT NULL COMMENT '自定义的，方便程序识别（通过此字段查询）',
  `template_diff` varchar(30) DEFAULT NULL COMMENT '二次区分字段，如快递单要根据快递公司区分udr模板，委托要根据现场/试验区分',
  `template_name` varchar(50) DEFAULT NULL COMMENT 'udr通用模板名称 - 方便识别',
  `template` varchar(200) DEFAULT NULL COMMENT '模板 - 实际加载的 hrp 全名',
  `data_set_name` varchar(50) DEFAULT NULL COMMENT '数据集名称 - 与Java中的类对应，名称不能随便写',
  `status` varchar(1) DEFAULT '1' COMMENT '状态：1.正常 0.禁用',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用于识别该模板需要加载哪几个数据集';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_exe_version`
--

DROP TABLE IF EXISTS `t_udr_exe_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_exe_version` (
  `id` varchar(36) NOT NULL,
  `name` varchar(500) DEFAULT NULL COMMENT '附件名称',
  `attachment_id` varchar(36) DEFAULT NULL COMMENT '通用附件id',
  `url` varchar(500) DEFAULT NULL COMMENT '安装包路径',
  `version_num` varchar(500) DEFAULT NULL COMMENT '版本号',
  `is_delete` char(2) NOT NULL COMMENT '删除标记:0:未删除,1:已删除',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='UDR安装包版本管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_object_verdict`
--

DROP TABLE IF EXISTS `t_udr_object_verdict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_object_verdict` (
  `id` varchar(55) NOT NULL,
  `test_object_id` varchar(55) NOT NULL,
  `test_verdict` varchar(4000) DEFAULT NULL,
  `test_verdict_remark` varchar(4000) DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='样品检验结论';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_record`
--

DROP TABLE IF EXISTS `t_udr_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_record` (
  `id` varchar(55) NOT NULL,
  `test_object_id` varchar(55) DEFAULT NULL,
  `record_code` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_table_head_info`
--

DROP TABLE IF EXISTS `t_udr_table_head_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_table_head_info` (
  `id` varchar(55) NOT NULL,
  `name` varchar(22) DEFAULT NULL,
  `test_item_id` varchar(55) DEFAULT NULL,
  `col_count` int(11) DEFAULT NULL,
  `binding_formula` varchar(55) DEFAULT NULL,
  `formula` varchar(55) DEFAULT NULL,
  `table_type` int(11) DEFAULT NULL,
  `test_unit_id` varchar(55) DEFAULT NULL,
  `validate_date` varchar(20) DEFAULT NULL,
  `invalidate_date` varchar(20) DEFAULT NULL,
  `create_name` varchar(50) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(50) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `oerder_no` int(11) DEFAULT NULL,
  `Is_deleted` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_template_version`
--

DROP TABLE IF EXISTS `t_udr_template_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_template_version` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(10) DEFAULT NULL,
  `object_id` varchar(36) NOT NULL COMMENT '对象id，对应类型字段',
  `object_type` varchar(20) NOT NULL COMMENT '对象类型，这里取的是ConstantsUdrTemplateType的id',
  `udr_template` varchar(50) NOT NULL COMMENT '由数据中心返回的模板文件名称',
  PRIMARY KEY (`id`),
  KEY `t_udr_template_version_object_id_object_type_index` (`object_id`,`object_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据中心各类型模板使用记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_test_data`
--

DROP TABLE IF EXISTS `t_udr_test_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_test_data` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `task_id` varchar(255) DEFAULT NULL COMMENT '打包名称',
  `out_put_data` mediumtext COMMENT 'udr回传的数据',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='UDR模板封装的数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_udr_test_sign_info`
--

DROP TABLE IF EXISTS `t_udr_test_sign_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udr_test_sign_info` (
  `id` varchar(55) NOT NULL,
  `test_task_id` varchar(55) DEFAULT NULL,
  `sign_photo` varchar(4000) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sign_code` varchar(55) DEFAULT NULL,
  `type` varchar(55) DEFAULT NULL,
  `role` varchar(55) DEFAULT NULL COMMENT '冗余',
  `sign_role` varchar(55) DEFAULT NULL COMMENT '取用户名',
  `create_name` varchar(255) DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `sys_org_code` varchar(50) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `user_id` varchar(55) DEFAULT NULL,
  `test_object_id` varchar(55) DEFAULT NULL COMMENT '冗余',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

-- MySQL dump 10.13  Distrib 5.7.27, for Win64 (x86_64)
--
-- Host: 192.168.2.3    Database: ilis_test
-- ------------------------------------------------------
-- Server version	5.7.17-log

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
-- Table structure for table `t_s_business_param`
--

DROP TABLE IF EXISTS `t_s_business_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_business_param` (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT '参数解释',
  `explains` varchar(255) DEFAULT NULL COMMENT '对参数更详细的解释',
  `param_id` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL COMMENT '参数值',
  `type` varchar(36) DEFAULT NULL COMMENT '排序的编号，用于栏目的现实顺序',
  `type_id` varchar(36) DEFAULT NULL COMMENT '用于树形表父id,父亲及是该表的ID',
  `type_or_param` varchar(36) DEFAULT NULL COMMENT '0 type    1 param',
  `input_type` varchar(36) DEFAULT NULL,
  `width` varchar(36) DEFAULT NULL,
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `p_id` varchar(36) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `select_type` varchar(36) DEFAULT NULL,
  `radio_name` varchar(36) DEFAULT NULL,
  `unit` varchar(36) DEFAULT NULL,
  `is_show` varchar(10) NOT NULL DEFAULT '1' COMMENT '是否在页面展示该参数',
  PRIMARY KEY (`id`),
  KEY `ind_type` (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_business_param`
--

LOCK TABLES `t_s_business_param` WRITE;
/*!40000 ALTER TABLE `t_s_business_param` DISABLE KEYS */;
INSERT INTO `t_s_business_param` VALUES ('09f5f20d-3c0f-4bb5-9410-6be19395fa99','原材料委托日期冲突提醒','勾选此参数，在完成新增的委托时，若填写的委托日期与当前的实际日期不一致，系统会进行提醒','R_M_C_DATE_TIP','Y',NULL,'402882cc5ddfa5ed015ddfa6cbb40005','1','checkbox',NULL,NULL,NULL,'2020-05-06 14:01:31','clm',NULL,NULL,NULL,NULL,NULL,'1'),('1e5b32c5b9ec11eab61fb8ca3a6052ac','允许上传的报告格式','多种格式\"|\"分隔,示例:*.pdf|*.docx','REPORT_MANAGE_32','*.pdf|*.docx|*.doc',NULL,'402882cc5ddfa5ed015ddfa704010040','1','text','300px',NULL,NULL,'2020-06-29 17:38:16','system',NULL,NULL,NULL,NULL,NULL,'1'),('261c0e72-beb1-4d7a-bd74-bfd309b2d444','综合试验委托日期冲突提醒','勾选此参数，在创建综合任务中指派人员时，若填写的委托日期与当前的实际日期不一致，系统会进行提醒','S_T_DATE_TIP','Y',NULL,'402882cc5ddfa5ed015ddfa6cbb40005','1','checkbox',NULL,NULL,NULL,'2020-05-06 14:01:31','clm',NULL,NULL,NULL,NULL,NULL,'1'),('28BE5DF5A3504AEDA9C7C36FE7DAB153','审核批准时查看记录报告的方式','','REPORT_MANAGE_23','origin','','402882cc5ddfa5ed015ddfa704010040','1','select','','','','2018-11-20 12:29:25','admin','','2018-11-20 19:34:33','fileDisplayType','','','1'),('4028138151adbcc50151adfd136d0003','预委托',NULL,NULL,'','0','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'0'),('402882cc5ddfa5ed015ddf8k04020587','UDR模板刷新',NULL,'UDR_REFRESH',NULL,NULL,'402882cc5ddfa5ed015ddfa704020060','1','button',NULL,NULL,NULL,'2020-02-28 10:37:05',NULL,NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6cbb40005','委托收样',NULL,'','','1','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6cbc8000a','完成委托',NULL,NULL,'','2','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6cbc9000b','检测收费',NULL,'','','3','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6cbca000c','完成委托时，是否自动打印委托单','勾选此项参数，完成委托时，会自动打印委托单','FINISH_DELE_2','N','','402882cc5ddfa5ed015ddfa6cbc8000a','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6cbcc000d','完成委托后打印委托单的份数',NULL,'FINISH_DELE_3','3','','402882cc5ddfa5ed015ddfa6cbc8000a','1','text','30px',NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6cbcd000e','完成委托后自动打印样品标签','勾选此项参数，完成委托时，会自动打印样品标签','FINISH_DELE_4','Y','','402882cc5ddfa5ed015ddfa6cbc8000a','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'0'),('402882cc5ddfa5ed015ddfa6d526001f','完成委托后系统自动分配任务','勾选此参数，将开启自动分配任务功能(试行版)','FINISH_DELE_7','N','','402882cc5ddfa5ed015ddfa6cbc8000a','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6d52f0012','试验检测检验任务不需要进行检验收费','勾选此项参数，委托默认为已收费，进入任务分配流程','TEST_CHARGE_2','Y','','402882cc5ddfa5ed015ddfa6cbc9000b','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6d5450017','合同管理',NULL,'','','4','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa6e0db0020','合同新增/修改需要审核','','CONTRACT_MANAGE_4','Y','','402882cc5ddfa5ed015ddfa6d5450017','1','checkbox','','','','2017-08-15 12:29:25','admin','','2019-04-29 13:55:49','','','','1'),('402882cc5ddfa5ed015ddfa6e0de001b','试验检测',NULL,'','','5','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704000075','样品废弃是否需要审核',NULL,'SAMPLE_MANAGE_1','Y','','402882cc5ddfa5ed015ddfa704010074','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'0'),('402882cc5ddfa5ed015ddfa704010040','报告管理',NULL,'','','6','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704010074','样品管理',NULL,'','','7','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'0'),('402882cc5ddfa5ed015ddfa704020060','其它',NULL,'','','8','','0','',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020061','延后付费是否允许打印报告','勾选此项参数，设置为延后付费的检测报告允许打印','REPORT_MANAGE_1','Y','','402882cc5ddfa5ed015ddfa704010040','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020067','自动打印以下空白章',NULL,'REPORT_MANAGE_7','Y','','402882cc5ddfa5ed015ddfa704010040','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'0'),('402882cc5ddfa5ed015ddfa704020072','报告重打修改是否需要审批','勾选此项参数，检测报告重打，要经过报告重打审批流程','REPORT_MANAGE_12','N','','402882cc5ddfa5ed015ddfa704010040','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020077','综合试验报告打印是否连续生成页码','勾选此项参数，综合试验在打印报告时，综合试验和子试验会连续生成页码（word报告不与其余子试验连续）','REPORT_MANAGE_17','Y','','402882cc5ddfa5ed015ddfa704010040','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020079','按参数分配的任务提交报告时,是否合并为按样品出报告','勾选此项参数，无论一个样品按参数分配成多少个任务,报告都会针对样品来出具,且一个试验人员提交报告后需要该样品下全部试验人员确认(包含同一样品不同任务的试验人员),然后才能流转到审批阶段','REPORT_MANAGE_19','Y','','402882cc5ddfa5ed015ddfa6e0de001b','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020080','提交的报告是否需要同任务的其他试验人员进行确认','勾选此项参数,任意实验人员提交报告后都需要同任务的其他试验人员确认后才能流转到审批阶段','REPORT_MANAGE_20','Y','','402882cc5ddfa5ed015ddfa704010040','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020117','填写现场试验数据时，是否允许由试验员增加组数','勾选此项参数，填写现场试验数据时，将允许试验员自己增加数组','TEST_DETECTION_18','Y','','402882cc5ddfa5ed015ddfa6e0de001b','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020136','是否启用电子盖章','勾选此项参数，代表启用电子盖章功能','OTHER_6','N','','402882cc5ddfa5ed015ddfa704020060','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020137','是否启用电子签名','勾选此项参数，代表启用电子签名功能','OTHER_7','N','','402882cc5ddfa5ed015ddfa704020060','1','checkbox',NULL,NULL,'0','2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020138','项目URL根地址','二维码扫描等功能需要用到该地址,请勿轻易修改','OTHER_8','http://hxcd.ilis.cn/ilis2/',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','300px',NULL,NULL,'2019-09-11 16:43:50','lilf',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020192','简易收样模式',NULL,'ACCEPT_SAMPLE_23','N',NULL,'402882cc5ddfa5ed015ddfa6cbb40005','1','checkbox',NULL,NULL,NULL,'2018-01-26 10:52:53','admin',NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020587','试验录入模板',NULL,'UDR_INPUT','103',NULL,'402882cc5ddfa5ed015ddfa704020060','1','selectudr',NULL,NULL,NULL,'2018-04-12 10:37:05',NULL,NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020588','试验检测模板',NULL,'UDR_TESTING','203',NULL,'402882cc5ddfa5ed015ddfa704020060','1','selectudr',NULL,NULL,NULL,'2018-04-12 10:37:05',NULL,NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020589','试验报告模板','','UDR_REPORT','305',NULL,'402882cc5ddfa5ed015ddfa704020060','1','selectudr',NULL,NULL,NULL,'2018-04-12 10:37:05',NULL,NULL,NULL,NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020590','任务自动分配策略','1.平均分配: 分配给有权限检测该样品的人员中任务数量（包括在检与检测完成的）最少的人<br/>&emsp;&emsp;&nbsp;&nbsp;2.能者多劳: 分配给有权限检测该样品的人员中任务数量（包括在检与检测完成的）最多的人<br/>&emsp;&emsp;&nbsp;&nbsp;3.随机分配: 分配给有权限检测该样品的人员中的随机一位<br/>&emsp;&emsp;&nbsp;&nbsp;4.空闲分配: 分配给有权限检测该样品的人员中在检任务数量最少的人','FINISH_DELE_9','4',NULL,'402882cc5ddfa5ed015ddfa6cbc8000a','1','select',NULL,NULL,NULL,'2018-04-12 10:37:05','yefei',NULL,NULL,'assignType',NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa704020591','试验检测任务龄期到期前','','TEST_DETECTION_35','7',NULL,'402882cc5ddfa5ed015ddfa6e0de001b','1','text','30px',NULL,NULL,'2018-08-06 13:59:05','wh',NULL,NULL,NULL,NULL,'天 提醒','1'),('402882cc5ddfa5ed015ddfa704020592','超过委托日期','','TEST_DETECTION_36','3',NULL,'402882cc5ddfa5ed015ddfa6e0de001b','1','text','30px',NULL,NULL,'2018-08-06 13:59:05','lilf',NULL,NULL,NULL,NULL,'天未分配的样品，在任务分配界面闪烁提醒','1'),('402882cc5ddfa5ed015ddfa704020593','试验检测任务到期前','','TEST_DETECTION_37','7','','402882cc5ddfa5ed015ddfa6e0de001b','1','text','30px','','','2018-08-06 13:59:05','wh','','2019-12-03 20:28:12','','','天 提醒','1'),('402882cc5ddfa5ed015ddfa704020594','开启盲样','勾选此参数后,部分收样敏感信息将显示为***','TEST_DETECTION_39','N',NULL,'402882cc5ddfa5ed015ddfa6e0de001b','1','checkbox',NULL,NULL,NULL,'2018-09-05 16:10:49','wh','zjq2','2019-06-14 15:53:33',NULL,NULL,NULL,'1'),('402882cc5ddfa5ed015ddfa7040205e6','预设报告签发时间为检测完成后第','','TEST_DETECTION_42','3','','402882cc5ddfa5ed015ddfa6e0de001b','1','text','30px','','','2020-05-06 17:08:44','lilf','','2020-05-06 17:08:33','','','天','1'),('402882cc5ddfa5ed015ddfa7040f5040','未完成收费是否允许打印报告','勾选此项参数，当含有未缴费项目时不能打印报告','REPORT_MANAGE_25','Y',NULL,'402882cc5ddfa5ed015ddfa704010040','1','checkbox',NULL,NULL,NULL,'2019-12-23 16:30:56','clm',NULL,NULL,NULL,NULL,NULL,'1'),('402892cc5ddfa5ed015ddfa704020170','不允许修改其他人的委托','勾选此项参数，在委托收样中，只能修改收样人是自己或者暂无收样人的委托（未审批的预委托）','ACCEPT_SAMPLE_24','N','','402882cc5ddfa5ed015ddfa6cbb40005','1','checkbox','','','','2018-04-19 12:29:25','admin','','2018-04-19 15:09:29','','','','1'),('4087f134cb374e8bb50e19e46295a397','允许提交报告时设置报告签发日期','勾选此项参数，允许提交报告时设置报告签发日期','REPORT_MANAGE_26','N',NULL,'402882cc5ddfa5ed015ddfa704010040','1','checkbox',NULL,NULL,NULL,'2020-03-02 13:39:14','clm',NULL,NULL,NULL,NULL,NULL,'1'),('411ff5756fb4469ba51e48b486a65ec8','试验检测是否允许打印报告','勾选此项参数,在打开的udr中的报告页签,显示预览和打印按钮','TEST_DETECTION_41','N','','402882cc5ddfa5ed015ddfa6e0de001b','1','checkbox',NULL,NULL,NULL,'2020-04-28 20:00:33','admin',NULL,NULL,NULL,NULL,NULL,'1'),('4390e43b619d49dcbb6fa640b9daa893','单位微信公众号ID','该参数由wx.ilis.cn提供,用于微信业务步骤通知功能','OTHER_10','a52ffbed-17f5-41ab-9bef-56b6b2ef6258',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','300px',NULL,NULL,'2019-10-24 13:59:45','admin',NULL,NULL,NULL,NULL,NULL,'0'),('4390e43b619d49dcbb6fa640b9daa894','微信消息模板ID-新事务通知消息','该参数由wx.ilis.cn提供,用于发送微信消息时指定行业消息模板','OTHER_11','mezPH5ZtVmtWuXvvM77ijpNxuVdVbua9k99OGiZaBRU',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','300px',NULL,NULL,'2019-10-24 13:59:45','admin',NULL,NULL,NULL,NULL,NULL,'0'),('4390e43b619d49dcbb6fa640b9daa895','微信消息模板ID-统计事务通知消息','该参数由wx.ilis.cn提供,用于发送微信消息时指定行业消息模板','OTHER_12','mezPH5ZtVmtWuXvvM77ijpNxuVdVbua9k99OGiZaBRU',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','300px',NULL,NULL,'2019-10-24 13:59:45','admin',NULL,NULL,NULL,NULL,NULL,'0'),('4390e43b619d49dcbb6fa640b9daa896','微信消息模板ID-事务抄送消息','该参数由wx.ilis.cn提供,用于发送微信消息时指定行业消息模板','OTHER_13','mezPH5ZtVmtWuXvvM77ijpNxuVdVbua9k99OGiZaBRU',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','300px',NULL,NULL,'2019-10-24 13:59:45','admin',NULL,NULL,NULL,NULL,NULL,'0'),('4390e43b619d49dcbb6fa640b9daa897','微信appId','微信开发者平台上,本ilis(宏信创达)项目的appId','OTHER_14','wxceb3249d482b6746',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','300px',NULL,NULL,'2020-01-08 09:25:35','lilf',NULL,'2020-01-08 09:25:28',NULL,NULL,NULL,'0'),('4390e43b619d49dcbb6fa640b9daa898','微信secret','微信开发者平台上,本ilis(宏信创达)项目的秘钥','OTHER_15','941ecdf4f78a17d25302ed7b79178ffe',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','300px',NULL,NULL,'2020-01-08 09:25:35','lilf',NULL,'2020-01-08 09:25:28',NULL,NULL,NULL,'0'),('4390e43b619d49dcbb6fa640b9daa901','设备导入模板文件地址','','OTHER_16','/export/hitek/importTemplate/设备导入模板_海特.xlsx',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','500px',NULL,NULL,'2020-02-25 13:57:34','lilf',NULL,'2020-02-25 13:57:41',NULL,NULL,NULL,'0'),('4390e43b619d49dcbb6fa640b9daa902','报告问题分类导入模板文件地址','','OTHER_17','/export/hitek/importTemplate/报告问题分类_海特.xls',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','500px',NULL,NULL,'2020-02-25 13:57:34','lilf',NULL,'2020-02-25 13:57:41',NULL,NULL,NULL,'0'),('4390e43b619d49dcbb6fa640b9daa903','人员信息导入模板文件地址','','OTHER_18','/export/template/人员信息导入模板_海特.xlsx',NULL,'402882cc5ddfa5ed015ddfa704020060','1','text','500px',NULL,NULL,'2020-02-25 13:57:34','lilf',NULL,'2020-02-25 13:57:41',NULL,NULL,NULL,'0'),('477c2eb3567a4d4f8923da192df58817','是否允许收样人员填写检测费用','勾选此项参数，在委托收样中，可以修改核定费用','ACCEPT_SAMPLE_26','Y','','402882cc5ddfa5ed015ddfa6cbb40005','1','checkbox','','','','2019-11-02 00:00:00','clm','','2019-11-02 00:00:00','','','','1'),('477c2eb3567a4d4f8923da192df58828','允许直接创建原材料试验','勾选此项参数,在创建综合试验时,也可以选到原材料试验的样品和参数','TEST_DETECTION_40','N','','402882cc5ddfa5ed015ddfa6e0de001b','1','checkbox','','','','2019-11-06 00:00:00','lilf','','2019-11-02 00:00:00','','','','1'),('477c2eb3567a4d4f8945da192df58817','根据计价数量生成样品对象','勾选此项参数，选择样品后，会根据参数计价数量，对应生成多个样品对象','ACCEPT_SAMPLE_25','Y','','402882cc5ddfa5ed015ddfa6cbb40005','1','checkbox','','','','2018-12-27 12:29:25','admin','','2018-12-27 15:09:29','','','','0'),('4f42074a9bf045a2873837330b023ff4','选择规程时是否显示条款号','勾选此项参数，代表显示条款号','OTHER_9','Y','','402882cc5ddfa5ed015ddfa704020060','1','checkbox',NULL,NULL,NULL,'2019-11-07 19:53:05','admin',NULL,NULL,NULL,NULL,NULL,'1'),('67027f5464a54927b066e1ccd6385688','允许提交报告时修改报告的资质','勾选此项参数, 在提交报告时允许修改报告的资质章信息','TEST_DETECTION_44','N',NULL,'402882cc5ddfa5ed015ddfa6e0de001b','1','checkbox',NULL,NULL,NULL,'2018-08-06 13:59:05','lilf',NULL,NULL,NULL,NULL,NULL,'1'),('6b065a621a2a4c59ade7aaa0100a040a','提交到批准','','REPORT_MANAGE_29','3','','402882cc5ddfa5ed015ddfa704010040','1','text','30px',NULL,NULL,'2018-08-06 13:59:05','lilf',NULL,NULL,NULL,NULL,'天未处理的报告，在报告批准界面闪烁提醒','1'),('80230f58b7b24d81a424a971e852196d','超出提交到审核','','REPORT_MANAGE_28','3','','402882cc5ddfa5ed015ddfa704010040','1','text','30px',NULL,NULL,'2018-08-06 13:59:05','lilf',NULL,NULL,NULL,NULL,'天未处理的报告，在报告审核界面闪烁提醒','1'),('EA9376B6-2BA5-4511-8BCF-79D0D5472AB8','完成委托后，快速填写试验检测数据','勾选此选项，完成委托后将跳过收费与任务分配流程，自动将收样样品分配给当前人员，并直接打开试验详情。','FINISH_DELE_8','N','','402882cc5ddfa5ed015ddfa6cbc8000a','1','checkbox','','','','2019-07-05 12:29:25','admin','','2019-07-05 13:49:01','','','','1'),('ab80958060a342a8bec106f08f65a9f8','开启电子签名','','REPORT_MANAGE_22','N','','402882cc5ddfa5ed015ddfa704010040','1','checkbox','','','','2018-11-20 12:29:25','admin','','2018-11-20 19:34:33','','','','1'),('ab80958060a342a8bec106f08f65a9f9','自动发送报告领取通知','勾选此项参数，报告批准通过后会自动发送报告领取的消息通知','REPORT_MANAGE_24','N','','402882cc5ddfa5ed015ddfa704010040','1','checkbox','','','','2018-11-20 12:29:25','admin','','2018-11-20 19:34:33','','','','1'),('f379bed1dad842c6a665bc862dca7e48','已打印的报告，未设置为已盖章的报告，允许进行归档',NULL,'REPORT_MANAGE_31','Y','','402882cc5ddfa5ed015ddfa704010040','1','checkbox',NULL,NULL,NULL,'2017-08-15 12:29:25','admin',NULL,NULL,NULL,NULL,NULL,'1');
/*!40000 ALTER TABLE `t_s_business_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_business_process`
--

DROP TABLE IF EXISTS `t_s_business_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_business_process` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `business_type` varchar(50) NOT NULL COMMENT '业务类型,详见ConstantsAP常量定义',
  `business_name` varchar(200) NOT NULL COMMENT '业务审核流程名称',
  `process_instance_key` varchar(200) DEFAULT NULL COMMENT 'activiti流程id,关联act_re_procdef.key',
  `process_name` varchar(200) DEFAULT NULL COMMENT '流程部署名称,关联act_re_procdef.name',
  `sys_company_code` varchar(50) NOT NULL COMMENT '组织机构编码',
  `create_name` varchar(100) DEFAULT NULL COMMENT '创建人姓名',
  `create_by` varchar(100) DEFAULT NULL COMMENT '创建人登陆名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务和通用审批流程的关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_business_process`
--

LOCK TABLES `t_s_business_process` WRITE;
/*!40000 ALTER TABLE `t_s_business_process` DISABLE KEYS */;
INSERT INTO `t_s_business_process` VALUES ('1','20','设备检校计划审核','SBJJJH','设备检校计划审核2','A03',NULL,NULL,NULL,'admin','2020-03-23 13:53:13','管理员'),('11','110','设备维修信息审批',NULL,NULL,'A03',NULL,NULL,NULL,NULL,NULL,NULL),('12','120','设备维修结果验收审批',NULL,NULL,'A03',NULL,NULL,NULL,NULL,NULL,NULL),('2','30','设备检校确认审批','SBJJJH','设备检校计划审核2','A03',NULL,NULL,NULL,'admin','2020-04-15 14:29:22','管理员'),('3','40','其他成果审核(三校一审)','OTHER_RESULT_AUDIT','其他成果审核流程','A03',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `t_s_business_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_function`
--

DROP TABLE IF EXISTS `t_s_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_function` (
  `ID` varchar(32) NOT NULL COMMENT 'ID',
  `functioniframe` smallint(6) DEFAULT NULL COMMENT '菜单地址打开方式',
  `functionlevel` smallint(6) DEFAULT NULL COMMENT '菜单等级',
  `functionname` varchar(50) NOT NULL COMMENT '菜单名字',
  `parentfunctionid` varchar(32) DEFAULT NULL COMMENT '父菜单ID',
  `function_explain` varchar(520) DEFAULT NULL COMMENT '权限描述',
  `functionorder` varchar(255) DEFAULT NULL COMMENT '排序',
  `functioncode` varchar(50) DEFAULT NULL COMMENT '菜单编码，与开发人员约定的值，切勿随意更改',
  `functionurl` varchar(500) DEFAULT NULL COMMENT 'URL',
  `iconid` varchar(32) DEFAULT NULL COMMENT '图标ID',
  `desk_iconid` varchar(32) DEFAULT NULL COMMENT '桌面图标ID',
  `functiontype` smallint(6) DEFAULT NULL COMMENT '菜单类型1:执行权限, 0:菜单 (ps:我也是根据数据库现有数据理解的,没有注释靠猜)',
  `function_icon_style` varchar(255) DEFAULT NULL COMMENT 'ace图标样式',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_name` varchar(32) DEFAULT NULL COMMENT '修改人',
  `icon_url` varchar(200) DEFAULT NULL COMMENT '菜单图片访问地址',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_functioncode` (`functioncode`) USING BTREE COMMENT '方法编号索引',
  KEY `FK_brd7b3keorj8pmxcv8bpahnxp` (`parentfunctionid`) USING BTREE,
  KEY `FK_q5tqo3v4ltsp1pehdxd59rccx` (`iconid`) USING BTREE,
  KEY `FK_gbdacaoju6d5u53rp4jo4rbs9` (`desk_iconid`) USING BTREE,
  KEY `FKD20FBACF321F7C30` (`iconid`) USING BTREE,
  KEY `FKD20FBACF63BA8C96` (`desk_iconid`) USING BTREE,
  KEY `FKD20FBACF84E661D8` (`parentfunctionid`) USING BTREE,
  CONSTRAINT `t_s_function_ibfk_1` FOREIGN KEY (`iconid`) REFERENCES `t_s_icon` (`ID`),
  CONSTRAINT `t_s_function_ibfk_2` FOREIGN KEY (`desk_iconid`) REFERENCES `t_s_icon` (`ID`),
  CONSTRAINT `t_s_function_ibfk_3` FOREIGN KEY (`parentfunctionid`) REFERENCES `t_s_function` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 600064 kB; (`parentfunctionid`) REFER `jeecg/t_';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_function`
--

LOCK TABLES `t_s_function` WRITE;
/*!40000 ALTER TABLE `t_s_function` DISABLE KEYS */;
INSERT INTO `t_s_function` VALUES ('026a4ab8c0fb11eab61fb8ca3a6052ac',NULL,2,'资料归档详情标记为已归档','4028826373219d0d017321b29a6a0001','资料归档详情[标记为已归档]按钮','100','detailDataMark','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:12:30',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('14ca4596c0fb11eab61fb8ca3a6052ac',NULL,2,'资料归档详情标记为未归档','4028826373219d0d017321b29a6a0001','资料归档详情[标记为未归档]按钮','110','detailDataUnMark','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:13:00',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('297ed4995dd0879a015dd088f6ef0003',NULL,2,'流程模型管理','402882206dd3541d016dd37669fe0004',NULL,'17',NULL,'modelController.do?model','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,'admin','2019-12-21 13:38:20',NULL,'管理员',NULL),('297ed4995dd0879a015dd08a3de10006',NULL,1,'流程定义管理','402882206a67ed0d016a6806c82b0000','','40',NULL,'processDefinitionController.do?processDefinition','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('297ed4995dd42920015dd42aaab00003',NULL,1,'请假单管理','402880e74d76e784014d76f5505a0012',NULL,'11',NULL,'leaveBillController.do?leaveBill','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,'admin','2017-08-12 10:25:00',NULL,'管理员',NULL),('297ed4995dd4b819015dd4b9f4030007',NULL,1,'我的代办任务','402880e74d76e784014d76f5505a0012',NULL,'12',NULL,'taskController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'','admin','管理员',NULL,NULL,'2017-08-12 12:35:43',NULL,NULL),('2b21a967c0fa11eab61fb8ca3a6052ac',NULL,2,'资料归档详情引用模板','4028826373219d0d017321b29a6a0001','资料归档详情[引用模板]按钮','40','detailTemplateQuote','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:06:28',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('2c90ac564c9d1734014c9d6f4e370024',NULL,1,'Online图表配置','8a8ab0b246dc81120146dc8180ce0019',NULL,'4',NULL,'jformGraphreportHeadController.do?jformGraphreportHead','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('2c98b9136f26e10d016f26f4781100c9',NULL,0,'通用功能',NULL,'','70',NULL,'','8a8ab0b246dc81120146dc8180860006','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2019-12-21 13:35:53',NULL,NULL),('2c98b9136f26e10d016f26f5df0f00cb',NULL,0,'单位配置',NULL,'','80',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('40284a815b48b411015b48b56fd80001',NULL,1,'动态tab设计','4028f6815af3ce54015af3d1ad610001',NULL,'8',NULL,'jeecgFormDemoController.do?ueditor','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-bug',NULL,NULL,'admin','2017-04-08 17:50:23',NULL,'管理员',NULL),('40287d81522a428401522a44aafb0002',NULL,1,'Online移动图表','8a8ab0b246dc81120146dc8180ce0019',NULL,'5',NULL,'cgDynamGraphConfigHeadController.do?cgDynamGraphConfigHead','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-03-15 12:34:36',NULL,'管理员',NULL),('40288088481d019401481d2fcebf000d',NULL,1,'jeecgdemo数据权限列表','402889fb486e848101486e8de3d60005',NULL,'1',NULL,'jeecgListDemoController.do?datagrid','8a8ab0b246dc81120146dc8180820003','8a8ab0b246dc81120146dc8180dd001e',1,'',NULL,NULL,'admin','2017-03-29 18:31:26',NULL,'管理员',NULL),('4028808848845c0f01488461226e0001',NULL,-1,'消息中间件',NULL,NULL,'888',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-commenting',NULL,NULL,'yefei','2018-01-31 11:13:13',NULL,'叶飞',NULL),('4028808848845c0f01488461b3ac0004',NULL,1,'业务SQL','4028808848845c0f01488461226e0001',NULL,'1',NULL,'tSSmsSqlController.do?tSSmsSql','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-03-14 16:47:13',NULL,'管理员',NULL),('4028808848845c0f01488462658f0006',NULL,1,'消息模板','4028808848845c0f01488461226e0001',NULL,'2',NULL,'tSSmsTemplateController.do?tSSmsTemplate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028808848845c0f01488463aa210009',NULL,1,'业务配置','4028808848845c0f01488461226e0001',NULL,'3',NULL,'tSSmsTemplateSqlController.do?tSSmsTemplateSql','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028808848845c0f014884649488000c',NULL,1,'消息中心','4028808848845c0f01488461226e0001',NULL,'0',NULL,'tSSmsController.do?tSSms','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402880e74d76e784014d76f5505a0012',NULL,-1,'在线演示',NULL,NULL,'999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-play-circle',NULL,NULL,'yefei','2018-01-31 11:10:07',NULL,'叶飞',NULL),('402880e74d76e784014d76f5cc2e0014',NULL,1,'请假列表','402880e74d76e784014d76f5505a0012',NULL,'1',NULL,'cgAutoListController.do?list&id=jform_leave','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-03-15 12:30:36',NULL,'管理员',NULL),('402880e74d76e784014d76fa7e970024',NULL,1,'数据报表','8a8ab0b246dc81120146dc8180d4001b',NULL,'2',NULL,'cgReportController.do?list&id=user_msg','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-03-14 11:37:27',NULL,'管理员',NULL),('402880e74d76e784014d76fd1bd60030',NULL,1,'图形报表','8a8ab0b246dc81120146dc8180d4001b',NULL,'3',NULL,'graphReportController.do?list&isIframe&id=yhcztj','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-03-14 11:37:16',NULL,'管理员',NULL),('402880ea53303a060153304a9ad50001',NULL,1,'系统公告','8a8ab0b246dc81120146dc8180d2001a','','50',NULL,'noticeController.do?tSNotice','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402880f25a980e2a015a981dc8de0005',NULL,1,'请假自定义表单','402889fb486e848101486e8de3d60005',NULL,'3',NULL,'autoFormController/af/employee_leave_form/goViewPage.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'',NULL,NULL,'admin','2017-03-29 16:18:26',NULL,'管理员',NULL),('402880f25a9833f5015a9843218f000c',NULL,1,'自定义表单查看','402889fb486e848101486e8de3d60005',NULL,'4',NULL,'autoFormController/af/order_form/goUpdatePage.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'',NULL,NULL,'admin','2017-03-29 16:18:48',NULL,'管理员',NULL),('402880f25b1d5a3a015b1d772c2b0013',NULL,2,'请假单编辑页面','402881855ab8c48a015ab8d133050018',NULL,'2',NULL,'cgFormBuildController/ftlForm/jform_leave/goUpdate.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员','yefei','2018-01-31 11:13:34','2017-03-30 12:26:41','叶飞',NULL),('402880f25b1e2ac7015b1e5cdc340010',NULL,2,'online请假加载数据请求','402881855ab8c48a015ab8d133050018',NULL,'3',NULL,'cgAutoListController.do?datagrid&configId=jform_leave','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2017-03-30 16:37:33',NULL,NULL),('402880f25b23a635015b23a992f10003',NULL,2,'ol订单编辑页面','402881855ab8c48a015ab8d133050018',NULL,'4',NULL,'cgFormBuildController/ftlForm/jform_order_main/goUpdate.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'',NULL,NULL,'yefei','2018-01-31 11:13:34',NULL,'叶飞',NULL),('402880f25b23a635015b23c7ce53001b',NULL,1,'测试一对多表单权限','402889fb486e848101486e8de3d60005',NULL,'5',NULL,'cgFormHeadController.do?addorupdate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2017-03-31 17:52:28',NULL,NULL),('402881855ab8c48a015ab8d133050018',NULL,1,'测试online表单权限','402889fb486e848101486e8de3d60005',NULL,'4',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'',NULL,NULL,'admin','2017-03-10 23:23:32',NULL,'管理员',NULL),('402881855ab8c48a015ab8d1f96f001b',NULL,2,'ol请假单查看页面','402881855ab8c48a015ab8d133050018',NULL,'1',NULL,'cgFormBuildController/ftlForm/jform_leave/goDetail.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'',NULL,NULL,'yefei','2018-01-31 11:13:34',NULL,'叶飞',NULL),('402881875992e76c015992eb2a3b0009',NULL,1,'百度','4028ef8155fd32e40155fd33c6670001',NULL,'2',NULL,'https://www.baidu.com','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2017-01-12 21:43:22',NULL,NULL),('402882016c65f1fb016c6687f3680377',NULL,1,'项目检测管理','402882d360d3935d0160d39772700008','','3',NULL,'itemController.do?goTestItem','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','clm','陈灵敏',NULL,NULL,'2019-08-06 18:44:41',NULL,NULL),('402882016cd0d681016cd0d81e1b0000',NULL,-1,'其它成果审核','402882d360d3935d0160d39772700008','','4',NULL,'itemController.do?goAudit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','clm','陈灵敏',NULL,NULL,'2019-08-27 10:12:00',NULL,NULL),('402882016cf0d13b016cf11bdf9f0004',NULL,2,'新增项目','402882016c65f1fb016c6687f3680377','','1','addSyntesisProject','projectController.do?doAdd','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-02 16:33:52',NULL,NULL),('402882016cf0d13b016cf18e26d00024',NULL,2,'编辑项目','402882016c65f1fb016c6687f3680377','','2','editSynthesisProject','projectController.do?doUpdate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-02 18:38:41',NULL,NULL),('402882016cf0d13b016cf18eb7450026',NULL,2,'删除项目','402882016c65f1fb016c6687f3680377','','3','deleteSyntesisProject','projectController.do?doDel','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-02 18:39:18',NULL,NULL),('402882016cf1a598016cf1adee170006',NULL,2,'结束项目','402882016c65f1fb016c6687f3680377','结束综合检测项目','4','complete:project','rest/synthesis/project','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-02 19:13:23',NULL,NULL),('402882016cf1a598016cf1f1486f0009',NULL,2,'项目设置人员','402882016c65f1fb016c6687f3680377','设置综合检测项目相关人员','5','set:person','rest/synthesis/person','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-02 20:26:58',NULL,NULL),('402882016cf1a598016cf1f9a3ab000b',NULL,2,'上传成果','402882016c65f1fb016c6687f3680377','新增综合检测项目其它成果','6','add:achieve','rest/synthesis/achievement','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-02 20:36:05',NULL,NULL),('402882016cf1a598016cf1fb57ee000d',NULL,2,'编辑其它成果','402882016c65f1fb016c6687f3680377','编辑综合检测项目其它成果','7','edit:achieve','rest/synthesis/achievement','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-02 20:37:57',NULL,NULL),('402882016cf1a598016cf1fc874d000f',NULL,2,'删除其它成果','402882016c65f1fb016c6687f3680377','删除综合检测项目其它成果','8','del:achieve','rest/synthesis/achievement','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-02 20:39:15',NULL,NULL),('402882016cf5ac5e016cf5b099c10000',NULL,2,'上传附录文件','402882016c65f1fb016c6687f3680377','新增综合检测项目附录','9','add:attach','rest/synthesis/attachment','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 13:54:47',NULL,NULL),('402882016cf5ac5e016cf5cd16db0002',NULL,2,'修改附录文件','402882016c65f1fb016c6687f3680377','修改综合检测项目附录','10','edit:attach','rest/synthesis/attachment','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:25:54',NULL,NULL),('402882016cf5ac5e016cf5d007d90004',NULL,2,'删除附录','402882016c65f1fb016c6687f3680377','删除综合检测项目附录','11','del:attach','rest/synthesis/attachment','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:29:07',NULL,NULL),('402882016cf5ac5e016cf5d91c5f0006',NULL,2,'添加合同段','402882016c65f1fb016c6687f3680377','新增合同段','12','add:contract','rest/synthesis/contract','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:39:02',NULL,NULL),('402882016cf5ac5e016cf5dabf1e0008',NULL,2,'编辑合同段','402882016c65f1fb016c6687f3680377','修改合同段','13','edit:contract','rest/synthesis/contract','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:40:49',NULL,NULL),('402882016cf5ac5e016cf5db9481000a',NULL,2,'删除合同段','402882016c65f1fb016c6687f3680377','删除合同段','14','del:contract','rest/synthesis/contract','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:41:44',NULL,NULL),('402882016cf5ac5e016cf5ddf865000c',NULL,2,'新增单位工程','402882016c65f1fb016c6687f3680377','新增单位工程','15','add:unit','rest/synthesis/unit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:44:21',NULL,NULL),('402882016cf5ac5e016cf5dea75e000e',NULL,2,'编辑单位工程','402882016c65f1fb016c6687f3680377','编辑单位工程','16','edit:unit','rest/synthesis/unit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:45:06',NULL,NULL),('402882016cf5ac5e016cf5df6daf0010',NULL,2,'删除单位工程','402882016c65f1fb016c6687f3680377','删除单位工程','17','del:unit','rest/synthesis/unit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:45:56',NULL,NULL),('402882016cf5ac5e016cf5e353be0012',NULL,2,'设置流程人员','402882016c65f1fb016c6687f3680377','设置合同段/单位工程流程人员','18','set:workers','rest/synthesis/contract/unit/person','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:50:12',NULL,NULL),('402882016cf5ac5e016cf5e63ece0014',NULL,2,'新增自定义字段','402882016c65f1fb016c6687f3680377','新增自定义上报字段','19','add:progress:column','rest/synthesis/column','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:53:23',NULL,NULL),('402882016cf5ac5e016cf5e751e40016',NULL,2,'编辑自定义字段','402882016c65f1fb016c6687f3680377','修改自定义上报字段','20','edit:progress:column','rest/synthesis/column','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:54:33',NULL,NULL),('402882016cf5ac5e016cf5e8d0ea0018',NULL,2,'删除自定义字段','402882016c65f1fb016c6687f3680377','删除自定义上报字段','21','del:progress:column','rest/synthesis/column','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:56:11',NULL,NULL),('402882016cf5ac5e016cf5ea8c2c001a',NULL,2,'更新进度','402882016c65f1fb016c6687f3680377','更新合同段/单位工程进度','22','update:progress','rest/synthesis/progress','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 14:58:05',NULL,NULL),('402882016cf5ac5e016cf5f1bbed001c',NULL,2,'新增联系人','402882016c65f1fb016c6687f3680377','','23','add:contact','rest/synthesis/contact','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 15:05:56',NULL,NULL),('402882016cf5ac5e016cf5f2b167001e',NULL,2,'编辑联系人','402882016c65f1fb016c6687f3680377','','24','edit:contact','rest/synthesis/contact','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 15:06:59',NULL,NULL),('402882016cf5ac5e016cf5f34dfe0020',NULL,2,'删除联系人','402882016c65f1fb016c6687f3680377','','24','del:contact','rest/synthesis/contact','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-09-03 15:07:39',NULL,NULL),('402882016d008dda016d008f6cd00002',NULL,1,'设备使用记录','402882cd5f9952fa015f9954b12c0000','','3',NULL,'equipmentNewController.do?goEquipmentUseRecord','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'clm','2019-09-05 16:35:12',NULL,'陈灵敏',NULL),('402882016dbd7430016dbdaa8a3c0004',NULL,1,'来样/预约管理','402882d35ebd7a23015ebd9300530030','','4',NULL,'consignController.do?goPreConsignList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882016e5e1a22016e5e22613c0002',NULL,2,'导出委托台账','402882d35f0f3e58015f0f4281a80004','导出委托台账按钮权限','13','exportConsignInfo','consignController.do?doExport','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','陈灵敏',NULL,NULL,'2019-11-12 13:42:22',NULL,NULL),('402882016e5e7c30016e5ebd266d0000',NULL,2,'打印委托台账','402882d35f0f3e58015f0f4281a80004','委托台账导出功能按钮权限','14','printConsignStandingBook','udrController.do?print','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','clm','敏帅',NULL,NULL,'2019-11-12 16:31:25',NULL,NULL),('402882016ea19d99016ea1b3b4d00000',NULL,1,'试验检测结果统计','402882d360d3935d0160d39772700008','','10',NULL,'testTaskController.do?goTestResult','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882016ea19d99016ea1b44fae0002',NULL,1,'不合格试验查询','402882d360d3935d0160d39772700008','','11',NULL,'testTaskController.do?goDisqualification','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','clm','陈灵敏',NULL,NULL,'2019-11-25 16:36:19',NULL,NULL),('402882016ea19d99016ea1b5441c0005',NULL,1,'检测超期统计','402882d360d3935d0160d39772700008','','12',NULL,'testTaskController.do?goOverDuo','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','clm','陈灵敏',NULL,NULL,'2019-11-25 16:37:22',NULL,NULL),('402882016ea19d99016ea1b5da400007',NULL,1,'检测任务量统计','402882d360d3935d0160d39772700008','','13',NULL,'testTaskController.do?goTestTaskCount','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','clm','陈灵敏',NULL,NULL,'2019-11-25 16:38:00',NULL,NULL),('402882016ea19d99016ea1b668430009',NULL,1,'检测工时统计','402882d360d3935d0160d39772700008','','14',NULL,'testTaskController.do?goTestTaskWorkHour','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','clm','陈灵敏',NULL,NULL,'2019-11-25 16:38:36',NULL,NULL),('402882016eab9318016eab9fc98b0002',NULL,1,'邮寄信息配置','402882cc5e2d0e90015e2d36e62d0004','','96',NULL,'reportController.do?goPostInfo','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882016f31927a016f31a7f4e80000',NULL,1,'盲样查看','402882206ef95335016ef9d2d4dd014e','拥有该权限的角色可以在盲样系统参数开启的情况下查看所有样品信息','12','seeThroughTheMist','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2019-12-23 15:28:08',NULL,NULL),('402882016fc1870b016fc1a165bb0151',NULL,3,'空表打印','402882105e5b5362015e5b57bbba000b','系统级空表打印的控制权限','1','emptyRecordPrint','testParamController.do?goUdrEmptyTablePrint','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-01-20 14:26:18',NULL,NULL),('402882016fc1870b016fc1a226d20153',NULL,3,'空报告打印','402882105e5b5362015e5b57bbba000b','系统级空报告打印的控制权限','3','emptyReportPrint','testParamController.do?goTestParamTableInfo','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-01-20 14:27:07',NULL,NULL),('402882017098d3d3017098f0a6420002',NULL,1,'合同统计数据区块','4028822067812815016781f527350010','首页合同统计信息数据区块','20','statisticContract','rest/statistic/contract','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-03-02 09:51:13',NULL,NULL),('402882017098d3d3017098f22ad40004',NULL,1,'部门/公司工时统计排名','4028822067812815016781f527350010','首页部门/公司工时排名统计信息','21','statisticWorkHoursRanking','rest/statistic/hours/ranking','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-03-02 09:52:52',NULL,NULL),('4028820171861d630171862242040000',NULL,2,'恢复项目','402882016c65f1fb016c6687f3680377','恢复已结束的工程项目','26','recover:project','rest/synthesis/recover-project','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-04-17 11:15:24',NULL,NULL),('4028820171b9bcb80171b9c02b500000',NULL,2,'随机编码','402882105e4c439d015e4c46e9480003','','3',NULL,'random-code.do?goRandomCodeConfigPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2020-04-27 11:48:31',NULL,NULL),('4028820171e78b1f0171e81050c2017e',NULL,2,'删除报告','402882016c65f1fb016c6687f3680377','删除综合检测项目报告','21','del:report','consignController.do?batchDelete','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-05-06 11:38:36',NULL,NULL),('40288201726d9eea01726dace7ef0001',NULL,2,'查看本部门项目','402882016c65f1fb016c6687f3680377','设置了该权限的用户，在查看综合检测项目列表能查看本部门所有检测项目','22','view:department:project','view:department:project','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-06-01 10:19:08',NULL,NULL),('4028820172febde80172fec0028a0000',NULL,1,'数据库升级','402882206a67ed0d016a6806c82b0000','用于授权管理中心无法管控数据的单位，升级数据库结构以及数据','9',NULL,'data-script/goUpdatePage.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2020-06-29 14:24:56',NULL,NULL),('4028820e65ea58bd0165eabead440065',NULL,1,'试验复核','402882d360d3935d0160d39772700008',NULL,'2','testTaskReviewMenu','testTaskReviewController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','wh','魏衡',NULL,NULL,'2018-09-18 11:34:49',NULL,NULL),('4028820e718099d6017180bbf251000d',NULL,2,'提交报告','402882d360d3935d0160d398ddb4000c','[提交报告]功能权限，试验检测主页面，提交原材料报告功能','10','testSubmitReport','testTaskReportController.do?goReportCommitPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-04-16 10:05:33',NULL,NULL),('4028820e718099d6017180c0d7fc000f',NULL,2,'通知修改委托','402882d360d3935d0160d398ddb4000c','[通知修改委托]功能权限，试验检测主页面，通知修改按钮','90','testModifyNotice','noticeController.do?goConsignModify','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-04-16 10:10:54',NULL,NULL),('4028820e718099d6017180c5598e0011',NULL,2,'龄期/制样管理','402882d360d3935d0160d398ddb4000c','[龄期/制样管理]功能按钮，试验检测主页面','100','testObjectPeriodManage','testObjectPeriodController.do?goTaskAddPeriod','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-04-16 10:15:49',NULL,NULL),('4028820e718099d6017180cb70fe0013',NULL,2,'引用已委托原材料','402882d360d3935d0160d398ddb4000c','[引用已委托原材料]功能按钮，试验检测主页面','110','quoteOtherMaterials','consignController.do?goReferConsignedSample','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-04-16 10:22:29',NULL,NULL),('4028820e718099d6017180dd02750016',NULL,2,'环境条件管理','402882d360d3935d0160d398ddb4000c','[环境条件管理]功能权限，试验检测主页面','120','envirimentManage','labEnvironmentController.do?goEnvironmentList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','wh','魏衡1',NULL,NULL,'2020-04-16 10:41:40',NULL,NULL),('4028820e718099d6017180e592ae0018',NULL,2,'复核撤回','402882d360d3935d0160d398ddb4000c','[撤回]按钮权限，复核确认中列表，行数据尾列操作按钮','1','confirmRollBack2Test','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','wh','魏衡1',NULL,NULL,'2020-04-16 10:51:01',NULL,NULL),('4028820e718099d6017180ec5dab001a',NULL,2,'审核撤回','402882d360d3935d0160d398ddb4000c','[撤回]按钮权限，审核确认中列表，行数据尾列的操作按钮','1','auditRollBack2Test','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','wh','魏衡1',NULL,NULL,'2020-04-16 10:58:26',NULL,NULL),('4028820e718099d6017180fbcaed001c',NULL,2,'批准撤回','402882cd5f52cb58015f52cce3370000','[撤回]按钮权限，报告审核 - 报告批准中数据列表，行数据列尾操作按钮','1','approveRollBack2Audit','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','wh','魏衡1',NULL,NULL,'2020-04-16 11:15:17',NULL,NULL),('4028820e71bf3bea0171bf601ac90000',NULL,2,'新增回款登记','402882105ebd2ee7015ebd34fbc80004','[新增回款登记]功能权限','1','addCreditRepayment','creditRepaymentController.do?goCreditRepayment','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','wh','魏衡1',NULL,NULL,'2020-04-28 14:01:19',NULL,NULL),('402882105dee15ab015dee22b5900013',NULL,1,'自动生成','4028f6815af3ce54015af3d1ad610001',NULL,'10',NULL,'tTestAlltypeController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-table',NULL,NULL,'admin','2017-08-30 11:23:56',NULL,'管理员',NULL),('402882105e0dd0e4015e0e0ba2a10023',NULL,1,'自动生成原版','4028f6815af3ce54015af3d1ad610001',NULL,'13',NULL,'tTestAlltypeController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-gears',NULL,NULL,'admin','2017-08-23 15:47:02',NULL,'管理员',NULL),('402882105e174fdb015e1774aa9d0015',NULL,1,'自动生成树原版','4028f6815af3ce54015af3d1ad610001',NULL,'21',NULL,'tTestTreeController.do?list','8a8ab0b246dc81120146dc8180810002','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-08-25 11:40:35',NULL,'管理员',NULL),('402882105e174fdb015e177573100017',NULL,1,'自动生成树','4028f6815af3ce54015af3d1ad610001',NULL,'20',NULL,'webpage/com/jeecg/tree/tTestTreeList.html','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-08-30 11:13:29',NULL,'管理员',NULL),('402882105e26b888015e27b479bd0029',NULL,1,'一对多原版','4028f6815af3ce54015af3d1ad610001',NULL,'25',NULL,'tTestOneController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-08-28 15:18:34',NULL,'管理员',NULL),('402882105e27e835015e27ecde780003',NULL,1,'一对多','4028f6815af3ce54015af3d1ad610001',NULL,'24',NULL,'webpage/com/jeecg/one2many/tTestOneList.html','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-08-30 11:13:44',NULL,'管理员',NULL),('402882105e4c439d015e4c46e9480003',NULL,1,'编号管理','2c98b9136f26e10d016f26f5df0f00cb','','110',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-list-ol',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882105e4c439d015e4c47e7800005',NULL,2,'编号类型','402882105e4c439d015e4c46e9480003',NULL,'1',NULL,'tSnCategoryController.do?list','8a8ab0b246dc81120146dc8180810002','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'lilf','2019-03-04 09:42:41',NULL,'李丽峰',NULL),('402882105e4c439d015e4c4af2a50007',NULL,2,'编号设置','402882105e4c439d015e4c46e9480003','','2',NULL,'tSnModelController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882105e5b5362015e5b55abd60003',NULL,1,'系统试验参数','2c98b9136f26e10d016f26f5df0f00cb','','20',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882105e5b5362015e5b5649880005',NULL,2,'检测大类','402882105e5b5362015e5b55abd60003','','10',NULL,'bigCategoryController.do?treeList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-10-09 11:43:31',NULL,'曾继强',NULL),('402882105e5b5362015e5b56af9c0007',NULL,2,'检测类别','402882105e5b5362015e5b55abd60003','','40',NULL,'checkTypeController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-10-09 11:42:12',NULL,'曾继强',NULL),('402882105e5b5362015e5b5745960009',NULL,1,'试验容器管理','402882d360d3935d0160d39772700008','','50',NULL,'utensilController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882105e5b5362015e5b57bbba000b',NULL,2,'检测参数','402882105e5b5362015e5b55abd60003','','20',NULL,'testParamController.do?list&canOperation=1','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-10-09 11:43:15',NULL,'曾继强',NULL),('402882105e5b5362015e5b584f90000d',NULL,2,'参数价格/工时','402882105e5b5362015e5b55abd60003','','30',NULL,'testParamPriceWorkingHourController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-10-09 11:42:44',NULL,'曾继强',NULL),('402882105e5b5362015e5b59391d000f',NULL,2,'样品层级管理','402882105e5b5362015e5b55abd60003','','60',NULL,'testSampleController.do?treeList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882105ebd2ee7015ebd3365ce0000',NULL,0,'费用管理',NULL,'','20',NULL,'','8a8ab0b246dc81120146dc8180880007','8a8ab0b246dc81120146dc8180dd001e',0,'fa-credit-card',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882105ebd2ee7015ebd34fbc80004',NULL,1,'费用','402882105ebd2ee7015ebd3365ce0000',NULL,'1',NULL,'feeModelController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-jpy',NULL,NULL,'lixin','2018-03-12 17:29:03',NULL,'李鑫',NULL),('402882105f4c1d6d015f4daea41f0049',NULL,1,'信用管理','402882105ebd2ee7015ebd3365ce0000',NULL,'1',NULL,'creditController.do?goCreditList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','yefei','叶飞',NULL,NULL,'2017-10-24 17:20:12',NULL,NULL),('402882105f70012e015f718517c900bb',NULL,1,'发票管理(待开发)','402882105ebd2ee7015ebd3365ce0000','','3',NULL,'feeReceiptController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2019-10-09 10:26:25',NULL,'管理员',NULL),('402882105fdc2b54015fdc813d58000b',NULL,1,'合同管理','402882105ebd2ee7015ebd3365ce0000',NULL,'5',NULL,'contractController.do?goContractlist','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','yefei','叶飞',NULL,NULL,'2017-11-21 10:56:18',NULL,NULL),('40288210602f04f001602f09fedb0000',NULL,1,'UdrDemo','4028f6815af3ce54015af3d1ad610001',NULL,'1',NULL,'udrController.do?goUdrDemo','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','yefei','叶飞',NULL,NULL,'2017-12-07 11:34:32',NULL,NULL),('40288210614ae16601614b0106ec003a',NULL,0,'统计/查询',NULL,'','999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-sort-numeric-asc',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('40288210614ae16601614b014e59003c',NULL,1,'用户查询','40288210614ae16601614b0106ec003a',NULL,'1',NULL,'cgReportController.do?list&id=ddt_s_base_user','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2018-01-31 14:57:12',NULL,NULL),('40288210614ae16601614b01df7d003e',NULL,1,'委托综合查询','40288210614ae16601614b0106ec003a',NULL,'2',NULL,'cgReportController.do?list&id=test_comp_query','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2018-01-31 14:57:49',NULL,NULL),('402882106159aac901615a1c55490001',NULL,0,'任务分配0',NULL,'','999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-tasks',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882106159aac901615a1cbd6b0004',NULL,1,'任务分配','402882d360d3935d0160d39772700008',NULL,'0','taskAssignMenu','taskAssignedController.do?goAll','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'yefei','2018-02-03 14:45:29',NULL,'叶飞',NULL),('402882106159aac901615a1cbd6b00i8',NULL,1,'审核管理','2c98b9136f26e10d016f26f4781100c9','通用审核流程的流程任务管理','70',NULL,'rest/auditProcess/goAuditProcessList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028821062d1832a0162d195681a0001',NULL,1,'数据变更日志','402882206a67ed0d016a6806c82b0000','','30',NULL,'logEntityController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('40288210631f662101631f8ae14d0002',NULL,1,'流程列表','402882206a67ed0d016a6806c82b0000','','10',NULL,'ActivityController.do?goProcessList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028821e6cff9753016d015c24c70042',NULL,1,'审批意见配置','2c98b9136f26e10d016f26f5df0f00cb','','90',NULL,'reportQuestionViewController.do?goQuestionTypeList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028821e6d65de4f016d66525ed30012',NULL,2,'流程审核权限','402882206dd3541d016dd37669fe0004','','20',NULL,'rest/auditAuthorityController/goAuditAuthority','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028821e6d65de4f016d6657f3090074',NULL,2,'业务与流程绑定','402882206dd3541d016dd37669fe0004','','10',NULL,'rest/auditProcessRelation/goRelation','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028821e6dbf968f016dbfbac1eb0006',NULL,1,'设备外出管理','402882cd5f9952fa015f9954b12c0000','','5',NULL,'rest/eqEgress/goEqEgressList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'lixin','2019-10-14 09:13:19',NULL,'李鑫',NULL),('4028821e6eaa6374016eaaa5d291007e',NULL,1,'单位业绩管理','2c98b9136f26e10d016f26f4781100c9','','20',NULL,'biddingController.do?biddingPerformance','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('40288220667a7ac801667a801ef00002',NULL,1,'编制报告','402882cc5e2d0e90015e2d36e62d0004','','9','createReportMenu','reportCreateController.do?goListPage','8a8ab0b246dc81120146dc8180830004','8a8ab0b246dc81120146dc8180eb0024',0,'icon-edit',NULL,NULL,'lilf','2019-05-29 14:44:19',NULL,'李丽峰',NULL),('402882206685e73d016685e9d1c70000',NULL,1,'API测试','402882206a67ed0d016a6806c82b0000','','20',NULL,'apiTestController.do?goApiTestPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028822066bf20530166bf239d620000',NULL,1,'重打&修改审批','402882cc5e2d0e90015e2d36e62d0004','','70',NULL,'reportRedoAuditController.do?goListPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8181290035',0,'icon-edit',NULL,NULL,'zengxb','2019-05-31 15:27:54',NULL,'曾小兵',NULL),('4028822067812815016781f527350010',NULL,0,'首页权限配置',NULL,NULL,'0',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','lilf','李丽峰',NULL,NULL,'2018-12-06 13:19:46',NULL,NULL),('4028822067812815016781f818660012',NULL,1,'试验检测部门统计(数据区块)','4028822067812815016781f527350010',NULL,'998',NULL,'homePageController.do?testTaskDepartmentDataBlock','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-06 13:22:59',NULL,NULL),('402882206786a29b016787574a680022',NULL,1,'委托收样统计信息(数据区块)','4028822067812815016781f527350010',NULL,'997',NULL,'homePageController.do?consignDataBlock','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:25:04',NULL,NULL),('402882206786a29b01678757cf230024',NULL,1,'委托收样趋势信息(折线图)','4028822067812815016781f527350010',NULL,'996',NULL,'homePageController.do?cosignLineChart','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:25:38',NULL,NULL),('402882206786a29b016787584fa30026',NULL,1,'费用统计信息(数据区块)','4028822067812815016781f527350010',NULL,'995',NULL,'homePageController.do?feeDataBlock','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:26:11',NULL,NULL),('402882206786a29b01678758d8c80028',NULL,1,'收费统计图(柱状图)','4028822067812815016781f527350010',NULL,'994',NULL,'homePageController.do?feeHistogram','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:26:46',NULL,NULL),('402882206786a29b0167875be8f5002c',NULL,1,'试验检测统计信息(数据区块)','4028822067812815016781f527350010',NULL,'992',NULL,'homePageController.do?testTaskDataBlock','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:30:07',NULL,NULL),('402882206786a29b0167875da42b002e',NULL,1,'报告统计信息(数据区块)','4028822067812815016781f527350010',NULL,'991',NULL,'homePageController.do?reportDataBlock','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:32:00',NULL,NULL),('402882206786a29b0167875e91ee0030',NULL,1,'报告发放统计信息(饼图)','4028822067812815016781f527350010',NULL,'990',NULL,'homePageController.do?reportPieChart','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:33:01',NULL,NULL),('402882206786a29b0167875f5c780032',NULL,1,'设备部门分布(柱图)','4028822067812815016781f527350010',NULL,'989',NULL,'homePageController.do?equipmentDepartHistogram','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:33:53',NULL,NULL),('402882206786a29b0167875fd3a00034',NULL,1,'设备购置年份分布(柱图)','4028822067812815016781f527350010',NULL,'988',NULL,'homePageController.do?equipmentYearHistogram','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:34:24',NULL,NULL),('402882206786a29b016787605f900036',NULL,1,'运营情况(数据区块)','4028822067812815016781f527350010',NULL,'987',NULL,'homePageController.do?operationDataBlock','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2018-12-07 14:34:59',NULL,NULL),('4028822068989f1a016898a804290003',NULL,2,'新增修改','402882d35f0f3e58015f0f4281a80004','[新增][查看详情]按钮权限','0','goConsignInfoPage','consignController.do?goEdit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 16:09:35',NULL,NULL),('4028822068989f1a016898ad3b210005',NULL,2,'完成委托','402882d35f0f3e58015f0f4281a80004','委托列表页[完成委托]功能权限','0','completeConsignById','consignController.do?doCompleteById','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 16:15:16',NULL,NULL),('4028822068989f1a016898b269020007',NULL,2,'打印','402882d35f0f3e58015f0f4281a80004','委托列表页[打印]按钮权限','0','consignCommonPrint','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 16:20:56',NULL,NULL),('4028822068989f1a016898b6d7f3000c',NULL,2,'复制委托','402882d35f0f3e58015f0f4281a80004','委托列表页面[复制委托]功能权限','0','consignCopy','consignController.do?doBatchCopy','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 16:25:46',NULL,NULL),('4028822068989f1a016898df54440017',NULL,2,'作废/恢复委托','402882d35f0f3e58015f0f4281a80004','[作废/恢复委托]按钮权限','0','delAndRecoverConsign','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 17:09:59',NULL,NULL),('4028822068989f1a016898e0ea4e0019',NULL,2,'作废委托','402882d35f0f3e58015f0f4281a80004','[作废委托]的执行权限','0','delConsign','consignController.do?batchDelete','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 17:11:43',NULL,NULL),('4028822068989f1a016898e19ca8001b',NULL,2,'恢复委托','402882d35f0f3e58015f0f4281a80004','[恢复委托]的执行权限','0','recoverConsign','consignController.do?recoveryConsign','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 17:12:29',NULL,NULL),('4028822068989f1a016898e84ac6004a',NULL,2,'保存委托','402882d35f0f3e58015f0f4281a80004','委托详情-[保存委托]功能权限','0','saveConsign','consignController.do?doSave','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 17:19:47',NULL,NULL),('4028822068989f1a016898e9340f004c',NULL,2,'完成委托','402882d35f0f3e58015f0f4281a80004','委托详情-[完成委托]功能权限','0','completeConsignByData','consignController.do?doCompleteByData','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 17:20:47',NULL,NULL),('4028822068989f1a016898ea58d9004f',NULL,2,'打印委托单','402882d35f0f3e58015f0f4281a80004','委托详情-[打印委托单]按钮权限','0','printConsignBills','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 17:22:02',NULL,NULL),('4028822068989f1a016898eba3010051',NULL,2,'打印样品标签','402882d35f0f3e58015f0f4281a80004','[打印样品标签]的按钮权限','0','printObjectLable','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-29 17:23:26',NULL,NULL),('40288220689cca2801689d3223880179',NULL,2,'新增','402882d35ebd7a23015ebd93e3720034','[新增]委托单位的功能权限','0','addConsignUnit','consignUnitController.do?addConsignUnit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:18:55',NULL,NULL),('40288220689cca2801689d335b7b017b',NULL,2,'修改','402882d35ebd7a23015ebd93e3720034','[修改]委托单位的功能权限','0','updateConsignUnit','consignUnitController.do?doUpdate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:20:15',NULL,NULL),('40288220689cca2801689d3c0ef101cd',NULL,2,'删除','402882d35ebd7a23015ebd93e3720034','[删除]委托单位的功能权限','0','delConsignUnit','consignUnitController.do?doDel','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:29:45',NULL,NULL),('40288220689cca2801689d3e732101cf',NULL,2,'关联送样人','402882d35ebd7a23015ebd93e3720034','[关联送样人]的功能权限','0','consignUnitRelationSampleSender','consignUnitController.do?doAddRelationship','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:32:22',NULL,NULL),('40288220689cca2801689d40126b01d1',NULL,2,'取消关联送样人','402882d35ebd7a23015ebd93e3720034','[取消送样人关联]的功能权限','0','delUnitSampleSenderRelation','consignUnitController.do?doDeleteRelationship','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:34:08',NULL,NULL),('40288220689cca2801689d41631301d5',NULL,2,'关联工程项目','402882d35ebd7a23015ebd93e3720034','[关联工程项目]的功能权限','0','consignUnitRelationProject','projectController.do?doAddUnitAndProjectsRelation','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:35:35',NULL,NULL),('40288220689cca2801689d427b9001d7',NULL,2,'取消关联工程项目','402882d35ebd7a23015ebd93e3720034','[取消关联工程项目]的功能权限','0','delConsignUnitProjectRelation','projectController.do?doDeleteUnitAndProjectsRelation','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:36:46',NULL,NULL),('40288220689cca2801689d45320001db',NULL,2,'新增','402882d35ebd7a23015ebd9375830032','[新增]工程项目的功能权限','0','addProject','projectController.do?doAdd','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:39:44',NULL,NULL),('40288220689cca2801689d45c4ff01dd',NULL,2,'修改','402882d35ebd7a23015ebd9375830032','[修改]工程项目的功能权限','0','updateProject','projectController.do?doUpdate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:40:22',NULL,NULL),('40288220689cca2801689d46729f01df',NULL,2,'删除','402882d35ebd7a23015ebd9375830032','[删除]工程项目的功能权限','0','delProject','projectController.do?doDel','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:41:06',NULL,NULL),('40288220689cca2801689d474f4f01e1',NULL,2,'关联委托单位','402882d35ebd7a23015ebd9375830032','[关联委托单位]的功能权限','0','projectRelationConsignUnit','projectController.do?doAddRelationship','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:42:03',NULL,NULL),('40288220689cca2801689d48493b01e3',NULL,2,'取消关联委托单位','402882d35ebd7a23015ebd9375830032','[取消关联委托单位]的功能权限','0','delProjectConsignUnitRelation','projectController.do?doDeleteRelationship','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:43:07',NULL,NULL),('40288220689cca2801689d49371501e5',NULL,2,'新增','402882d35ebd7a23015ebd94d5c90039','[新增]送样人员的功能权限','0','addSampleSender','sampleSenderController.do?doAdd','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:44:08',NULL,NULL),('40288220689cca2801689d4a0b1801e7',NULL,2,'修改','402882d35ebd7a23015ebd94d5c90039','[修改]送样人员的功能权限','0','updateSampleSender','sampleSenderController.do?doUpdate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:45:02',NULL,NULL),('40288220689cca2801689d4b2eb201e9',NULL,2,'删除','402882d35ebd7a23015ebd94d5c90039','[删除]送样人的功能权限','0','delSampleSender','sampleSenderController.do?doDel','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:46:17',NULL,NULL),('40288220689cca2801689d4c01f301eb',NULL,2,'重置密码','402882d35ebd7a23015ebd94d5c90039','[重置密码]的功能权限','0','resetSqmpleSenderPassword','sampleSenderController.do?doResetPassword','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:47:11',NULL,NULL),('40288220689cca2801689d4dd96701ed',NULL,2,'锁定/解锁','402882d35ebd7a23015ebd94d5c90039','[锁定][解锁]公用的功能权限','0','lockOrUnlockSampleSender','sampleSenderController.do?doLockOrUnLock','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:49:11',NULL,NULL),('40288220689cca2801689d5019d301ef',NULL,2,'关联委托单位','402882d35ebd7a23015ebd94d5c90039','[关联委托单位]的功能权限','0','sampleSenderRelationConsignUnit','sampleSenderController.do?addConsignUnitRelation','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:51:39',NULL,NULL),('40288220689cca2801689d512eaa01f1',NULL,2,'取消关联委托单位','402882d35ebd7a23015ebd94d5c90039','[取消关联委托单位]的功能权限','0','delSampleSenderConsignUnitRelation','sampleSenderController.do?delConsignUnitRelation','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 13:52:50',NULL,NULL),('40288220689cca2801689d61c1f00201',NULL,2,'新增','402882d35ebd7a23015ebd9560d0003b','[新增]自定义属性的功能权限','0','addConsignCustomAttribute','consignCustomAttributeController.do?doAdd','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 14:10:56',NULL,NULL),('40288220689cca2801689d6259c20203',NULL,2,'修改','402882d35ebd7a23015ebd9560d0003b','[修改]自定义属性的功能权限','0','updateConsignCustomAttribute','consignCustomAttributeController.do?doUpdate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 14:11:35',NULL,NULL),('40288220689cca2801689d630d270205',NULL,2,'删除','402882d35ebd7a23015ebd9560d0003b','[删除]自定义属性的功能权限','0','delConsignCustomAttribute','consignCustomAttributeController.do?doDel','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 14:12:21',NULL,NULL),('40288220689cca2801689d9897100240',NULL,2,'收费','402882105ebd2ee7015ebd34fbc80004','[收费]的按钮权限','0','goAddFee','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 15:10:50',NULL,NULL),('40288220689cca2801689d9948500242',NULL,2,'回退','402882105ebd2ee7015ebd34fbc80004','[回退]的按钮权限','0','feeRollback','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 15:11:35',NULL,NULL),('40288220689cca2801689d99ef370244',NULL,2,'批量选择','402882105ebd2ee7015ebd34fbc80004','[批量选择]的按钮权限','0','batchSelectFee','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 15:12:18',NULL,NULL),('40288220689cca2801689d9a77700246',NULL,2,'导出','402882105ebd2ee7015ebd34fbc80004','[导出]的功能权限','0','feeExportXls','feeModelController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 15:12:53',NULL,NULL),('40288220689cca2801689d9b85fb0248',NULL,2,'新增收费','402882105ebd2ee7015ebd34fbc80004','[新增收费]的功能权限','0','newFeeDetail','chargeController.do?doAddFee','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 15:14:02',NULL,NULL),('40288220689cca2801689d9c3ca0024a',NULL,2,'查看详情','402882105ebd2ee7015ebd34fbc80004','[查看详情]的按钮权限','0','goFeeDetail','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 15:14:49',NULL,NULL),('40288220689cca2801689da75b06024c',NULL,2,'计费调整','402882105ebd2ee7015ebd34fbc80004','[费用调整]的按钮权限','0','feeChange','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 15:26:57',NULL,NULL),('40288220689cca2801689dd06a400280',NULL,2,'任务分配','402882106159aac901615a1cbd6b0004','[任务分配]的按钮权限','0','goTaskAssign','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:11:48',NULL,NULL),('40288220689cca2801689dd1958e0282',NULL,2,'按样品分配任务','402882106159aac901615a1cbd6b0004','[分配]-按样品分配的执行权限','0','taskAssignByObject','unAssignedTaskController.do?assignTaskWithObject','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:13:05',NULL,NULL),('40288220689cca2801689dd276ed0284',NULL,2,'按参数分配任务','402882106159aac901615a1cbd6b0004','[分配]-按参数分配的执行权限','0','taskAssignByParam','unAssignedTaskController.do?assignTaskWithParams','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:14:02',NULL,NULL),('40288220689cca2801689dd3b3d00286',NULL,2,'回退','402882106159aac901615a1cbd6b0004','未分配-[回退]按钮权限','0','unAssignRollback','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:15:24',NULL,NULL),('40288220689cca2801689dd4f3ce0288',NULL,2,'查看委托详情','402882106159aac901615a1cbd6b0004','未分配-[查看详情]按钮权限','0','unAssignGoConsignInfo','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:16:46',NULL,NULL),('40288220689cca2801689dd67338028a',NULL,2,'查看详情','402882106159aac901615a1cbd6b0004','已分配-[查看详情]按钮权限','0','assignedGoTestTaskInfo','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:18:24',NULL,NULL),('40288220689cca2801689dd753cc028c',NULL,2,'查看日志','402882106159aac901615a1cbd6b0004','已分配-[查看日志]按钮权限','0','assignedGoProcessLog','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:19:21',NULL,NULL),('40288220689cca2801689dd87ef4028e',NULL,2,'任务撤回','402882106159aac901615a1cbd6b0004','已分配-[任务撤回]按钮权限','0','assignedRollback','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:20:38',NULL,NULL),('40288220689cca2801689dd982060290',NULL,2,'重新分配','402882106159aac901615a1cbd6b0004','已分配-[重新分配]功能权限','0','assignedReAssignTask','assignedTaskController.do?reAssignTask','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:21:44',NULL,NULL),('40288220689cca2801689df3fc1702ba',NULL,2,'任务回退','402882d360d3935d0160d398ddb4000c','[任务回退]按钮权限','0','testTaskRollback','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:50:39',NULL,NULL),('40288220689cca2801689df4e71702bc',NULL,2,'放弃任务','402882d360d3935d0160d398ddb4000c','[放弃任务]的按钮权限','0','testtaskGiveup','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:51:39',NULL,NULL),('40288220689cca2801689df5b9ba02be',NULL,2,'任务转交','402882d360d3935d0160d398ddb4000c','[任务转交]功能权限','0','testtaskTransfer','commonController.do?taskTransfer','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:52:33',NULL,NULL),('40288220689cca2801689df6721702c0',NULL,2,'打印空表','402882d360d3935d0160d398ddb4000c','[打印空表]按钮权限','0','testtaskPrintNullTable','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:53:21',NULL,NULL),('40288220689cca2801689df7595c02c2',NULL,2,'查看详情','402882d360d3935d0160d398ddb4000c','[查看详情]功能权限(查看任务详情)','0','goTesttaskInfo','testTaskController.do?goTestTaskDetail','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-01-30 16:54:20',NULL,NULL),('40288220690e851701690eb66ecc003c',NULL,2,'创建综合报告','402882d360d3935d0160d398ddb4000c','[创建综合报告]功能权限,拥有该权限可以勾选多个任务来一键创建综合报告','999','createReportByTestTasks','reportCreateController.do?createByTestTasks','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-02-21 14:20:31',NULL,NULL),('4028822069b966cb0169b97bfb430040',NULL,2,'复核权限','4028820e65ea58bd0165eabead440065','按钮[复核同意][复核不同意]的功能权限','0','doTaskReview','testTaskReviewController.do?doTaskReview','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:11:44',NULL,NULL),('4028822069b966cb0169b98235d50054',NULL,2,'查看试验详情','4028820e65ea58bd0165eabead440065','[查看试验详情]的按钮权限','1','taskReviewGoTaskDetail','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:18:32',NULL,NULL),('4028822069b966cb0169b990aabc005d',NULL,2,'修改报告编号','40288220667a7ac801667a801ef00002','[修改报告编号]的功能权限','1','modifyReportSn','reportCreateController.do?modifyReportSn','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:34:20',NULL,NULL),('4028822069b966cb0169b99190340062',NULL,2,'作废报告','40288220667a7ac801667a801ef00002','[作废报告]的功能权限','2','discardReport','reportCreateController.do?discardReport','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:35:18',NULL,NULL),('4028822069b966cb0169b9942f910067',NULL,2,'取消作废','40288220667a7ac801667a801ef00002','报告已作废-[取消作废]的功能权限','3','recoverReport','reportCreateController.do?recoverReport','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:38:10',NULL,NULL),('4028822069b966cb0169b99b2506006a',NULL,2,'创建报告','40288220667a7ac801667a801ef00002','[创建报告]的按钮权限','0','createReport','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:45:46',NULL,NULL),('4028822069b966cb0169b99bb295006c',NULL,2,'编辑报告','40288220667a7ac801667a801ef00002','[编辑报告]的按钮权限','1','editReport','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:46:23',NULL,NULL),('4028822069b966cb0169b99c6e6f006e',NULL,2,'查看报告','40288220667a7ac801667a801ef00002','[查看报告]的按钮权限','2','viewReport','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:47:11',NULL,NULL),('4028822069b966cb0169b99df7af0070',NULL,2,'跳转报告详情页','40288220667a7ac801667a801ef00002','跳转报告详情页的执行权限,用户有{创建/编辑/查看}之一则必须选中这个','3','goReportEditPage','reportCreateController.do?goEditPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 18:48:51',NULL,NULL),('4028822069b966cb0169b9ab38750078',NULL,2,'保存报告','40288220667a7ac801667a801ef00002','报告详情页-[保存报告]功能权限','7','saveReport','reportCreateController.do?saveReport','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 19:03:20',NULL,NULL),('4028822069b966cb0169b9aeac360087',NULL,2,'提交报告','40288220667a7ac801667a801ef00002','报告详情页-[提交报告]功能权限','8','submitReport','reportCreateController.do?submitReport','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 19:07:06',NULL,NULL),('4028822069b966cb0169b9b3d2f100a6',NULL,2,'审核通过','402882cd5f52cb58015f52cce3370000','[审核通过]的功能权限','0','doReportAuditPass','reportAuditController.do?goReportAuditPass','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 19:12:44',NULL,NULL),('4028822069b966cb0169b9b4b64100a8',NULL,2,'退回','402882cd5f52cb58015f52cce3370000','[退回]的按钮权限','1','reportAuditRollback','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 19:13:42',NULL,NULL),('4028822069b966cb0169b9b539aa00aa',NULL,2,'转交','402882cd5f52cb58015f52cce3370000','[转交]的按钮权限','2','reportAuditTransfer','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 19:14:16',NULL,NULL),('4028822069b966cb0169b9b617d100ac',NULL,2,'查看详情','402882cd5f52cb58015f52cce3370000','[查看详情]的功能权限','3','goReportAuditDetail','reportAuditController.do?goReportAuditDetail','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 19:15:12',NULL,NULL),('4028822069b966cb0169b9b8bb1100ae',NULL,2,'查看日志','402882cd5f52cb58015f52cce3370000','[查看日志]的按钮权限','4','reportAuditViewLog','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-26 19:18:05',NULL,NULL),('4028822069c23c660169c2b4c04c0000',NULL,1,'在线体验配置权限','8a8ab0b246dc81120146dc8180d2001a','这个菜单用于打包在线体验用户的各项特殊自定义权限控制','888',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028822069c23c660169c2b7e76e0002',NULL,2,'显示悬浮导航','4028822069c23c660169c2b4c04c0000','显示悬浮导航的按钮权限,获得该权限可以显示悬浮导航','0','showFloatNavigator','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-28 13:13:46',NULL,NULL),('4028822069c23c660169c2bc42880004',NULL,2,'显示引导蒙层','4028822069c23c660169c2b4c04c0000','显示引导蒙层的按钮权限,获得该权限可以显示引导蒙层','1','showGuideMaskLayer','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-28 13:18:32',NULL,NULL),('4028822069c31fa80169c33541410001',NULL,2,'创建试验','402882d360d3935d0160d398ddb4000c','[创建试验]的功能权限','6','createTestTask','testerTasteController.do?createTest','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-28 15:30:41',NULL,NULL),('4028822069c78f410169c7f9a8c30013',NULL,2,'批准通过','402882cd5f572480015f5725137d0000','[批准通过]的功能权限','0','reportApprovePass','reportApproveController.do?doReportApprovePass','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-29 13:43:42',NULL,NULL),('4028822069c78f410169c7fb2e470015',NULL,2,'退回','402882cd5f572480015f5725137d0000','[退回]的按钮权限','1','reportApproveRollback','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-29 13:45:21',NULL,NULL),('4028822069c78f410169c7fbe4980017',NULL,2,'转交','402882cd5f572480015f5725137d0000','[转交]的按钮权限','2','reportApproveTransfer','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-29 13:46:08',NULL,NULL),('4028822069c78f410169c7fcb26a0019',NULL,2,'查看详情','402882cd5f572480015f5725137d0000','[查看详情]的功能权限','3','reportApproveDetail','reportApproveController.do?goReportApproveDetail','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-29 13:47:01',NULL,NULL),('4028822069c78f410169c7fd6228001b',NULL,2,'查看日志','402882cd5f572480015f5725137d0000','[查看日志]的按钮权限','4','reportApproveShowLog','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-29 13:47:46',NULL,NULL),('4028822069c863d80169c86d4e0d0003',NULL,2,'修改盲样策略','4028822069c23c660169c2b4c04c0000','修改[是否盲样]的按钮权限,获得该权限可以切换盲样/不盲样','2','modifyBlindSampleParam','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-03-29 15:50:00',NULL,NULL),('4028822069d6a3ea0169d6911ac50008',NULL,2,'收集用户信息弹窗','4028822069c23c660169c2b4c04c0000','拥有该权限,每指定周期会弹出填写用户信息的页面(填写后不清理缓存不会再弹出)','3','experienceUserInfoCollection','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-04-01 09:43:48',NULL,NULL),('402882206a05e84e016a060a53e6000b',NULL,1,'机构管理','2c98b9136f26e10d016f26f5df0f00cb','机构管理','10',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882206a05e84e016a060b57be000d',NULL,2,'单位管理','402882206a05e84e016a060a53e6000b','单位信息版本/资质/授权管理','0',NULL,'systemUnitController.do?goSystemUnitPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','lilf','李丽峰',NULL,NULL,'2019-04-10 14:59:28',NULL,NULL),('402882206a67ed0d016a6806c82b0000',NULL,0,'海特后台管理',NULL,'','100',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882206b493563016b49aa5eb50019',NULL,2,'创建临时报告','40288220667a7ac801667a801ef00002','[创建临时报告]的按钮权限','9','createTempReport','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-06-12 11:10:31',NULL,NULL),('402882206dd3541d016dd37669fe0004',NULL,1,'流程管理','8a8ab0b246dc81120146dc8180d2001a','','30',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882206ed416f3016ed4921b210000',NULL,2,'留样到期通知权限','4028826367a513a10167a51fae120005','留样到期的通知权限,拥有该权限的人可以收到留样到期的提醒消息','0','objectReserveDueMsg','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-12-05 13:39:35',NULL,NULL),('402882206ef95335016ef9d2d4dd014e',NULL,0,'特殊权限配置',NULL,'特殊权限集中存放到\r\n该组下, 该权限不是一个菜单','0',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','lilf','李丽峰',NULL,NULL,'2019-12-12 19:16:14',NULL,NULL),('402882206ef95335016ef9d478c20150',NULL,1,'超级管理员','402882206ef95335016ef9d2d4dd014e','超级用户可以查看项目内全部数据','10','superUserAuthority','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-12-12 19:18:02',NULL,NULL),('402882206f59b754016f5aafebf10074',NULL,2,'外出','4028821e6dbf968f016dbfbac1eb0006','[新增外出]的功能权限','1','newEgress','rest/eqEgress/newEgress','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-12-31 14:41:16',NULL,NULL),('402882206f59b754016f5ab166f80076',NULL,2,'外出确认/拒绝','4028821e6dbf968f016dbfbac1eb0006','[确认外出]和[拒绝外出]的功能权限','2','egressConfirm','rest/eqEgress/egressConfirm','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-12-31 14:42:53',NULL,NULL),('402882206f59b754016f5ab2431f0078',NULL,2,'归还','4028821e6dbf968f016dbfbac1eb0006','[归还设备]的功能权限','3','equipmentReturn','rest/eqEgress/equipmentReturn','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-12-31 14:43:50',NULL,NULL),('402882206f59b754016f5ab3270f007a',NULL,2,'归还确认/拒绝','4028821e6dbf968f016dbfbac1eb0006','[确认归还]和[拒绝归还]的功能权限','4','returnConfirm','rest/eqEgress/returnConfirm','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2019-12-31 14:44:48',NULL,NULL),('402882206f63d1f3016f641dfbb30005',NULL,2,'信用额度设置权限','402882105f4c1d6d015f4daea41f0049','[挂账额度设置]和[批量设置额度]的功能权限','1','setCreditLine','creditController.do?setCreditLine','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 10:38:04',NULL,NULL),('402882206f63d1f3016f641f691f0008',NULL,2,'信用回款登记权限','402882105f4c1d6d015f4daea41f0049','[回款登记]的功能权限','2','creditRepayment','creditRepaymentController.do?doRepayment','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 10:39:38',NULL,NULL),('402882206f63d1f3016f6447fa22004d',NULL,2,'创建综合试验','402882d360d3935d0160d398ddb4000c','[创建综合试验]的功能权限','8','createSynthesisTestTask','synthesisTestTaskController.do?createSynthesisTestTask','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 11:23:56',NULL,NULL),('402882206f63d1f3016f645fac5000ca',NULL,2,'报告发放权限','4028826366e8b9190166e8bd76180002','[报告发放]和[重新发放]的功能权限','1','reportIssue','reportIssueController.do?saveOrUpdate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 11:49:49',NULL,NULL),('402882206f63d1f3016f6466f75b00d0',NULL,2,'打印邮寄单','4028826366e8b9190166e8bd76180002','[打印邮寄单]的按钮权限','2','printMailInfomation','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 11:57:47',NULL,NULL),('402882206f63d1f3016f6469208000d2',NULL,2,'打印发放登记表(已选)','4028826366e8b9190166e8bd76180002','[]打印发放登记表(已选)]的按钮权限','3','printIssueRegistrationForm1','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 12:00:09',NULL,NULL),('402882206f63d1f3016f6469b08b00d4',NULL,2,'打印发放登记表(全部)','4028826366e8b9190166e8bd76180002','[打印发放登记表(全部)]的按钮权限','4','printIssueRegistrationForm2','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 12:00:46',NULL,NULL),('402882206f63d1f3016f64abfb6300d6',NULL,2,'导出报告发放记录','4028826366e8b9190166e8bd76180002','[导出发放记录]的功能权限','5','reportIssueRecordExport','reportIssueController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 13:13:10',NULL,NULL),('402882206f63d1f3016f64ad67ba00d8',NULL,2,'撤销报告发放登记','4028826366e8b9190166e8bd76180002','[撤销登记]的功能权限','6','undoReportIssue','reportIssueController.do?undoIssue','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 13:14:44',NULL,NULL),('402882206f63d1f3016f64c55af700ed',NULL,2,'发起报告重打修改审批','4028822066bf20530166bf239d620000','[新增申请]和[重新提交]的功能权限','1','applyReportReprintOrModify','reportRedoAuditController.do?newOrModifyAudit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 13:40:53',NULL,NULL),('402882206f63d1f3016f64c7a7f400ef',NULL,2,'重打修改审核权限','4028822066bf20530166bf239d620000','[审核通过]和[审核拒绝]的功能权限','2','doAuditReportModifyOrReprint','reportRedoAuditController.do?doAudit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 13:43:24',NULL,NULL),('402882206f63d1f3016f64c9346e00f1',NULL,2,'中止报告重打修改申请','4028822066bf20530166bf239d620000','[中止申请]的功能权限','3','breakReportRedoAudit','reportRedoAuditController.do?breakAudit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 13:45:05',NULL,NULL),('402882206f63d1f3016f64cb4f4000f3',NULL,2,'处理客户单位申请','4028822066bf20530166bf239d620000','[处理客户单位申请]的按钮权限','4','disposeClientApply','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 13:47:23',NULL,NULL),('402882206f63d1f3016f64e97c7200f6',NULL,2,'归档/重新编辑归档信息','4028826367065b49016706633a070002','[归档]和[重新编辑归档信息]的功能权限','1','saveReportArchive','archiveController.do?batchSaveArchive','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:20:21',NULL,NULL),('402882206f63d1f3016f64ea611a00f8',NULL,2,'删除档案','4028826367065b49016706633a070002','[删除档案]的功能权限','2','delArchiveById','archiveController.do?delArchiveById','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:21:20',NULL,NULL),('402882206f63d1f3016f64eafadd00fa',NULL,2,'导出归档信息','4028826367065b49016706633a070002','[导出归档信息]的功能权限','3','exportArchive','archiveController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:21:59',NULL,NULL),('402882206f63d1f3016f64efd15000fc',NULL,2,'归档地址配置','4028826367065b49016706633a070002','进入归档地址配置功能的权限','4','goArchiveSitePage','archiveSiteController.do?goArchiveSitePage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:27:16',NULL,NULL),('402882206f63d1f3016f64f18af900fe',NULL,2,'保存归档地址','4028826367065b49016706633a070002','[保存归档地址]的功能权限','5','saveArchiveSite','archiveSiteController.do?saveOrUpdate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:29:09',NULL,NULL),('402882206f63d1f3016f64f22cd50100',NULL,2,'删除归档地址','4028826367065b49016706633a070002','[删除归档地址]的功能权限','6','delArchiveSite','archiveSiteController.do?delArchiveSite','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:29:50',NULL,NULL),('402882206f63d1f3016f64f3e9be0102',NULL,2,'进入归档资料配置的权限','4028826367065b49016706633a070002','进入归档资料配置页面的权限','7','goArchiveDataPage','archiveSiteController.do?goArchiveDataPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:31:44',NULL,NULL),('402882206f63d1f3016f64f5dc6a0104',NULL,2,'保存归档资料配置','4028826367065b49016706633a070002','[保存归档资料配置]的功能权限','8','saveArchiveMaterial','archiveMaterialController/saveOrUpdate.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:33:52',NULL,NULL),('402882206f63d1f3016f64f6d8440106',NULL,2,'删除归档资料配置','4028826367065b49016706633a070002','[删除归档资料配置]的功能权限','9','delArchiveMaterial','archiveMaterialController/delete.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 14:34:56',NULL,NULL),('402882206f63d1f3016f653431980113',NULL,2,'领取样品&重新登记领取','4028826367a513a10167a51fae120005','[领取样品]和[重新登记领取]的功能权限','2','objectGet','objectDisposeController.do?objectGet','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:41:57',NULL,NULL),('402882206f63d1f3016f6534ca7d0115',NULL,2,'收样处留样','4028826367a513a10167a51fae120005','[收样处留样]的功能权限','3','sampleRoomSave','objectDisposeController.do?sampleRoomSave','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:42:36',NULL,NULL),('402882206f63d1f3016f6535ab390117',NULL,2,'打印样品流转单','4028826367a513a10167a51fae120005','[打印样品流转单]的按钮权限','4','printObjectProcessInfo','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:43:34',NULL,NULL),('402882206f63d1f3016f653630cc0119',NULL,2,'作废样品','4028826367a513a10167a51fae120005','[作废样品]的功能权限','5','invalidObject','objectDisposeController.do?invalid','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:44:08',NULL,NULL),('402882206f63d1f3016f653714ce011b',NULL,2,'测后样品处理/留样处理','4028826367a513a10167a51fae120005','[测后样品处理]和[留样处理]的功能权限','6','objectDispose','objectDisposeController.do?dispose','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:45:06',NULL,NULL),('402882206f63d1f3016f6537b080011d',NULL,2,'进入制样管理功能','4028826367a513a10167a51fae120005','[进入制样管理功能]的功能权限','7','goObjectProcessAddPeriod','testObjectPeriodController.do?goObjectProcessAddPeriod','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:45:46',NULL,NULL),('402882206f63d1f3016f6538082c011f',NULL,2,'新增制件信息','4028826367a513a10167a51fae120005','[新增制件信息]的功能权限','8','addProcessObjectPeriod','testObjectPeriodController.do?addProcessObjectPeriod','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:46:09',NULL,NULL),('402882206f63d1f3016f6538ced10121',NULL,2,'删除制件信息','4028826367a513a10167a51fae120005','[删除制件信息]的功能权限','9','delObjectPeriod','testObjectPeriodController.do?delPeriod','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:46:59',NULL,NULL),('402882206f63d1f3016f653b40ae0123',NULL,2,'打印留样标签','4028826367a513a10167a51fae120005','[打印留样标签]的功能权限','10','printSampleRetentionLable','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:49:40',NULL,NULL),('402882206f63d1f3016f653c23ca0125',NULL,2,'导出已处理样品','4028826367a513a10167a51fae120005','[导出已处理样品]的功能权限','11','exportDisposedObject','processedObjectController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:50:38',NULL,NULL),('402882206f63d1f3016f653d59cc0127',NULL,2,'导出全部样品','4028826367a513a10167a51fae120005','[导出全部样品]的功能权限','12','exportAllObject','allObjectController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 15:51:57',NULL,NULL),('402882206f63d1f3016f6579cf9501aa',NULL,2,'新增/编辑设备','402882cd5f9952fa015f998520050039','[新增]和[编辑]设备的功能权限','1','saveEquipment','equipmentNewController.do?saveEq','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 16:57:59',NULL,NULL),('402882206f63d1f3016f657a477601ac',NULL,2,'删除设备','402882cd5f9952fa015f998520050039','[删除设备]的功能权限','2','deleteEquipment','equipmentNewController.do?delEq','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 16:58:30',NULL,NULL),('402882206f63d1f3016f657b267801ae',NULL,2,'导入设备','402882cd5f9952fa015f998520050039','[导入设备]的功能权限','3','importEquipment','equipmentNewController.do?importEquipment','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 16:59:27',NULL,NULL),('402882206f63d1f3016f657ca07f01b0',NULL,2,'下载导入模板','402882cd5f9952fa015f998520050039','[下载导入模板]的功能权限','4','downloadEQImportTemplate','equipmentNewController.do?downloadEQImportTemplate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:01:04',NULL,NULL),('402882206f63d1f3016f657d489701b2',NULL,2,'导出设备','402882cd5f9952fa015f998520050039','[导出设备]的功能权限','5','exportEquipment','equipmentNewController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:01:47',NULL,NULL),('402882206f63d1f3016f657ef4b001b4',NULL,2,'打印设备台账','402882cd5f9952fa015f998520050039','[打印设备台账]的按钮权限','6','printEquipmentList','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:03:37',NULL,NULL),('402882206f63d1f3016f6584e30601b6',NULL,2,'检校参数配置','402882cd5f9952fa015f998520050039','进入[检校参数配置]功能的权限','7','goEquipmentCheckItemList','checkItemController.do?goCheckItemList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:10:05',NULL,NULL),('402882206f63d1f3016f6587742501b8',NULL,2,'保存设备检校参数','402882cd5f9952fa015f998520050039','[保存设备检校参数]的功能权限','8','saveEuipmentCheckItem','checkItemController.do?saveItem','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:12:54',NULL,NULL),('402882206f63d1f3016f65891d7501ba',NULL,2,'删除设备检校参数','402882cd5f9952fa015f998520050039','[删除设备检校参数]的功能权限','9','delEquipmentCheckItem','checkItemController.do?delete','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:14:42',NULL,NULL),('402882206f63d1f3016f658f903f01bc',NULL,2,'新增/修改供应商','402882636b4e6ca7016b4e8039800002','[新增]或[修改]供应商的功能权限','1','saveSupplier','supplierController.do?saveSupplier','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:21:45',NULL,NULL),('402882206f63d1f3016f658ffcd601be',NULL,2,'删除供应商','402882636b4e6ca7016b4e8039800002','[删除供应商]的功能权限','2','delSupplier','supplierController.do?delSupplier','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:22:13',NULL,NULL),('402882206f63d1f3016f6590a02501c0',NULL,2,'导出设备供应商','402882636b4e6ca7016b4e8039800002','[导出设备供应商]的功能权限','3','exportEquipmentSupplier','supplierController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:22:55',NULL,NULL),('402882206f63d1f3016f65918c2001c2',NULL,2,'打印供应商台账','402882636b4e6ca7016b4e8039800002','[打印供应商台账]的按钮权限','4','printEquipmentSupplier','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-02 17:23:55',NULL,NULL),('402882206f691b82016f694948980008',NULL,3,'新增/编辑检校计划','402882636b53d8e3016b53f5b2840065','[新增]和[编辑]检校计划的功能权限','1','saveEquipmentCheckPlan','checkPlanController.do?savePlan','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-03 10:43:28',NULL,NULL),('402882206f691b82016f6949cbc8000a',NULL,3,'删除检校计划','402882636b53d8e3016b53f5b2840065','[删除检校计划]的功能权限','2','delEquipmentCheckPlan','checkPlanController.do?delPlan','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-03 10:44:02',NULL,NULL),('402882206f691b82016f694a6cdc000c',NULL,3,'导出检校计划列表','402882636b53d8e3016b53f5b2840065','[导出检校计划列表]的功能权限','3','exportEquipmentCheckPlanList','checkPlanController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-03 10:44:43',NULL,NULL),('402882206f691b82016f694b4522000e',NULL,3,'提交检校计划','402882636b53d8e3016b53f5b2840065','[提交检校计划]的功能权限','4','submitEquipmentCheckPlan','checkPlanController.do?submitPlanAudit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-03 10:45:38',NULL,NULL),('402882206f691b82016f694cb6710010',NULL,3,'导出检校计划明细','402882636b53d8e3016b53f5b2840065','[导出检校计划明细]的功能权限','5','exportEquipmentCheckPlanDetail','checkPlanController.do?exportPlanDetailXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-03 10:47:13',NULL,NULL),('402882206f691b82016f694d8dd30012',NULL,3,'打印检校计划明细','402882636b53d8e3016b53f5b2840065','[打印检校计划明细]的按钮权限','6','printEquipmentCheckPlanDetail','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-03 10:48:08',NULL,NULL),('402882206f691b82016f694fe6170014',NULL,3,'新增/编辑检校记录','402882636b53d8e3016b5550bddf015f','[新增]和[编辑]检校记录的功能权限','1','saveEquipmentCheckRecord','checkController.do?saveCheck','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-03 10:50:42',NULL,NULL),('402882206f691b82016f6950d0010016',NULL,3,'提交检校记录','402882636b53d8e3016b5550bddf015f','[提交检校记录]的功能权限','2','submitCheckRecord','checkController.do?submitCheckAudit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-01-03 10:51:41',NULL,NULL),('402882207133c73f017133dd41bd0001',NULL,2,'设备附件目录操作权限','402882cd5f9952fa015f998520050039','控制设备附件目录的新增/编辑/删除功能','10','eqFolderAuth','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-04-01 11:51:11',NULL,NULL),('402882207133c73f017133de362a0003',NULL,2,'设备文件操作权限','402882cd5f9952fa015f998520050039','控制设备文件的上传/删除(下载)','11','eqFileAuth','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-04-01 11:52:13',NULL,NULL),('402882207133c73f017133dff7270005',NULL,2,'设备文件查阅权限','402882cd5f9952fa015f998520050039','控制设备文件的下载/查看权限','12','eqFileView','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','admin','管理员',NULL,NULL,'2020-04-01 11:54:08',NULL,NULL),('4028822071e8210d0171e8e4a7af308d',NULL,1,'系统初始化','402882206a67ed0d016a6806c82b0000','系统的各项初始化功能操作页面','0',NULL,'initController.do?goInitPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','lilf','李丽峰',NULL,NULL,'2020-05-06 15:30:31',NULL,NULL),('4028822072407de8017240d7d7fb00e7',NULL,2,'修改借用人和归还人','4028821e6dbf968f016dbfbac1eb0006','修改借用人和归还人的按钮权限,拥有该权限可以在对应功能中选择借用人或归还人','5','modifyBorrower','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-05-23 17:23:07',NULL,NULL),('4028822072837c8c017283a7b2b90018',NULL,2,'打印权限','402882cc5e2d0e90015e2d38d1a40007','[打印]功能权限','1','reportPrint','reportPrintController.do?goReportPrintConfig','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 16:45:05',NULL,NULL),('4028822072837c8c017283a8e5c6001c',NULL,2,'标记为打印权限','402882cc5e2d0e90015e2d38d1a40007','[标记为打印]的功能权限','2','markPrinted','reportPrintController.do?markPrint','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 16:46:24',NULL,NULL),('4028822072837c8c017283aade9a001f',NULL,2,'设置资质盖章权限','402882cc5e2d0e90015e2d38d1a40007','[设置资质盖章]的功能权限','3','setReportQualificaction','reportController.do?doSaveReportQualifications','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 16:48:33',NULL,NULL),('4028822072837c8c017283bba79c0021',NULL,2,'退回权限','402882cc5e2d0e90015e2d38d1a40007','[退回]的按钮权限','4','reportPrintRollback','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 17:06:53',NULL,NULL),('4028822072837c8c017283bd4f610023',NULL,2,'通知修改委托','402882cc5e2d0e90015e2d38d1a40007','[通知修改委托]的按钮权限','5','reportPrintNoticeModifyConsign','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 17:08:41',NULL,NULL),('4028822072837c8c017283bef0540025',NULL,2,'导出权限','402882cc5e2d0e90015e2d38d1a40007','[导出]的功能权限','6','reportPrintExport','reportPrintController.do?exportXls','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 17:10:28',NULL,NULL),('4028822072837c8c017283c06ee50028',NULL,2,'打印报告封面权限','402882cc5e2d0e90015e2d38d1a40007','[打印报告封面]的按钮权限','7','printReportCover','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 17:12:06',NULL,NULL),('4028822072837c8c017283c2a2dc002a',NULL,2,'通知领取报告权限','402882cc5e2d0e90015e2d38d1a40007','[通知领取报告]的功能权限','8','noticeClaimReport','reportController.do?doReportReceivesNotice','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 17:14:30',NULL,NULL),('4028822072837c8c017283c5b0580031',NULL,2,'报告重打修改申请权限','402882cc5e2d0e90015e2d38d1a40007','[报告重打修改申请]的按钮权限','9','reportRedoApply','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-05 17:17:51',NULL,NULL),('40288220729178c60172918539a2000a',NULL,2,'查看全部报告','402882cc5e2d0e90015e2d38d1a40007','拥有该权限，能查阅全单位报告。没有则只能查询本部门和下属部门报告','0','showAllReportAtPrint','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-08 09:22:07',NULL,NULL),('4028822072b588150172b590e1d10003',NULL,2,'下载档案文件','4028826367065b49016706633a070002','[下载报告档案文件]的功能权限','10','downloadReportArchives','archiveDownloadController.do?download','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','lilf','李丽峰',NULL,NULL,'2020-06-15 09:21:11',NULL,NULL),('40288220732dc6ae01732dd1c1200002',NULL,2,'资料分组管理权限','4028826373219d0d017321b29a6a0001','拥有该权限,可以增删改资料归档的分组信息','1','documentGroupManage','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lilf','李丽峰',NULL,NULL,'2020-07-08 17:46:28',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('40288220732dc6ae01732dd2ce6b0004',NULL,2,'新增/修改档案','4028826373219d0d017321b29a6a0001','新增和修改档案的权限','2','saveDocument','documentController.do?saveDocument','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lilf','李丽峰',NULL,NULL,'2020-07-08 17:47:37',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('40288220732dc6ae01732dd3ab810006',NULL,2,'完成归档权限','4028826373219d0d017321b29a6a0001','完成归档的权限','3','completeDocument','documentController.do?complete','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lilf','李丽峰',NULL,NULL,'2020-07-08 17:48:34',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('40288220732dc6ae01732dd498eb0008',NULL,2,'删除档案权限','4028826373219d0d017321b29a6a0001','删除档案的权限','4','delDocument','documentController.do?delDocument','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lilf','李丽峰',NULL,NULL,'2020-07-08 17:49:34',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('40288220732dc6ae01732dd581b9000a',NULL,2,'下载档案权限','4028826373219d0d017321b29a6a0001','下载档案的权限','5','downloadDocument','documentController.do?downloadData','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lilf','李丽峰',NULL,NULL,'2020-07-08 17:50:34',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('40288220732dc6ae01732dd642d3000c',NULL,2,'档案模板配置权限','4028826373219d0d017321b29a6a0001','模板配置权限','6','documentTemplateManage','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lilf','李丽峰',NULL,NULL,'2020-07-08 17:51:23',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('402882476072cd05016072f4fa040010',NULL,-1,'测试demo',NULL,NULL,'999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'yefei','2018-01-31 11:10:13',NULL,'叶飞',NULL),('402882476072cd05016072f8e97b0013',NULL,1,'检测单位','402882476072cd05016072f4fa040010',NULL,'1',NULL,'txingController.do?list','8a8ab0b246dc81120146dc8180880007','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-12-22 16:10:17',NULL,'管理员',NULL),('402882476080e12201608172b256001f',NULL,1,'检测人员管理','402882476072cd05016072f4fa040010',NULL,'2',NULL,'tXingStaffController.do?list','8a8ab0b246dc81120146dc8180860006','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-12-23 13:40:19',NULL,'管理员',NULL),('4028824761c03b0e0161c1803f380032',NULL,0,'文件管理',NULL,'','999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-files-o',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028824761c03b0e0161c180947d0034',NULL,1,'文件管理','2c98b9136f26e10d016f26f4781100c9','','60',NULL,'FolderController.do?golist','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882586e86e906016e87341bab0016',NULL,1,'资料管理','2c98b9136f26e10d016f26f4781100c9','','40',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882586e86e906016e87372379007b',NULL,2,'主题管理','402882586e86e906016e87341bab0016','','10',NULL,'dataCollectionController.do?goDataCollection','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2019-12-21 13:54:09',NULL,'管理员',NULL),('402882586e86e906016e87379e37007d',NULL,2,'主题资料上报','402882586e86e906016e87341bab0016','','20',NULL,'dataCollectionController.do?goDataUpload','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2019-12-21 13:54:09',NULL,'管理员',NULL),('402882586f31a2b5016f31a8e2f90004',NULL,1,'现场检测数据采集','402882846f020c7f016f0274f0a70779','','20',NULL,'dataGather.do?siteDataCollection','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','jiangliang','海特江良',NULL,NULL,'2019-12-23 15:29:09',NULL,NULL),('4028825a708445000170847698f30002',NULL,1,'设计级配范围配置','402882d360d3935d0160d39772700008','','60',NULL,'tDesignGradeTypeController.do?designGradeConfiguration','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','jiangliang','海特江良',NULL,NULL,'2020-02-27 10:25:30',NULL,NULL),('4028825a70e7325b0170e73729ef0002',NULL,2,'检测参数版本管理','402882105e5b5362015e5b55abd60003','','01',NULL,'paramVersionManagementController/paramVersionManagement.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','jiangliang','海特江良',NULL,NULL,'2020-03-17 14:38:37',NULL,NULL),('4028825a713438a5017134737b00040b',NULL,3,'主题信息项配置','402882586e86e906016e87372379007b','资料管理[主题信息项配置]按钮权限','10','dataCollectionCustomize','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','jiangliang','海特江良',NULL,NULL,'2020-04-01 14:35:16',NULL,NULL),('4028825a72793edc01727992508900d5',NULL,2,'报告标记为未盖章','843cf96eaae64133ba959d6806db50b7','报告管理标记为未盖章','20','markNotStampCode','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','jiangliang','海特江良',NULL,NULL,'2020-06-03 17:45:32',NULL,NULL),('4028825a72793edc0172799424be00df',NULL,2,'报告标记为盖章','843cf96eaae64133ba959d6806db50b7','报告管理标记为盖章','10','markStampCode','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','jiangliang','海特江良',NULL,NULL,'2020-06-03 17:47:31',NULL,NULL),('4028825a72793edc01727995547700e1',NULL,2,'导出','843cf96eaae64133ba959d6806db50b7','','30','markStampExport','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','jiangliang','海特江良',NULL,NULL,'2020-06-03 17:48:49',NULL,NULL),('4028825a72dff58d0172e00eb3f50005',NULL,1,'表格空白区域设置','8a8ab0b246dc81120146dc8180d2001a','','60',NULL,'rest/udrBlankDrawTypeController/goUdrBlankDraw','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028825a7328b48a0173293a0dc90210',NULL,2,'上传报告附件','402882cc5e2d0e90015e2d38d1a40007','[上传报告附件]的按钮权限','50','uploadOtherFile','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','jiangliang','海特江良',NULL,NULL,'2020-07-07 20:22:17',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('4028826366e8b9190166e8bd76180002',NULL,1,'报告发放','402882cc5e2d0e90015e2d36e62d0004','','50',NULL,'reportIssueController.do?goListPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 09:58:27',NULL,'曾继强',NULL),('4028826367065b49016706633a070002',NULL,1,'资料归档','402882cc5e2d0e90015e2d36e62d0004','','60',NULL,'archiveController.do?goListPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 09:58:55',NULL,'曾继强',NULL),('40288263673a662001673a6a91530000',NULL,1,'流程人员预设','8a8ab0b246dc81120146dc8180d2001a','','40',NULL,'processPersonController.do?goListPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('40288263675d385801675d3e21b40006',NULL,1,'首页','8a8ab0b246dc81120146dc8180d2001a','','777',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('40288263677d2f5901677d330fd10002',NULL,1,'待办事项配置','8a8ab0b246dc81120146dc8180d2001a','','20',NULL,'backlogController.do?goBacklogPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826367a513a10167a51d2ddd0002',NULL,0,'样品管理',NULL,'','50',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826367a513a10167a51fae120005',NULL,1,'样品流转','4028826367a513a10167a51d2ddd0002',NULL,'1',NULL,'waitTestObjectController.do?goListPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','zh','张红',NULL,NULL,'2018-12-13 09:12:56',NULL,NULL),('4028826367bae4d90167baf33c6f0001',NULL,1,'样品审核','4028826367a513a10167a51d2ddd0002',NULL,'1',NULL,'objectAuditController.do?goObjectAuditListPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','zh','张红',NULL,NULL,'2018-12-17 14:56:02',NULL,NULL),('4028826367ce4df50167ce5f19de0010',NULL,2,'样品处理审核','4028826367bae4d90167baf33c6f0001',NULL,'062','objectDisposeAudit','objectAuditController.do?doAudit','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','zh','张红',NULL,NULL,'2018-12-21 09:26:38',NULL,NULL),('402882636b4e6ca7016b4e8039800002',NULL,1,'供应商管理','402882cd5f9952fa015f9954b12c0000','','2',NULL,'supplierController.do?goSupplierList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','zh','张红',NULL,NULL,'2019-06-13 09:42:35',NULL,NULL),('402882636b53d8e3016b53dec8a30002',NULL,1,'检校管理','402882cd5f9952fa015f9954b12c0000','','4',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zh','2019-06-14 11:08:09',NULL,'张红',NULL),('402882636b53d8e3016b53f5b2840065',NULL,2,'年度检校计划','402882636b53d8e3016b53dec8a30002','','1',NULL,'checkPlanController.do?goCheckPlanList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','zh','张红',NULL,NULL,'2019-06-14 11:08:59',NULL,NULL),('402882636b53d8e3016b5550bddf015f',NULL,2,'检校确认','402882636b53d8e3016b53dec8a30002','','2',NULL,'checkController.do?goCheckList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zh','2019-06-15 14:22:33',NULL,'张红',NULL),('402882636ccd1eb9016ccd2235fe0000',NULL,1,'检测室管理','2c98b9136f26e10d016f26f5df0f00cb','','70',NULL,'laboratoryController.do?goLaboratoryList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882636ccd1eb9016ccd23ad4a0002',NULL,1,'环境条件记录查询','402882d360d3935d0160d39772700008','','60',NULL,'labEnvironmentController.do?goEnvironmentStatistics','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882636ccd3c69016ccd424ad60001',NULL,1,'规程管理','2c98b9136f26e10d016f26f5df0f00cb','','80',NULL,'baseStandardManageController.do?goStandardList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826370f6e2e90170f6e83c2a0007',NULL,1,'委托信息统计','402882d35ebd7a23015ebd9300530030','','6',NULL,'statisticalController.do?goConsignInfoStatisticalPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826370f6e2e90170f6ee206600de',NULL,1,'收样走势图','402882d35ebd7a23015ebd9300530030','','6',NULL,'statisticalController.do?goConsignSampleStatisticalPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826370f6e2e90170f6eebcb400e0',NULL,1,'收费统计','402882105ebd2ee7015ebd3365ce0000','','7',NULL,'statisticalController.do?goChargeStatisticalPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826370f6e2e90170f6effd6f00e5',NULL,1,'欠费统计','402882105ebd2ee7015ebd3365ce0000','','7',NULL,'statisticalController.do?goBillsStatisticalPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826370f6e2e90170f6f05b6300e7',NULL,1,'合同费用统计','402882105ebd2ee7015ebd3365ce0000','','7',NULL,'statisticalController.do?goContractFeeStatisticalPage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826370f6e2e90170f6f0e8cd00e9',NULL,1,'检测参数覆盖统计','402882d360d3935d0160d39772700008','','15',NULL,'statisticalController.do?goTestParamCoveragePage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('40288263710a1b8e01710b50fd6f010b',NULL,1,'收样样品分类统计','402882d35ebd7a23015ebd9300530030','','6',NULL,'statisticalController.do?goConsignCollectionStatistic','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2020-03-24 14:53:09',NULL,NULL),('4028826371146135017114b9fa800002',NULL,1,'报告打印统计','402882cc5e2d0e90015e2d36e62d0004','','97',NULL,'statisticalController.do?goReportPrintStatistics','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2020-03-26 10:44:25',NULL,NULL),('4028826371146135017114babfbd0004',NULL,2,'检测产值统计','402882d360d3935d0160d39772700008','','60',NULL,'statisticalController.do?goTestOutputStatistic','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826371be5d2d0171bfcd3cb0008c',NULL,1,'报告发放统计','402882cc5e2d0e90015e2d36e62d0004','','98',NULL,'statisticalController.do?goReportGrantStatistics','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882637215d29c017216426d460047',NULL,1,'低值易耗品','402882cd5f9952fa015f9954b12c0000','','6',NULL,'consumablesController.do?goConsumablesList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2020-05-15 10:55:52',NULL,NULL),('4028826372fac0ad0172fac89dfc0003',NULL,1,'数据状态查询','402882cc5e2d0e90015e2d36e62d0004','','71',NULL,'rest/allDataController/goAllData','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028826373219d0d017321b29a6a0001',NULL,1,'资料归档','2c98b9136f26e10d016f26f4781100c9','','80',NULL,'documentController.do?goDocumentListPage','8a8ab0b246dc81120146dc8180860006',NULL,0,'',NULL,NULL,NULL,NULL,NULL,NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/1f5278a9-ca23-4bd0-91b2-b26dbe4888c1.bmp'),('40288283732bfc1a01732da4dfcd0c1d',NULL,2,'资料归档详情目录新增','4028826373219d0d017321b29a6a0001','资料归档详情目录[新增]按钮','10','detailFolderAdd','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 16:57:27',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('40288283732bfc1a01732da5cd420c1f',NULL,2,'资料归档详情目录编辑','4028826373219d0d017321b29a6a0001','资料归档详情目录[编辑]按钮','20','detailFolderUpdate','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 16:58:28',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('40288283732bfd3701732da6a23606a0',NULL,2,'资料归档详情目录删除','4028826373219d0d017321b29a6a0001','资料归档详情目录[删除]按钮','30','detailFolderDelete','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 16:59:22',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('402882846a008145016a00f7ebce012e',NULL,0,'后台管理',NULL,'系统级别的菜单','999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180e50022',0,'fa-leaf',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882846a4e15d3016a62b967fd01a3',NULL,1,'合同审核','402882105ebd2ee7015ebd3365ce0000','','40',NULL,'contractAuditController.do?goContractAuditList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','wh','魏衡',NULL,NULL,'2019-04-28 14:54:39',NULL,NULL),('402882846b62f99d016b64fdc80a0125',NULL,2,'任务分配单打印','402882106159aac901615a1cbd6b0004','已分配-[任务分配单打印]功能权限','99','assignedListPrint','','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',1,'','wh','魏衡',NULL,NULL,'2019-06-17 18:31:22',NULL,NULL),('402882846eb4dadc016eb61dfdfc04c8',NULL,1,'人员信息管理','2c98b9136f26e10d016f26f4781100c9','','10',NULL,'biddingController.do?biddingPerson','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882846ec41ef6016ec5d08d1d0186',NULL,1,'投标记录管理','2c98b9136f26e10d016f26f4781100c9','','30',NULL,'biddingController.do?biddingRecord','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882846f020c7f016f0274f0a70779',NULL,1,'数据采集','402882d360d3935d0160d39772700008','','9',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882846f020c7f016f0277f3d507a2',NULL,2,'力学数据采集','402882846f020c7f016f0274f0a70779','','1',NULL,'dataGather.do?mechanicsDataCollection','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2019-12-21 13:54:22',NULL,'管理员',NULL),('4028829d60d35dd00160d4e223390005',NULL,1,'系统控制参数','8a8ab0b246dc81120146dc8180d2001a','','10',NULL,'tSBusinessParamController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882b54df53718014df538fc100001',NULL,1,'Online表单样式','8a8ab0b246dc81120146dc8180ce0019',NULL,'2',NULL,'cgformTemplateController.do?cgformTemplate','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882cc5e02d32f015e02e69ffb0006',NULL,2,'登录日志','8a8ab0b246dc81120146dc8180d9001d',NULL,'8',NULL,'logLoginController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员','admin','2019-12-21 14:16:34','2017-08-21 11:47:02','管理员',NULL),('402882cc5e02d32f015e02e736c60008',NULL,2,'操作日志','8a8ab0b246dc81120146dc8180d9001d',NULL,'9',NULL,'logOperationController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员','admin','2019-12-21 14:16:34','2017-08-21 11:47:41','管理员',NULL),('402882cc5e172240015e17271cc90003',NULL,2,'测试日志','8a8ab0b246dc81120146dc8180d9001d',NULL,'10',NULL,'tSLogTestController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员','admin','2019-12-21 14:16:34','2017-08-25 10:09:53','管理员',NULL),('402882cc5e1c5d52015e1c6622760002',NULL,2,'审批日志','8a8ab0b246dc81120146dc8180d9001d',NULL,'12',NULL,'tSLogApprovalController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2019-12-21 14:16:34',NULL,'管理员',NULL),('402882cc5e1d8f42015e1d91347a0005',NULL,2,'数据日志','8a8ab0b246dc81120146dc8180d9001d',NULL,'4',NULL,'tSLogDataSaveController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员','admin','2019-12-21 14:16:34','2017-08-26 16:03:29','管理员',NULL),('402882cc5e2d0e90015e2d36e62d0004',NULL,0,'报告管理',NULL,'','40',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-file-text',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882cc5e2d0e90015e2d38d1a40007',NULL,1,'报告打印','402882cc5e2d0e90015e2d36e62d0004','','40',NULL,'reportPrintController.do?goReportPrintList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 09:57:48',NULL,'曾继强',NULL),('402882cc5e645c32015e64608bee0000',NULL,1,'报告领取(待删)','402882cc5e2d0e90015e2d36e62d0004','','80',NULL,'tSReportReprintController.do?reportGetinglist','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 10:10:31',NULL,'曾继强',NULL),('402882cc5e6fe887015e700c338e0003',NULL,1,'职能参数权限','2c98b9136f26e10d016f26f5df0f00cb','','50',NULL,'tSProjectAuthorityController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882cd5f47ddbe015f47f73a520006',NULL,1,'职能管理','2c98b9136f26e10d016f26f5df0f00cb','','40',NULL,'tSProjectAuthorityController.do?roleManage','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882cd5f52cb58015f52cce3370000',NULL,1,'报告审核','402882cc5e2d0e90015e2d36e62d0004','','20','reportAuditMenu','reportAuditController.do?goReportAuditList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 09:56:45',NULL,'曾继强',NULL),('402882cd5f572480015f5725137d0000',NULL,1,'报告批准','402882cc5e2d0e90015e2d36e62d0004','','30','reportApproveMenu','reportApproveController.do?goReportApproveList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 09:57:10',NULL,'曾继强',NULL),('402882cd5f764fe4015f773ad4930006',NULL,2,'邮寄表单字段','402882cd5f7baae7015f7bc8e0c8000b','','0',NULL,'tSPostFormColumnsUseableController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zengxb','2019-05-31 15:27:31',NULL,'曾小兵',NULL),('402882cd5f7baae7015f7bc8e0c8000b',NULL,1,'邮寄管理(待删除)','8a8ab0b246dc81120146dc8180d2001a','','999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-truck',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882cd5f7bfcd0015f7c04f3b30000',NULL,2,'邮寄单填写','402882cd5f7baae7015f7bc8e0c8000b',NULL,'3',NULL,'tSPostFormsController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'','admin','管理员',NULL,NULL,'2017-11-02 17:17:00',NULL,NULL),('402882cd5f8f4d19015f8f4ff5350000',NULL,2,'字段配置','402882cd5f7baae7015f7bc8e0c8000b',NULL,'1',NULL,'tSPostManageController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-11-06 11:12:20',NULL,'管理员',NULL),('402882cd5f8f4d19015f8f52bdc90003',NULL,2,'下拉框分类及内容管理','402882cd5f7baae7015f7bc8e0c8000b',NULL,'2',NULL,'tSPostSelectTypeController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-11-07 09:51:14',NULL,'管理员',NULL),('402882cd5f9952fa015f9954b12c0000',NULL,0,'设备管理',NULL,'','60',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-wrench',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882cd5f9952fa015f9954f5980002',NULL,1,'设备类别(待删)','402882cd5f9952fa015f9954b12c0000','','0',NULL,'tSEquipmentController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-10-15 09:17:22',NULL,'曾继强',NULL),('402882cd5f9952fa015f998520050039',NULL,1,'综合管理','402882cd5f9952fa015f9954b12c0000','','1','','equipmentNewController.do?goEquipmentList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zh','2019-06-11 16:48:35',NULL,'张红',NULL),('402882cd5fc7fb11015fc80191e10001',NULL,1,'报告修改(待删)','402882cc5e2d0e90015e2d36e62d0004','','90',NULL,'tSReportUpdateController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 10:10:54',NULL,'曾继强',NULL),('402882cd5fc7fb11015fc8138e68000d',NULL,1,'报告修改审批(待删)','402882cc5e2d0e90015e2d36e62d0004','','95',NULL,'tSReportUpdateController.do?reportUpdateexalist','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 10:11:14',NULL,'曾继强',NULL),('402882cd5fd6fb99015fd70733240003',NULL,0,'样品管理-Old',NULL,'','999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-cubes',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882cd5fd6fb99015fd70dee5c0007',NULL,1,'在检测样品管理','402882cd5fd6fb99015fd70733240003',NULL,'1',NULL,'tObjectLogController.do?listed','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'cuixx','2018-03-14 16:27:11',NULL,'崔枭雄',NULL),('402882cd5fd7e82f015fd7eb7ecb0001',NULL,1,'待检测样品管理','402882cd5fd6fb99015fd70733240003',NULL,'1',NULL,'tObjectLogController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'cuixx','2018-03-13 10:34:11',NULL,'崔枭雄',NULL),('402882cd5fdc3f4e015fdc5976950005',NULL,1,'留样处样品处理','402882cd5fd6fb99015fd70733240003',NULL,'2',NULL,'tObjectLogController.do?disposingList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'cuixx','2018-03-14 19:43:49',NULL,'崔枭雄',NULL),('402882cd5fe22f0f015fe231cc6c0000',NULL,1,'样品处理审批','402882cd5fd6fb99015fd70733240003',NULL,'4',NULL,'tObjectLogController.do?disposedApprovalList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'cuixx','2018-03-14 22:07:28',NULL,'崔枭雄',NULL),('402882d35ebd7a23015ebd9300530030',NULL,0,'委托/收样',NULL,'','10',NULL,'','8a8ab0b246dc81120146dc8180880007','8a8ab0b246dc81120146dc8181210033',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882d35ebd7a23015ebd9375830032',NULL,1,'工程项目管理','402882d35ebd7a23015ebd9300530030',NULL,'3',NULL,'projectController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,'zhouxb','2018-01-08 10:25:47',NULL,'周晓彬',NULL),('402882d35ebd7a23015ebd93e3720034',NULL,1,'委托单位管理','402882d35ebd7a23015ebd9300530030',NULL,'2',NULL,'consignUnitController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'','admin','管理员',NULL,NULL,'2017-09-26 17:45:39',NULL,NULL),('402882d35ebd7a23015ebd94d5c90039',NULL,1,'送样人员管理','402882d35ebd7a23015ebd9300530030',NULL,'3',NULL,'sampleSenderController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'','admin','管理员',NULL,NULL,'2017-09-26 17:46:41',NULL,NULL),('402882d35ebd7a23015ebd9560d0003b',NULL,1,'委托自定义属性','402882d35ebd7a23015ebd9300530030','','4',NULL,'consignCustomAttributeController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,'zengxb','2019-05-31 15:28:47',NULL,'曾小兵',NULL),('402882d35f003ad7015f003cb0b20001',NULL,2,'标准管理(无用)','402882105e5b5362015e5b55abd60003','','70',NULL,'baseStandardController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-10-09 11:40:16',NULL,'曾继强',NULL),('402882d35f0f3e58015f0f4281a80004',NULL,1,'委托管理','402882d35ebd7a23015ebd9300530030',NULL,'1','consignManagement','consignController.do?goConsignList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,'zhouxb','2018-01-08 10:25:12',NULL,'周晓彬',NULL),('402882d360d3935d0160d39772700008',NULL,0,'试验检测',NULL,'','30',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'fa-flask',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('402882d360d3935d0160d398ddb4000c',NULL,1,'试验任务','402882d360d3935d0160d39772700008',NULL,'1','testTaskMenu','testTaskController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'','zhouxb','周晓彬',NULL,NULL,'2018-01-08 10:28:19',NULL,NULL),('402889fb486e848101486e8de3d60005',NULL,0,'数据权限',NULL,NULL,'999',NULL,'','8a8ab0b246dc81120146dc8180820003','8a8ab0b246dc81120146dc8180dd001e',1,'fa-gears',NULL,NULL,'yefei','2018-01-31 11:13:33',NULL,'叶飞',NULL),('4028948150f5ba6a0150f5d0b0200004',NULL,1,'客户跟踪记录','402880e74d76e784014d76f5505a0012',NULL,'4',NULL,'cgAutoListController.do?list&id=jeecg_custom_record','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028948150f5ba6a0150f5d34aca000a',NULL,1,'客户资料管理','402880e74d76e784014d76f5505a0012',NULL,'5',NULL,'cgAutoListController.do?list&id=jeecg_custom_info','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4028bc934869765001486977f0980001',NULL,2,'多数据源管理','8a8ab0b246dc81120146dc8180d9001d',NULL,'6',NULL,'dynamicDataSourceController.do?dbSource','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-03-10 12:15:41',NULL,'管理员',NULL),('4028ef81535fff5101536001bb8d0005',NULL,1,'招聘管理','402880e74d76e784014d76f5505a0012',NULL,'2',NULL,'cgAutoListController.do?list&id=jform_resume_info','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-03-01 11:51:06',NULL,'管理员',NULL),('4028ef815373fb53015373fef1c50003',NULL,1,'通讯录分组','402880e74d76e784014d76f5505a0012',NULL,'9',NULL,'cgAutoListController.do?list&id=jform_contact_group','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-06-27 18:16:01',NULL,'管理员',NULL),('4028ef815373fb53015373ff521d0005',NULL,1,'通讯录','402880e74d76e784014d76f5505a0012',NULL,'10',NULL,'cgAutoListController.do?list&id=jform_contact','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-06-27 18:16:09',NULL,'管理员',NULL),('4028ef815378741f0153787764cc0004',NULL,1,'移动请假单','402880e74d76e784014d76f5505a0012',NULL,'2',NULL,'cgFormBuildController/ftlForm/jform_leave/goAdd.do?olstylecode=moblieCommon001','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-03-10 18:09:11',NULL,'管理员',NULL),('4028ef815378741f01537879315e0009',NULL,1,'PC请假单','402880e74d76e784014d76f5505a0012',NULL,'2',NULL,'cgFormBuildController/ftlForm/jform_leave/goAddButton.do','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-03-10 18:10:26',NULL,'管理员',NULL),('4028ef815378be7c015378ddc2380001',NULL,1,'3D饼图','4028ef815378be7c015378e019750003',NULL,'7',NULL,'cgDynamGraphController.do?design&id=t_s_log&gtype=Pie3D','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-03-15 14:04:46',NULL,'管理员',NULL),('4028ef815378be7c015378e019750003',NULL,-1,'移动报表',NULL,NULL,'999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-pie-chart',NULL,NULL,'yefei','2018-01-31 11:09:19',NULL,'叶飞',NULL),('4028ef815378be7c015378e0d39d0006',NULL,1,'折线图','4028ef815378be7c015378e019750003',NULL,'1',NULL,'cgDynamGraphController.do?design&id=t_s_log&gtype=LineBasic2D','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-01-12 21:40:11',NULL,'管理员',NULL),('4028ef815378be7c015378e1395d0008',NULL,1,'面积图 ','4028ef815378be7c015378e019750003',NULL,'2',NULL,'cgDynamGraphController.do?design&id=t_s_log&gtype=Area2D','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,'admin','管理员',NULL,NULL,'2016-03-15 14:05:39',NULL,NULL),('4028ef815378be7c015378e19969000a',NULL,1,'条状图','4028ef815378be7c015378e019750003',NULL,'3',NULL,'cgDynamGraphController.do?design&id=t_s_log&gtype=Bar2D','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,'admin','管理员',NULL,NULL,'2016-03-15 14:06:04',NULL,NULL),('4028ef815378be7c015378e207cf000c',NULL,1,'3D柱状图','4028ef815378be7c015378e019750003',NULL,'4',NULL,'cgDynamGraphController.do?design&id=t_s_log&gtype=Column3D','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,'admin','管理员',NULL,NULL,'2016-03-15 14:06:32',NULL,NULL),('4028ef815378be7c015378e27ae5000e',NULL,1,'2D柱状图','4028ef815378be7c015378e019750003',NULL,'5',NULL,'cgDynamGraphController.do?design&id=t_s_log&gtype=Column2D','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,'admin','管理员',NULL,NULL,'2016-03-15 14:07:01',NULL,NULL),('4028ef815378be7c015378e30f760010',NULL,1,'2D饼图','4028ef815378be7c015378e019750003',NULL,'6',NULL,'cgDynamGraphController.do?design&id=t_s_log&gtype=Pie2D','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-03-15 14:12:59',NULL,'管理员',NULL),('4028ef815378be7c015378e3e6530013',NULL,1,'综合报表','4028ef815378be7c015378e019750003',NULL,'8',NULL,'cgDynamGraphController.do?design&id=t_s_log','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,'admin','管理员',NULL,NULL,'2016-03-15 14:08:34',NULL,NULL),('4028ef8155fd32e40155fd33c6670001',NULL,-1,'插件模块',NULL,NULL,'999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-download-alt',NULL,NULL,'yefei','2018-01-31 11:12:47',NULL,'叶飞',NULL),('4028ef8155fd32e40155fd344cdd0003',NULL,1,'普通列表','4028ef8155fd32e40155fd33c6670001',NULL,'1',NULL,'p3/wxActInvite.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-07-22 13:45:46',NULL,'管理员',NULL),('4028ef8155fd32e40155fd344cddd3',NULL,1,'订单管理','4028ef8155fd32e40155fd33c6670001',NULL,'1',NULL,'demo/jpDemoOrderMain.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'admin','2017-03-07 13:50:29',NULL,'管理员',NULL),('4028ef8155fd32e40155fd348df80005',NULL,1,'树形列表','4028ef8155fd32e40155fd33c6670001',NULL,'2',NULL,'p3/auth.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,NULL,NULL,'admin','2016-07-18 16:52:19',NULL,'管理员',NULL),('4028ef8155fd32e40155fd3564520008',NULL,1,'我的邮箱','4028ef8155fd32e40155fd33c6670001',NULL,'3',NULL,'mail/p3MailJformInnerMail.do?toSendMail','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,NULL,'admin','管理员',NULL,NULL,'2016-07-18 16:53:02',NULL,NULL),('4028f6815af3ce54015af3d1ad610001',NULL,-1,'常用示例',NULL,NULL,'999',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-twitch',NULL,NULL,'yefei','2018-01-31 11:11:14',NULL,'叶飞',NULL),('4028f6815af3ce54015af3d1f52c0003',NULL,1,'UI标签','4028f6815af3ce54015af3d1ad610001',NULL,'1',NULL,'jeecgFormDemoController.do?uitag','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-italic',NULL,NULL,'admin','2017-03-22 17:48:16',NULL,'管理员',NULL),('4028f6815af5ca04015af5cbf9300001',NULL,1,'表单校验','4028f6815af3ce54015af3d1ad610001',NULL,'2',NULL,'jeecgFormDemoController.do?formValidDemo','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-table','admin','管理员',NULL,NULL,'2017-03-22 19:34:29',NULL,NULL),('4028f6815af5e479015af5f08dc4001a',NULL,1,'列表标签','4028f6815af3ce54015af3d1ad610001',NULL,'3',NULL,'jeecgListDemoController.do?list','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-list-alt','admin','管理员',NULL,NULL,'2017-03-22 20:14:27',NULL,NULL),('4028f6815af6de95015af6e078420001',NULL,1,'Minidao列表','4028f6815af3ce54015af3d1ad610001',NULL,'5',NULL,'jeecgListDemoController.do?minidaoListDemo','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-dropbox',NULL,NULL,'admin','2017-03-23 16:08:38',NULL,'管理员',NULL),('4028f6815af750eb015af755e1ca0001',NULL,1,'原生态组件','4028f6815af3ce54015af3d1ad610001',NULL,'4',NULL,'jeecgFormDemoController.do?nature','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-bug',NULL,NULL,'admin','2017-03-26 22:42:44',NULL,'管理员',NULL),('4028f6815af9fb56015af9fc51d30001',NULL,1,'自定义查询条件','4028f6815af3ce54015af3d1ad610001',NULL,'6',NULL,'webpage/com/jeecg/demo/taglist_mysearch.html','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-search',NULL,NULL,'admin','2017-08-15 11:11:38',NULL,'管理员',NULL),('4028f6815afa8964015afa8a63e20001',NULL,1,'行编辑','4028f6815af3ce54015af3d1ad610001',NULL,'8',NULL,'jeecgListDemoController.do?rowListDemo','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-frown','admin','管理员',NULL,NULL,'2017-03-23 17:40:57',NULL,NULL),('4028f6815b0b1017015b0b1265cf0002',NULL,1,'日志报表','4028f6815af3ce54015af3d1ad610001',NULL,'9',NULL,'jeecgListDemoController.do?log','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'icon-table',NULL,NULL,'admin','2017-03-26 22:43:57',NULL,'管理员',NULL),('5f2c3675c0fa11eab61fb8ca3a6052ac',NULL,2,'资料归档详情新增资料项','4028826373219d0d017321b29a6a0001','资料归档详情[新增资料项]按钮','50','detailItemAdd','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:07:56',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('760ab956c0fb11eab61fb8ca3a6052ac',NULL,2,'资料归档详情资料项和周期删除','4028826373219d0d017321b29a6a0001','资料归档详情资料项和周期[删除]按钮','70','detailItemAndCycleDelete','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:15:44',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('843cf96eaae64133ba959d6806db50b7',NULL,1,'报告盖章管理','402882cc5e2d0e90015e2d36e62d0004','','40',NULL,'reportStampController.do?goReportStampList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'zjq','2019-05-29 09:57:48',NULL,'曾继强',NULL),('873d64afc0fa11eab61fb8ca3a6052ac',NULL,2,'资料归档详情资料项和周期编辑','4028826373219d0d017321b29a6a0001','资料归档详情资料项和周期[编辑]按钮','60','detailItemAndCycleUpdate','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:09:03',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('8a8ab0b246dc81120146dc8180ce0019',NULL,-1,'在线开发',NULL,NULL,'999',NULL,'','8a8ab0b246dc81120146dc8180890008','8a8ab0b246dc81120146dc8180dd001e',0,'fa-cloud',NULL,NULL,'yefei','2018-01-31 11:10:19',NULL,'叶飞',NULL),('8a8ab0b246dc81120146dc8180d2001a',NULL,0,'系统管理',NULL,'','90',NULL,'','8a8ab0b246dc81120146dc8180860006','8a8ab0b246dc81120146dc8180dd001e',0,'fa-cogs',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8180d4001b',NULL,-1,'统计报表',NULL,NULL,'999',NULL,'','8a8ab0b246dc81120146dc8180890008','8a8ab0b246dc81120146dc8180dd001e',0,'fa-bar-chart-o',NULL,NULL,'yefei','2018-01-31 11:09:35',NULL,'叶飞',NULL),('8a8ab0b246dc81120146dc8180d9001d',NULL,1,'系统监控','402882206a67ed0d016a6806c82b0000','','70',NULL,'','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'fa-headphones',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8180df001f',NULL,1,'用户管理','2c98b9136f26e10d016f26f5df0f00cb','','60',NULL,'userController.do?user','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8180e30021',NULL,1,'角色管理','2c98b9136f26e10d016f26f5df0f00cb','','30',NULL,'roleController.do?role','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180e10020',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8180e70023',NULL,1,'菜单管理','402882206a67ed0d016a6806c82b0000','','50',NULL,'functionController.do?function','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180e50022',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8180ee0025',NULL,1,'数据字段配置','2c98b9136f26e10d016f26f5df0f00cb','','100',NULL,'systemController.do?typeGroupList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180eb0024',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8180f30027',NULL,1,'系统图标','402882206a67ed0d016a6806c82b0000','','60',NULL,'iconController.do?icon','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180f00026',0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8180f60028',NULL,2,'组织机构','402882206a05e84e016a060a53e6000b',NULL,'4',NULL,'departController.do?depart','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8180dd001e',0,'',NULL,NULL,'yefei','2018-02-01 11:29:21',NULL,'叶飞',NULL),('8a8ab0b246dc81120146dc8180fe002b',NULL,1,'用户分析','8a8ab0b246dc81120146dc8180d4001b',NULL,'1',NULL,'logController.do?statisticTabs&isIframe','8a8ab0b246dc81120146dc8180810002','8a8ab0b246dc81120146dc8180fb002a',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc818106002d',NULL,1,'智能表单配置','8a8ab0b246dc81120146dc8180ce0019',NULL,'1',NULL,'cgFormHeadController.do?cgFormHeadList','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc818102002c',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc818109002e',NULL,1,'Online报表配置','8a8ab0b246dc81120146dc8180ce0019',NULL,'3',NULL,'cgreportConfigHeadController.do?cgreportConfigHead','8a8ab0b246dc81120146dc8180460000',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8181100030',NULL,2,'数据监控','8a8ab0b246dc81120146dc8180d9001d',NULL,'1',NULL,'dataSourceController.do?goDruid&isIframe','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc81810d002f',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc81811d0032',NULL,2,'系统日志','8a8ab0b246dc81120146dc8180d9001d',NULL,'2',NULL,'logController.do?log','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8181150031',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('8a8ab0b246dc81120146dc8181250034',NULL,2,'定时任务','8a8ab0b246dc81120146dc8180d9001d',NULL,'3',NULL,'timeTaskController.do?timeTask','8a8ab0b246dc81120146dc8180460000','8a8ab0b246dc81120146dc8181210033',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('c3169322c0fa11eab61fb8ca3a6052ac',NULL,2,'资料归档详情档案新增','4028826373219d0d017321b29a6a0001','资料归档详情档案[新增]按钮','80','detailItemDataAdd','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:10:43',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('d22ec830c0fa11eab61fb8ca3a6052ac',NULL,2,'资料归档详情档案编辑','4028826373219d0d017321b29a6a0001','资料归档详情档案[编辑]按钮','90','detailItemDataUpdate','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:11:09',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp'),('dbcccc2dc0fa11eab61fb8ca3a6052ac',NULL,2,'资料归档详情档案删除','4028826373219d0d017321b29a6a0001','资料归档详情档案[删除]按钮','90','detailItemDataDelete','','8a8ab0b246dc81120146dc8180460000',NULL,1,'','lifei','海特李飞',NULL,NULL,'2020-07-08 17:11:25',NULL,'http://192.168.2.3:8801/fileShare/A03/images/2020/5485c60e-7ab4-4647-b616-d2214ca6cf24.bmp');
/*!40000 ALTER TABLE `t_s_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_type`
--

DROP TABLE IF EXISTS `t_s_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_type` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `typecode` varchar(50) DEFAULT NULL COMMENT '字典编码',
  `typename` varchar(50) DEFAULT NULL COMMENT '字典名称',
  `typepid` varchar(32) DEFAULT NULL COMMENT '无用字段',
  `typegroupid` varchar(32) DEFAULT NULL COMMENT '字典组ID',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(36) DEFAULT NULL COMMENT '创建用户',
  `desc` varchar(100) DEFAULT NULL COMMENT '描述',
  `source_from` varchar(10) NOT NULL COMMENT '数据来源: 1:系统, 2:用户',
  `order_number` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000' COMMENT '排序号',
  PRIMARY KEY (`ID`),
  KEY `FK_nw2b22gy7plh7pqows186odmq` (`typepid`) USING BTREE,
  KEY `FK_3q40mr4ebtd0cvx79matl39x1` (`typegroupid`) USING BTREE,
  CONSTRAINT `t_s_type_ibfk_1` FOREIGN KEY (`typegroupid`) REFERENCES `t_s_typegroup` (`ID`),
  CONSTRAINT `t_s_type_ibfk_2` FOREIGN KEY (`typepid`) REFERENCES `t_s_type` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 599040 kB; (`typegroupid`) REFER `jeecg/t_s_typ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_type`
--

LOCK TABLES `t_s_type` WRITE;
/*!40000 ALTER TABLE `t_s_type` DISABLE KEYS */;
INSERT INTO `t_s_type` VALUES ('1338860d5f4048a89960e84cdfdd12bb','FeeReType','报告重打费用',NULL,'afd95249560b431889866e4c42a4b824','2018-08-01 13:33:43','魏衡',NULL,'1',00000000000),('1371dc58d577413988cd53545312fc02','genjurenwuidhuoquzizhizhangtupianlujing','根据任务ID获取资质章图片路径',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('297e201047e95ee30147e9baab5c000b','1','common.company',NULL,'297e201047e95ee30147e9ba56ce0009','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('297e201047e95ee30147e9baef97000d','2','common.department',NULL,'297e201047e95ee30147e9ba56ce0009','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('297e201047e95ee30147e9bb1210000f','3','common.position',NULL,'297e201047e95ee30147e9ba56ce0009','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('2c90ac564c9d1734014c9db1e025002d','Y','是',NULL,'2c90ac564c9d1734014c9db1a167002b','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('2c90ac564c9d1734014c9db20b0d002f','N','否',NULL,'2c90ac564c9d1734014c9db1a167002b','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('2c98b9136db4683b016db89296f8005c','10','检测设备',NULL,'402882206b72e01e016b72f8bfd80001','2019-10-11 10:07:58','曾继强',NULL,'2',00000000000),('2c98b9136db4683b016db8a99d5100b4','5','比对',NULL,'402882cd5f998a58015f998cea300000','2019-10-11 10:33:07','曾继强',NULL,'2',00000000000),('2c98b9136db4683b016db8aa697b00b6','6','核查',NULL,'402882cd5f998a58015f998cea300000','2019-10-11 10:33:59','曾继强',NULL,'2',00000000000),('2c98b9136db4683b016db931d14c00bc','7','/',NULL,'402882cd5f998a58015f998cea300000','2019-10-11 13:01:53','曾继强',NULL,'2',00000000000),('2c98b91370c8f1110170cdf4d15321c2','8','辅助设备',NULL,'402882cd5f998a58015f998cea300000','2020-03-12 16:55:39','管理员',NULL,'2',00000000009),('2c98b913710b16300171102f1a2047a3','个','个',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-03-25 13:34:15','管理员',NULL,'2',00000000016),('2c98b913710b16300171102f6f3047a5','副','副',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-03-25 13:34:36','管理员',NULL,'2',00000000017),('2c98b913710b163001711067890e519a','套','套',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-03-25 14:35:53','管理员',NULL,'2',00000000019),('379875e094b1433c8ddb7c6a5ba0550b','weituodanzhubiao','委托单主表',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('402880884883eff4014884180bf80029','1','蔷薇七村',NULL,'402880884883eff401488415cbb60027','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402880cd4dbd4baa014dbd9c184f0003','WXTP','图片',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881a151f1af7c0151f1bb1b520004','cigong','辞工',NULL,'402881a151f1af7c0151f1b9d7f50002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881a151f1af7c0151f1bc55b10006','jicigong','急辞工',NULL,'402881a151f1af7c0151f1b9d7f50002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881a151f1af7c0151f1bca0680008','citui','辞退',NULL,'402881a151f1af7c0151f1b9d7f50002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881a151f1af7c0151f1bcbf62000a','kaichu','开除',NULL,'402881a151f1af7c0151f1b9d7f50002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881a151f1af7c0151f1bce839000c','zidonglizhi','自动离职',NULL,'402881a151f1af7c0151f1b9d7f50002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e44df713f5014df73ef09a003d','table','form.db.type.table',NULL,'402881e44df713f5014df738349c002f','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e44df713f5014df73f1436003f','sql','form.db.type.sql',NULL,'402881e44df713f5014df738349c002f','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e44df713f5014df73f3f830041','clazz','form.db.type.clazz',NULL,'402881e44df713f5014df738349c002f','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e54dcb624a014dcbf65e5a0010','bdfl_ptbd','普通表单',NULL,'402881e54dcb624a014dcbf4912b000e','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e54dcb624a014dcbf6a4620012','bdfl_fzbd','复杂表单',NULL,'402881e54dcb624a014dcbf4912b000e','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e54dce16ba014dce17990c0001','bdfl_vipbd','VIP表单',NULL,'402881e54dcb624a014dcbf4912b000e','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e55af64f07015af683bd930006','text','单行文本输入框',NULL,'402881e55af64f07015af68356550004','2017-03-22 22:55:13','管理员',NULL,'1',00000000000),('402881e55af64f07015af683f8910008','textarea','多行文本输入框',NULL,'402881e55af64f07015af68356550004','2017-03-22 22:55:28','管理员',NULL,'1',00000000000),('402881e55af64f07015af6866f2f000a','select','下拉菜单',NULL,'402881e55af64f07015af68356550004','2017-03-22 22:58:10','管理员',NULL,'1',00000000000),('402881e55af64f07015af686a8ca000c','radios','单选框',NULL,'402881e55af64f07015af68356550004','2017-03-22 22:58:25','管理员',NULL,'1',00000000000),('402881e55af64f07015af686eb55000e','checkboxs','复选框',NULL,'402881e55af64f07015af68356550004','2017-03-22 22:58:42','管理员',NULL,'1',00000000000),('402881e55af64f07015af689cf09001a','button','Button按钮控件',NULL,'402881e55af64f07015af68356550004','2017-03-22 23:01:51','管理员',NULL,'1',00000000000),('402881e55b05c578015b060cbe480009','timeText','时间控件精确秒',NULL,'402881e55af64f07015af68356550004','2017-03-25 23:19:10','管理员',NULL,'1',00000000000),('402881e55b05c578015b060d087f000b','dateText','时间控件精确天',NULL,'402881e55af64f07015af68356550004','2017-03-25 23:19:29','管理员',NULL,'1',00000000000),('402881e64ca6fd1b014ca7052d930006','spline','曲线图',NULL,'402881e64ca6fd1b014ca7044c370004','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e64ca6fd1b014ca705b2b40008','column','柱状图',NULL,'402881e64ca6fd1b014ca7044c370004','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e64ca6fd1b014ca7061fb7000a','pie','饼图',NULL,'402881e64ca6fd1b014ca7044c370004','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e946e71f5f0146e736c4e80008','en','common.english',NULL,'402881e946e71f5f0146e73619bb0002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402881e946e71f5f0146e740dcad0012','zh-cn','common.chinese',NULL,'402881e946e71f5f0146e73619bb0002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('40288201730d2a8701730e2ab8810106','长度单位比较长','长度单位比较长',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-07-02 14:15:48','管理员',NULL,'2',00000000010),('4028820e6b968713016b96e602300008','pdf','PDF',NULL,'BC5D57506F5F4E9090F77148458C7726','2019-06-27 11:06:25','魏衡',NULL,'1',00000000000),('4028820e6b968713016b96e66585000a','origin','原文件',NULL,'BC5D57506F5F4E9090F77148458C7726','2019-06-27 11:06:50','魏衡',NULL,'1',00000000000),('402882105e4beb0c015e4c073b6e0008','TermQualification','资质类型',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:34:56','管理员',NULL,'1',00000000000),('402882105e4beb0c015e4c09418a000a','TermTestCategories','检测大类',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:37:09','管理员',NULL,'1',00000000000),('402882105e4beb0c015e4c0a13a3000c','TermText','固定字符',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:38:02','管理员',NULL,'1',00000000000),('402882105e4beb0c015e4c0a5ea4000e','TermYear','年份',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:38:22','管理员',NULL,'1',00000000000),('402882105e4beb0c015e4c0b04300010','TermSerialNumber','自增长数字',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:39:04','管理员',NULL,'1',00000000000),('402882105e4beb0c015e4c0b5dea0012','TermTestOrg','检测科室',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:39:27','管理员',NULL,'1',00000000000),('402882105e4beb0c015e4c0c46620016','TermMonth','月份',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:40:26','管理员',NULL,'1',00000000000),('402882105e4beb0c015e4c0c7fe50018','TermDay','日',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:40:41','管理员',NULL,'1',00000000000),('402882105e4beb0c015e4c0ce934001a','TermTestType','检测类别',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-04 16:41:08','管理员',NULL,'1',00000000000),('402882105e551b4c015e55208dcc000a','0','正常',NULL,'402882105e551b4c015e551f619b0007','2017-09-06 10:59:10','管理员',NULL,'1',00000000000),('402882105e551b4c015e55218c37000f','1','启用时间执行',NULL,'402882105e551b4c015e551f619b0007','2017-09-06 11:00:16','管理员',NULL,'1',00000000000),('402882105e551b4c015e5521d5150011','2','停用时间停止',NULL,'402882105e551b4c015e551f619b0007','2017-09-06 11:00:34','管理员',NULL,'1',00000000000),('402882105e551b4c015e552296850013','3','启停时间段内执行',NULL,'402882105e551b4c015e551f619b0007','2017-09-06 11:01:24','管理员',NULL,'1',00000000000),('402882105e551b4c015e5522b88f0015','9','停用',NULL,'402882105e551b4c015e551f619b0007','2017-09-06 11:01:32','管理员',NULL,'1',00000000000),('402882105e551b4c015e554eb6310022','consign','委托编号',NULL,'402882105e551b4c015e5547f1ea001e','2017-09-06 11:49:35','管理员',NULL,'1',00000000000),('402882105e551b4c015e554f68ff0024','sample','样品编号',NULL,'402882105e551b4c015e5547f1ea001e','2017-09-06 11:50:21','管理员',NULL,'1',00000000000),('402882105e551b4c015e554fa5500026','task','任务编号',NULL,'402882105e551b4c015e5547f1ea001e','2017-09-06 11:50:37','管理员',NULL,'1',00000000000),('402882105e551b4c015e554fd9880028','report','报告编号',NULL,'402882105e551b4c015e5547f1ea001e','2017-09-06 11:50:50','管理员',NULL,'1',00000000000),('402882105e551b4c015e5550dc43002a','record','记录编号',NULL,'402882105e551b4c015e5547f1ea001e','2017-09-06 11:51:56','管理员',NULL,'1',00000000000),('402882105e551b4c015e5550dc43002b','tempReport','临时报告编号',NULL,'402882105e551b4c015e5547f1ea001e','2017-09-06 11:51:56','管理员','','1',00000000000),('402882105ebcb7b2015ebcf0dfe0000d','1','已结清',NULL,'402882105ebcb7b2015ebcf09204000b','2017-09-26 14:47:36','叶飞',NULL,'1',00000000000),('402882105ebcb7b2015ebcf10bcf000f','2','部分缴费',NULL,'402882105ebcb7b2015ebcf09204000b','2017-09-26 14:47:47','叶飞',NULL,'1',00000000000),('402882105ebcb7b2015ebcf132010011','3','未缴费',NULL,'402882105ebcb7b2015ebcf09204000b','2017-09-26 14:47:57','叶飞',NULL,'1',00000000000),('402882105ebd052e015ebd100b0b0016','FeeConsign','委托收费',NULL,'402882105ebd052e015ebd0ed1e00014','2017-09-26 15:21:39','叶飞',NULL,'1',00000000000),('402882105ebd052e015ebd10a03b0018','FeeContract','合同收费',NULL,'402882105ebd052e015ebd0ed1e00014','2017-09-26 15:22:17','叶飞',NULL,'1',00000000000),('402882105ebd052e015ebd1117b4001a','FeeReType','重打收费',NULL,'402882105ebd052e015ebd0ed1e00014','2017-09-26 15:22:48','叶飞',NULL,'1',00000000000),('402882105ebd052e015ebd1ca159002e','1','收费',NULL,'402882105ebd052e015ebd1c7a3b002c','2017-09-26 15:35:24','叶飞',NULL,'1',00000000000),('402882105ebd052e015ebd1cca070030','2','退费',NULL,'402882105ebd052e015ebd1c7a3b002c','2017-09-26 15:35:34','叶飞',NULL,'1',00000000000),('402882105ec22504015ec23ef417000d','1','启用',NULL,'402882105ec22504015ec23ed20b000b','2017-09-27 15:30:59','叶飞',NULL,'1',00000000000),('402882105ec22504015ec23f45660012','2','停用',NULL,'402882105ec22504015ec23ed20b000b','2017-09-27 15:31:20','叶飞',NULL,'1',00000000000),('402882105ed0398d015ed1907650003f','1','公路',NULL,'402882105ed0398d015ed19040c6003d','2017-09-30 14:54:19','叶飞',NULL,'1',00000000000),('402882105ed0398d015ed190934a0041','2','水运',NULL,'402882105ed0398d015ed19040c6003d','2017-09-30 14:54:27','叶飞',NULL,'1',00000000000),('402882105f482f9a015f483e0cba0009','FeeDetailTransfer','转账',NULL,'402882105f482f9a015f483cea1a0005','2017-10-23 15:59:07','叶飞',NULL,'1',00000000000),('402882105f482f9a015f483eaca8000c','FeeDetailCheck','支票',NULL,'402882105f482f9a015f483cea1a0005','2017-10-23 15:59:48','叶飞',NULL,'1',00000000000),('402882105f482f9a015f483ee989000e','FeeDetailCash','现金',NULL,'402882105f482f9a015f483cea1a0005','2017-10-23 16:00:03','叶飞',NULL,'1',00000000000),('402882105f4db238015f4de44d640004','1','启用',NULL,'402882105f4db238015f4de414f70002','2017-10-24 18:18:49','叶飞',NULL,'1',00000000000),('402882105f4db238015f4de487b10006','0','停用',NULL,'402882105f4db238015f4de414f70002','2017-10-24 18:19:03','叶飞',NULL,'1',00000000000),('402882105f70012e015f716d369000af','1','普通发票',NULL,'402882105f70012e015f716ce30e00ad','2017-10-31 15:55:04','叶飞',NULL,'1',00000000000),('402882105f70012e015f716d66eb00b1','2','专用发票',NULL,'402882105f70012e015f716ce30e00ad','2017-10-31 15:55:16','叶飞',NULL,'1',00000000000),('402882105f70012e015f716da4c900b3','1','正常',NULL,'402882105f70012e015f716b9c0d00ab','2017-10-31 15:55:32','叶飞',NULL,'1',00000000000),('402882105f70012e015f716dbb0c00b5','2','作废',NULL,'402882105f70012e015f716b9c0d00ab','2017-10-31 15:55:38','叶飞',NULL,'1',00000000000),('402882105f70012e015f716dd20e00b7','3','冲红',NULL,'402882105f70012e015f716b9c0d00ab','2017-10-31 15:55:44','叶飞',NULL,'1',00000000000),('402882105fdc8297015fdcad6cdb0008','1','全包合同',NULL,'402882105fdc8297015fdcabfe8e0006','2017-11-21 11:44:34','叶飞',NULL,'1',00000000000),('402882105fdc8297015fdcadca57000a','2','折扣合同',NULL,'402882105fdc8297015fdcabfe8e0006',NULL,NULL,NULL,'1',00000000000),('402882105fdc8297015fdcb11aee000c','3','指定参数折扣',NULL,'402882105fdc8297015fdcabfe8e0006','2017-11-21 11:48:35','叶飞',NULL,'1',00000000000),('402882105fdd6b42015fde49ffbe0004','1','正常',NULL,'402882105fdc8297015fdcabc07a0004','2017-11-21 19:15:12','叶飞',NULL,'1',00000000000),('402882105fdd6b42015fde4a3b150006','2','终止',NULL,'402882105fdc8297015fdcabc07a0004','2017-11-21 19:15:28','叶飞',NULL,'1',00000000000),('402882105fdd6b42015fde4a628e0008','3','审核中',NULL,'402882105fdc8297015fdcabc07a0004','2017-11-21 19:15:38','叶飞',NULL,'1',00000000000),('402882105fdd6b42015fde4a93b8000a','4','审核未通过',NULL,'402882105fdc8297015fdcabc07a0004','2017-11-21 19:15:50','叶飞',NULL,'1',00000000000),('402882105fec75ec015fed0f3bb4000b','4','指定参数价格',NULL,'402882105fdc8297015fdcabfe8e0006',NULL,NULL,NULL,'1',00000000000),('40288210611232ec0161123f4bdd0000','FeeDetailCredit','信用',NULL,'402882105f482f9a015f483cea1a0005','2018-01-20 14:26:34','叶飞',NULL,'1',00000000000),('4028821062b9b6ec0162b9b979ac0002','1','平均分配',NULL,'4028821062b9b6ec0162b9b91c690000','2018-04-12 19:59:23','叶飞',NULL,'1',00000000000),('4028821062b9b6ec0162b9b9c67d0004','2','能者多劳',NULL,'4028821062b9b6ec0162b9b91c690000','2018-04-12 19:59:43','叶飞',NULL,'1',00000000000),('4028821062b9b6ec0162b9b9f8670006','3','随机分配',NULL,'4028821062b9b6ec0162b9b91c690000','2018-04-12 19:59:55','叶飞',NULL,'1',00000000000),('4028821062b9b6ec0162b9ba385b0008','4','空闲分配',NULL,'4028821062b9b6ec0162b9b91c690000','2018-04-12 20:00:12','叶飞',NULL,'1',00000000000),('4028821062f545d70162f58e6d3a00ab','0','不默认',NULL,'4028821062f545d70162f58de4fd00a9','2018-04-24 10:49:35','叶飞',NULL,'1',00000000000),('4028821062f545d70162f58e942600ad','1','按检测参数默认',NULL,'4028821062f545d70162f58de4fd00a9','2018-04-24 10:49:45','叶飞',NULL,'1',00000000000),('4028821062f545d70162f58eedb500af','2','单位检测参数默认',NULL,'4028821062f545d70162f58de4fd00a9','2018-04-24 10:50:08','叶飞',NULL,'1',00000000000),('4028821e6ea5bc4b016ea642a48f0011','交工检测','交工检测',NULL,'4028821e6ea5bc4b016ea642236b000f','2019-11-26 13:50:16','管理员',NULL,'2',00000000000),('4028821e6ea5bc4b016ea642cc810013','竣工检测','竣工检测',NULL,'4028821e6ea5bc4b016ea642236b000f','2019-11-26 13:50:26','管理员',NULL,'2',00000000000),('4028821e6ea5bc4b016ea642ee5a0015','材料检测','材料检测',NULL,'4028821e6ea5bc4b016ea642236b000f','2019-11-26 13:50:35','管理员',NULL,'2',00000000000),('4028821e6ea5bc4b016ea64332e70017','地质预报','地质预报',NULL,'4028821e6ea5bc4b016ea642236b000f','2019-11-26 13:50:52','管理员',NULL,'2',00000000000),('4028821e6ea5bc4b016ea6459038001b','高速公路','高速公路',NULL,'4028821e6ea5bc4b016ea643bdb10019','2019-11-26 13:53:27','管理员',NULL,'2',00000000000),('4028821e6ea5bc4b016ea645d2e7001d','一级路','一级路',NULL,'4028821e6ea5bc4b016ea643bdb10019','2019-11-26 13:53:44','管理员',NULL,'2',00000000000),('4028821e6ea5bc4b016ea645f5b7001f','二级路','二级路',NULL,'4028821e6ea5bc4b016ea643bdb10019','2019-11-26 13:53:53','管理员',NULL,'2',00000000000),('4028821e6ea5bc4b016ea64613ea0021','国道','国道',NULL,'4028821e6ea5bc4b016ea643bdb10019','2019-11-26 13:54:01','管理员',NULL,'2',00000000000),('4028821e6ea5bc4b016ea64638d30023','市政道路','市政道路',NULL,'4028821e6ea5bc4b016ea643bdb10019','2019-11-26 13:54:10','管理员',NULL,'2',00000000000),('4028821e6eb14554016eb1e014780008','试验检测工程师','试验检测工程师',NULL,'4028821e6eb14554016eb1dfd7d80006','2019-11-28 19:58:03','管理员',NULL,'2',00000000000),('4028821e6eb14554016eb1e03854000a','试验检测员','试验检测员',NULL,'4028821e6eb14554016eb1dfd7d80006','2019-11-28 19:58:12','管理员',NULL,'2',00000000000),('4028821e6eb14554016eb1e1413d000e','道路工程','道路工程',NULL,'4028821e6eb14554016eb1e11006000c','2019-11-28 19:59:20','管理员',NULL,'2',00000000000),('4028821e6eb14554016eb1e16d060010','桥梁隧道工程','桥梁隧道工程',NULL,'4028821e6eb14554016eb1e11006000c','2019-11-28 19:59:31','管理员',NULL,'2',00000000000),('4028821e6eb14554016eb1e196cb0012','交通工程','交通工程',NULL,'4028821e6eb14554016eb1e11006000c','2019-11-28 19:59:42','管理员',NULL,'2',00000000000),('4028821e6eb14554016eb1e1c04f0014','水运材料','水运材料',NULL,'4028821e6eb14554016eb1e11006000c','2019-11-28 19:59:52','管理员',NULL,'2',00000000000),('4028821e6eb14554016eb1e1fe320016','水运结构与地基','水运结构与地基',NULL,'4028821e6eb14554016eb1e11006000c','2019-11-28 20:00:08','管理员',NULL,'2',00000000000),('402882206762317b016762734fe70004','EC_SF','顺丰速运',NULL,'402882206762317b0167626787270002','2018-11-30 10:29:44','李丽峰',NULL,'1',00000000000),('402882206762317b01676273bb0e0006','EC_YZ','邮政快递',NULL,'402882206762317b0167626787270002','2018-11-30 10:30:11','李丽峰',NULL,'1',00000000000),('402882206762317b01676273f41a0008','EC_YT','圆通快递',NULL,'402882206762317b0167626787270002','2018-11-30 10:30:26','李丽峰',NULL,'1',00000000000),('402882206762317b016762744f51000a','EC_ST','申通快递',NULL,'402882206762317b0167626787270002','2018-11-30 10:30:49','李丽峰',NULL,'1',00000000000),('402882206762317b01676274870b000c','EC_YD','韵达快递',NULL,'402882206762317b0167626787270002','2018-11-30 10:31:03','李丽峰',NULL,'1',00000000000),('402882206762317b0167627503cc000e','EC_HT','汇通快递',NULL,'402882206762317b0167626787270002','2018-11-30 10:31:35','李丽峰',NULL,'1',00000000000),('402882206762317b0167627549220010','EC_ZT','中通快递',NULL,'402882206762317b0167626787270002','2018-11-30 10:31:53','李丽峰',NULL,'1',00000000000),('402882206762317b01676275949b0012','EC_ZJS','宅急送',NULL,'402882206762317b0167626787270002','2018-11-30 10:32:12','李丽峰',NULL,'1',00000000000),('402882206762317b01676275e0b20014','EC_TT','天天快递',NULL,'402882206762317b0167626787270002','2018-11-30 10:32:32','李丽峰',NULL,'1',00000000000),('402882206b72e01e016b737a405e000b','0','未借出',NULL,'402882206b72e01e016b7379c5e70009','2019-06-20 14:02:00','李丽峰',NULL,'1',00000000000),('402882206b72e01e016b737a63e3000d','1','借出',NULL,'402882206b72e01e016b7379c5e70009','2019-06-20 14:02:09','李丽峰',NULL,'1',00000000000),('402882206b72e01e016b737aa580000f','2','出租',NULL,'402882206b72e01e016b7379c5e70009','2019-06-20 14:02:26','李丽峰',NULL,'1',00000000000),('402882206b72e01e016b737add9d0011','3','内部借用',NULL,'402882206b72e01e016b7379c5e70009','2019-06-20 14:02:40','李丽峰',NULL,'1',00000000000),('402882206b72e01e016b737baba00016','1','正常',NULL,'402882cd5f998a58015f9998ff71001b','2019-06-20 14:03:33','李丽峰',NULL,'1',00000000000),('402882206b72e01e016b737bd52f0018','2','已停用',NULL,'402882cd5f998a58015f9998ff71001b','2019-06-20 14:03:44','李丽峰',NULL,'1',00000000000),('402882206fabef6f016fac6883a70002','g','g',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:32:08','管理员',NULL,'1',00000000000),('402882206fabef6f016fac68a2430004','kg','kg',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:32:16','管理员',NULL,'1',00000000001),('40288220719b2d1101719bbd5fcf0001','serious','严重',NULL,'8a8ab0b246dc81120146dc8181cd005g','2020-04-21 15:56:52','李丽峰',NULL,'2',00000000001),('40288220719b2d1101719bbdf3d00003','general','一般',NULL,'8a8ab0b246dc81120146dc8181cd005g','2020-04-21 15:57:29','李丽峰',NULL,'2',00000000002),('40288220719b2d1101719bbf08370005','notTarget','欠缺',NULL,'8a8ab0b246dc81120146dc8181cd005g','2020-04-21 15:58:40','李丽峰',NULL,'2',00000000003),('4028824760777e200160778507380001','0','类别1',NULL,'40288247607719500160773198bb0004','2017-12-21 13:21:35','管理员',NULL,'1',00000000000),('4028824760777e200160778530b10003','1','类别2',NULL,'40288247607719500160773198bb0004','2017-12-21 13:21:46','管理员',NULL,'1',00000000000),('4028825a71b952640171b97f4e6600f9','TermTestObjectCode','样品编号',NULL,'402882105e4beb0c015e4c04432e0006','2020-04-27 10:37:40','海特江良',NULL,'2',00000000000),('4028825a72a0ee350172a16667190057','40*80','大标签',NULL,'0c084cfcab9211eab61fb8ca3a6052ac','2020-06-11 11:22:22','海特江良',NULL,'2',00000000001),('4028825a72a0ee350172a166b85f0059','40*60','小标签',NULL,'0c084cfcab9211eab61fb8ca3a6052ac','2020-06-11 11:22:43','海特江良',NULL,'2',00000000002),('4028825a72baa1ec0172baff89960031','project','项目',NULL,'8e42d660af6f11eab61fb8ca3a6052ac','2020-06-16 10:40:09','海特江良',NULL,'2',00000000010),('4028825a72baa1ec0172bb0099c80033','standard','标准',NULL,'8e42d660af6f11eab61fb8ca3a6052ac','2020-06-16 10:41:18','海特江良',NULL,'2',00000000020),('4028825a72dae3e30172daeb653f0000','1','自定义字符',NULL,'ffaf79d6b45811eab61fb8ca3a6052ac','2020-06-22 15:25:59','海特唐金玉',NULL,'2',00000000010),('4028825a72dae3e30172daeb8b3b0002','2','以下空白章',NULL,'ffaf79d6b45811eab61fb8ca3a6052ac','2020-06-22 15:26:09','海特唐金玉',NULL,'2',00000000020),('4028825a72dae3e30172daebc1fd0004','3','从左下到右上的斜线',NULL,'ffaf79d6b45811eab61fb8ca3a6052ac','2020-06-22 15:26:23','海特唐金玉',NULL,'2',00000000030),('4028825a72dae3e30172daebf39a0006','4','从左上到右下的斜线',NULL,'ffaf79d6b45811eab61fb8ca3a6052ac','2020-06-22 15:26:36','海特唐金玉',NULL,'2',00000000040),('402882636fabe810016fac6f41150001','t','t',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:39:30','海特李飞',NULL,'1',00000000002),('402882636fabe810016fac6f66890003','km','km',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:39:40','海特李飞',NULL,'1',00000000003),('402882636fabe810016fac6f892b0005','m','m',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:39:48','海特李飞',NULL,'1',00000000004),('402882636fabe810016fac6fa4d90007','mm','mm',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:39:55','海特李飞',NULL,'1',00000000005),('402882636fabe810016fac70c62d0009','㎡','㎡',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:41:10','海特李飞',NULL,'1',00000000006),('402882636fabe810016fac70fd4e000b','m³','m³',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:41:24','海特李飞',NULL,'1',00000000007),('402882636fabe810016fac71213e000d','cm','cm',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:41:33','海特李飞',NULL,'1',00000000008),('402882636fabe810016fac714138000f','cm³','cm³',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:41:41','海特李飞',NULL,'1',00000000009),('402882636fabe810016fac71d4450012','L','L',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:42:19','海特李飞',NULL,'1',00000000010),('402882636fabe810016fac71f9b00014','桶','桶',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:42:28','海特李飞',NULL,'1',00000000011),('402882636fabe810016fac72180e0016','卷','卷',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:42:36','海特李飞',NULL,'1',00000000012),('402882636fabe810016fac7233640018','块','块',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:42:43','海特李飞',NULL,'1',00000000013),('402882636fabe810016fac725180001a','根','根',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:42:51','海特李飞',NULL,'1',00000000014),('402882636fabe810016fac727bf3001c','组','组',NULL,'8a8ab0b246dc81120146dc8181c3006d','2020-01-16 11:43:02','海特李飞',NULL,'1',00000000015),('40288263722bd2c701722bde53c10002','collecting','领用',NULL,'f852d85d47ed64a40147ed70894c0005','2020-05-19 15:38:10','管理员',NULL,'2',00000000001),('40288263722bd2c701722bdf3d3f0004','discard','损耗（废弃）',NULL,'f852d85d47ed64a40147ed70894c0005','2020-05-19 15:39:10','管理员',NULL,'2',00000000002),('40288263722bd2c701722be0d35f0006','overdue','损耗（过保质期失效）',NULL,'f852d85d47ed64a40147ed70894c0005','2020-05-19 15:40:54','管理员',NULL,'2',00000000003),('4028826372ca660f0172cb31538b0038','1','设备资产报废',NULL,'402882206b72e01e016b72f8bfd800x1','2020-06-19 14:08:27','李丽峰',NULL,'1',00000000001),('4028826372ca660f0172cb321bc1003a','2','设备实体报废',NULL,'402882206b72e01e016b72f8bfd800x1','2020-06-19 14:09:18','李丽峰',NULL,'1',00000000002),('402882845e5f0f05015e5f122ed60003','TermTestParams','检测参数',NULL,'402882105e4beb0c015e4c04432e0006','2017-09-08 09:19:41','管理员',NULL,'1',00000000000),('402882845e5f0f05015e5f122ed60007','TermReportCode','正式报告编码',NULL,'402882105e4beb0c015e4c04432e0006','2020-03-02 14:34:41','管理员',NULL,'1',00000000040),('402882846e7c792d016e7c8925d5000d','transportationSection','交通厅科技项目',NULL,'402882846e7c792d016e7c8606340005','2019-11-18 11:23:13','管理员',NULL,'2',00000000000),('402882846e7c792d016e7c89c599000f','motorway','公路局项目',NULL,'402882846e7c792d016e7c8606340005','2019-11-18 11:23:54','管理员',NULL,'2',00000000000),('402882846e7c792d016e7c8a83ec0011','hd','宏信达项目',NULL,'402882846e7c792d016e7c8606340005','2019-11-18 11:24:43','管理员',NULL,'2',00000000000),('402882846e7c792d016e7c8acf380013','local','地方标准',NULL,'402882846e7c792d016e7c8606340005','2019-11-18 11:25:02','管理员',NULL,'2',00000000000),('402882846e7c792d016e7c8b41b50015','group','团体标准',NULL,'402882846e7c792d016e7c8606340005','2019-11-18 11:25:31','管理员',NULL,'2',00000000000),('402882846e7c792d016e7c8baa420017','enterprise','企业标准',NULL,'402882846e7c792d016e7c8606340005','2019-11-18 11:25:58','管理员',NULL,'2',00000000000),('402882cc5dc0686f015dc06c0d7c0003','0','推送成功',NULL,'402882cc5dc0686f015dc06a797f0000',NULL,NULL,NULL,'1',00000000000),('402882cc5dc0686f015dc06c36010006','1','推送失败',NULL,'402882cc5dc0686f015dc06a797f0000','2017-08-08 13:58:23','管理员',NULL,'1',00000000000),('402882cc5dc13d65015dc13f7f5f0002','2','解析模板获取消息失败',NULL,'402882cc5dc0686f015dc06a797f0000','2017-08-08 17:49:10','管理员',NULL,'1',00000000000),('402882cc5dc5d85c015dc5da6efa0004','3','非预料情况',NULL,'402882cc5dc0686f015dc06a797f0000','2017-08-09 15:16:53','管理员',NULL,'1',00000000000),('402882cc5dc62591015dc6296b510005','0','短信',NULL,'402882cc5dc62591015dc629403c0003','2017-08-09 16:43:10','管理员',NULL,'1',00000000000),('402882cc5dc62591015dc62984a90007','1','email',NULL,'402882cc5dc62591015dc629403c0003','2017-08-09 16:43:16','管理员',NULL,'1',00000000000),('402882cc5e5b0c2b015e5b0eea2f0003','10','已缴费',NULL,'402882cc5e5b0c2b015e5b0e70870001','2017-09-07 14:37:38','管理员',NULL,'1',00000000000),('402882cc5e5b0c2b015e5b0f07ad0005','20','未缴费',NULL,'402882cc5e5b0c2b015e5b0e70870001','2017-09-07 14:37:45','管理员',NULL,'1',00000000000),('402882cc5e5b0c2b015e5b0f47ae0007','30','延迟缴费',NULL,'402882cc5e5b0c2b015e5b0e70870001','2017-09-07 14:38:02','管理员',NULL,'1',00000000000),('402882cc5e5b0c2b015e5b0fd427000b','10','待打印',NULL,'402882cc5e5b0c2b015e5b0f89820009','2017-09-07 14:38:38','管理员',NULL,'1',00000000000),('402882cc5e5b0c2b015e5b0ffe99000d','20','已打印',NULL,'402882cc5e5b0c2b015e5b0f89820009','2017-09-07 14:38:48','管理员',NULL,'1',00000000000),('402882cc5e5b0c2b015e5b1076f0000f','30','已领取',NULL,'402882cc5e5b0c2b015e5b0f89820009','2017-09-07 14:39:19','管理员',NULL,'1',00000000000),('402882cc5e641e24015e642997b60003','10','正常',NULL,'402882cc5e60d61b015e60ec8a2a0003','2017-09-09 09:03:21','管理员',NULL,'1',00000000000),('402882cc5e641e24015e6429b8f60005','20','临时报告',NULL,'402882cc5e60d61b015e60ec8a2a0003','2017-09-09 09:03:30','管理员',NULL,'1',00000000000),('402882cc5e641e24015e6429e7390007','30','标记为不需要打印',NULL,'402882cc5e60d61b015e60ec8a2a0003','2017-09-09 09:03:41','管理员',NULL,'1',00000000000),('402882cc5e641e24015e642a689a0009','40','自动生成的抽检查报告',NULL,'402882cc5e60d61b015e60ec8a2a0003','2017-09-09 09:04:14','管理员',NULL,'1',00000000000),('402882cd5f5640fa015f564570190005','10','待审核',NULL,'402882cd5f5640fa015f5645288b0003','2017-10-26 09:21:52','管理员',NULL,'1',00000000000),('402882cd5f5640fa015f564589720007','20','待批准',NULL,'402882cd5f5640fa015f5645288b0003','2017-10-26 09:21:59','管理员',NULL,'1',00000000000),('402882cd5f5640fa015f5645a6910009','30','审批通过',NULL,'402882cd5f5640fa015f5645288b0003','2017-10-26 09:22:06','管理员',NULL,'1',00000000000),('402882cd5f774643015f7747e6d00002','INPUT','INPUT',NULL,'402882cd5f774643015f7747879c0000','2017-11-01 19:12:02','管理员',NULL,'1',00000000000),('402882cd5f774643015f77480a450004','CHECKBOX','CHECKBOX',NULL,'402882cd5f774643015f7747879c0000','2017-11-01 19:12:11','管理员',NULL,'1',00000000000),('402882cd5f774643015f7748265e0006','RADIO','RADIO',NULL,'402882cd5f774643015f7747879c0000','2017-11-01 19:12:18','管理员',NULL,'1',00000000000),('402882cd5f774643015f774845980008','SELECT','SELECT',NULL,'402882cd5f774643015f7747879c0000','2017-11-01 19:12:26','管理员',NULL,'1',00000000000),('402882cd5f774643015f77490786000a','TEXT','TEXT',NULL,'402882cd5f774643015f7747879c0000','2017-11-01 19:13:16','管理员',NULL,'1',00000000000),('402882cd5f998a58015f998d9a240002','0','检定',NULL,'402882cd5f998a58015f998cea300000','2017-11-08 10:55:15','管理员',NULL,'1',00000000000),('402882cd5f998a58015f998dcb1f0004','1','校准',NULL,'402882cd5f998a58015f998cea300000','2017-11-08 10:55:28','管理员',NULL,'1',00000000000),('402882cd5f998a58015f998e3ad90006','2','自查',NULL,'402882cd5f998a58015f998cea300000','2017-11-08 10:55:56','管理员',NULL,'1',00000000000),('402882cd5f998a58015f998e9a040008','3','自校',NULL,'402882cd5f998a58015f998cea300000','2017-11-08 10:56:20','管理员',NULL,'1',00000000000),('402882cd5f998a58015f998ecd62000a','4','测试',NULL,'402882cd5f998a58015f998cea300000',NULL,NULL,NULL,'1',00000000000),('402882cd5f998a58015f99933679000f','1','检测仪器-固定资产',NULL,'402882cd5f998a58015f9991d359000d',NULL,NULL,NULL,'1',00000000000),('402882cd5f998a58015f9993660f0011','2','检测仪器-低值仪器',NULL,'402882cd5f998a58015f9991d359000d',NULL,NULL,NULL,'1',00000000000),('402882cd5f998a58015f999383bf0013','3','检测仪器-消耗品',NULL,'402882cd5f998a58015f9991d359000d',NULL,NULL,NULL,'1',00000000000),('402882cd5f998a58015f9993aab60015','4','通用设备-固定资产',NULL,'402882cd5f998a58015f9991d359000d',NULL,NULL,NULL,'1',00000000000),('402882cd5f998a58015f9993c4a60017','5','通用设备-低值设备',NULL,'402882cd5f998a58015f9991d359000d',NULL,NULL,NULL,'1',00000000000),('402882cd5f998a58015f9993da240019','6','通用设备-消耗品',NULL,'402882cd5f998a58015f9991d359000d',NULL,NULL,NULL,'1',00000000000),('402882cd5f998a58015f999d16b10023','3','报废留用',NULL,'402882cd5f998a58015f9998ff71001b','2017-11-08 11:12:10','管理员',NULL,'1',00000000000),('402882cd5f998a58015f999d3bc10025','4','已报废',NULL,'402882cd5f998a58015f9998ff71001b','2017-11-08 11:12:19','管理员',NULL,'1',00000000000),('402882cd5f998a58015f999d662d0027','5','正在维修',NULL,'402882cd5f998a58015f9998ff71001b','2017-11-08 11:12:30','管理员',NULL,'1',00000000000),('402882cd5fd90ef6015fd911b7280002','0','收样处留样',NULL,'402882cd5fd90ef6015fd91002ed0000','2017-11-20 18:55:38','管理员',NULL,'1',00000000000),('402882cd5fd90ef6015fd9129a200004','1','测后留样',NULL,'402882cd5fd90ef6015fd91002ed0000','2017-11-20 18:56:36','管理员',NULL,'1',00000000000),('402882cd5fdc3f4e015fdc5d588c0009','0','废弃',NULL,'402882cd5fdc3f4e015fdc5bd5d70007','2017-11-21 10:17:06','管理员',NULL,'1',00000000000),('402882cd5fdc3f4e015fdc5d7f42000b','1','利用',NULL,'402882cd5fdc3f4e015fdc5bd5d70007','2017-11-21 10:17:16','管理员',NULL,'1',00000000000),('402882cd5fdc3f4e015fdc5d9c24000d','2','收回',NULL,'402882cd5fdc3f4e015fdc5bd5d70007','2017-11-21 10:17:23','管理员',NULL,'1',00000000000),('402882cd5fdcf694015fdd0e0d5d000e','0','待审核',NULL,'402882cd5fdcf694015fdd0d514f000c','2017-11-21 13:30:07','管理员',NULL,'1',00000000000),('402882cd5fdcf694015fdd0e25b70010','1','审核通过',NULL,'402882cd5fdcf694015fdd0d514f000c','2017-11-21 13:30:13','管理员',NULL,'1',00000000000),('402882cd5fdcf694015fdd0e51dd0012','2','批准通过',NULL,'402882cd5fdcf694015fdd0d514f000c','2017-11-21 13:30:24','管理员',NULL,'1',00000000000),('402882cd5fe27b22015fe28265940002','0','审核',NULL,'402882cd5fe27b22015fe28244b10000','2017-11-22 14:55:17','管理员',NULL,'1',00000000000),('402882cd5fe27b22015fe2827c130004','1','批准',NULL,'402882cd5fe27b22015fe28244b10000','2017-11-22 14:55:23','管理员',NULL,'1',00000000000),('4028838850c35b6a0150c372e3b10005','*','非空',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850c35b6a0150c3abef800019','n','数字',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850c35b6a0150c3ac17f9001b','s','字母',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850d2666a0150d267a61e0001','p','邮政编码',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850d2666a0150d267d5c10003','m','手机号码',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850d2666a0150d26812d40005','e','电子邮件',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850d2666a0150d26850210007','url','网址',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850d2666a0150d268ae510009','*6-16','6到16位任意字符',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850d2666a0150d268e229000b','n6-16','6到16位数字',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028838850d2666a0150d26912e2000d','s6-18','6到18位字符串',NULL,'4028838850c35b6a0150c37251e00002','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('402889f647f797e30147f79ec3760005','1','待提交',NULL,'402889f647f797e30147f79e7ca60003','2017-02-23 15:17:53','管理员',NULL,'1',00000000000),('402889f647f797e30147f79f28de0007','2','处理中',NULL,'402889f647f797e30147f79e7ca60003','2017-02-23 15:17:53','管理员',NULL,'1',00000000000),('402889f647f797e30147f79fa724000b','3','已完成',NULL,'402889f647f797e30147f79e7ca60003','2017-02-23 15:17:53','管理员',NULL,'1',00000000000),('4028b881533ac16a01533adf65370003','Pie2D','2D饼图',NULL,'4028b881533ac16a01533adb50460001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028b881533ac16a01533ae0363d0005','Pie3D','3D饼图',NULL,'4028b881533ac16a01533adb50460001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028b881533ac16a01533ae2d2a50007','Column2D','2D柱状图',NULL,'4028b881533ac16a01533adb50460001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028b881533ac16a01533ae305340009','Column3D','3D柱状图',NULL,'4028b881533ac16a01533adb50460001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028b881533ac16a01533ae45759000b','Bar2D','条状图',NULL,'4028b881533ac16a01533adb50460001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028b881533ac16a01533ae4c6de000d','Area2D','面积图',NULL,'4028b881533ac16a01533adb50460001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028b881533ac16a01533ae50a67000f','LineBasic2D','折线图',NULL,'4028b881533ac16a01533adb50460001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028ef8154753f2601547546bb620007','1','单选',NULL,'4028ef8154753f2601547546249f0005','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('4028ef8154753f2601547546d3d60009','2','多选',NULL,'4028ef8154753f2601547546249f0005','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('46358c90cef343e1aee8c5194022c474','shouyangxinxi','UDR收样信息',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('48e8ae8161d2485b943459eb338391fb','FeeUpdateReport','报告修改费用',NULL,'afd95249560b431889866e4c42a4b824','2018-08-01 13:34:31','魏衡',NULL,'1',00000000000),('4bb77e3bcca14d8dab073496b6bde147','canshugongyongzhibiao','UDR_参数公用指标',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('7011cf28c267445fa92654faf8ae0568','jianyanzhibiaozhi','检验指标值',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('716e3fe3db6b4d22a57b661bf858b929','testCenterId','373',NULL,'4028820e669f674501669f6a01970000','2019-05-16 16:24:28','魏衡','2019新版导则体验单位 ID，对应海特中心系统管理 - 单位信息ID','1',00000000000),('7b1c0f7819af4d639625c36fd50dd563','printedExportTitle','已打印数据',NULL,'4028828466c1027f0166c28da7030001','2018-10-30 13:31:11','魏衡',NULL,'1',00000000000),('7ec364c51cfd4d01ad31a81c1d98f012','zhongjianjiancejieguo','中间检测结果',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('7ed2aff32f5843479151343b6e3a2e29','pizhuxiangxineirong','批注详细内容',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('8a1c7ee54e3e2ca9014e3e520bdc0010','spring','java.enhance.type.spring',NULL,'8a1c7ee54e3e2ca9014e3e4b78f90009','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a1c7ee54e3e2ca9014e3e524b560012','class','java.enhance.type.class',NULL,'8a1c7ee54e3e2ca9014e3e4b78f90009','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a71b40e4a38319b014a3859a2c1001a','1','common.smsAlertsModel',NULL,'8a71b40e4a38319b014a3858fca40018','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a71b40e4a38319b014a385a01d1001c','2','common.emailAlertsModel',NULL,'8a71b40e4a38319b014a3858fca40018','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a71b40e4a38319b014a385d30300020','1','common.smsAlerts',NULL,'8a71b40e4a38319b014a385cb115001e','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a71b40e4a38319b014a385d86c30022','2','common.emailAlerts',NULL,'8a71b40e4a38319b014a385cb115001e','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a71b40e4a38319b014a385dc1370024','3','common.sysAlerts',NULL,'8a71b40e4a38319b014a385cb115001e','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a71b40e4a38319b014a3860603f0028','1','common.didNotSend',NULL,'8a71b40e4a38319b014a386022bd0026','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a71b40e4a38319b014a38608d98002a','2','common.sendSuccess',NULL,'8a71b40e4a38319b014a386022bd0026','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a71b40e4a38319b014a3860b181002c','3','common.failToSend',NULL,'8a71b40e4a38319b014a386022bd0026','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8181f30060','2','menu.icon',NULL,'8a8ab0b246dc81120146dc8181aa0056','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8181f70061','1','system.icon',NULL,'8a8ab0b246dc81120146dc8181aa0056','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8181fa0062','files','common.attachment',NULL,'8a8ab0b246dc81120146dc8181ca005e','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8181fe0063','1','lang.excellent.order',NULL,'8a8ab0b246dc81120146dc8181b10057','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182010064','2','lang.normal.order',NULL,'8a8ab0b246dc81120146dc8181b10057','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182050065','1','lang.contract.customer',NULL,'8a8ab0b246dc81120146dc8181b50058','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182080066','2','lang.normal.customer',NULL,'8a8ab0b246dc81120146dc8181b50058','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc81820b0067','1','lang.special.servcie',NULL,'8a8ab0b246dc81120146dc8181b90059','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182100068','2','lang.normal.service',NULL,'8a8ab0b246dc81120146dc8181b90059','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182130069','single','common.single.condition.query',NULL,'8a8ab0b246dc81120146dc8181bc005a','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc818216006a','group','common.scope.query',NULL,'8a8ab0b246dc81120146dc8181bc005a','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc81821a006b','Y','common.yes',NULL,'8a8ab0b246dc81120146dc8181c0005b','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc81821d006c','N','common.no',NULL,'8a8ab0b246dc81120146dc8181c0005b','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc818221006d','Integer','common.db.integer',NULL,'8a8ab0b246dc81120146dc8181c3005c','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc818224006e','Date','common.db.date',NULL,'8a8ab0b246dc81120146dc8181c3005c','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc818227006f','String','common.db.string',NULL,'8a8ab0b246dc81120146dc8181c3005c','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc81822b0070','Long','common.db.long',NULL,'8a8ab0b246dc81120146dc8181c3005c','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc81822f0071','act','common.workflow.engine.table',NULL,'8a8ab0b246dc81120146dc8181c6005d','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182320072','t_s','common.system.table',NULL,'8a8ab0b246dc81120146dc8181c6005d','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182350073','t_b','common.business.table',NULL,'8a8ab0b246dc81120146dc8181c6005d','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182390074','t_p','common.customer.engine.table',NULL,'8a8ab0b246dc81120146dc8181c6005d','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc81823c0075','news','common.news',NULL,'8a8ab0b246dc81120146dc8181ca005e','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182400076','0','common.male',NULL,'8a8ab0b246dc81120146dc8181cd005f','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0b246dc81120146dc8182430077','1','common.female',NULL,'8a8ab0b246dc81120146dc8181cd005f','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0ba487c527201487c7863ec001b','oracle','common.oracle',NULL,'8a8ab0ba487c527201487c7732790019','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0ba487c527201487c78aefc001d','sqlserver2008','common.sqlserver2008',NULL,'8a8ab0ba487c527201487c7732790019','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('8a8ab0ba487c527201487c78fbb5001f','mysql','common.mysql',NULL,'8a8ab0ba487c527201487c7732790019','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('979893e3866d4a87aceff2e8bdc21a8c','baobiaofujiajielun','报表附加结论',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('aa1570a43861431fb9c0e0159e914555','waitPrintExportTitle','待打印数据',NULL,'4028828466c1027f0166c28da7030001','2018-10-30 09:26:46','魏衡',NULL,'1',00000000000),('b83a95573ee34c3bace25f6f6c2936e3','baobiaofujiajielunquanbu','报告附加结论_全部',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('d765193b29f04eaeb3f8d6d1b09d2ead','pizhuzhubiao','批注主表',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('db02a62954944e29bfeed3e5a2c2a020','testCenterName','贵州宏信创达工程检测咨询有限公司',NULL,'4028820e669f674501669f6a01970000','2018-10-23 13:39:08','魏衡','检测中心名称','1',00000000000),('f351c9545f6f4501af9e5c9d3e07561b','FeeOther','其他费用',NULL,'afd95249560b431889866e4c42a4b824','2018-08-01 13:36:09','魏衡',NULL,'1',00000000000),('f852d85d47ed64a40147ed71f6b40005','>','大于',NULL,'f852d85d47ed64a40147ed70894c0003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('f852d85d47ed64a40147ed72a9dc0007','>=','大于等于',NULL,'f852d85d47ed64a40147ed70894c0003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('f852d85d47ed64a40147ed750e1c0009','<','小于',NULL,'f852d85d47ed64a40147ed70894c0003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('f852d85d47ed64a40147ed753b6f000b','<=','小于等于',NULL,'f852d85d47ed64a40147ed70894c0003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('f852d85d47ed64a40147ed75afe5000d','=','等于',NULL,'f852d85d47ed64a40147ed70894c0003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('f852d85d47ed64a40147ed75ed62000f','IN','包含',NULL,'f852d85d47ed64a40147ed70894c0003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('f852d85d47ed64a40147ed7638b20011','LIKE','模糊',NULL,'f852d85d47ed64a40147ed70894c0003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('f852d85d47ed64a40147ed767c240013','!=','不等于',NULL,'f852d85d47ed64a40147ed70894c0003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('fda211172e3f486a990cc74c0ac1b3e6','shiyanzuidazushucishu','试验最大组数次数',NULL,'cf9b07fe8c7846f88bf0d1cd93cca91f','2019-01-23 15:19:12','魏衡','打印空表需要清空值的数据集名称','1',00000000000),('ff80808151399d0d015139b0e0b80003','hour','小时',NULL,'4028ab8c5134f1ed0151350f08d90003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('ff80808151399d0d015139b1609d0006','day','天',NULL,'4028ab8c5134f1ed0151350f08d90003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('ff80808151399d0d015139b283a10008','perday','天/人',NULL,'4028ab8c5134f1ed0151350f08d90003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('ff80808151399d0d015139b29550000a','permoney','元/人',NULL,'4028ab8c5134f1ed0151350f08d90003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('ff80808151399d0d015139b2a6e5000c','money','元',NULL,'4028ab8c5134f1ed0151350f08d90003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('ff80808151399d0d015139b2bab4000e','age','岁',NULL,'4028ab8c5134f1ed0151350f08d90003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('ff80808151399d0d015139b2c9ce0010','class','课时',NULL,'4028ab8c5134f1ed0151350f08d90003','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('jglongjbtstype201506041030000001','WXGZYD','关注引导',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('jglongjbtstype201506041030000002','WXNRQ','内容区',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('jglongjbtstype201506041030000003','WXYWYD','原文引导',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('jglongjbtstype201506041030000004','WXBT','标题',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('jglongjbtstype201506041030000005','WXFGX','分隔线',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('jglongjbtstype201506041030000006','WXHTZH','互推账号',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('jglongjbtstype201506041030000007','WXQT','其他',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000),('jglongjbtstype201506041030000008','WXWDYS','我的样式',NULL,'jglongjbtstypegourp2015060400001','2016-09-04 22:19:12','管理员',NULL,'1',00000000000);
/*!40000 ALTER TABLE `t_s_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_typegroup`
--

DROP TABLE IF EXISTS `t_s_typegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_typegroup` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `typegroupcode` varchar(50) DEFAULT NULL COMMENT '字典分组编码',
  `typegroupname` varchar(50) DEFAULT NULL COMMENT '字典分组名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(36) DEFAULT NULL COMMENT '创建用户',
  `source_from` varchar(10) NOT NULL COMMENT '数据来源: 1:系统, 2:用户',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_typegroup`
--

LOCK TABLES `t_s_typegroup` WRITE;
/*!40000 ALTER TABLE `t_s_typegroup` DISABLE KEYS */;
INSERT INTO `t_s_typegroup` VALUES ('0c084cfcab9211eab61fb8ca3a6052ac','equipment_label_format','设备标签打印格式','2020-06-11 11:17:47',NULL,'1'),('297e201047e95ee30147e9ba56ce0009','orgtype','common.org.type','2016-09-04 22:19:12','管理员','1'),('2c90ac564c9d1734014c9db1a167002b','sf_yn','是否YN','2016-09-04 22:19:12','管理员','1'),('402880884883eff401488415cbb60027','smsTplType','模板类型','2016-09-04 22:19:12','管理员','1'),('402881a151f1af7c0151f1b9d7f50002','outType','离职方式','2016-09-04 22:19:12','管理员','1'),('402881e44df713f5014df738349c002f','formDbType','form.db.type','2016-09-04 22:19:12','管理员','1'),('402881e54dcb624a014dcbf4912b000e','bdfl','表单分类','2016-09-04 22:19:12','管理员','1'),('402881e55af64f07015af68356550004','widgetType','控件类型','2017-03-22 22:54:47','管理员','1'),('402881e64ca6fd1b014ca7044c370004','tblx','图表类型','2016-09-04 22:19:12','管理员','1'),('402881e946e71f5f0146e73619bb0002','lang','common.mutilang','2016-09-04 22:19:12','管理员','1'),('4028820e669f674501669f6a01970000','sys_config','系统配置','2018-10-23 13:33:37','魏衡','1'),('402882105e4beb0c015e4c04432e0006','SNTermType','编号格式项',NULL,NULL,'1'),('402882105e551b4c015e551f619b0007','SNStatus','编号状态','2017-09-06 10:57:54','管理员','1'),('402882105e551b4c015e5547f1ea001e','SNType','编号种类','2017-09-06 11:42:12','管理员','1'),('402882105ebcb7b2015ebcf09204000b','feeStatus','费用状态','2017-09-26 14:47:16','叶飞','1'),('402882105ebd052e015ebd0ed1e00014','feeType','费用类型','2017-09-26 15:20:19','叶飞','1'),('402882105ebd052e015ebd1c7a3b002c','feeDType','收费or退费','2017-09-26 15:35:14','叶飞','1'),('402882105ec22504015ec23ed20b000b','deptVerSta','组织版本状态','2017-09-27 15:30:51','叶飞','1'),('402882105ed0398d015ed19040c6003d','testQual','检测资质','2017-09-30 14:54:06','叶飞','1'),('402882105f482f9a015f483cea1a0005','paidType','支付方式',NULL,NULL,'1'),('402882105f4db238015f4de414f70002','credit_st','信用状态','2017-10-24 18:18:34','叶飞','1'),('402882105f70012e015f716b9c0d00ab','receiptSta','发票状态','2017-10-31 15:53:19','叶飞','1'),('402882105f70012e015f716ce30e00ad','receiptTyp','发票类型','2017-10-31 15:54:42','叶飞','1'),('402882105fdc8297015fdcabc07a0004','contractSt','合同状态','2017-11-21 11:42:44','叶飞','1'),('402882105fdc8297015fdcabfe8e0006','contractTy','合同类别','2017-11-21 11:43:00','叶飞','1'),('4028821062b9b6ec0162b9b91c690000','assignType','任务分配模式','2018-04-12 19:58:59','叶飞','1'),('4028821062f545d70162f58de4fd00a9','def_equ','默认检测设备的方式','2018-04-24 10:49:00','叶飞','1'),('4028821e6ea5bc4b016ea642236b000f','performanceType','业绩类型','2019-11-26 13:49:43','管理员','2'),('4028821e6ea5bc4b016ea643bdb10019','grade','等级','2019-11-26 13:51:28','管理员','2'),('4028821e6eb14554016eb1dfd7d80006','certificateType','证书类型','2019-11-28 19:57:47','管理员','2'),('4028821e6eb14554016eb1e11006000c','certificateProfessio','持证专业','2019-11-28 19:59:07','管理员','2'),('402882206762317b0167626787270002','expressCompany','快递公司','2018-11-30 10:16:51','李丽峰','1'),('402882206b72e01e016b72f8bfd80001','eq_type','设备类别',NULL,NULL,'1'),('402882206b72e01e016b72f8bfd800x1','eq_scrap_type','设备报废类别','2020-06-19 09:13:52','lilf','1'),('402882206b72e01e016b7379c5e70009','eq_rstatus','设备租借状态','2019-06-20 14:01:29','李丽峰','1'),('40288247607719500160773198bb0004','xingType','检测demo类别','2017-12-21 11:50:27','管理员','1'),('4028828466c1027f0166c28da7030001','exportTitle','导出文件名','2018-10-30 09:19:15','魏衡','1'),('402882846e7c792d016e7c8606340005','data_collection_type','资料主题类型','2019-11-21 11:00:24','管理员','2'),('402882cc5dc0686f015dc06a797f0000','sendResult','推送结果',NULL,NULL,'1'),('402882cc5dc62591015dc629403c0003','sendType','发送消息类型',NULL,NULL,'1'),('402882cc5e5b0c2b015e5b0e70870001','rChargeS','报告管理收费状态','2017-09-07 14:37:07','管理员','1'),('402882cc5e5b0c2b015e5b0f89820009','printSt','打印状态','2017-09-07 14:38:18','管理员','1'),('402882cc5e60d61b015e60ec8a2a0003','reportT','报告类型','2017-09-08 17:57:48','管理员','1'),('402882cd5f5640fa015f5645288b0003','reportS','报告状态','2017-10-26 09:21:34','管理员','1'),('402882cd5f774643015f7747879c0000','formColumn','邮寄可用字段','2017-11-01 19:11:37','管理员','1'),('402882cd5f998a58015f998cea300000','eq_ck_type','设备检校类别',NULL,NULL,'1'),('402882cd5f998a58015f9991d359000d','eq_m_type','设备管理类别',NULL,NULL,'1'),('402882cd5f998a58015f9998ff71001b','eq_status','设备状态',NULL,NULL,'1'),('402882cd5fd90ef6015fd91002ed0000','typeOfReserveObject','留样类型','2017-11-20 18:53:46','管理员','1'),('402882cd5fdc3f4e015fdc5bd5d70007','objectDisposingT','留样处理类型','2017-11-21 10:15:27','管理员','1'),('402882cd5fdcf694015fdd0d514f000c','objectDisposedS','留样处理审批状态','2017-11-21 13:29:18','管理员','1'),('402882cd5fe27b22015fe28244b10000','objectDisposingAppT','留样处理审批类型','2017-11-22 14:55:09','管理员','1'),('4028838850c35b6a0150c37251e00002','dataType','校验规则','2016-09-04 22:19:12','管理员','1'),('402889f647f797e30147f79e7ca60003','bpm_status','业务BPM流转状态','2017-02-23 15:17:53','管理员','1'),('4028ab8c5134f1ed0151350f08d90003','units','常用单位','2016-09-04 22:19:12','管理员','1'),('4028b881533ac16a01533adb50460001','graphType','动态图表类型','2016-09-04 22:19:12','管理员','1'),('4028ef8154753f2601547546249f0005','pop_retype','POP返回类型','2016-09-04 22:19:12','管理员','1'),('4028efa25219c9f0015219d1d2720004','leaveType','请假类别','2016-09-04 22:19:12','管理员','1'),('8a1c7ee54e3e2ca9014e3e4b78f90009','enhanceType','java.enhance.type','2016-09-04 22:19:12','管理员','1'),('8a71b40e4a38319b014a3858fca40018','msgTplType','消息模板分类','2016-09-04 22:19:12','管理员','1'),('8a71b40e4a38319b014a385cb115001e','msgType','消息类别','2016-09-04 22:19:12','管理员','1'),('8a71b40e4a38319b014a386022bd0026','msgStatus','消息发送状态','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181aa0056','icontype','common.icon.type','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181b10057','order','lang.order.type','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181b50058','custom','lang.customer.type','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181b90059','service','lang.service.item.type','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181bc005a','searchmode','common.query.module','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181c0005b','yesorno','common.logic.condition','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181c3005c','fieldtype','field.type','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181c3006d','sampleAmountUnit','样品数量单位','2020-01-16 11:10:29','管理员','1'),('8a8ab0b246dc81120146dc8181c6005d','database','common.data.table','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181ca005e','fieltype','common.document.category','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181cd005f','sex','common.sex.type','2016-09-04 22:19:12','管理员','1'),('8a8ab0b246dc81120146dc8181cd005g','otherResultProblemSeverity','其他成果问题严重程度','2020-04-21 15:50:22','lilf','1'),('8a8ab0ba487c527201487c7732790019','dbtype','common.dbtype','2016-09-04 22:19:12','管理员','1'),('8e42d660af6f11eab61fb8ca3a6052ac','data_manage_standard','主题资料管理配置类型','2020-06-16 10:38:57',NULL,'1'),('afd95249560b431889866e4c42a4b824','feeItemAddType','新增费用项类型','2018-08-01 12:01:31','魏衡','1'),('BC5D57506F5F4E9090F77148458C7726','fileDisplayType','审核审批时文件显示方式','2019-06-27 10:37:15','魏衡','1'),('cf9b07fe8c7846f88bf0d1cd93cca91f','emptyTableClearDataSets','打印空表需要清空的数据集','2019-01-23 15:49:31','魏衡','1'),('f852d85d47ed64a40147ed70894c0003','rulecon','规则条件','2016-09-04 22:19:12','管理员','1'),('f852d85d47ed64a40147ed70894c0005','EqConsumableOutType','低值易耗品出库类型','2016-09-04 22:19:12','管理员','1'),('ffaf79d6b45811eab61fb8ca3a6052ac','udr_blank_draw_type','udr空白区域绘制类型','2020-06-22 15:22:33','管理员','1'),('jglongjbtstypegourp2015060400001','weixin','微信模板类型','2016-09-04 22:19:12','管理员','1');
/*!40000 ALTER TABLE `t_s_typegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_check_type`
--

DROP TABLE IF EXISTS `t_s_check_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_check_type` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_name` varchar(255) DEFAULT NULL,
  `sys_company_code` varchar(255) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL COMMENT '类型掩码',
  `is_charge` varchar(255) DEFAULT NULL COMMENT '是否收费1：是、0：否',
  `is_completed_type` varchar(255) DEFAULT NULL COMMENT '是否为交竣工检测类型1：是、0：否',
  `is_default` varchar(255) DEFAULT NULL COMMENT '是否为默认类型1：是、0：否',
  `is_quality_supervise` varchar(255) DEFAULT NULL COMMENT '是否为质量监督1：是、0：否',
  `name` varchar(255) NOT NULL COMMENT '类型名称',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检测类型表（监督抽检、普通送检等）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_check_type`
--

LOCK TABLES `t_s_check_type` WRITE;
/*!40000 ALTER TABLE `t_s_check_type` DISABLE KEYS */;
INSERT INTO `t_s_check_type` VALUES ('2c98b9136e260951016e3e2695321f57','admin','2019-11-06 08:39:06','管理员','A03',NULL,NULL,NULL,'','0','0','0','0','定期检测',''),('2c98b91370ed99b50170f0d4d77b14cf','admin','2020-03-19 11:27:26','管理员','A03',NULL,NULL,NULL,'RYJD','0','0','0','0','人员监督',''),('2c98b91370ed99b50170f0d53e9d1573','admin','2020-03-19 11:27:52','管理员','A03',NULL,NULL,NULL,'BDSY','0','0','0','0','比对试验',''),('2c98b913710b163001710fb0170a416b','admin','2020-03-25 11:15:31','管理员','A03',NULL,NULL,NULL,'','0','0','0','0','模拟检测',''),('2c98b913710b163001710fb07453416d','admin','2020-03-25 11:15:55','管理员','A03',NULL,NULL,NULL,'','0','0','0','0','评审检测',''),('402882105f5261ae015f526c034e0007','yefei','2017-10-25 15:25:31','叶飞','A01',NULL,NULL,NULL,'','1','1','1','1','普通检测',''),('402882105f5261ae015f526c34830009','yefei','2017-10-25 15:25:44','叶飞','A01',NULL,NULL,NULL,'','0','0','0','0','交竣工检测',''),('402882105f5261ae015f526c696c000b','yefei','2017-10-25 15:25:57','叶飞','A01',NULL,NULL,NULL,'','0','0','0','0','监督送检',''),('402882d35ec17ac8015ec17b8a350003','zhouxb','2017-09-27 11:57:33','周晓彬','A03','admin','2020-06-12 11:51:36','管理员','','1','0','0','0','普通送检',''),('402882d35ec17ac8015ec17b9b830005','zhouxb','2017-09-27 11:57:37','周晓彬','A03','zhouxb','2017-10-18 19:22:23','周晓彬','','0','0','1','1','监督抽检',''),('402882d35f1df502015f1e10a2c3000e','zhouxb','2017-10-15 11:25:28','周晓彬','A03',NULL,NULL,NULL,'','0','1','0','0','交竣工检测','');
/*!40000 ALTER TABLE `t_s_check_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_muti_lang`
--

DROP TABLE IF EXISTS `t_s_muti_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_muti_lang` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `lang_key` varchar(50) DEFAULT NULL COMMENT '语言主键',
  `lang_context` varchar(500) DEFAULT NULL COMMENT '内容',
  `lang_code` varchar(50) DEFAULT NULL COMMENT '语言',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人编号',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人编号',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_langkey_langcode` (`lang_key`,`lang_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_muti_lang`
--

LOCK TABLES `t_s_muti_lang` WRITE;
/*!40000 ALTER TABLE `t_s_muti_lang` DISABLE KEYS */;
INSERT INTO `t_s_muti_lang` VALUES ('01ca201223b14e3e86c13904a9ae5ca2','common.password','密码','zh-cn','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('02916620f68b4845ba09773de6799706','please.select.department','Please select a department','en','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('0ab1a1fddf14420fa0dbcbfb5d2e9e85','common.strong','Strong','en','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('0bacd0fab1c84f03854435c1adab88c2','common.lock.user','锁定用户','zh-cn','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('11d18a9927e34873a813eade025b5c18','fill.realname','Fill in the real name','en','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('121a68d32c6a419b800eb92431b20dd4','common.department','Org','en','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('1e5963a78dcd4b1fa5f9d6d845f151be','common.department','部门','zh-cn','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('2075b6c641bc44b392638fed9a62cce9','password.rang6to18','密码至少6个字符,最多18个字符','zh-cn','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('27a06a8ed99f45438be00b7f1ca097f7','common.username','用户账号','zh-cn','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('297e201046ff41480146ffbb62a30012','menu.manage','Menu Manage','en','2014-07-04 12:56:50','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:06:15','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ff41480146ffbc59ac0014','menu.manage','菜单管理','zh-cn','2014-07-04 12:57:54','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:06:26','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffc8cd320001','common.id','ID','en','2014-07-04 13:11:28','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-21 14:04:37','8a8ab0b246dc81120146dc8181950052','admin'),('297e201046ffc2ca0146ffc933dc0003','common.id','编号','zh-cn','2014-07-04 13:11:54','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:11:54','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffc9b4bb0005','menu.name','Menu Name','en','2014-07-04 13:12:27','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:14:52','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffc9b4bb0006','menu.explain','说明','zh-cn','2019-01-29 14:41:18','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201046ffc2ca0146ffc9b4bb0007','menu.explain','explain','en','2019-01-29 14:41:18','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201046ffc2ca0146ffc9b4bb00x1','menu.code','权限编码','zh-cn','2019-01-29 14:41:18','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201046ffc2ca0146ffc9b4bb00x2','menu.code','code','en','2019-01-29 14:41:18','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201046ffc2ca0146ffcd8f60000b','menu.name','菜单名称','zh-cn','2014-07-04 13:16:40','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:16:40','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffcdc44b000d','common.icon','Icon','en','2014-07-04 13:16:53','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:16:53','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffcdf4a6000f','common.icon','图标','zh-cn','2014-07-04 13:17:06','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:17:06','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffce76c70011','menu.url','Menu Url','en','2014-07-04 13:17:39','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:17:39','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffcea7d80013','menu.url','菜单地址','zh-cn','2014-07-04 13:17:51','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:17:51','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffcf13090015','menu.order','Menu Order','en','2014-07-04 13:18:19','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:18:19','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffcf4b0a0017','menu.order','菜单顺序','zh-cn','2014-07-04 13:18:33','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:18:33','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffd059670019','menu.add','Function Add','en','2014-07-04 13:19:42','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:22:11','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffd1cfeb001d','menu.edit','Menu Edit','en','2014-07-04 13:21:18','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:21:18','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffd20205001f','menu.edit','菜单编辑','zh-cn','2014-07-04 13:21:31','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:21:31','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffe1a54f0023','menu.level','Menu Level','en','2014-07-04 13:38:36','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:38:36','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffe1e8530025','menu.level','菜单等级','zh-cn','2014-07-04 13:38:53','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:38:53','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffe5e2860027','parent.function','Parent Function','en','2014-07-04 13:43:14','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:54:25','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffe6108b0029','parent.function','父菜单','zh-cn','2014-07-04 13:43:26','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:54:37','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffe9ec39002b','main.function','Main Function','en','2014-07-04 13:47:38','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:54:52','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffea3970002d','main.function','一级菜单','zh-cn','2014-07-04 13:47:58','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:55:06','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffea9f27002f','sub.function','Sub Function','en','2014-07-04 13:48:24','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:55:23','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffead7b80031','sub.function','下级菜单','zh-cn','2014-07-04 13:48:39','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:55:34','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046ffc2ca0146ffebb2660033','desktop.icon','Desk Icon','en','2014-07-04 13:49:35','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:49:35','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046ffc2ca0146ffebdf940035','desktop.icon','桌面图标','zh-cn','2014-07-04 13:49:46','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 13:49:46','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380146fffca39a0003','icon.list','Icon List','en','2014-07-04 14:08:05','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 15:20:31','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046fff2380146fffd42c40005','icon.list','图标列表','zh-cn','2014-07-04 14:08:46','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 15:20:45','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046fff23801470001e905000b','common.icon.name','Icon Name','en','2014-07-04 14:13:50','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:13:50','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470002280b000d','common.icon.name','图标名称','zh-cn','2014-07-04 14:14:07','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:14:07','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff238014700030848000f','common.icon.style','Icon Style','en','2014-07-04 14:15:04','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:21:40','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046fff2380147000332810011','common.icon.style','图标样式','zh-cn','2014-07-04 14:15:15','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:15:15','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147000387440013','common.icon.type','Icon Type','en','2014-07-04 14:15:37','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:15:37','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470003af940015','common.icon.type','图标类型','zh-cn','2014-07-04 14:15:47','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:15:47','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff238014700054be10020','icon.add','Icon Add','en','2014-07-04 14:17:32','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:17:32','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470005af9a0024','icon.edit','Icon Edit','en','2014-07-04 14:17:58','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:17:58','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470005d3550026','icon.edit','图标修改','zh-cn','2014-07-04 14:18:07','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:18:07','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff238014700063c220028','batch.generate.style','Batch Generate Style','en','2014-07-04 14:18:34','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-21 11:32:32','8a8ab0b246dc81120146dc8181950052','admin'),('297e201046fff238014700068560002a','batch.generate.style','批量生成样式','zh-cn','2014-07-04 14:18:53','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:18:53','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470015a389002e','common.department.list','Org List','en','2014-07-04 14:35:23','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 15:17:33','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046fff23801470015ff8f0030','common.department.list','组织机构列表','zh-cn','2014-07-04 14:35:47','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 15:17:09','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046fff23801470016d58e0036','common.department.name','Org Name','en','2014-07-04 14:36:42','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:36:42','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff238014700172e590038','common.department.name','组织机构名称','zh-cn','2014-07-04 14:37:04','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:37:04','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470017a515003a','position.desc','Org Desc','en','2014-07-04 14:37:35','297e201046d3660a0146d36d7b7a01e7','admin','2014-08-18 23:41:49','8a8ab0b246dc81120146dc8181950052','admin'),('297e201046fff23801470017d2fb003c','position.desc','组织机构描述','zh-cn','2014-07-04 14:37:47','297e201046d3660a0146d36d7b7a01e7','admin','2014-08-18 23:41:59','8a8ab0b246dc81120146dc8181950052','admin'),('297e201046fff238014700193e67003e','view.member','View Member','en','2014-07-04 14:39:20','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:39:20','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147001963ef0040','view.member','查看成员','zh-cn','2014-07-04 14:39:29','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:39:29','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147001ab010004a','parent.depart','Parent Org','en','2014-07-04 14:40:54','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:40:54','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147001ad6a7004c','parent.depart','上级组织机构','zh-cn','2014-07-04 14:41:04','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:41:04','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff238014700256132004e','area.manage','Area Manage','en','2014-07-04 14:52:35','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:52:35','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470025a7e70050','area.manage','地域管理','zh-cn','2014-07-04 14:52:53','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:52:53','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147002800990056','area.name','Area Name','en','2014-07-04 14:55:27','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:55:27','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470028c0330058','area.name','地域名称','zh-cn','2014-07-04 14:56:16','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:56:16','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff238014700295bd8005a','area.code','Area Code','en','2014-07-04 14:56:56','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:56:56','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147002981ee005c','area.code','地域编码','zh-cn','2014-07-04 14:57:06','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:57:06','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff23801470029c84d005e','display.order','Area Sort','en','2014-07-04 14:57:24','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:57:37','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046fff2380147002a3fa50061','display.order','显示顺序','zh-cn','2014-07-04 14:57:54','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:58:02','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046fff2380147002a93ba0064','area.add.param','Area Add','en','2014-07-04 14:58:16','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 15:12:56','297e201046d3660a0146d36d7b7a01e7','admin'),('297e201046fff2380147002c144c006c','area.level','Area Level','en','2014-07-04 14:59:54','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 14:59:54','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147002c3711006e','area.level','地域等级','zh-cn','2014-07-04 15:00:03','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 15:00:03','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147002ce8a70070','parent.area','Parent Area','en','2014-07-04 15:00:48','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 15:00:48','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e201046fff2380147002d42990072','parent.area','父地域','zh-cn','2014-07-04 15:01:11','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 15:01:11','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e20104701c151014701d4ac920001','system.icon','System Icon','en','2014-07-04 22:43:40','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 22:43:40','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e20104701c151014701d4e2990003','system.icon','系统图标','zh-cn','2014-07-04 22:43:54','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 22:43:54','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e20104701c151014701d53b200005','menu.icon','Menu Icon','en','2014-07-04 22:44:17','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 22:44:17','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e20104701c151014701d5c6cc0007','menu.icon','菜单图标','zh-cn','2014-07-04 22:44:53','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 22:44:53','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e20104701c151014701dda832000d','main.area','Main Level','en','2014-07-04 22:53:29','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 22:53:29','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e20104701c151014701ddf718000f','main.area','一级地域','zh-cn','2014-07-04 22:53:49','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 22:58:41','297e201046d3660a0146d36d7b7a01e7','admin'),('297e20104701c151014701de50dd0011','sub.area','Sub Level','en','2014-07-04 22:54:12','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 22:55:00','297e201046d3660a0146d36d7b7a01e7','admin'),('297e20104701c151014701dece660013','sub.area','下级地域','zh-cn','2014-07-04 22:54:44','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 22:54:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e20104701ecd4014701f3a69c0001','member.list','Member List','en','2014-07-04 23:17:30','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 23:17:30','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e20104701ecd4014701f3dcfb0003','member.list','成员列表','zh-cn','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('297e2010477674e7014776e5ffae0005','iconname.rang2to10','名称范围2~10位字符,且不为空','zh-cn','2014-07-27 16:18:12','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e2010477674e7014776e6eecd0007','iconname.rang2to10','Icon name should be 2-10 characters and should not empty','en','2014-07-27 16:19:11','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e20104777447a01477784810a000f','operate.name','页面控件名称','zh-cn','2014-07-27 19:11:18','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:28:39','admin','管理员'),('297e20104777447a0147778a170d0011','operate.name','Page Element Name','en','2014-07-27 19:17:24','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:30:10','admin','管理员'),('297e20104777447a01477791affe0014','operate.manage','Page access control','en','2014-07-27 19:25:42','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:21:45','admin','管理员'),('297e20104777447a01477791eea00016','operate.manage','页面控件权限配置','zh-cn','2014-07-27 19:25:58','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:22:00','admin','管理员'),('297e20104777447a01477796ccde0018','operatename.rang2to20','操作名称范围2~20位字符','zh-cn','2014-07-27 19:31:17','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e20104777447a014777979ab6001a','operatename.rang2to20','Operate name should be 2-20 characters','en','2014-07-27 19:32:10','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e20104777447a014777991ef9001c','operatestatus.number','必须为数字','zh-cn','2014-07-27 19:33:49','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e20104777447a0147779a0f71001e','operatestatus.number','Must be numeric','en','2014-07-27 19:34:50','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777a9190b0007','common.default.icon','default','en','2014-07-27 19:51:16','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777a974ca0009','common.default.icon','默认','zh-cn','2014-07-27 19:51:39','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777a9cbc3000b','common.back','back','en','2014-07-27 19:52:02','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777a9f433000d','common.back','返回','zh-cn','2014-07-27 19:52:12','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777ae465e000f','common.smallpie.icon','smallpie','en','2014-07-27 19:56:55','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777aeb70c0011','common.smallpie.icon','小饼状图','zh-cn','2014-07-27 19:57:24','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777af2a970013','common.picture','图片','zh-cn','2014-07-27 19:57:54','8a8ab0b246dc81120146dc8181950052','admin','2014-07-27 19:58:19','8a8ab0b246dc81120146dc8181950052','admin'),('297e201047779c5b014777af611a0015','common.picture','pictures','en','2014-07-27 19:58:08','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777afea2c0018','common.pencil.icon','笔','zh-cn','2014-07-27 19:58:43','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b01f4a001a','common.pencil.icon','pencil','en','2014-07-27 19:58:56','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b210ae001c','common.smallmap','小地图','zh-cn','2014-07-27 20:01:04','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b2638d001e','common.smallmap','smallmap','en','2014-07-27 20:01:25','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b2d38b0020','common.group','组','zh-cn','2014-07-27 20:01:54','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b3010a0022','common.group','group','en','2014-07-27 20:02:05','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b361fa0024','common.calculator','计算器','zh-cn','2014-07-27 20:02:30','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b39c390026','common.calculator','calculator','en','2014-07-27 20:02:45','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b3ed9e0028','common.folder','文件夹','zh-cn','2014-07-27 20:03:06','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047779c5b014777b440fd002a','common.folder','folder','en','2014-07-27 20:03:27','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e20104777c827014777f13d7f0002','common.delete.fail.param','{0}删除失败{1}','zh-cn','2014-07-27 21:10:04','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e20104777c827014777f282f60004','common.delete.fail.param','{0} delete fail{1}','en','2014-07-27 21:11:27','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e20104777c827014777f52cd10006','common.icon.isusing','！图标正在使用，不允许删除。','zh-cn','2014-07-27 21:14:22','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e20104777c827014777f8c27e0008','common.icon.isusing',', Icon is using, can not be deleted.','en','2014-07-27 21:18:17','8a8ab0b246dc81120146dc8181950052','admin','2014-07-27 21:27:54','8a8ab0b246dc81120146dc8181950052','admin'),('297e201047781c8e014778273b160007','departmentname.rang3to10','机构名称在3~10位字符','zh-cn','2014-07-27 22:09:02','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047781c8e0147782885e90009','departmentname.rang3to10','Department name should be 3-10 characters','en','2014-07-27 22:10:27','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047781c8e0147782a1443000b','areaname.rang2to15','地域名称范围2~15位字符,且不为空','zh-cn','2014-07-27 22:12:09','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047781c8e0147782a6615000d','areaname.rang2to15','Area name should be 2-15 characters and should not empty','en','2014-07-27 22:12:30','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047e73d0f0147e7ffd4540028','common.org.code','机构编码','zh-cn','2014-08-18 15:23:28','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047e73d0f0147e8004113002a','common.org.code','Org Code','en','2014-08-18 15:23:56','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047e73d0f0147e800add5002c','common.org.type','机构类型','zh-cn','2014-08-18 15:24:24','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047e73d0f0147e800edf8002e','common.org.type','Org Type','en','2014-08-18 15:24:40','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047e73d0f0147e80a71980030','common.company','公司','zh-cn','2014-08-18 15:35:04','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047e73d0f0147e80abac10032','common.company','Company','en','2014-08-18 15:35:23','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047e73d0f0147e815144e0034','common.position','岗位','zh-cn','2014-08-18 15:46:41','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047e73d0f0147e81561a80036','common.position','Position','en','2014-08-18 15:47:01','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047f766400147f7b9d4d20009','role.set','角色设置','zh-cn','2014-08-21 16:40:56','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201047f766400147f7be2c6a000c','current.org','机构','zh-cn','2014-08-21 16:45:41','8a8ab0b246dc81120146dc8181950052','admin','2015-12-23 19:05:22','admin','管理员'),('297e201047f766400147f7be6144000e','current.org','Org','en','2014-08-21 16:45:54','8a8ab0b246dc81120146dc8181950052','admin','2015-12-23 19:05:17','admin','管理员'),('297e201047f8c5050147f923e5e8000c','role.set','Role Set','en','2014-08-21 23:16:25','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201048154920014815c3e9a7000c','common.add.exist.user','添加已有客户','zh-cn','2014-08-27 12:40:33','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201048154920014815c47ac1000e','common.add.exist.user','Add Exist User','en','2014-08-27 12:41:11','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('297e201048b7e5c60148b7ffe64e0001','common.type.list','类型列表','zh-cn','2014-09-28 00:44:34','admin','管理员',NULL,NULL,NULL),('297e201048b7e5c60148b8002b620003','common.type.list','Type List','en','2014-09-28 00:44:51','admin','管理员','2014-09-28 00:46:01','admin','管理员'),('297e201048b7e5c60148b801c7520006','common.type.code','类型编码','zh-cn','2014-09-28 00:46:37','admin','管理员',NULL,NULL,NULL),('297e201048b7e5c60148b801f8dc0008','common.type.code','Type Code','en','2014-09-28 00:46:50','admin','管理员',NULL,NULL,NULL),('297e201048b7e5c60148b8024884000a','common.type.name','类型名称','zh-cn','2014-09-28 00:47:10','admin','管理员',NULL,NULL,NULL),('297e201048b7e5c60148b802773e000c','common.type.name','Type Name','en','2014-09-28 00:47:22','admin','管理员',NULL,NULL,NULL),('297e201048b803ec0148b80d34360001','common.type.view','查看类型','zh-cn','2014-09-28 00:59:06','admin','管理员',NULL,NULL,NULL),('297e201048b803ec0148b80d6da10003','common.type.view','Type View','en','2014-09-28 00:59:20','admin','管理员',NULL,NULL,NULL),('297ed4995dd0879a015dd08b3718000d','common.model.metainfo','元数据','zh-cn','2017-08-11 17:06:11','admin','管理员',NULL,NULL,NULL),('297ed4995dd0879a015dd08dddd30011','common.model.list','流程模型列表','zh-cn','2017-08-11 17:09:05','admin','管理员',NULL,NULL,NULL),('2a609258aef344bbbcf0c766d922e449','common.phone','Phone','en','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('2bad4a20100e456aac2f6be3d1cc85ac','common.real.name','Real Name','en','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('2c948a855611e7c8015611ea72800001','menu.funiconstyle','菜单图标样式','zh-cn','2016-07-22 17:23:13','admin','管理员','2016-07-22 17:24:24','admin','管理员'),('2c948a855611e7c8015611eb204f0003','menu.funiconstyle','Menu Icon Style','en','2016-07-22 17:23:57','admin','管理员',NULL,NULL,NULL),('2c948a85567d940f01567db64d4e0005','confirm.copy.form','确认复制表单','zh-cn','2016-08-12 15:45:15','admin','管理员',NULL,NULL,NULL),('2c948a85567d940f01567db6bcc00007','confirm.copy.form','Confirm copy form','en','2016-08-12 15:45:43','admin','管理员',NULL,NULL,NULL),('2d70c1a8158b415b9aff12e1957c1819','common.repeat.password','Repeat Password','en','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('2fe5274af5d94fb49240d82b7b8d2a95','common.tel','Telephone','en','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('3db54b3731434dc38bc5ea3b20de7db8','common.middle','Middle','en','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('402831814d8a1ae0014d8a239f520001','common.unlock.user','激活用户','zh-cn','2015-05-25 16:14:59','admin','管理员',NULL,NULL,NULL),('402831814d8a1ae0014d8a2402d40003','common.unlock.user','unlock user','en','2015-05-25 16:15:25','admin','管理员',NULL,NULL,NULL),('4028808847f3e70d0147f3eb326b0005','funcType','菜单类型','zh-cn','2014-08-20 22:56:23','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('4028808847f3e70d0147f3eb9f400007','funcType','funcType','en','2014-08-20 22:56:51','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('4028808847f3e70d0147f3ef30570009','funcType.page','菜单类型','zh-cn','2014-08-20 23:00:44','8a8ab0b246dc81120146dc8181950052','admin','2014-08-23 01:48:20','8a8ab0b246dc81120146dc8181950052','admin'),('4028808847f3e70d0147f3ef5482000b','funcType.page','menu type','en','2014-08-20 23:00:54','8a8ab0b246dc81120146dc8181950052','admin','2014-08-23 01:48:29','8a8ab0b246dc81120146dc8181950052','admin'),('4028808847f3e70d0147f3ef8590000d','funcType.from','author type','en','2014-08-20 23:01:06','8a8ab0b246dc81120146dc8181950052','admin','2014-08-23 01:49:57','8a8ab0b246dc81120146dc8181950052','admin'),('4028808847f3e70d0147f3efcd02000f','funcType.from','权限类型','zh-cn','2014-08-20 23:01:24','8a8ab0b246dc81120146dc8181950052','admin','2014-08-23 01:50:07','8a8ab0b246dc81120146dc8181950052','admin'),('4028808847f972bb0147f9749a7b0003','operationType.disabled','disabled','en','2014-08-22 00:44:34','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('4028808847f972bb0147f974dc860005','operationType.disabled','禁用','zh-cn','2014-08-22 00:44:51','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('4028808847f972bb0147f9754c030007','common.enable','有效','zh-cn','2014-08-22 00:45:19','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('4028808847f972bb0147f97581920009','common.enable','enable','en','2014-08-22 00:45:33','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('4028808847f972bb0147f975c3c8000b','common.disable','无效','zh-cn','2014-08-22 00:45:50','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('4028808847f972bb0147f97612a1000d','common.disable','disable','en','2014-08-22 00:46:10','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('402880e447e9ba550147e9be3a3a0003','common.rang','{0}Operate name  should be {1}-{2} characters','en','2014-08-18 23:31:03','8a8ab0b246dc81120146dc8181950052','admin','2014-08-18 23:32:00','8a8ab0b246dc81120146dc8181950052','admin'),('402880e447e9ba550147e9bf9eaa0006','common.rang','{0}范围{1}~{2}位字符','zh-cn','2014-08-18 23:32:35','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('402880e447e9ba550147e9c1ab590008','departmentname.rang1to20','Depart name should be 1-20 characters','en','2014-08-18 23:34:49','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('402880e447e9ba550147e9c25bbe000a','departmentname.rang1to20','组织机构范围1~20位字符','zh-cn','2014-08-18 23:35:34','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('402880e4489db6e601489dbc2cdc0001','common.add.to','AddTo','en','2014-09-22 22:20:28','admin','管理员',NULL,NULL,NULL),('402880e4489db6e601489dbc61380003','common.add.to','添加','zh-cn','2014-09-22 22:20:41','admin','管理员',NULL,NULL,NULL),('402880e64705eca9014705eee9120001','user.analysis.line','User analysis Line','en','2014-07-05 17:50:49','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca9014705f1741c0003','user.analysis.line','用户分析 Line','zh-cn','2014-07-05 17:53:35','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca9014705f535a50005','user.analysis.pie','User analysis Pie','en','2014-07-05 17:57:41','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca9014705f597d10007','user.analysis.pie','用户分析 Pie','zh-cn','2014-07-05 17:58:07','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca9014705f82a580009','user.analysis.histogram','User Analysis Histogram','en','2014-07-05 18:00:55','402880e64705a8ce014705af94280052','admin','2014-07-21 10:08:08','8a8ab0b246dc81120146dc8181950052','admin'),('402880e64705eca9014705fc8656000b','user.browser.analysis',' Analysis of the user\'s browser proportion','en','2014-07-05 18:05:41','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca9014705fce72d000d','user.browser.analysis','用户浏览器比例分析','zh-cn','2014-07-05 18:06:06','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca901470608088c000f','class.student.count.analysis','Class student ratio analysis','en','2014-07-05 18:18:15','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca9014706088d7c0011','class.student.count.analysis','班级学生人数比例分析','zh-cn','2014-07-05 18:18:49','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147060a873a0013','common.line.chart','Line chart','en','2014-07-05 18:20:59','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147060aef730015','common.line.chart','折线图','zh-cn','2014-07-05 18:21:25','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147060bfcae0017','common.pie.chart','pie','en','2014-07-05 18:22:34','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147060c5e310019','common.pie.chart','饼状图','zh-cn','2014-07-05 18:22:59','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147060dc6b6001b','common.histogram','Histogram','en','2014-07-05 18:24:31','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147060e11f3001d','common.histogram','柱状图','zh-cn','2014-07-05 18:24:51','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147060fa1ba001f','class.count.statistics','Class size statistics','en','2014-07-05 18:26:33','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147060fdf3a0021','class.count.statistics','班级人数统计','zh-cn','2014-07-05 18:26:49','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147061123451230','common.query.statistics','统计报表','zh-cn','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2015-10-15 10:28:26','admin','管理员'),('402880e64705eca90147061123451231','common.query.statistics','Statistics Report','en','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2015-10-15 10:28:57','admin','管理员'),('402880e64705eca90147061123451232','common.schedule.task','定时任务','zh-cn','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451233','common.schedule.task','Timed Task','en','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451234','system.log','系统日志','zh-cn','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451235','system.log','Sys Log','en','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451236','data.monitor','数据监控','zh-cn','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451237','data.monitor','Data Monitor','en','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451238','form.config','Online表单开发','zh-cn','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451239','form.config','Form Config','en','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451240','dynamic.form.config','Online报表配置','zh-cn','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451241','dynamic.form.config','Dynamic Report Config','en','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451242','user.analysis','用户分析','zh-cn','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061123451243','user.analysis','User Analysis','en','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin'),('402880e64705eca90147061365350027','lang.class','Class','en','2014-07-05 18:30:40','402880e64705a8ce014705af94280052','admin','2014-07-20 11:56:18','8a8ab0b246dc81120146dc8181950052','admin'),('402880e64705eca901470614932d0029','lang.class','班级','zh-cn','2014-07-05 18:31:57','402880e64705a8ce014705af94280052','admin','2014-07-20 11:56:24','8a8ab0b246dc81120146dc8181950052','admin'),('402880e64705eca9014706152c0a002b','number.ofpeople',' Number of people','en','2014-07-05 18:32:36','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca901470615588b002d','number.ofpeople','人数','zh-cn','2014-07-05 18:32:48','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca901470615f986002f','common.proportion','Proportion','en','2014-07-05 18:33:29','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e64705eca90147061627450031','common.proportion','比例','zh-cn','2014-07-05 18:33:40','402880e64705a8ce014705af94280052','admin','2014-07-04 23:17:44','297e201046d3660a0146d36d7b7a01e7','管理员'),('402880e74c5e73f5014c5e80548f0001','user.report','综合报表','zh-cn','2015-03-28 11:50:10','admin','管理员',NULL,NULL,NULL),('402880e74c5e73f5014c5e809f9d0003','user.report','newReport','en','2015-03-28 11:50:30','admin','管理员',NULL,NULL,NULL),('402880e74c6084c9014c609276500002','common.start','启动','zh-cn','2015-03-28 21:29:13','admin','管理员',NULL,NULL,NULL),('402880e74c6084c9014c60929d5b0004','start','common.start','en','2015-03-28 21:29:23','admin','管理员',NULL,NULL,NULL),('402880e74c7a776c014c7a8121980004','operate.manage.data','数据权限控制','zh-cn','2015-04-02 22:20:25','admin','管理员',NULL,NULL,NULL),('402880e74c7a776c014c7a817cd30006','operate.manage.data','Data access control','en','2015-04-02 22:20:48','admin','管理员',NULL,NULL,NULL),('402880e74c7a776c014c7a8c8c860010','operation.type','rule type','en','2015-04-02 22:32:53','admin','管理员','2015-04-02 22:34:48','admin','管理员'),('402880e74c7a776c014c7a8cb6290012','operation.type','规则类型','zh-cn','2015-04-02 22:33:04','admin','管理员','2015-04-02 22:34:06','admin','管理员'),('402880e74d762a40014d76332b370003','rolescope.rang2to8.notnull','Role need 2~8 bits','en','2015-05-21 19:19:34','admin','管理员',NULL,NULL,NULL),('402880e74d762a40014d7633a30c0005','rolescope.rang2to8.notnull','角色范围在2~8位字符','zh-cn','2015-05-21 19:20:05','admin','管理员',NULL,NULL,NULL),('402880e74d762a40014d76342eb00007','rolecode.rang2to15.notnull','角色编码范围在2~15位字符','zh-cn','2015-05-21 19:20:40','admin','管理员',NULL,NULL,NULL),('402880e74d762a40014d76348d970009','rolecode.rang2to15.notnull','Rolecode need 2~15 bits','en','2015-05-21 19:21:05','admin','管理员',NULL,NULL,NULL),('402880e750693d44015069621039002e','menu.online.template','Online Form Style','en','2015-10-15 10:44:05','admin','管理员','2015-10-15 10:44:45','admin','管理员'),('402880e750a90ffc0150a9d47e580027','auto.form.formTempldateName','formTemplateName','en','2015-10-27 23:04:46','admin','管理员','2015-10-27 23:05:35','admin','管理员'),('402880e750a90ffc0150a9d586f8002c','auto.form.formTempldateName','自定义表单模板名','zh-cn','2015-10-27 23:05:54','admin','管理员',NULL,NULL,NULL),('402880e750b134780150b16db5ce0003','auto.form.formCode','表单编码','zh-cn','2015-10-29 10:29:28','admin','管理员',NULL,NULL,NULL),('402880e750b134780150b16de6ed0005','auto.form.formCode','formCode','en','2015-10-29 10:29:41','admin','管理员',NULL,NULL,NULL),('402880ea53365da801533671c4860001','notice.tip','公告','zh-cn','2016-03-02 16:28:58','admin','管理员',NULL,NULL,NULL),('402880ea53365da80153367223df0003','notice.tip','Notifications','en','2016-03-02 16:29:23','admin','管理员',NULL,NULL,NULL),('402880ea53365da80153367419dd0005','notice.seeAll','查看全部','zh-cn','2016-03-02 16:31:31','admin','管理员',NULL,NULL,NULL),('402880ea53365da801533674bd1e0007','notice.seeAll','See all notifications','en','2016-03-02 16:32:13','admin','管理员','2016-03-02 16:32:35','admin','管理员'),('402880ea53365da801533675e268000a','message.tip','消息','zh-cn','2016-03-02 16:33:28','admin','管理员',NULL,NULL,NULL),('402880ea53365da80153367664c5000c','message.tip','Messages','en','2016-03-02 16:34:02','admin','管理员',NULL,NULL,NULL),('402880ea53365da801533676f54f000e','message.seeAll','查看全部','zh-cn','2016-03-02 16:34:39','admin','管理员',NULL,NULL,NULL),('402880ea53365da80153367768ea0010','message.seeAll','See all messages','en','2016-03-02 16:35:08','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fb6bcc50002','please.select.role','Please select a role','en','2016-03-04 11:40:53','admin','管理员','2016-03-04 11:41:19','admin','管理员'),('402880eb533fb18001533fb776cb0005','please.select.role','请选择角色','zh-cn','2016-03-04 11:41:41','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fb7ef010007','please.select.user','please select a user','en','2016-03-04 11:42:12','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fb841280009','please.select.user','请选择用户','zh-cn','2016-03-04 11:42:33','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fbe3093000b','common.user.select','用户选择','zh-cn','2016-03-04 11:49:02','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fbe79ad000d','common.user.select','User Select','en','2016-03-04 11:49:20','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fc29581000f','common.notice','公告','zh-cn','2016-03-04 11:53:50','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fc3ead70011','common.notice','Notifications','en','2016-03-04 11:55:17','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fc84f540013','notice.manage','公告管理','zh-cn','2016-03-04 12:00:05','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fc9a6e60015','notice.manage','Notifications Management','en','2016-03-04 12:01:33','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fce327a0018','common.authority','授权','zh-cn','2016-03-04 12:06:31','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fcfbe4a001a','common.authority','Authorization','en','2016-03-04 12:08:12','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fd57083001c','common.authority.role','角色授权','zh-cn','2016-03-04 12:14:25','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fd61fc6001e','common.authority.role','Role Authorization','en','2016-03-04 12:15:10','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fd6baf40020','common.authority.user','User Authorization','en','2016-03-04 12:15:50','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fd6e88d0022','common.authority.user','用户授权','zh-cn','2016-03-04 12:16:02','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fd8cfe10024','common.read','阅读','zh-cn','2016-03-04 12:18:06','admin','管理员',NULL,NULL,NULL),('402880eb533fb18001533fd921060026','common.read','Read','en','2016-03-04 12:18:27','admin','管理员',NULL,NULL,NULL),('402881034728d95a014728dc0fdf0005','has.sync','已同步','zh-cn','2014-07-12 12:36:56','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 12:36:56','admin','管理员'),('402881034728d95a014728dcc32c0007','has.sync','Synchronized','en','2014-07-12 12:37:42','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:10:45','8a8ab0b246dc81120146dc8181950052','admin'),('402881034728d95a014728dd29140009','have.nosync','未同步','zh-cn','2014-07-12 12:38:08','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 12:38:08','admin','管理员'),('402881034728d95a014728dd8161000b','have.nosync','No Synchronize','en','2014-07-12 12:38:31','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 12:38:31','admin','管理员'),('402881034728d95a014728dfe5610013','single.table','单表','zh-cn','2014-07-12 12:41:07','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 12:41:07','admin','管理员'),('402881034728d95a014728e0077e0015','single.table','Single Table','en','2014-07-12 12:41:16','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 12:41:16','admin','管理员'),('402881034728d95a014728e0f6500017','slave.table','附表','zh-cn','2014-07-12 12:42:17','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 12:42:17','admin','管理员'),('402881034728d95a014728e1183d0019','slave.table','Slave Table','en','2014-07-12 12:42:26','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 12:42:26','admin','管理员'),('402881034728fa28014728fd5f160003','smart.form.setting','智能表单配置','zh-cn','2014-07-12 13:13:19','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:13:19','admin','管理员'),('402881034728fa28014728fd89ff0005','smart.form.setting','Smart Form Setting','en','2014-07-12 13:13:30','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:13:30','admin','管理员'),('402881034728fa28014728feca7b0007','generate.form','生成表单','zh-cn','2014-07-12 13:14:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:14:52','admin','管理员'),('402881034728fa28014728feedfa0009','generate.form','Generate Form','en','2014-07-12 13:15:01','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:15:01','admin','管理员'),('402881034728fa28014728ff5a4e000b','generate.success','生成成功','zh-cn','2014-07-12 13:15:29','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:15:29','admin','管理员'),('402881034728fa28014728ff7e81000d','generate.success','Generate Success','en','2014-07-12 13:15:38','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:15:38','admin','管理员'),('402881034728fa2801472900fe10000f','please.select.generate.item','请选择要生成表单的项!','zh-cn','2014-07-12 13:17:16','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:17:16','admin','管理员'),('402881034728fa2801472901dab10011','please.select.generate.item','Please select should be generated item.','en','2014-07-12 13:18:13','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:18:13','admin','管理员'),('402881034728fa280147290fad990013','button.code','按钮编码','zh-cn','2014-07-12 13:33:19','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:33:19','admin','管理员'),('402881034728fa280147290fcac30015','button.code','Button Code','en','2014-07-12 13:33:26','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:33:26','admin','管理员'),('402881034728fa2801472910045f0017','button.name','按钮名称','zh-cn','2014-07-12 13:33:41','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:33:41','admin','管理员'),('402881034728fa28014729101a4a0019','button.name','Button Name','en','2014-07-12 13:33:46','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:33:46','admin','管理员'),('402881034728fa280147291059ca001b','button.style','按钮样式','zh-cn','2014-07-12 13:34:03','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:34:03','admin','管理员'),('402881034728fa2801472910776c001d','button.style','Button Style','en','2014-07-12 13:34:10','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:34:10','admin','管理员'),('402881034728fa2801472910a634001f','action.type','动作类型','zh-cn','2014-07-12 13:34:22','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:34:22','admin','管理员'),('402881034728fa2801472910bdd70021','action.type','Action Type','en','2014-07-12 13:34:28','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 13:34:28','admin','管理员'),('4028810347292c730147293008280009','super.admin','超级管理员','zh-cn','2014-07-12 14:08:39','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:08:39','admin','管理员'),('4028810347292c730147293021c7000b','super.admin','Super Admin','en','2014-07-12 14:08:46','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:08:46','admin','管理员'),('4028810347292c73014729308a0e000d','please.select.lock.item','请选择锁定项目','zh-cn','2014-07-12 14:09:12','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:09:12','admin','管理员'),('4028810347292c7301472930ae9e000f','please.select.lock.item','Please select locked item','en','2014-07-12 14:09:22','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:09:22','admin','管理员'),('4028810347292c7301472931c5900011','is.confirm','确定吗','zh-cn','2014-07-12 14:10:33','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:10:33','admin','管理员'),('4028810347292c73014729320e310013','is.confirm','Confirm?','en','2014-07-12 14:10:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:10:52','admin','管理员'),('4028810347292c73014729369dde0015','current.permission','当前权限','zh-cn','2014-07-12 14:15:51','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:15:51','admin','管理员'),('4028810347292c7301472936c80f0017','current.permission','Current Permission','en','2014-07-12 14:16:01','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:16:01','admin','管理员'),('4028810347292c73014729386dce0019','confirm.delete.this.record','确定删除该记录吗','zh-cn','2014-07-12 14:17:49','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:17:49','admin','管理员'),('4028810347292c7301472938c6f9001b','confirm.delete.this.record','Delete this record, Confirm?','en','2014-07-12 14:18:12','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:18:12','admin','管理员'),('4028810347292c7301472939f98b001d','menu.list','菜单列表','zh-cn','2014-07-12 14:19:31','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:19:31','admin','管理员'),('4028810347292c730147293a157d001f','menu.list','Menu List','en','2014-07-12 14:19:38','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:19:38','admin','管理员'),('4028810347292c730147293ab7a10021','operate.button.list','精细化权限控制','zh-cn','2014-07-12 14:20:19','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:25:39','admin','管理员'),('4028810347292c730147293aefc40023','operate.button.list','Fine access control','en','2014-07-12 14:20:34','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:25:56','admin','管理员'),('4028810347292c730147293b76f80025','select.all','全选','zh-cn','2014-07-12 14:21:08','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:21:08','admin','管理员'),('4028810347292c730147293b8dc60027','select.all','Select All','en','2014-07-12 14:21:14','8a8ab0b246dc81120146dc8181950052','admin','2014-07-12 14:21:14','admin','管理员'),('40288103472948880147294b26420002','button.setting','页面控件权限','zh-cn','2014-07-12 14:38:16','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:12:27','admin','管理员'),('40288103472948880147294b432a0004','button.setting','Page control config','en','2014-07-12 14:38:24','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 20:06:10','admin','管理员'),('4028810b474cecc301474cf3de950001','common.button.code','按钮编码','zh-cn','2014-07-19 12:49:16','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:49:16','admin','管理员'),('4028810b474cecc301474cf407a90003','common.button.code','Button Code','en','2014-07-19 12:49:26','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:49:26','admin','管理员'),('4028810b474cecc301474cf46f7f0005','common.button.name','按钮名称','zh-cn','2014-07-19 12:49:53','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:49:53','admin','管理员'),('4028810b474cecc301474cf4994d0007','common.button.name','Button Name','en','2014-07-19 12:50:04','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:50:04','admin','管理员'),('4028810b474cecc301474cf4f6430009','common.button.style','按钮样式','zh-cn','2014-07-19 12:50:28','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:50:28','admin','管理员'),('4028810b474cecc301474cf517aa000b','common.button.style','Button Style','en','2014-07-19 12:50:36','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:50:36','admin','管理员'),('4028810b474cecc301474cf5930c000d','common.action.type','动作类型','zh-cn','2014-07-19 12:51:08','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:51:08','admin','管理员'),('4028810b474cecc301474cf5af11000f','common.action.type','Action Type','en','2014-07-19 12:51:15','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:51:15','admin','管理员'),('4028810b474cecc301474cf652c20011','common.show.sequence','Show Sequence','en','2014-07-19 12:51:57','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:04:07','8a8ab0b246dc81120146dc8181950052','admin'),('4028810b474cecc301474cf694a20013','common.show.sequence','显示顺序','zh-cn','2014-07-19 12:52:14','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:52:14','admin','管理员'),('4028810b474cecc301474cf6fa160015','common.show.icon.style','显示图标样式','zh-cn','2014-07-19 12:52:40','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:52:40','admin','管理员'),('4028810b474cecc301474cf71da40017','common.show.icon.style','Show Icon Style','en','2014-07-19 12:52:49','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:52:49','admin','管理员'),('4028810b474cecc301474cf776390019','common.show.expression','显示表达式','zh-cn','2014-07-19 12:53:11','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:53:11','admin','管理员'),('4028810b474cecc301474cf7972c001b','common.show.expression','Show Expression','en','2014-07-19 12:53:20','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 12:53:20','admin','管理员'),('4028810b474cecc301474d025ae20024','lang.code.cannot.add.update.delete','编码不能是add/update/delete','zh-cn','2014-07-19 13:05:05','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:05:05','admin','管理员'),('4028810b474cecc301474d0294e30026','lang.code.cannot.add.update.delete','Code cannot be add/update/delete','en','2014-07-19 13:05:20','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:05:20','admin','管理员'),('4028810b474d25ab01474d28a1fe0002','lang.user.online','人在线','zh-cn','2014-07-19 13:46:54','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:46:54','admin','管理员'),('4028810b474d25ab01474d28cef50004','lang.user.online','user online','en','2014-07-19 13:47:05','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:47:05','admin','管理员'),('4028810b474d25ab01474d2cc7d80006','common.login.name','登录名','zh-cn','2014-07-19 13:51:26','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:51:26','admin','管理员'),('4028810b474d25ab01474d2cf5650008','common.login.name','Login Name','en','2014-07-19 13:51:37','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:51:37','admin','管理员'),('4028810b474d25ab01474d2ed970000a','common.login.time','登录时间','zh-cn','2014-07-19 13:53:41','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:53:41','admin','管理员'),('4028810b474d25ab01474d2f0340000c','common.login.time','Login Time','en','2014-07-19 13:53:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:53:52','admin','管理员'),('4028810b474d25ab01474d2f0340001c','common.enter.verifycode','请输入验证码','zh-cn','2014-07-19 13:53:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:53:52','admin','管理员'),('4028810b474d25ab01474d2f0340002c','common.verifycode.error','验证码错误','zh-cn','2014-07-19 13:53:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:53:52','admin','管理员'),('4028810b474d25ab01474d2f0340003c','common.username.or.password.error','用户名或密码错误','zh-cn','2014-07-19 13:53:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:53:52','admin','管理员'),('4028810b474d25ab01474d2f0340004c','common.enter.verifycode','Please enter the verification code','en','2014-07-19 13:53:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:53:52','admin','管理员'),('4028810b474d25ab01474d2f0340005c','common.verifycode.error','Verification code error','en','2014-07-19 13:53:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:53:52','admin','管理员'),('4028810b474d25ab01474d2f0340006c','common.username.or.password.error','User name or password error','en','2014-07-19 13:53:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 13:53:52','admin','管理员'),('4028810b474d25ab01474d3ad8c9000f','common.select','选择','zh-cn','2014-07-19 14:06:48','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 14:06:48','admin','管理员'),('4028810b474d25ab01474d3b14bb0011','common.select','Select','en','2014-07-19 14:07:03','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 14:07:03','admin','管理员'),('4028810b474d25ab01474d3b61020013','common.clear','清空','zh-cn','2014-07-19 14:07:22','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 14:07:22','admin','管理员'),('4028810b474d25ab01474d3b78f30015','common.clear','Clear','en','2014-07-19 14:07:29','8a8ab0b246dc81120146dc8181950052','admin','2014-07-19 14:07:29','admin','管理员'),('4028813f4752b0d7014752b35e4f0001','username.rang2to10','User account need 2~10 bits','en','2014-07-20 15:36:32','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 15:36:32','admin','管理员'),('4028813f4752c793014752cd3369000a','common.delete.success.param','{0}删除成功','zh-cn','2014-07-20 16:04:45','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 16:04:45','admin','管理员'),('4028813f4752dc11014752e731930003','lang.dictionary.type','字典分类','zh-cn','2014-07-20 16:33:09','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 16:33:09','admin','管理员'),('4028813f4752dc11014752e765dd0005','lang.dictionary.type','Dictionary Type','en','2014-07-20 16:33:22','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 16:33:22','admin','管理员'),('4028813f4752dc11014752e98bf90007','lang.dictionary.value','字典值','zh-cn','2014-07-20 16:35:43','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 16:35:43','admin','管理员'),('4028813f4752dc11014752e9eba60009','lang.dictionary.value','Dictionary Value','en','2014-07-20 16:36:07','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 14:06:50','8a8ab0b246dc81120146dc8181950052','admin'),('4028818d46f7832b0146f793fd690016','common.taskid','Task Id','en','2014-07-02 22:56:50','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:41:28','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f794259e0018','common.taskid','任务ID','zh-cn','2014-07-02 22:57:00','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:19:13','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7949e2d001a','common.task.desc','任务描述','zh-cn','2014-07-02 22:57:31','4028818d46f764fb0146f7661cb60052','admin','2014-07-03 12:37:08','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f794d224001c','common.task.desc','Task Describe','en','2014-07-02 22:57:44','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:41:38','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79550c4001e','cron.expression','cron表达式','zh-cn','2014-07-02 22:58:16','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:22:37','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7956b7b0020','cron.expression','Cron Expression','en','2014-07-02 22:58:23','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:41:44','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f795c74b0022','common.iseffect','是否生效','zh-cn','2014-07-02 22:58:47','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:22:58','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79643cc0024','common.iseffect','isEffect','en','2014-07-02 22:59:19','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:23:03','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f796fbd60026','running.state','运行状态','zh-cn','2014-07-02 23:00:06','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:23:19','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79729ce0028','running.state','Running State','en','2014-07-02 23:00:17','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:41:52','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f798b8850034','common.createby','Create By','en','2014-07-02 23:02:00','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:41:58','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f798f9cf0036','common.createby','创建人','zh-cn','2014-07-02 23:02:16','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:23:44','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7999ffd003c','common.updateby','Update By','en','2014-07-02 23:02:59','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:42:12','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f799e7e9003e','common.updateby','修改人','zh-cn','2014-07-02 23:03:17','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:24:30','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79a3aed0040','common.updatetime','修改时间','zh-cn','2014-07-02 23:03:38','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:24:47','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79a6c310042','common.updatetime','Update Time','en','2014-07-02 23:03:51','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:42:21','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79b70e90044','common.operation','Operation','en','2014-07-02 23:04:58','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:42:27','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79b9eef0046','common.operation','操作','zh-cn','2014-07-02 23:05:10','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:25:17','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79d8ea10048','common.start','Start','en','2014-07-02 23:07:17','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:42:32','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79e5f54004c','common.stop','Stop','en','2014-07-02 23:08:10','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:42:38','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79e7be9004e','common.stop','停止','zh-cn','2014-07-02 23:08:17','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:26:27','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79faa1d0050','effective.immediately','Effective Immediately','en','2014-07-02 23:09:35','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:26:35','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f79fcc7f0052','effective.immediately','立即生效','zh-cn','2014-07-02 23:09:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:26:39','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a011b60054','common.delete','Delete','en','2014-07-02 23:10:01','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:42:44','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a02ccc0056','common.delete','删除','zh-cn','2014-07-02 23:10:08','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:26:55','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a0da820059','common.add','Add','en','2014-07-02 23:10:53','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:42:57','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a106cf005b','common.add','录入','zh-cn','2014-07-02 23:11:04','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:13','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a1500f005d','common.edit','Edit','en','2014-07-02 23:11:23','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:43:04','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a16f90005f','common.edit','编辑','zh-cn','2014-07-02 23:11:31','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:24','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a186c20061','common.view','View','en','2014-07-02 23:11:37','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:43:09','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a1aa900063','common.view','查看','zh-cn','2014-07-02 23:11:46','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:36','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a44eb60065','schedule.task.manage','Timed Task Manage','en','2014-07-02 23:14:39','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:28:08','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7a471110067','schedule.task.manage','定时任务管理','zh-cn','2014-07-02 23:14:48','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7b7f88700a0','log.content','Log Content','en','2014-07-02 23:36:08','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:41:04','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7b828ee00a2','log.content','日志内容','zh-cn','2014-07-02 23:36:20','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7b932f600a4','operate.ip','Operate IP','en','2014-07-02 23:37:28','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:43:30','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7b9677100a6','operate.ip','操作IP','zh-cn','2014-07-02 23:37:41','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7b9bd7d00a8','common.browser','Broswer','en','2014-07-02 23:38:04','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:43:36','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7b9f40a00aa','common.browser','浏览器','zh-cn','2014-07-02 23:38:17','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7ba2e7e00ac','operate.time','Operate Time','en','2014-07-02 23:38:32','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:43:44','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7ba610e00ae','operate.time','操作时间','zh-cn','2014-07-02 23:38:45','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7bb601a00b0','log.manage','Log Manage','en','2014-07-02 23:39:51','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7bb7ef200b2','log.manage','日志管理','zh-cn','2014-07-02 23:39:59','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7bbef3600b4','log.level','Log Level','en','2014-07-02 23:40:27','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c012cd00cc','select.loglevel','Please select log level','en','2014-07-02 23:44:59','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c086ff00ce','select.loglevel','选择日志类型','zh-cn','2014-07-02 23:45:28','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c0c98a00d0','common.login','Login','en','2014-07-02 23:45:45','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c0ecb900d2','common.login','登录','zh-cn','2014-07-02 23:45:54','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c287de00d9','common.insert','Insert','en','2014-07-02 23:47:40','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c2a1f200db','common.insert','插入','zh-cn','2014-07-02 23:47:46','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c4ad4600e1','common.update','Update','en','2014-07-02 23:50:00','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c4dc8700e3','common.update','更新','zh-cn','2014-07-02 23:50:12','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c5815c00e5','common.upload','Upload','en','2014-07-02 23:50:55','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c5a60600e7','common.upload','上传','zh-cn','2014-07-02 23:51:04','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c5fd5700e9','common.other','Other','en','2014-07-02 23:51:26','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46f7832b0146f7c62c2400eb','common.other','其他','zh-cn','2014-07-02 23:51:38','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('4028818d46fa75be0146fa855c60000e','log.level','日志类型','zh-cn','2014-07-03 12:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('402881b74e234fb0014e239611a10034','auto.form.formName','表单名称','zh-cn','2015-06-24 11:21:54','admin','管理员',NULL,NULL,NULL),('402881b74e234fb0014e239641ff0036','auto.form.formName','formName','en','2015-06-24 11:22:06','admin','管理员',NULL,NULL,NULL),('402881b74e234fb0014e23968fe00038','auto.form.formDesc','表单描述','zh-cn','2015-06-24 11:22:26','admin','管理员',NULL,NULL,NULL),('402881b74e234fb0014e2396b425003a','auto.form.formDesc','formDesc','en','2015-06-24 11:22:35','admin','管理员',NULL,NULL,NULL),('402881b74e234fb0014e23980122003c','auto.form.formContent','formContent','en','2015-06-24 11:24:01','admin','管理员',NULL,NULL,NULL),('402881b74e234fb0014e23984307003e','auto.form.formContent','表单内容','zh-cn','2015-06-24 11:24:18','admin','管理员',NULL,NULL,NULL),('402881b74e4833b6014e48397c250003','auto.form.addorupdate','表单设计器','zh-cn','2015-07-01 14:06:43','admin','管理员',NULL,NULL,NULL),('402881b74e4833b6014e483b9ed60008','auto.form.addorupdate','formdesign','en','2015-07-01 14:09:03','admin','管理员',NULL,NULL,NULL),('402881b74e4833b6014e483fbd30000a','formstyle.title','自定义表单模板','zh-cn','2015-07-01 14:13:33','admin','管理员','2015-10-27 22:41:20','admin','管理员'),('402881b74e4833b6014e48409456000c','formstyle.title','formTemplate','en','2015-07-01 14:14:28','admin','管理员','2015-10-27 22:41:37','admin','管理员'),('402881c046efce8d0146effd3b0a0001','common.language','语言','zh-cn','2014-07-01 11:34:48','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 11:41:20','8a8ab0b246dc81120146dc8181950052','admin'),('402881c046efce8d0146effd5d980003','language','Languge','en','2014-07-01 11:34:57','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 12:01:46','8a8ab0b246dc81120146dc8181950052','admin'),('402881c046efce8d0146f001f7cd0007','common.delete.success.param','{0} delete success','en','2014-07-01 11:39:59','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 11:40:26','8a8ab0b246dc81120146dc8181950052','admin'),('402881c046efce8d0146f00e2152000b','common.edit.success.param','{0} 更新成功','zh-cn','2014-07-01 11:53:16','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 12:17:01','8a8ab0b246dc81120146dc8181950052','admin'),('402881c046efce8d0146f00f05aa000d','common.edit.success.param','{0} update success','en','2014-07-01 11:54:14','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 16:03:05','8a8ab0b246dc81120146dc8181950052','admin'),('402881c046efce8d0146f01110bc000f','common.add.success.param','{0} 录入成功','zh-cn','2014-07-01 11:56:28','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 11:56:28','admin','管理员'),('402881c046efce8d0146f01153070011','common.add.success.param','{0} add success','en','2014-07-01 11:56:45','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 11:56:45','admin','管理员'),('402881c046f02a3f0146f02d9e910002','common.refresh.success','刷新成功','zh-cn','2014-07-01 12:27:40','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 12:27:40','admin','管理员'),('402881c046f02a3f0146f02df49c0004','common.refresh.success','Refresh success','en','2014-07-01 12:28:02','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 12:28:02','admin','管理员'),('402881c046f02a3f0146f0301b150006','common.edit.fail.param','{0} 更新失败','zh-cn','2014-07-01 12:30:22','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 12:30:22','admin','管理员'),('402881c046f02a3f0146f030cde00008','common.edit.fail.param','{0} update fail','en','2014-07-01 12:31:08','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 12:31:08','admin','管理员'),('402881c046f02a3f0146f0346009000a','common.refresh.fail','刷新失败','zh-cn','2014-07-01 12:35:02','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 12:35:02','admin','管理员'),('402881c046f02a3f0146f0348bc9000c','common.refresh.fail','Refresh Fail','en','2014-07-01 12:35:13','8a8ab0b246dc81120146dc8181950052','admin','2014-07-01 12:35:13','admin','管理员'),('402881c1470636fe0147063dc2080001','database.property','数据库属性','zh-cn','2014-07-05 19:16:56','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:16:56','admin','管理员'),('402881c1470636fe0147063e03aa0003','database.property','Database Property','en','2014-07-05 19:17:13','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:17:13','admin','管理员'),('402881c1470636fe0147063e73640005','page.property','页面属性','zh-cn','2014-07-05 19:17:41','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:17:41','admin','管理员'),('402881c1470636fe0147063e910c0007','page.property','Page Property','en','2014-07-05 19:17:49','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:17:49','admin','管理员'),('402881c1470636fe0147063f9a4a0009','validate.dict','Validate Dictionary','en','2014-07-05 19:18:57','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:18:57','admin','管理员'),('402881c1470636fe0147063fe101000b','validate.dict','校验字典','zh-cn','2014-07-05 19:19:15','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:19:15','admin','管理员'),('402881c1470636fe014706408c51000d','common.fk','外键','zh-cn','2014-07-05 19:19:59','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:19:59','admin','管理员'),('402881c1470636fe0147064102b0000f','common.fk','Foreign Key','en','2014-07-05 19:20:29','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:20:29','admin','管理员'),('402881c1470636fe0147065887a70011','smark.form.form.maintain','智能表单-表单维护','zh-cn','2014-07-05 19:46:10','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:46:10','admin','管理员'),('402881c1470636fe01470658c29d0013','smark.form.form.maintain','Smart Form','en','2014-07-05 19:46:26','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:46:26','admin','管理员'),('402881c1470636fe0147065a870d0015','common.one.to.many','一对多','zh-cn','2014-07-05 19:48:21','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:48:21','admin','管理员'),('402881c1470636fe0147065acd6d0017','common.one.to.many','One To Many','en','2014-07-05 19:48:39','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:48:39','admin','管理员'),('402881c1470636fe0147065c1d980019','comon.one.to.one','一对一','zh-cn','2014-07-05 19:50:05','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:50:05','admin','管理员'),('402881c1470636fe0147065c3551001b','comon.one.to.one','One To One','en','2014-07-05 19:50:12','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:50:12','admin','管理员'),('402881c1470636fe0147066041eb001d','common.uuid36bit','UUID(36位唯一编码)','zh-cn','2014-07-05 19:54:37','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:54:37','admin','管理员'),('402881c1470636fe01470660a327001f','common.uuid36bit','UUID(36 Bit Unique Code)','en','2014-07-05 19:55:02','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:55:02','admin','管理员'),('402881c1470636fe0147066267e70021','common.native.auto.increment','NATIVE(自增长方式)','zh-cn','2014-07-05 19:56:58','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:56:58','admin','管理员'),('402881c1470636fe01470662f1dd0023','common.native.auto.increment','NATIVE(Auto Increment)','en','2014-07-05 19:57:33','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:57:33','admin','管理员'),('402881c1470636fe01470663fbd00025','common.sequence','SEQUENCE(序列方式)','zh-cn','2014-07-05 19:58:41','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:58:41','admin','管理员'),('402881c1470636fe014706646c6b0027','common.sequence','SEQUENCE(Sequence)','en','2014-07-05 19:59:10','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 19:59:19','8a8ab0b246dc81120146dc8181950052','admin'),('402881c1470636fe014706669f32002a','please.input.table.name','请输入表名！','zh-cn','2014-07-05 20:01:34','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 20:01:34','admin','管理员'),('402881c1470636fe01470666c8e8002c','please.input.table.name','Please Input Table Name','en','2014-07-05 20:01:45','8a8ab0b246dc81120146dc8181950052','admin','2014-07-05 20:01:45','admin','管理员'),('402881c347203fcc0147204d69020009','input.error','输入错误','zh-cn','2014-07-10 20:44:09','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 20:44:09','admin','管理员'),('402881c347203fcc0147204d9ef9000b','input.error','Input error','en','2014-07-10 20:44:23','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 20:44:23','admin','管理员'),('402881c347205fc0014720704aa50001','menuname.rang4to15','菜单名称范围4~15位字符,且不为空','zh-cn','2014-07-10 21:22:15','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 21:22:15','admin','管理员'),('402881c347205fc0014720718d360003','menuname.rang4to15','Menu name should be 4-15 characters and should not empty','en','2014-07-10 21:23:38','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 21:23:38','admin','管理员'),('402881c347205fc001472082f5130005','jeect.platform','Jeecg 快速开发平台','zh-cn','2014-07-10 21:42:39','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 21:42:39','admin','管理员'),('402881c347205fc00147208321e10007','jeect.platform','Jeecg Quckly Platform','en','2014-07-10 21:42:50','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 21:42:50','admin','管理员'),('402881c347205fcc0014720704aa5000','menuname.rang2to15','菜单名称范围2~15位字符,且不为空','zh-cn','2014-07-10 21:22:15','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 21:22:15','admin','管理员'),('402881c347205fcd0014720718d36000','menuname.rang2to15','Menu name should be 2-15 characters and should not empty','en','2014-07-10 21:23:38','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 21:23:38','admin','管理员'),('402881e446f486df0146f49af73f0001','pk.strategies','Primary key strategies','en','2014-07-02 09:05:35','402881e946e70d550146e70fa0680086','admin','2014-07-02 09:05:35','admin','管理员'),('402881e446f486df0146f49c57320003','pk.strategies','主键策略','zh-cn','2014-07-02 09:07:05','402881e946e70d550146e70fa0680086','admin','2014-07-02 09:07:05','admin','管理员'),('402881e446f5ec0b0146f5f492d60001','table.name','表名','zh-cn','2014-07-02 15:23:04','402881e946e70d550146e70fa0680086','admin','2014-07-02 15:23:04','admin','管理员'),('402881e446f5ec0b0146f5f4b8fe0003','table.name','Table Name','en','2014-07-02 15:23:14','402881e946e70d550146e70fa0680086','admin','2014-07-02 15:23:14','admin','管理员'),('402881e446f5ec0b0146f5f536b50005','table.description','Table Desc','en','2014-07-02 15:23:46','402881e946e70d550146e70fa0680086','admin','2014-07-21 10:16:11','8a8ab0b246dc81120146dc8181950052','admin'),('402881e446f5ec0b0146f5f56e0d0007','table.description','表描述','zh-cn','2014-07-02 15:24:00','402881e946e70d550146e70fa0680086','admin','2014-07-21 10:16:15','8a8ab0b246dc81120146dc8181950052','admin'),('402881e446f5ec0b0146f5f648c00009','table.type','Table Type','en','2014-07-02 15:24:56','402881e946e70d550146e70fa0680086','admin','2014-07-02 15:24:56','admin','管理员'),('402881e446f5ec0b0146f5f672b6000b','table.type','表类型','zh-cn','2014-07-02 15:25:07','402881e946e70d550146e70fa0680086','admin','2014-07-02 15:25:07','admin','管理员'),('402881e446f5ec0b0146f61534a0000d','sequence.name','Sequence','en','2014-07-02 15:58:43','402881e946e70d550146e70fa0680086','admin','2016-03-01 21:26:48','admin','管理员'),('402881e446f5ec0b0146f621503b0019','master.table','主表','zh-cn','2014-07-02 16:11:56','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:11:56','admin','管理员'),('402881e446f5ec0b0146f621dddd001b','master.table','Master Table','en','2014-07-02 16:12:33','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:12:33','admin','管理员'),('402881e446f5ec0b0146f6279e0f001d','common.yes','Yes','en','2014-07-02 16:18:50','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:18:49','admin','管理员'),('402881e446f5ec0b0146f627cd1f001f','common.yes','是','zh-cn','2014-07-02 16:19:02','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:19:02','admin','管理员'),('402881e446f5ec0b0146f627f2040021','common.no','No','en','2014-07-02 16:19:11','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:19:11','admin','管理员'),('402881e446f5ec0b0146f6281f900023','common.no','否','zh-cn','2014-07-02 16:19:23','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:19:23','admin','管理员'),('402881e446f5ec0b0146f62fe8800025','single.query','Single Choice Query','en','2014-07-02 16:27:53','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:27:53','admin','管理员'),('402881e446f5ec0b0146f6302a9f0027','single.query','单表查询','zh-cn','2014-07-02 16:28:10','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:28:10','admin','管理员'),('402881e446f5ec0b0146f630e67d0029','combine.query','组合查询','zh-cn','2014-07-02 16:28:58','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:28:58','admin','管理员'),('402881e446f5ec0b0146f6312721002b','combine.query','Combined Query','en','2014-07-02 16:29:14','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:29:14','admin','管理员'),('402881e446f5ec0b0146f6422c510036','common.isnull','Is Null','en','2014-07-02 16:47:50','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:47:50','admin','管理员'),('402881e446f5ec0b0146f6428fd00038','common.isnull','是否为空','zh-cn','2014-07-02 16:48:15','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:48:15','admin','管理员'),('402881e446f5ec0b0146f642e30f003a','common.pk','Primary Key','en','2014-07-02 16:48:37','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:48:37','admin','管理员'),('402881e446f5ec0b0146f64311fb003c','common.pk','主键','zh-cn','2014-07-02 16:48:49','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:48:49','admin','管理员'),('402881e446f5ec0b0146f6457894003e','field.type','Filed Type','en','2014-07-02 16:51:26','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:51:26','admin','管理员'),('402881e446f5ec0b0146f6459cd30040','field.type','字段类型','zh-cn','2014-07-02 16:51:35','402881e946e70d550146e70fa0680086','admin','2014-07-02 16:51:35','admin','管理员'),('402881e44df713f5014df72de2170028','form.db.type','数据源类型','zh-cn','2015-06-15 20:24:48','admin','管理员','2015-06-15 20:34:07','admin','管理员'),('402881e44df713f5014df72f5a47002b','form.db.type','formDbType','en','2015-06-15 20:26:25','admin','管理员','2015-06-16 16:23:46','admin','管理员'),('402881e44df713f5014df73a703d0031','form.db.type.table','数据库表','zh-cn','2015-06-15 20:38:31','admin','管理员',NULL,NULL,NULL),('402881e44df713f5014df73ac0d20033','form.db.type.table','TABLE','en','2015-06-15 20:38:52','admin','管理员',NULL,NULL,NULL),('402881e44df713f5014df73b30750035','form.db.type.sql','动态SQL','zh-cn','2015-06-15 20:39:20','admin','管理员',NULL,NULL,NULL),('402881e44df713f5014df73bdc330037','form.db.type.sql','DYN_SQL','en','2015-06-15 20:40:04','admin','管理员',NULL,NULL,NULL),('402881e44df713f5014df73c6e6f0039','form.db.type.clazz','java类','zh-cn','2015-06-15 20:40:42','admin','管理员',NULL,NULL,NULL),('402881e44df713f5014df73c91d0003b','form.db.type.clazz','CLAZZ','en','2015-06-15 20:40:51','admin','管理员',NULL,NULL,NULL),('402881e44dfc7bea014dfc7e0a170005','common.company.code','sysCompanyCode','en','2015-06-16 21:10:28','admin','管理员',NULL,NULL,NULL),('402881e44dfc7bea014dfc7e3b740007','common.company.code','所属公司','zh-cn','2015-06-16 21:10:40','admin','管理员',NULL,NULL,NULL),('402881e44e06f820014e06fa58e90001','form.param.name','参数','zh-cn','2015-06-18 22:02:26','admin','管理员','2015-10-27 19:49:03','admin','管理员'),('402881e44e06f820014e06fa81ab0003','form.param.name','param','en','2015-06-18 22:02:37','admin','管理员','2015-10-27 19:49:18','admin','管理员'),('402881e44e06f820014e06fab7c70005','form.param.desc','参数文本','zh-cn','2015-06-18 22:02:51','admin','管理员',NULL,NULL,NULL),('402881e44e06f820014e06fad8e80007','form.param.desc','paramTxt','en','2015-06-18 22:02:59','admin','管理员',NULL,NULL,NULL),('402881e44e06f820014e06fb161f0009','form.param.value','默认值','zh-cn','2015-06-18 22:03:15','admin','管理员','2015-10-27 19:44:45','admin','管理员'),('402881e44e06f820014e06fb489c000b','form.param.value','defaultValue','en','2015-06-18 22:03:28','admin','管理员','2015-10-27 19:45:07','admin','管理员'),('402881e44e06f820014e06fc10b0000d','form.field.name','字段','zh-cn','2015-06-18 22:04:19','admin','管理员',NULL,NULL,NULL),('402881e44e06f820014e06fc6141000f','form.field.name','field','en','2015-06-18 22:04:40','admin','管理员',NULL,NULL,NULL),('402881e44e5d67e1014e5d7245f20002','autoform.preview','预览','zh-cn','2015-07-05 17:00:47','admin','管理员',NULL,NULL,NULL),('402881e44e5d67e1014e5d726b1d0004','autoform.preview','preview','en','2015-07-05 17:00:56','admin','管理员',NULL,NULL,NULL),('402881e453a3a2550153a3b80b0f0001','please.muti.department','please.muti.department','en','2016-03-23 21:44:21','admin','管理员',NULL,NULL,NULL),('402881e453a3a2550153a3b868250003','please.muti.department','部门可多选','zh-cn','2016-03-23 21:44:45','admin','管理员',NULL,NULL,NULL),('402881e54dcddf80014dcde2db0a000b','form.category','表单分类','zh-cn','2015-06-07 19:58:26','admin','管理员',NULL,NULL,NULL),('402881e54dce2349014dce3e00e80005','form.category','formCategory','en','2015-06-07 21:37:59','admin','管理员',NULL,NULL,NULL),('402881e54dce2349014dce3e43b50007','bdfl','bdfl','zh-cn','2015-06-07 21:38:16','admin','管理员','2015-06-07 21:44:17','admin','管理员'),('402881e54de251ee014de2713e550001','common.ssms.getSysInfos','系统消息','zh-cn','2015-06-11 19:46:22','admin','管理员',NULL,NULL,NULL),('402881e54de251ee014de27235560003','common.ssms.getSysInfos','System message','en','2015-06-11 19:47:25','admin','管理员',NULL,NULL,NULL),('402881e55a6b49b0015a6b5456f40002','common.department.hasuser','组织机构下有用户,不可直接删除','zh-cn','2017-02-23 22:16:14','admin','管理员','2017-02-23 22:19:54','admin','管理员'),('402881e55a6b49b0015a6b55b7510004','common.department.hasuser','the department has related users','en','2017-02-23 22:17:44','admin','管理员',NULL,NULL,NULL),('402881e74e44c238014e44c40deb0001','form.db.query.param','查询参数','zh-cn','2015-06-30 21:59:36','admin','管理员',NULL,NULL,NULL),('402881e74e44c238014e44c44e7d0003','form.db.query.param','queryParam','en','2015-06-30 21:59:52','admin','管理员',NULL,NULL,NULL),('402881e74e44c238014e44d0a7400005','form.db.query.data.column','查询数据列','zh-cn','2015-06-30 22:13:21','admin','管理员',NULL,NULL,NULL),('402881e74e44c238014e44d0e08a0007','form.db.query.data.column','queryDataColumn','en','2015-06-30 22:13:36','admin','管理员',NULL,NULL,NULL),('402881e946eca0a40146eca464640011','common.version','Version','en','2014-06-30 19:58:55','402881e946e70d550146e70fa0680086','admin','2014-06-30 19:58:55','admin','管理员'),('402881e946eca0a40146eca47e280013','common.version','版本','zh-cn','2014-06-30 19:59:01','402881e946e70d550146e70fa0680086','admin','2014-06-30 19:59:01','admin','管理员'),('402881e946eca0a40146eca4b6bf0015','is.tree','Is Tree','en','2014-06-30 19:59:16','402881e946e70d550146e70fa0680086','admin','2014-06-30 19:59:16','admin','管理员'),('402881e946eca0a40146eca4d8ba0017','is.tree','是否树','zh-cn','2014-06-30 19:59:24','402881e946e70d550146e70fa0680086','admin','2014-06-30 19:59:24','admin','管理员'),('402881e946eca0a40146eca510d60019','is.page','Is Page','en','2014-06-30 19:59:39','402881e946e70d550146e70fa0680086','admin','2014-06-30 19:59:39','admin','管理员'),('402881e946eca0a40146eca537b7001b','is.page','是否分页','zh-cn','2014-06-30 19:59:49','402881e946e70d550146e70fa0680086','admin','2014-06-30 19:59:49','admin','管理员'),('402881e946eca0a40146eca6c3b8001d','sync.db','Sync DB','en','2014-06-30 20:01:30','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:01:30','admin','管理员'),('402881e946eca0a40146eca7193f001f','sync.db','同步数据库','zh-cn','2014-06-30 20:01:52','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:01:52','admin','管理员'),('402881e946eca0a40146eca922890025','common.createtime','Create Time','en','2014-06-30 20:04:05','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:04:05','admin','管理员'),('402881e946eca0a40146ecab61a50033','common.createtime','创建时间','zh-cn','2014-06-30 20:06:33','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:53:48','402881e946e70d550146e70fa0680086','admin'),('402881e946eca0a40146ecac51520039','show.checkbox','Show Checkbox','en','2014-06-30 20:07:34','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:07:34','admin','管理员'),('402881e946eca0a40146ecac8bed003b','show.checkbox','显示复选框','zh-cn','2014-06-30 20:07:49','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:07:49','admin','管理员'),('402881e946eca0a40146ecaea5630041','edit.form','Edit Table','en','2014-06-30 20:10:07','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:10:07','admin','管理员'),('402881e946eca0a40146ecaed7730043','edit.form','编辑表单','zh-cn','2014-06-30 20:10:19','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:10:19','admin','管理员'),('402881e946eca0a40146ecaf39000045','create.form','Create From','en','2014-06-30 20:10:44','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:10:44','admin','管理员'),('402881e946eca0a40146ecaf63e00047','create.form','创建表单','zh-cn','2014-06-30 20:10:55','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:10:55','admin','管理员'),('402881e946eca0a40146ecb108de0049','custom.button','Custom Button','en','2014-06-30 20:12:43','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:12:43','admin','管理员'),('402881e946eca0a40146ecb18fa6004b','custom.button','自定义按钮','zh-cn','2014-06-30 20:13:18','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:13:31','402881e946e70d550146e70fa0680086','admin'),('402881e946eca0a40146ecb3bd13004e','form.generate','Generated From From DB','en','2014-06-30 20:15:40','402881e946e70d550146e70fa0680086','admin','2014-09-15 11:28:33','admin','管理员'),('402881e946eca0a40146ecb3f9df0050','form.generate','数据库导入表单','zh-cn','2014-06-30 20:15:56','402881e946e70d550146e70fa0680086','admin','2014-09-15 11:28:19','admin','管理员'),('402881e946eca0a40146ecb58ed40052','form.import','表单导入','zh-cn','2014-06-30 20:17:40','402881e946e70d550146e70fa0680086','admin','2014-09-15 11:28:01','admin','管理员'),('402881e946eca0a40146ecb5a76b0054','form.import','From Import','en','2014-06-30 20:17:46','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:17:46','admin','管理员'),('402881e946eca0a40146ecb72e600056','form.export','From Export','en','2014-06-30 20:19:26','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:19:26','admin','管理员'),('402881e946eca0a40146ecb762b50058','form.export','表单导出','zh-cn','2014-06-30 20:19:39','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:40:55','402881e946e70d550146e70fa0680086','admin'),('402881e946eca0a40146ecc71340005a','js.enhance','JsEnhance','en','2014-06-30 20:36:48','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:36:48','admin','管理员'),('402881e946eca0a40146ecc74476005c','js.enhance','js增强','zh-cn','2014-06-30 20:37:00','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:37:00','admin','管理员'),('402881e946eca0a40146ecca27d20062','sql.enhance','SqlEnhance','en','2014-06-30 20:40:09','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:40:09','admin','管理员'),('402881e946eca0a40146ecca51c60064','sql.enhance','sql增强','zh-cn','2014-06-30 20:40:20','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:40:20','admin','管理员'),('402881e946eca0a40146ecd312230068','smart.form.config','Smart Form Config','en','2014-06-30 20:49:54','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:49:54','admin','管理员'),('402881e946eca0a40146ecd3732a006a','smart.form.config','智能表单配置','zh-cn','2014-06-30 20:50:19','402881e946e70d550146e70fa0680086','admin','2014-06-30 20:50:19','admin','管理员'),('402881e946f723300146f728bca20001','common.code','Code','en','2014-07-02 20:59:40','402881e946e70d550146e70fa0680086','admin','2014-07-02 20:59:40','admin','管理员'),('402881e946f723300146f728e6220003','common.code','编码','zh-cn','2014-07-02 20:59:51','402881e946e70d550146e70fa0680086','admin','2014-07-02 20:59:51','admin','管理员'),('402881e946f723300146f72b42b40015','common.batch.delete','Batch Delete','en','2014-07-02 21:02:25','402881e946e70d550146e70fa0680086','admin','2014-07-02 21:02:25','admin','管理员'),('402881e946f723300146f72b9a000017','common.batch.delete','批量删除','zh-cn','2014-07-02 21:02:48','402881e946e70d550146e70fa0680086','admin','2014-07-02 21:02:48','admin','管理员'),('402881e946f723300146f72ce5260021','query.sql','Query Sql','en','2014-07-02 21:04:13','402881e946e70d550146e70fa0680086','admin','2014-07-02 21:04:13','admin','管理员'),('402881e946f723300146f72d1b480023','query.sql','查询sql','zh-cn','2014-07-02 21:04:26','402881e946e70d550146e70fa0680086','admin','2014-07-02 21:04:26','admin','管理员'),('402881e946f723300146f72d54c60025','common.name','Name','en','2014-07-02 21:04:41','402881e946e70d550146e70fa0680086','admin','2014-07-02 21:04:41','admin','管理员'),('402881e946f723300146f72d72840027','common.name','名称','zh-cn','2014-07-02 21:04:49','402881e946e70d550146e70fa0680086','admin','2014-07-02 21:04:49','admin','管理员'),('402881e946f723300146f72e486c0029','dynamic.table.head','Dynamic Table','en','2014-07-02 21:05:44','402881e946e70d550146e70fa0680086','admin','2014-07-02 21:05:44','admin','管理员'),('402881e946f723300146f72e7bda002b','dynamic.table.head','动态表头','zh-cn','2014-07-02 21:05:57','402881e946e70d550146e70fa0680086','admin','2014-07-02 21:05:57','admin','管理员'),('402881ea4706d22b014706da32a10009','common.order','Order','en','2014-07-05 22:07:48','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:07:48','admin','管理员'),('402881ea4706d22b014706da55fa000b','common.order','排序','zh-cn','2014-07-05 22:07:57','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:07:57','admin','管理员'),('402881ea4706d22b014706daa606000d','common.text','Field Text','en','2014-07-05 22:08:18','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:08:18','admin','管理员'),('402881ea4706d22b014706dadb74000f','common.text','字段文本','zh-cn','2014-07-05 22:08:32','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:08:32','admin','管理员'),('402881ea4706d22b014706db1a6f0011','common.type','Type','en','2014-07-05 22:08:48','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:08:48','admin','管理员'),('402881ea4706d22b014706db389d0013','common.type','类型','zh-cn','2014-07-05 22:08:55','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:08:55','admin','管理员'),('402881ea4706d22b014706db76390015','common.isshow','Is Show','en','2014-07-05 22:09:11','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:09:11','admin','管理员'),('402881ea4706d22b014706db99420017','common.isshow','是否显示','zh-cn','2014-07-05 22:09:20','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:09:20','admin','管理员'),('402881ea4706d22b014706dbdb330019','common.href','Href','en','2014-07-05 22:09:37','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:09:37','admin','管理员'),('402881ea4706d22b014706dc0bfe001b','common.href','字段href','zh-cn','2014-07-05 22:09:50','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:09:50','admin','管理员'),('402881ea4706d22b014706dc5fc0001d','common.query.module','Query Module','en','2014-07-05 22:10:11','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:10:11','admin','管理员'),('402881ea4706d22b014706dc87df001f','common.query.module','查询模式','zh-cn','2014-07-05 22:10:21','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:10:21','admin','管理员'),('402881ea4706d22b014706dd524d0021','dict.code','字典Code','zh-cn','2014-07-05 22:11:13','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:11:13','admin','管理员'),('402881ea4706d22b014706dd8a300023','dict.code','Dict Code','en','2014-07-05 22:11:27','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:11:27','admin','管理员'),('402881ea4706d22b014706ddc7570025','common.isquery','Is Query','en','2014-07-05 22:11:43','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:11:43','admin','管理员'),('402881ea4706d22b014706ddec9e0027','common.isquery','是否查询','zh-cn','2014-07-05 22:11:53','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:11:53','admin','管理员'),('402881ea4706d22b014706e230b80029','common.text.type','Column Type','en','2014-07-05 22:16:32','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:16:32','admin','管理员'),('402881ea4706d22b014706e25a9f002b','common.text.type','文本类型','zh-cn','2014-07-05 22:16:43','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:16:43','admin','管理员'),('402881ea4706d22b014706e368c9002d','common.hide','Hideen','en','2014-07-05 22:17:52','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:17:52','admin','管理员'),('402881ea4706d22b014706e3b1e2002f','common.hide','隐藏','zh-cn','2014-07-05 22:18:11','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:18:11','admin','管理员'),('402881ea4706d22b014706e3fe800031','common.show','Show','en','2014-07-05 22:18:30','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:18:30','admin','管理员'),('402881ea4706d22b014706e423e40033','common.show','显示','zh-cn','2014-07-05 22:18:40','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:18:40','admin','管理员'),('402881ea4706d22b014706eba47c003e','dynamic.report.config.detail','Dyna Report Detail','en','2014-07-05 22:26:52','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:29:53','402881e946e70d550146e70fa0680086','admin'),('402881ea4706d22b014706ebe1cd0040','dynamic.report.config.detail','动态报表配置明细','zh-cn','2014-07-05 22:27:07','402881e946e70d550146e70fa0680086','admin','2014-07-05 22:30:02','402881e946e70d550146e70fa0680086','admin'),('402881ea5b2472b6015b2479b9ba0001','common.typemode','Cascade switch','en','2017-03-31 21:06:48','admin','管理员',NULL,NULL,NULL),('402881ea5b2472b6015b247aa19a0003','common.typemode','切换模式','zh-cn','2017-03-31 21:07:48','admin','管理员',NULL,NULL,NULL),('402881fa470fe92601470fefea200003','dict.manage','数据字典管理','zh-cn','2014-07-07 16:28:07','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601470ff21ddd0009','dict.name','Dict Name','en','2014-07-07 16:30:31','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601470ff24cb8000b','dict.name','字典名称','zh-cn','2014-07-07 16:30:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601470ff4e2830019','common.add.param','{0} Add','en','2014-07-07 16:33:33','4028818d46f764fb0146f7661cb60052','admin','2014-07-20 16:02:09','8a8ab0b246dc81120146dc8181950052','admin'),('402881fa470fe92601470ff51cc9001b','common.add.param','{0}录入','zh-cn','2014-07-07 16:33:48','4028818d46f764fb0146f7661cb60052','admin','2014-07-20 16:02:23','8a8ab0b246dc81120146dc8181950052','admin'),('402881fa470fe92601470ff925da0025','dict.information.type','Data Dictionary Group Info','en','2014-07-07 16:38:12','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601470ff950100027','dict.information.type','字典类型信息','zh-cn','2014-07-07 16:38:23','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:43:03','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601471005919a0037','common.role.list','Role List','en','2014-07-07 16:51:46','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601471005f5ac0039','common.role.list','角色列表','zh-cn','2014-07-07 16:52:12','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601471006c0bf003f','common.role.code','Role Code','en','2014-07-07 16:53:04','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601471006e44a0041','common.role.code','角色编码','zh-cn','2014-07-07 16:53:13','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147100713840043','common.role.name','Role Name','en','2014-07-07 16:53:25','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe926014710073e820045','common.role.name','角色名称','zh-cn','2014-07-07 16:53:36','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe926014710095eb50053','common.edit.param','{0} Edit','en','2014-07-07 16:55:55','4028818d46f764fb0146f7661cb60052','admin','2014-07-20 15:07:04','8a8ab0b246dc81120146dc8181950052','admin'),('402881fa470fe9260147100980ee0055','common.edit.param','{0}编辑','zh-cn','2014-07-07 16:56:04','4028818d46f764fb0146f7661cb60052','admin','2014-07-20 15:07:13','8a8ab0b246dc81120146dc8181950052','admin'),('402881fa470fe9260147100affff0057','common.role.info','Role Info','en','2014-07-07 16:57:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147100b20eb0059','common.role.info','角色信息','zh-cn','2014-07-07 16:57:51','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147100bf680005b','permission.set','Permission','en','2014-07-07 16:58:45','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147100c2c96005d','permission.set','权限设置','zh-cn','2014-07-07 16:58:59','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147100e5051005f','permission.manage','Permission Manage','en','2014-07-07 17:01:19','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147100e8a360061','permission.manage','权限管理','zh-cn','2014-07-07 17:01:34','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147100f73140067','permission.name','Permission Name','en','2014-07-07 17:02:34','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147100fa9270069','permission.name','权限名称','zh-cn','2014-07-07 17:02:48','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe9260147101199f1006f','permission.collection','Permission Collection','en','2014-07-07 17:04:55','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402881fa470fe92601471011bb380071','permission.collection','权限集合','zh-cn','2014-07-07 17:05:03','4028818d46f764fb0146f7661cb60052','admin','2014-07-07 16:42:54','4028818d46f764fb0146f7661cb60052','admin'),('402882b54e3eaa5b014e3ebde5d1000b','menu.online.template','Online表单样式','zh-cn','2015-06-29 17:55:09','admin','管理员','2015-10-15 10:43:08','admin','管理员'),('402882b54e943804014e944151e30001','form.template.style','自定义表单风格','zh-cn','2015-07-16 08:26:26','admin','管理员','2015-07-16 15:06:03','admin','管理员'),('402882b54e943804014e944196d10003','form.template.style','Custom Template Style','en','2015-07-16 08:26:43','admin','管理员','2015-07-16 15:05:52','admin','管理员'),('402882e54ebb5629014ebb5c56540003','form.tb.db.key','填报数据源','zh-cn','2015-07-23 22:41:08','admin','管理员',NULL,NULL,NULL),('402882e54ebb5629014ebb5ca0650005','form.tb.db.table.name','填报数据库表','zh-cn','2015-07-23 22:41:27','admin','管理员',NULL,NULL,NULL),('402883884dc3b87d014dc3ba4cbd0001','common.menu.del.fail','删除失败，有关联数据不能删除!','zh-cn','2015-06-05 20:37:56','admin','管理员',NULL,NULL,NULL),('402883884dd31b11014dd31cedf20001','common.dynamic.dbsource','数据源','zh-cn','2015-06-08 20:19:58','admin','管理员',NULL,NULL,NULL),('4028838850ac5c1d0150ac6389e80001','form.db.chname','数据源名称','zh-cn','2015-10-28 11:00:16','admin','管理员',NULL,NULL,NULL),('4028838850ac5c1d0150ac63cd910003','form.db.chname','dbName','en','2015-10-28 11:00:33','admin','管理员',NULL,NULL,NULL),('4028838850ae6f7b0150ae720a9c0003','form.field.content','字段文本','zh-cn','2015-10-28 20:35:21','admin','管理员',NULL,NULL,NULL),('4028838850ae6f7b0150ae72f8960005','form.field.content','fieldContent','en','2015-10-28 20:36:22','admin','管理员',NULL,NULL,NULL),('402884f146cc37ab0146cc3fc7350002','common.change.refresh','样式修改成功，请刷新页面','zh-cn','2014-06-24 13:01:10','admin','管理员','2014-06-24 13:01:10','admin','管理员'),('402884f146cc37ab0146cc4029a60004','common.change.refresh','Style change success, please refresh','en','2014-06-24 13:01:35','admin','管理员','2014-06-24 13:01:35','admin','管理员'),('402884f146cc37ab0146cc4541cb0006','common.login.again','请登录后再操作','zh-cn','2014-06-24 13:07:09','admin','管理员','2014-06-24 13:07:09','admin','管理员'),('402884f146cc37ab0146cc45c1270008','common.login.again','Please login again','en','2014-06-24 13:07:41','admin','管理员','2014-06-24 13:07:41','admin','管理员'),('402884f146cc37ab0146cc4de4da000a','common.userinfo','用户信息','zh-cn','2014-06-24 13:16:35','admin','管理员','2014-06-24 13:16:35','admin','管理员'),('402884f146cc37ab0146cc4e7b25000c','common.userinfo','My Profile','en','2014-06-24 13:17:13','admin','管理员','2014-06-24 13:17:13','admin','管理员'),('402884f146cc37ab0146cc55cac30012','common.surname','姓名','zh-cn','2014-06-24 13:25:13','admin','管理员','2014-06-24 13:25:13','admin','管理员'),('402884f146cc37ab0146cc55f21b0014','common.surname','Name','en','2014-06-24 13:25:23','admin','管理员','2014-06-24 13:25:23','admin','管理员'),('402885814e2ef20c014e2ef347d50003','common.dbname','数据库名称','zh-cn','2015-06-26 16:19:32','admin','管理员',NULL,NULL,NULL),('402885814e2ef20c014e2ef3767e0005','common.dbname','Database Name','en','2015-06-26 16:19:44','admin','管理员',NULL,NULL,NULL),('4028948151536dc10151536f1a4e0001','common.returnvalfield','返回值字段','zh-cn','2015-11-29 21:29:28','admin','管理员',NULL,NULL,NULL),('4028948151536dc10151536f4a190003','common.returnvalfield','returnvalfield','en','2015-11-29 21:29:41','admin','管理员',NULL,NULL,NULL),('4028948151536dc10151536f87c10005','common.returntxtfield','返回文本字段','zh-cn','2015-11-29 21:29:56','admin','管理员',NULL,NULL,NULL),('4028948151536dc10151536fa6ca0007','common.returntxtfield','returntxtfield','en','2015-11-29 21:30:04','admin','管理员',NULL,NULL,NULL),('4028b8815325c044015325c515890001','common.mobile','电话','zh-cn','2016-02-28 10:46:26','admin','管理员',NULL,NULL,NULL),('4028b8815325c044015325c545850003','common.mobile','mobile','en','2016-02-28 10:46:39','admin','管理员',NULL,NULL,NULL),('4028b8815325c044015325c93bb10005','common.fax','传真','zh-cn','2016-02-28 10:50:58','admin','管理员',NULL,NULL,NULL),('4028b8815325c044015325c960bb0007','common.fax','fax','en','2016-02-28 10:51:08','admin','管理员',NULL,NULL,NULL),('4028b8815325c044015325c9ab690009','common.address','地址','zh-cn','2016-02-28 10:51:27','admin','管理员',NULL,NULL,NULL),('4028b8815325c044015325c9cf32000b','common.address','address','en','2016-02-28 10:51:36','admin','管理员',NULL,NULL,NULL),('4028b8815325ce7a015325d636ec0002','departmentaddress.rang1to50','组织机构地址范围1~50位字符','zh-cn','2016-02-28 11:05:09','admin','管理员',NULL,NULL,NULL),('4028b8815325ce7a015325d6ed890004','departmentaddress.rang1to50','Depart address should be 1-50 characters','en','2016-02-28 11:05:56','admin','管理员',NULL,NULL,NULL),('4028b8815364df430153651ae7dd0002','excelImport','导入','zh-cn','2016-03-11 17:56:15','admin','管理员',NULL,NULL,NULL),('4028b8815364df430153651b22b60004','excelImport','excelImport','en','2016-03-11 17:56:31','admin','管理员',NULL,NULL,NULL),('4028b8815364df430153651b5a730006','excelOutput','导出','zh-cn','2016-03-11 17:56:45','admin','管理员',NULL,NULL,NULL),('4028b8815364df430153651b89410008','excelOutput','excelOutput','en','2016-03-11 17:56:57','admin','管理员',NULL,NULL,NULL),('4028b8815364df430153651c4d28000a','templateDownload','模板下载','zh-cn','2016-03-11 17:57:47','admin','管理员',NULL,NULL,NULL),('4028b8815364df430153651c5c5b000c','templateDownload','templateDownload','en','2016-03-11 17:57:51','admin','管理员',NULL,NULL,NULL),('4028b881552e643e01552e6bd9300001','common.index','索引','zh-cn','2016-06-08 13:11:08','admin','管理员',NULL,NULL,NULL),('4028b881552e643e01552e6c03b50003','common.index','index','en','2016-06-08 13:11:19','admin','管理员',NULL,NULL,NULL),('4028ef81532b894f01532b93ced70003','common.office.tel','手机号','zh-cn','2016-02-29 13:50:20','admin','管理员',NULL,NULL,NULL),('4028ef81532b894f01532b93f9e00005','common.office.tel','telphone','en','2016-02-29 13:50:31','admin','管理员',NULL,NULL,NULL),('4028ef81532b894f01532b943c070007','common.mail','邮箱','zh-cn','2016-02-29 13:50:48','admin','管理员',NULL,NULL,NULL),('4028ef81533051360153305bbcf60002','form.template.style_pc','PC表单风格','zh-cn','2016-03-01 12:07:11','admin','管理员',NULL,NULL,NULL),('4028ef81533051360153305bfda90004','form.template.style_pc','pc form style','en','2016-03-01 12:07:28','admin','管理员',NULL,NULL,NULL),('4028ef81533051360153305c33ff0006','form.template.style_mobile','移动表单风格','zh-cn','2016-03-01 12:07:42','admin','管理员',NULL,NULL,NULL),('4028ef81533051360153305c60c90008','form.template.style_mobile','mobile form style','en','2016-03-01 12:07:53','admin','管理员',NULL,NULL,NULL),('4028ef815335c1da015335c8647d0003','self.defined.form','use defined form','en','2016-03-02 13:23:58','admin','管理员',NULL,NULL,NULL),('4028ef81533a788e01533a7a53180005','form.tb.db.table.name','table','en','2016-03-03 11:16:48','admin','管理员','2016-03-03 11:17:56','admin','管理员'),('4028ef81533a788e01533a7ba98c0008','form.tb.db.key','db source','en','2016-03-03 11:18:16','admin','管理员',NULL,NULL,NULL),('4028ef81533c078201533c08b1ca0001','system.version.number','3.7','zh-cn','2016-03-03 18:31:56','admin','管理员','2016-06-29 11:50:18','admin','管理员'),('4028ef81533c078201533c08e2370003','system.version.number','3.7','en','2016-03-03 18:32:08','admin','管理员','2016-06-29 11:50:12','admin','管理员'),('4028ef8154753f26015475436db30001','common.returntxttype','return type','en','2016-05-03 14:17:13','admin','管理员','2016-05-03 14:41:57','admin','管理员'),('4028ef8154753f26015475438dd00003','common.returntxttype','返回类型','zh-cn','2016-05-03 14:17:22','admin','管理员','2016-05-03 14:42:06','admin','管理员'),('4028efa2523a030601523a55381d0004','self.defined.form','自定义表单','zh-cn','2016-01-13 17:33:29','admin','管理员',NULL,NULL,NULL),('4028efa2523dfc4c01523e2adb110009','business.application','业务申请','zh-cn','2016-01-14 11:25:42','admin','管理员',NULL,NULL,NULL),('4028efa2523dfc4c01523e2c5f9b000c','individual.office','个人办公','zh-cn','2016-01-14 11:27:21','admin','管理员',NULL,NULL,NULL),('4028efa2523dfc4c01523e2d7ba5000e','process.design','流程管理','zh-cn','2016-01-14 11:28:34','admin','管理员','2016-01-14 18:58:21','admin','管理员'),('4028fc4d46c481da0146c4a15aa60003','common.calendar','日历','zh-cn','2014-06-23 01:30:47','admin','管理员','2014-06-23 01:30:47','admin','管理员'),('4028fc4d46c481da0146c4a190580005','common.calendar','Calendar','en','2014-06-23 01:31:01','admin','管理员','2014-06-23 01:31:01','admin','管理员'),('4028fc4d46c481da0146c4a2dc220007','common.map','地图','zh-cn','2014-06-23 01:32:26','admin','管理员','2014-06-23 01:32:26','admin','管理员'),('4028fc4d46c481da0146c4a2f24e0009','common.map','Map','en','2014-06-23 01:32:31','admin','管理员','2014-06-23 01:32:31','admin','管理员'),('4028fc4d46c481da0146c4aff7ea000b','common.please.select','---请选择---','zh-cn','2014-06-23 01:46:45','admin','管理员','2014-06-23 01:46:45','admin','管理员'),('4028fc4d46c481da0146c4b03310000d','common.please.select','Please Select','en','2014-06-23 01:47:00','admin','管理员','2014-06-23 02:01:20','admin','管理员'),('4028fc4d46c481da0146c4b8af79000f','common.please.input.keyword','请输入关键字','zh-cn','2014-06-23 01:56:16','admin','管理员','2014-06-23 01:56:16','admin','管理员'),('4028fc4d46c481da0146c4b8f7aa0011','common.please.input.keyword','Keyword','en','2014-06-23 01:56:34','admin','管理员','2014-06-23 01:56:34','admin','管理员'),('4028fc4d46c481da0146c4ba979a0013','common.please.input.query.keyword','请输入查询关键字','zh-cn','2014-06-23 01:58:21','admin','管理员','2014-06-23 01:58:21','admin','管理员'),('4028fc4d46c481da0146c4bade820015','common.please.input.query.keyword','Query keyword','en','2014-06-23 01:58:39','admin','管理员','2014-06-23 01:58:39','admin','管理员'),('4028fc4d46c481da0146c4bee05c0018','common.query','查询','zh-cn','2014-06-23 02:03:02','admin','管理员','2015-11-30 12:37:53','admin','管理员'),('4028fc4d46c481da0146c4bf0575001a','common.query','See','en','2014-06-23 02:03:11','admin','管理员','2015-10-27 22:47:21','admin','管理员'),('4028fc4d46c481da0146c4bf4239001c','common.reset','重置','zh-cn','2014-06-23 02:03:27','admin','管理员','2014-06-23 02:03:27','admin','管理员'),('4028fc4d46c481da0146c4bf638a001e','common.reset','Reset','en','2014-06-23 02:03:35','admin','管理员','2014-06-23 02:03:35','admin','管理员'),('4028fc5346c18cdc0146c19fa9370004','common.navegation','导航菜单','zh-cn','2014-06-22 11:30:04','admin','管理员','2014-06-22 11:30:04','admin','管理员'),('4028fc5346c18cdc0146c1a0a4d50006','common.navegation','Navegation','en','2014-06-22 11:31:09','admin','管理员','2014-06-22 11:31:09','admin','管理员'),('4028fc5346c18cdc0146c1a1b46e0008','common.control.panel','Control Panel','en','2014-06-22 11:32:18','admin','管理员','2014-06-22 11:32:18','admin','管理员'),('4028fc5346c18cdc0146c1a1e59b000a','common.control.panel','控制面板','zh-cn','2014-06-22 11:32:31','admin','管理员','2014-06-22 11:32:31','admin','管理员'),('4028fc5346c18cdc0146c1a2d668000c','common.profile','个人信息','zh-cn','2014-06-22 11:33:32','admin','管理员','2014-06-22 11:33:32','admin','管理员'),('4028fc5346c18cdc0146c1a31e02000e','common.profile','Profile','en','2014-06-22 11:33:51','admin','管理员','2014-06-22 11:33:51','admin','管理员'),('4028fc5346c18cdc0146c1a386000010','common.my.style','首页风格','zh-cn','2014-06-22 11:34:17','admin','管理员','2014-06-22 11:34:17','admin','管理员'),('4028fc5346c18cdc0146c1a3bccd0012','common.my.style','Style','en','2014-06-22 11:34:31','admin','管理员','2014-06-22 11:34:31','admin','管理员'),('4028fc5346c18cdc0146c1a412670014','common.logout','注销','zh-cn','2014-06-22 11:34:53','admin','管理员','2014-06-22 11:36:06','admin','管理员'),('4028fc5346c18cdc0146c1a4f99a0016','common.logout','Logout','en','2014-06-22 11:35:52','admin','管理员','2014-06-22 11:35:52','admin','管理员'),('4028fc5346c18cdc0146c1a5edff0019','common.exit','退出','zh-cn','2014-06-22 11:36:55','admin','管理员','2014-06-22 11:36:55','admin','管理员'),('4028fc5346c18cdc0146c1a60dff001b','common.exit','Exit','en','2014-06-22 11:37:03','admin','管理员','2014-06-22 11:37:03','admin','管理员'),('4028fc5346c18cdc0146c1a85f8e001d','common.user','User','en','2014-06-22 11:39:35','admin','管理员','2014-06-22 11:39:35','admin','管理员'),('4028fc5346c18cdc0146c1a88d9b001f','common.user','用户','zh-cn','2014-06-22 11:39:47','admin','管理员','2014-06-22 11:39:47','admin','管理员'),('4028fc5346c18cdc0146c1aae98c0025','common.platform','JEECG 演示系统','zh-cn','2014-06-22 11:42:22','admin','管理员','2014-06-22 11:42:22','admin','管理员'),('4028fc5346c18cdc0146c1ab90ac0027','common.platform','JEECG Platform','en','2014-06-22 11:43:04','admin','管理员','2014-06-22 11:43:04','admin','管理员'),('4028fc5346c1aec50146c1e09ce00017','lang.maintain','语言信息维护','zh-cn','2014-06-22 12:41:01','admin','管理员','2014-06-22 12:41:01','admin','管理员'),('4028fc5346c1aec50146c1e0f0780019','lang.maintain','Language Maintain','en','2014-06-22 12:41:22','admin','管理员','2014-06-23 13:37:39','admin','管理员'),('4028fc5346c1aec50146c1ea9872002b','online.develop','Online Develop','en','2014-06-22 12:51:55','admin','管理员','2014-06-22 12:51:55','admin','管理员'),('4028fc5346c1aec50146c1eaf4d6002d','online.develop','在线开发','zh-cn','2014-06-22 12:52:19','admin','管理员','2016-04-14 12:36:39','admin','管理员'),('4028fc5346c1aec50146c1eb749c002f','system.manage','系统管理','zh-cn','2014-06-22 12:52:51','admin','管理员','2014-06-22 12:52:51','admin','管理员'),('4028fc5346c1aec50146c1ebac710031','system.manage','System Manage','en','2014-06-22 12:53:06','admin','管理员','2014-06-22 12:53:06','admin','管理员'),('4028fc5346c1aec50146c1ec37a10033','project.manage','项目管理','zh-cn','2014-06-22 12:53:41','admin','管理员','2014-06-22 12:53:41','admin','管理员'),('4028fc5346c1aec50146c1ec67a40035','project.manage','Project Manage','en','2014-06-22 12:53:54','admin','管理员','2014-06-22 12:53:54','admin','管理员'),('4028fc5346c1aec50146c1ed9e6e0037','general.demo','常用示例','zh-cn','2014-06-22 12:55:13','admin','管理员','2014-06-22 12:55:13','admin','管理员'),('4028fc5346c1aec50146c1edcc6d0039','general.demo','Demo','en','2014-06-22 12:55:25','admin','管理员','2014-06-22 12:55:25','admin','管理员'),('4028fc5346c1aec50146c1ee629d003b','system.monitor','系统监控','zh-cn','2014-06-22 12:56:03','admin','管理员','2014-06-22 12:56:03','admin','管理员'),('4028fc5346c1aec50146c1eebe6c003d','system.monitor','System Monitor','en','2014-06-22 12:56:27','admin','管理员','2014-06-22 12:56:27','admin','管理员'),('4028fc5346c1aec50146c1ef4206003f','workflow.manage','工作流管理','zh-cn','2014-06-22 12:57:01','admin','管理员','2014-06-22 12:57:01','admin','管理员'),('4028fc5346c1aec50146c1ef78d20041','workflow.manage','Workflow Manage','en','2014-06-22 12:57:15','admin','管理员','2014-06-22 12:57:15','admin','管理员'),('4028fc5346c1aec50146c1fe512f0045','common.change.password','修改密码','zh-cn','2014-06-22 13:13:28','admin','管理员','2014-06-22 13:13:28','admin','管理员'),('4028fc5346c1aec50146c1fe90260047','common.change.password','Change Password','en','2014-06-22 13:13:44','admin','管理员','2014-06-22 13:13:44','admin','管理员'),('4028fc5346c1aec50146c202c92c0049','common.copyright','JEECG 版权所有','zh-cn','2014-06-22 13:18:20','admin','管理员','2014-06-23 11:01:46','admin','管理员'),('4028fc5346c1aec50146c203cd8d004b','common.copyright','JEEECT Copyright Reserved','en','2014-06-22 13:19:27','admin','管理员','2014-06-22 13:19:27','admin','管理员'),('4028fc5346c1aec50146c20508bf004d','common.refresh','刷新缓存','zh-cn','2014-06-22 13:20:48','admin','管理员','2014-06-22 13:20:48','admin','管理员'),('4028fc5346c1aec50146c2053659004f','common.refresh','Refresh','en','2014-06-22 13:20:59','admin','管理员','2014-06-22 13:20:59','admin','管理员'),('4028fc5346c1aec50146c2057c580051','common.close','Close','en','2014-06-22 13:21:17','admin','管理员','2014-06-22 13:21:17','admin','管理员'),('4028fc5346c1aec50146c205aff20053','common.close','关闭','zh-cn','2014-06-22 13:21:31','admin','管理员','2014-06-22 13:21:31','admin','管理员'),('4028fc5346c1aec50146c205f4be0055','common.close.all','全部关闭','zh-cn','2014-06-22 13:21:48','admin','管理员','2014-06-22 13:21:48','admin','管理员'),('4028fc5346c1aec50146c20631f70057','common.close.all','Close All','en','2014-06-22 13:22:04','admin','管理员','2014-06-22 13:22:04','admin','管理员'),('4028fc5346c1aec50146c2070b8a0059','common.close.all.but.this','Close all but this','en','2014-06-22 13:23:00','admin','管理员','2014-06-22 13:23:00','admin','管理员'),('4028fc5346c1aec50146c2074657005b','common.close.all.but.this','除此之外全部关闭','zh-cn','2014-06-22 13:23:15','admin','管理员','2014-06-22 13:23:15','admin','管理员'),('4028fc5346c1aec50146c207f0bc005d','common.close.all.right','当前页右侧全部关闭','zh-cn','2014-06-22 13:23:58','admin','管理员','2014-06-22 13:23:58','admin','管理员'),('4028fc5346c1aec50146c2085b89005f','common.close.all.right','Close all on right','en','2014-06-22 13:24:26','admin','管理员','2014-06-22 13:24:26','admin','管理员'),('4028fc5346c1aec50146c208cabc0061','common.close.all.left','当前页左侧全部关闭','zh-cn','2014-06-22 13:24:54','admin','管理员','2014-06-22 13:24:54','admin','管理员'),('4028fc5346c1aec50146c2094dee0063','common.close.all.left','Close all on left','en','2014-06-22 13:25:28','admin','管理员','2014-06-22 13:25:28','admin','管理员'),('4028fc5346c1aec50146c2325e890069','common.assist.tools','辅助工具','zh-cn','2014-06-22 14:10:19','admin','管理员','2014-06-22 14:10:19','admin','管理员'),('4028fc5346c1aec50146c2330cf3006b','common.assist.tools','Tool','en','2014-06-22 14:11:04','admin','管理员','2014-06-22 14:11:04','admin','管理员'),('4028fc5346c1aec50146c238a6eb006d','common.online.user','用户在线列表','zh-cn','2014-06-22 14:17:11','admin','管理员','2014-06-22 14:17:11','admin','管理员'),('4028fc5346c1aec50146c238d41e006f','common.online.user','Online User','en','2014-06-22 14:17:22','admin','管理员','2014-06-22 14:17:22','admin','管理员'),('4028fd2b471f63bb01471f9575f10001','language.manage','国际化语言','zh-cn','2014-07-10 17:23:14','8a8ab0b246dc81120146dc8181950052','admin','2015-10-15 11:31:11','admin','管理员'),('4028fd2b471f63bb01471f95fdd20003','language.manage','Lang Manage','en','2014-07-10 17:23:49','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 17:23:49','admin','管理员'),('4028fd2b471f63bb01471fc8bd5d0010','form.template','模板配置','zh-cn','2014-07-10 18:19:15','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:19:15','admin','管理员'),('4028fd2b471f63bb01471fc8dc9b0012','form.template','Form Template','en','2014-07-10 18:19:23','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:19:23','admin','管理员'),('4028fd2b471f63bb01471fc961b70014','function.test','功能测试','zh-cn','2014-07-10 18:19:57','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:19:57','admin','管理员'),('4028fd2b471f63bb01471fc97f300016','function.test','Function Test','en','2014-07-10 18:20:04','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:20:04','admin','管理员'),('4028fd2b471f63bb01471fc9e6310018','config.place','配置地址','zh-cn','2014-07-10 18:20:31','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:20:31','admin','管理员'),('4028fd2b471f63bb01471fca0508001a','config.place','Setting Address','en','2014-07-10 18:20:39','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:20:39','admin','管理员'),('4028fd2b471f63bb01471fcd6c920020','table.exit.in.db.confirm','表在数据库中已存在\\n确认删除','zh-cn','2014-07-10 18:24:22','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:24:22','admin','管理员'),('4028fd2b471f63bb01471fcdd7140022','table.exit.in.db.confirm','Table exit already\\n Confirm Delete','en','2014-07-10 18:24:49','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:24:49','admin','管理员'),('4028fd2b471f63bb01471fce9e7a0024','confirm.delete.record','确认移除该记录','zh-cn','2014-07-10 18:25:40','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:25:40','admin','管理员'),('4028fd2b471f63bb01471fcec9d60026','confirm.delete.record','Confirm delete record','en','2014-07-10 18:25:51','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:25:51','admin','管理员'),('4028fd2b471f63bb01471fcf68be0028','form.datalist','表单数据列表','zh-cn','2014-07-10 18:26:32','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:26:32','admin','管理员'),('4028fd2b471f63bb01471fcf948f002a','form.datalist','Form data list','en','2014-07-10 18:26:43','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:26:43','admin','管理员'),('4028fd2b471f63bb01471fd33eb1002e','common.please.select.edit.item','请选择编辑项目','zh-cn','2014-07-10 18:30:43','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:30:43','admin','管理员'),('4028fd2b471f63bb01471fd36c4d0030','common.please.select.edit.item','Please select edit item','en','2014-07-10 18:30:55','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:30:55','admin','管理员'),('4028fd2b471f63bb01471fd429130032','common.please.select.one.record.to.edit','请选择一条记录再编辑','zh-cn','2014-07-10 18:31:43','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:31:43','admin','管理员'),('4028fd2b471f63bb01471fd487c40034','common.please.select.one.record.to.edit','Please select one record to edit','en','2014-07-10 18:32:07','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:32:07','admin','管理员'),('4028fd2b471f63bb01471fd8bd8f003c','common.menu.link','菜单链接','zh-cn','2014-07-10 18:36:43','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:36:43','admin','管理员'),('4028fd2b471f63bb01471fd8d355003e','common.menu.link','Menu Link','en','2014-07-10 18:36:49','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:36:49','admin','管理员'),('4028fd2b471f63bb01471fdae99f0040','form.sqlimport','表单SQL导入','zh-cn','2014-07-10 18:39:06','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:39:06','admin','管理员'),('4028fd2b471f63bb01471fdb06f60042','form.sqlimport','Form SQL Import','en','2014-07-10 18:39:13','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:39:13','admin','管理员'),('4028fd2b471f63bb01471fdbd2b60044','slave.table.can.not.generate.code','附表不能代码生成','zh-cn','2014-07-10 18:40:05','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:40:05','admin','管理员'),('4028fd2b471f63bb01471fdc1ba70046','slave.table.can.not.generate.code','Slave table can not generate code','en','2014-07-10 18:40:24','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:47:00','8a8ab0b246dc81120146dc8181950052','admin'),('4028fd2b471f63bb01471fdd7b230048','please.syncdb','请先同步数据库','zh-cn','2014-07-10 18:41:54','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:41:54','admin','管理员'),('4028fd2b471f63bb01471fde0d02004a','please.syncdb','Please synchronize database first','en','2014-07-10 18:42:31','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:42:31','admin','管理员'),('4028fd2b471f63bb01471fde8727004c','code.generate','代码生成','zh-cn','2014-07-10 18:43:03','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:43:03','admin','管理员'),('4028fd2b471f63bb01471fdebba6004e','code.generate','Code Generate','en','2014-07-10 18:43:16','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:43:16','admin','管理员'),('4028fd2b471f63bb01471fdfb0040050','please.select.sync.method','请选择同步方式','zh-cn','2014-07-10 18:44:19','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:44:19','admin','管理员'),('4028fd2b471f63bb01471fdff96f0052','please.select.sync.method','Please select synchronize method','en','2014-07-10 18:44:37','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:44:37','admin','管理员'),('4028fd2b471f63bb01471fe393f60059','normal.sync','普通同步(保留表数据)','zh-cn','2014-07-10 18:48:34','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:48:34','admin','管理员'),('4028fd2b471f63bb01471fe4c6cb005b','normal.sync','Normal Sync(Retain Data)','en','2014-07-10 18:49:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:49:52','admin','管理员'),('4028fd2b471f63bb01471fe58641005d','force.sync','强制同步(删除表,重新生成)','zh-cn','2014-07-10 18:50:41','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:50:41','admin','管理员'),('4028fd2b471f63bb01471fe611cd005f','force.sync','Force Sync(Delete Table, ReGenerate)','en','2014-07-10 18:51:17','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 18:51:17','admin','管理员'),('4028fd2b471f63bb01471ff8d3000061','enhance.type','增强类型','zh-cn','2014-07-10 19:11:46','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 19:11:46','admin','管理员'),('4028fd2b471f63bb01471ff8fcca0063','enhance.type','Enhance Type','en','2014-07-10 19:11:57','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 19:11:57','admin','管理员'),('4028fd2b471f63bb01471ff9ec220065','enhance.js','增强js','zh-cn','2014-07-10 19:12:58','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 19:12:58','admin','管理员'),('4028fd2b471f63bb01471ffa2ef10067','enhance.js','Enhance JS','en','2014-07-10 19:13:15','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 19:13:15','admin','管理员'),('4028fd2b471f63bb01471ffb99300069','get.error','出错了','zh-cn','2014-07-10 19:14:48','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 19:14:48','admin','管理员'),('4028fd2b471f63bb01471ffbb3d7006b','get.error','Get Error','en','2014-07-10 19:14:55','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 19:14:55','admin','管理员'),('4028fd2b471f63bb01471ffcc59f006d','operate.code','页面控件编码','zh-cn','2014-07-10 19:16:05','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:30:34','admin','管理员'),('4028fd2b471f63bb01471ffce066006f','operate.code','Page Element Code','en','2014-07-10 19:16:12','8a8ab0b246dc81120146dc8181950052','admin','2015-04-02 22:30:50','admin','管理员'),('4028fd2b471f63bb01471ffed3280075','enhance.sql','增强sql','zh-cn','2014-07-10 19:18:19','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 19:18:19','admin','管理员'),('4028fd2b471f63bb01471ffeef0d0077','enhance.sql','Enhance SQL','en','2014-07-10 19:18:26','8a8ab0b246dc81120146dc8181950052','admin','2014-07-10 19:18:26','admin','管理员'),('41e9ba5d4f2546fd871d0a4a401732a8','common.phone','手机号码','zh-cn','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('42a24520ac85497d9da92af210113da2','common.status','状态','zh-cn','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('52ce422654ab40329fe3a0518b5c8f67','password.rang6to18','The password is at least 6 characters long, up to 18 characters','en','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('5910b83799b242318f456a4f42303cb0','select.byrole','按角色选择','zh-cn','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('5e5106b716d6476cae700ab27f2da555','common.middle','中','zh-cn','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('767053e885704be2b203fbe5c0389b73','common.password.reset','密码重置','zh-cn','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('7aae85094220429a84158e4db5c05d45','common.status','Status','en','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('7f980a800b114020b085530096b95d86','role.muti.select','角色可多选','zh-cn','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('8a1c7ee54dfb73d7014dfb7688c40001','form.db.name','dbCode','en','2015-06-16 16:22:39','admin','管理员',NULL,NULL,NULL),('8a1c7ee54dfb73d7014dfb76ed1b0003','form.db.name','数据源编码','zh-cn','2015-06-16 16:23:04','admin','管理员',NULL,NULL,NULL),('8a1c7ee54dfb73d7014dfb7a1f830007','form.db.tablename','dbTableName','en','2015-06-16 16:26:34','admin','管理员','2015-06-16 16:27:13','admin','管理员'),('8a1c7ee54dfb73d7014dfb7a56130009','form.db.tablename','数据库表名','zh-cn','2015-06-16 16:26:48','admin','管理员',NULL,NULL,NULL),('8a1c7ee54dfb73d7014dfb7ae850000c','form.db.synsql','dbSynSql','en','2015-06-16 16:27:25','admin','管理员',NULL,NULL,NULL),('8a1c7ee54dfb73d7014dfb7b1b28000e','form.db.synsql','动态查询SQ','zh-cn','2015-06-16 16:27:38','admin','管理员',NULL,NULL,NULL),('8a1c7ee54dfb73d7014dfb7b84800010','form.auto.formid','autoFormId','en','2015-06-16 16:28:05','admin','管理员','2015-06-16 16:55:30','admin','管理员'),('8a1c7ee54dfb73d7014dfb7bb98a0012','form.auto.formid','主键字段','zh-cn','2015-06-16 16:28:19','admin','管理员','2015-06-16 16:55:24','admin','管理员'),('8a1c7ee54e2e5e3b014e2e68f43d001a','form.db.preview','预览','zh-cn','2015-06-26 13:48:27','admin','管理员','2015-06-26 13:49:44','admin','管理员'),('8a1c7ee54e2e5e3b014e2e6a52a2001d','form.db.preview','preview','en','2015-06-26 13:49:56','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e2e8df2014e2e91fed00001','form.db.param.input','参数录入区','zh-cn','2015-06-26 14:33:16','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e2e8df2014e2e92522f0003','form.db.param.input','paramInput','en','2015-06-26 14:33:38','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e2e8df2014e2e93f8f70005','form.db.data.view','结果展示区','zh-cn','2015-06-26 14:35:26','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e2e8df2014e2e9433120007','form.db.data.view','dataView','en','2015-06-26 14:35:41','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e2e8df2014e2e9696630009','form.db.data.query','dataQuery','en','2015-06-26 14:38:17','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e2e8df2014e2e96c7f2000b','form.db.data.query','数据查询','zh-cn','2015-06-26 14:38:30','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e3ce62e014e3d07eb820001','java.enhance','java增强','zh-cn','2015-06-29 09:56:46','admin','管理员','2015-06-29 10:00:07','admin','管理员'),('8a1c7ee54e3ce62e014e3d0835860003','java.enhance','javaEnhance','en','2015-06-29 09:57:05','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e3e2ca9014e3e46f3c40001','common.value','数值','zh-cn','2015-06-29 15:45:14','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e3e2ca9014e3e472c390003','common.value','value','en','2015-06-29 15:45:28','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e3e2ca9014e3e491d0a0005','java.enhance.type','扩展类型','zh-cn','2015-06-29 15:47:35','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e3e2ca9014e3e49822c0007','java.enhance.type','enhanceType','en','2015-06-29 15:48:01','admin','管理员',NULL,NULL,NULL),('8a1c7ee54e3e2ca9014e3e50bc7b000b','java.enhance.type.class','java-class','zh-cn','2015-06-29 15:55:55','admin','管理员','2015-06-29 15:56:26','admin','管理员'),('8a1c7ee54e3e2ca9014e3e519584000e','java.enhance.type.spring','spring-key','zh-cn','2015-06-29 15:56:50','admin','管理员',NULL,NULL,NULL),('8a8ab00846c664b70146c741b9ed0045','lang.langkey','语言主键','zh-cn','2014-06-23 13:45:11','admin','管理员','2014-06-23 13:45:11','admin','管理员'),('8a8ab00846c664b70146c74226100047','lang.langkey','Lang Key','en','2014-06-23 13:45:39','admin','管理员','2014-06-23 13:45:39','admin','管理员'),('8a8ab00846c664b70146c743a8a40049','common.content','内容','zh-cn','2014-06-23 13:47:18','admin','管理员','2014-06-23 13:47:18','admin','管理员'),('8a8ab00846c664b70146c74416f5004b','common.content','Content','en','2014-06-23 13:47:46','admin','管理员','2014-06-23 13:47:46','admin','管理员'),('8a8ab00846c664b70146c74526330050','common.language','Language','en','2014-06-23 13:48:56','admin','管理员','2014-06-23 13:48:56','admin','管理员'),('8a8ab00846c664b70146c77efdb60076','common.import','数据导入','zh-cn','2014-06-23 14:52:06','admin','管理员','2014-06-23 14:52:06','admin','管理员'),('8a8ab00846c664b70146c77f95070078','common.import','Data Import','en','2014-06-23 14:52:45','admin','管理员','2014-06-23 14:52:45','admin','管理员'),('8a8ab00846c664b70146c7802f4f007a','common.export','数据导出','zh-cn','2014-06-23 14:53:25','admin','管理员','2014-06-23 14:58:50','admin','管理员'),('8a8ab00846c664b70146c7809eb6007c','common.export','Data Export','en','2014-06-23 14:53:53','admin','管理员','2014-06-23 14:59:00','admin','管理员'),('8a8ab00846d1bb660146d1ef63000003','user.manage','用户管理','zh-cn','2014-06-25 15:31:05','admin','管理员','2014-06-25 15:31:05','admin','管理员'),('8a8ab00846d1bb660146d1eff19e0005','user.manage','User Manage','en','2014-06-25 15:31:41','admin','管理员','2014-06-25 15:31:41','admin','管理员'),('8a8ab00846d1bb660146d1f12ae00007','common.data.dictionary','Data Dictionary ','en','2014-06-25 15:33:01','admin','管理员','2014-06-25 16:10:45','admin','管理员'),('8a8ab00846d1bb660146d1f1635a0009','common.data.dictionary','数据字典','zh-cn','2014-06-25 15:33:16','admin','管理员','2014-06-25 15:33:16','admin','管理员'),('8a8ab00846d1bb660146d1f24c0b000b','role.manage','角色管理','zh-cn','2014-06-25 15:34:15','admin','管理员','2014-06-25 15:34:15','admin','管理员'),('8a8ab00846d1bb660146d1f35861000f','role.manage','Role Manage','en','2014-06-25 15:35:24','admin','管理员','2014-06-25 15:35:24','admin','管理员'),('8a8ab00846d1bb660146d1f8e1610015','icon.manage','系统图标','zh-cn','2014-06-25 15:41:27','admin','管理员','2015-10-15 11:37:26','admin','管理员'),('8a8ab00846d1bb660146d1fbc5bf0017','icon.manage','System Icon','en','2014-06-25 15:44:36','admin','管理员','2015-10-15 11:37:41','admin','管理员'),('8a8ab00846d1bb660146d1fffdb40019','department.manage','组织机构','zh-cn','2014-06-25 15:49:13','admin','管理员','2015-10-15 10:57:18','admin','管理员'),('8a8ab00846d1bb660146d20cbafe001b','department.manage','Org Manage','en','2014-06-25 16:03:08','admin','管理员','2014-06-25 16:03:08','admin','管理员'),('8a8ab01b46b7bff40146b7c2eb6f0001','common.dash_board','首页','zh-cn','2014-06-20 13:32:23','admin','管理员','2014-06-20 14:58:43','admin','管理员'),('8a8ab01b46b7bff40146b7c38f560003','common.dash_board','Dashboard','en','2014-06-20 13:33:05','admin','管理员','2014-06-20 14:58:51','admin','管理员'),('8a8ab01b46b802300146b8038a070001','common.add.success','添加成功','zh-cn','2014-06-20 14:42:58','admin','管理员','2014-06-20 14:42:58','admin','管理员'),('8a8ab01b46b802300146b8048a5e0004','common.add.success','Add success','en','2014-06-20 14:44:03','admin','管理员','2014-06-20 14:44:03','admin','管理员'),('8a8ab01b46b802300146b806d7bd0006','common.edit.success','更新成功','zh-cn','2014-06-20 14:46:34','admin','管理员','2014-06-20 14:46:34','admin','管理员'),('8a8ab01b46b802300146b807c4e60008','common.edit.success','Update success','en','2014-06-20 14:47:35','admin','管理员','2014-06-20 14:47:35','admin','管理员'),('8a8ab01b46b80a850146b80cf84d0002','common.delete.success','删除成功','zh-cn','2014-06-20 14:53:16','admin','管理员','2014-06-20 14:53:16','admin','管理员'),('8a8ab01b46b80a850146b80d35b70004','common.delete.success','Delete success','en','2014-06-20 14:53:31','admin','管理员','2014-06-20 14:53:31','admin','管理员'),('8a8ab01b46b80a850146b80e7d420006','common.edit.fail','更新失败','zh-cn','2014-06-20 14:54:55','admin','管理员','2014-06-20 14:54:55','admin','管理员'),('8a8ab01b46b80a850146b80eddca0008','common.edit.fail','Update Fail','en','2014-06-20 14:55:20','admin','管理员','2014-06-20 14:55:20','admin','管理员'),('8a8ab01b46b83b0b0146b83ec7070008','common.notfind.langkey','','zh-cn','2014-06-20 15:55:50','admin','管理员','2014-06-21 01:18:10','admin','管理员'),('8a8ab01b46b83b0b0146b83ec7070009','common.notfind.langkey','','en','2014-06-20 15:57:14','admin','管理员','2014-06-21 01:18:16','admin','管理员'),('8a8ab02147423c5101474264c8980002','common.confirm','确定','zh-cn','2014-07-17 11:36:47','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:36:47','admin','管理员'),('8a8ab02147423c5101474264e0510004','common.confirm','Confirm','en','2014-07-17 11:36:53','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:36:53','admin','管理员'),('8a8ab02147423c51014742654bd20006','common.remove','Remove','en','2014-07-17 11:37:20','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:37:20','admin','管理员'),('8a8ab02147423c510147426569f90008','common.remove','移除','zh-cn','2014-07-17 11:37:28','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:37:28','admin','管理员'),('8a8ab02147423c5101474265ac98000a','common.item','条','zh-cn','2014-07-17 11:37:45','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:37:45','admin','管理员'),('8a8ab02147423c5101474265cdc1000c','common.item','Item','en','2014-07-17 11:37:53','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:37:53','admin','管理员'),('8a8ab02147423c51014742662411000e','common.total','共','zh-cn','2014-07-17 11:38:15','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:38:15','admin','管理员'),('8a8ab02147423c51014742664c5c0010','common.total','Total','en','2014-07-17 11:38:26','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:38:26','admin','管理员'),('8a8ab02147423c51014742669c660012','common.inactive','未激活','zh-cn','2014-07-17 11:38:46','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:38:46','admin','管理员'),('8a8ab02147423c5101474266cf100014','common.inactive','Inactive','en','2014-07-17 11:38:59','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:38:59','admin','管理员'),('8a8ab02147423c5101474267077d0016','common.active','激活','zh-cn','2014-07-17 11:39:14','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:39:14','admin','管理员'),('8a8ab02147423c510147426722730018','common.active','Active','en','2014-07-17 11:39:21','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:39:21','admin','管理员'),('8a8ab02147423c5101474267fdef001e','common.languagekey','Lang Key','en','2014-07-17 11:40:17','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:40:17','admin','管理员'),('8a8ab02147423c51014742687da20020','common.languagekey','语言Key','zh-cn','2014-07-17 11:40:49','8a8ab0b246dc81120146dc8181950052','admin','2014-07-17 11:40:49','admin','管理员'),('8a8ab0af476afe8501476b05f8860005','common.remember.user','是否记住用户名','zh-cn','2014-07-25 08:57:39','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 08:57:39','admin','管理员'),('8a8ab0af476afe8501476b0642280007','common.remember.user','Remember User','en','2014-07-25 08:57:58','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 08:57:58','admin','管理员'),('8a8ab0af476afe8501476b0b61120009','common.login.success.wait','登陆成功!请稍后....','zh-cn','2014-07-25 09:03:33','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:03:33','admin','管理员'),('8a8ab0af476afe8501476b0bc257000b','common.login.success.wait','Login success, waiting....','en','2014-07-25 09:03:58','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:03:58','admin','管理员'),('8a8ab0af476afe8501476b0d4233000d','common.init.data','是否初始化数据','zh-cn','2014-07-25 09:05:36','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:05:36','admin','管理员'),('8a8ab0af476afe8501476b0db938000f','common.init.data','Initialize data?','en','2014-07-25 09:06:07','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:06:07','admin','管理员'),('8a8ab0af476afe8501476b162e630012','lang.order.type','订单类型','zh-cn','2014-07-25 09:15:21','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:15:21','admin','管理员'),('8a8ab0af476afe8501476b164ceb0014','lang.order.type','Order Type','en','2014-07-25 09:15:29','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:15:29','admin','管理员'),('8a8ab0af476afe8501476b16a56e0016','lang.customer.type','客户类型','zh-cn','2014-07-25 09:15:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:15:52','admin','管理员'),('8a8ab0af476afe8501476b16c0d50018','lang.customer.type','Customer Type','en','2014-07-25 09:15:59','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:15:59','admin','管理员'),('8a8ab0af476afe8501476b170b9a001a','lang.service.item.type','服务项目类型','zh-cn','2014-07-25 09:16:18','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:16:18','admin','管理员'),('8a8ab0af476afe8501476b1749cc001c','lang.service.item.type','Service Item Type','en','2014-07-25 09:16:34','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:16:34','admin','管理员'),('8a8ab0af476afe8501476b1936c60020','common.logic.condition','逻辑条件','zh-cn','2014-07-25 09:18:40','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:18:40','admin','管理员'),('8a8ab0af476afe8501476b1956dd0022','common.logic.condition','Logic Condition','en','2014-07-25 09:18:48','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:18:48','admin','管理员'),('8a8ab0af476afe8501476b1a1cc30024','common.data.table','数据表','zh-cn','2014-07-25 09:19:39','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:19:39','admin','管理员'),('8a8ab0af476afe8501476b1a3c0a0026','common.data.table','Data Table','en','2014-07-25 09:19:47','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:19:47','admin','管理员'),('8a8ab0af476afe8501476b1ac59e0028','common.document.category','文档分类','zh-cn','2014-07-25 09:20:22','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:20:22','admin','管理员'),('8a8ab0af476afe8501476b1aeaa3002a','common.document.category','Document Category','en','2014-07-25 09:20:31','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:20:31','admin','管理员'),('8a8ab0af476afe8501476b1b3e55002c','common.sex.type','性别类','zh-cn','2014-07-25 09:20:53','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:20:53','admin','管理员'),('8a8ab0af476afe8501476b1b59af002e','common.sex.type','Sex Type','en','2014-07-25 09:21:00','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:21:00','admin','管理员'),('8a8ab0af476afe8501476b1c08ba0030','common.attachment','附件','zh-cn','2014-07-25 09:21:45','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:21:45','admin','管理员'),('8a8ab0af476afe8501476b1c22dd0032','common.attachment','Attachment','en','2014-07-25 09:21:51','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:21:51','admin','管理员'),('8a8ab0af476afe8501476b1d4e400034','lang.excellent.order','优质订单','zh-cn','2014-07-25 09:23:08','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:23:08','admin','管理员'),('8a8ab0af476afe8501476b1d7ece0036','lang.excellent.order','Excellent Order','en','2014-07-25 09:23:20','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:23:20','admin','管理员'),('8a8ab0af476afe8501476b1de2050038','lang.normal.order','普通订单','zh-cn','2014-07-25 09:23:46','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:23:46','admin','管理员'),('8a8ab0af476afe8501476b1dfde4003a','lang.normal.order','Normal Order','en','2014-07-25 09:23:53','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:23:53','admin','管理员'),('8a8ab0af476afe8501476b1ef393003c','lang.contract.customer','签约客户','zh-cn','2014-07-25 09:24:56','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:24:56','admin','管理员'),('8a8ab0af476afe8501476b1f0b32003e','lang.contract.customer','Contract Customer','en','2014-07-25 09:25:02','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:25:02','admin','管理员'),('8a8ab0af476afe8501476b1f4fea0040','lang.normal.customer','普通客户','zh-cn','2014-07-25 09:25:19','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:25:19','admin','管理员'),('8a8ab0af476afe8501476b1f67050042','lang.normal.customer','Normal Customer','en','2014-07-25 09:25:25','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:25:25','admin','管理员'),('8a8ab0af476afe8501476b1fa93d0044','lang.special.servcie','特殊服务','zh-cn','2014-07-25 09:25:42','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:25:42','admin','管理员'),('8a8ab0af476afe8501476b1fceec0046','lang.special.servcie','Special Service','en','2014-07-25 09:25:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:25:52','admin','管理员'),('8a8ab0af476afe8501476b2014720048','lang.normal.service','普通服务','zh-cn','2014-07-25 09:26:10','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:26:10','admin','管理员'),('8a8ab0af476afe8501476b203ca4004a','lang.normal.service','Normal Service','en','2014-07-25 09:26:20','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:26:20','admin','管理员'),('8a8ab0af476afe8501476b20bf5a004c','common.single.condition.query','单条件查询','zh-cn','2014-07-25 09:26:54','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:26:54','admin','管理员'),('8a8ab0af476afe8501476b20e447004e','common.single.condition.query','Single Condition Query','en','2014-07-25 09:27:03','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:27:03','admin','管理员'),('8a8ab0af476afe8501476b214fe20050','common.scope.query','范围查询','zh-cn','2014-07-25 09:27:31','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:27:31','admin','管理员'),('8a8ab0af476afe8501476b2171de0052','common.scope.query','Scope Queyr','en','2014-07-25 09:27:39','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:27:39','admin','管理员'),('8a8ab0af476afe8501476b21ffbf0054','common.db.integer','Integer','en','2014-07-25 09:28:16','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:29:19','8a8ab0b246dc81120146dc8181950052','admin'),('8a8ab0af476afe8501476b2227930056','common.db.integer','数值类型','zh-cn','2014-07-25 09:28:26','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:29:23','8a8ab0b246dc81120146dc8181950052','admin'),('8a8ab0af476afe8501476b234ba5005a','common.db.date','Date','en','2014-07-25 09:29:41','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:29:41','admin','管理员'),('8a8ab0af476afe8501476b238657005c','common.db.date','日期类型','zh-cn','2014-07-25 09:29:56','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:29:56','admin','管理员'),('8a8ab0af476afe8501476b23efed005e','common.db.string','字符类型','zh-cn','2014-07-25 09:30:23','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:30:23','admin','管理员'),('8a8ab0af476afe8501476b2404d30060','common.db.string','String','en','2014-07-25 09:30:28','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:30:28','admin','管理员'),('8a8ab0af476afe8501476b245e800062','common.db.long','Long','en','2014-07-25 09:30:51','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:30:51','admin','管理员'),('8a8ab0af476afe8501476b248ee60064','common.db.long','长整型','zh-cn','2014-07-25 09:31:03','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:31:03','admin','管理员'),('8a8ab0af476afe8501476b253d760066','common.workflow.engine.table','工作流引擎表','zh-cn','2014-07-25 09:31:48','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:31:48','admin','管理员'),('8a8ab0af476afe8501476b256e3a0068','common.workflow.engine.table','Workflow Engine Table','en','2014-07-25 09:32:00','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:32:00','admin','管理员'),('8a8ab0af476afe8501476b25c1d4006a','common.system.table','系统基础表','zh-cn','2014-07-25 09:32:22','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:32:22','admin','管理员'),('8a8ab0af476afe8501476b25d9b3006c','common.system.table','System Table','en','2014-07-25 09:32:28','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:32:28','admin','管理员'),('8a8ab0af476afe8501476b267773006e','common.business.table','业务表','zh-cn','2014-07-25 09:33:08','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:33:08','admin','管理员'),('8a8ab0af476afe8501476b26a71c0070','common.business.table','Business Table','en','2014-07-25 09:33:21','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:33:21','admin','管理员'),('8a8ab0af476afe8501476b2761320072','common.customer.engine.table','自定义引擎表','zh-cn','2014-07-25 09:34:08','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:34:08','admin','管理员'),('8a8ab0af476afe8501476b2791440074','common.customer.engine.table','Customer Engine Table','en','2014-07-25 09:34:20','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:34:20','admin','管理员'),('8a8ab0af476afe8501476b27d3790076','common.news','新闻','zh-cn','2014-07-25 09:34:37','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:34:37','admin','管理员'),('8a8ab0af476afe8501476b27f9b30078','新闻','News','en','2014-07-25 09:34:47','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:34:47','admin','管理员'),('8a8ab0af476afe8501476b28e56e007a','common.male','男性','zh-cn','2014-07-25 09:35:48','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:35:48','admin','管理员'),('8a8ab0af476afe8501476b28fa30007c','common.male','Male','en','2014-07-25 09:35:53','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:35:53','admin','管理员'),('8a8ab0af476afe8501476b291a73007e','common.female','女性','zh-cn','2014-07-25 09:36:01','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:36:01','admin','管理员'),('8a8ab0af476afe8501476b29466c0080','common.female','Female','en','2014-07-25 09:36:12','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 09:36:12','admin','管理员'),('8a8ab0ba487c37d001487c488a4d0006','common.datasource.manage','多数据源管理','zh-cn','2014-09-16 10:26:41','8a8ab0b246dc81120146dc8181950052','admin','2014-09-16 10:30:20','admin','管理员'),('8a8ab0ba487c37d001487c491f480008','common.datasource.manage','Multiple DataSource Manage','en','2014-09-16 10:27:20','8a8ab0b246dc81120146dc8181950052','admin','2014-09-16 10:30:56','admin','管理员'),('8a8ab0ba487c527201487c5f6d400001','common.datasrouce.key','多数据源主键','zh-cn','2014-09-16 10:51:41','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c5fba980003','common.datasrouce.key','Mutipule DataSource Key','en','2014-09-16 10:52:01','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c6193ec0005','common.driverclass','驱动类','zh-cn','2014-09-16 10:54:02','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c61b73d0007','common.driverclass','Driver Class','en','2014-09-16 10:54:11','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c62b0b00009','common.datasrouce.url','数据源地址','zh-cn','2014-09-16 10:55:15','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c62f4d8000b','common.datasrouce.url','DataSource URL','en','2014-09-16 10:55:33','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c63c17c000d','common.dbuser','数据库用户名','zh-cn','2014-09-16 10:56:25','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c63f0bf000f','common.dbuser','DB User','en','2014-09-16 10:56:37','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c6430510011','common.dbpassword','数据库密码','zh-cn','2014-09-16 10:56:53','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c6456940013','common.dbpassword','DB Password','en','2014-09-16 10:57:03','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c66d45d0015','common.dbtype','数据库类型','zh-cn','2014-09-16 10:59:46','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c66ffe00017','common.dbtype','DB Type','en','2014-09-16 10:59:58','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c79d0660021','common.oracle','甲骨文Oracle数据库','zh-cn','2014-09-16 11:20:31','8a8ab0b246dc81120146dc8181950052','admin','2014-09-16 11:21:58','admin','管理员'),('8a8ab0ba487c527201487c7aee7b0024','common.oracle','Oracle','en','2014-09-16 11:21:44','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c8f0bfc0027','common.sqlserver2008','微软SQL Server2008','zh-cn','2014-09-16 11:43:42','8a8ab0b246dc81120146dc8181950052','admin','2014-09-16 11:48:44','admin','管理员'),('8a8ab0ba487c527201487c8f57910029','common.sqlserver2008','SQL Server2008','en','2014-09-16 11:44:01','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c94614b002d','common.mysql','甲骨文MySQL','zh-cn','2014-09-16 11:49:32','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0ba487c527201487c948fc0002f','common.mysql','MySQL','en','2014-09-16 11:49:44','8a8ab0b246dc81120146dc8181950052','admin',NULL,NULL,NULL),('8a8ab0c34761c347014761dfb98c0001','common.english','English','en','2014-07-23 14:19:17','8a8ab0b246dc81120146dc8181950052','admin','2014-07-23 14:19:17','admin','管理员'),('8a8ab0c34761c347014761dfde030003','common.english','English','zh-cn','2014-07-23 14:19:27','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 08:51:07','8a8ab0b246dc81120146dc8181950052','admin'),('8a8ab0c34761c347014761e00f350005','common.chinese','中文','en','2014-07-23 14:19:39','8a8ab0b246dc81120146dc8181950052','admin','2014-07-25 08:51:20','8a8ab0b246dc81120146dc8181950052','admin'),('8a8ab0c34761c347014761e0305c0007','common.chinese','中文','zh-cn','2014-07-23 14:19:48','8a8ab0b246dc81120146dc8181950052','admin','2014-07-23 14:19:48','admin','管理员'),('8a8ab0d44756a3bd014756ad82990002','user.analysis.histogram','用户分析直方图','zh-cn','2014-07-21 10:08:37','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 10:08:37','admin','管理员'),('8a8ab0d44756a3bd014756ae22ce0004','usename.range2to10','用户账号长度范围在2~10','zh-cn','2014-07-21 10:09:18','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 10:09:18','admin','管理员'),('8a8ab0d44756a3bd014756ae9c2a0006','sequence.name','序号','zh-cn','2014-07-21 10:09:49','8a8ab0b246dc81120146dc8181950052','admin','2016-03-01 21:26:41','admin','管理员'),('8a8ab0d44756ec17014756eff8410001','common.menu','菜单','zh-cn','2014-07-21 11:21:13','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 11:21:13','admin','管理员'),('8a8ab0d44756ec17014756f0122e0003','common.menu','Menu','en','2014-07-21 11:21:19','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 11:21:19','admin','管理员'),('8a8ab0d44756ec17014756f5940d0007','common.area','地域','zh-cn','2014-07-21 11:27:20','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 11:27:20','admin','管理员'),('8a8ab0d44756ec17014756f5b12e0009','common.area','Area','en','2014-07-21 11:27:28','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 11:27:28','admin','管理员'),('8a8ab0d447576a86014757a4266d0004','common.role.select','角色选择','zh-cn','2014-07-21 14:38:01','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 14:38:01','admin','管理员'),('8a8ab0d447576a86014757a44a7b0006','common.role.select','Role Select','en','2014-07-21 14:38:10','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 14:38:10','admin','管理员'),('8a8ab0d44757b3f2014757b802010004','common.cancel','Cancel','en','2014-07-21 14:59:42','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 14:59:42','admin','管理员'),('8a8ab0d44757b3f2014757b821e00006','common.cancel','取消','zh-cn','2014-07-21 14:59:50','8a8ab0b246dc81120146dc8181950052','admin','2014-07-21 14:59:50','admin','管理员'),('8a8ab0de46c66d490146c674f6ee0002','common.data.loading','数据加载中...','zh-cn','2014-06-23 10:01:32','admin','管理员','2014-06-23 10:01:32','admin','管理员'),('8a8ab0de46c66d490146c675351b0004','common.data.loading','Data Loading......','en','2014-06-23 10:01:48','admin','管理员','2014-06-23 10:01:48','admin','管理员'),('8a8ab0de46c66d490146c6788e550006','common.exit.confirm','确定退出该系统吗 ?','zh-cn','2014-06-23 10:05:28','admin','管理员','2014-06-23 10:05:28','admin','管理员'),('8a8ab0de46c66d490146c678d8600008','common.exit.confirm','Confirm Exit?','en','2014-06-23 10:05:46','admin','管理员','2014-06-23 10:05:46','admin','管理员'),('8a8ab0de46c66d490146c67af864000a','common.change.style','首页风格','zh-cn','2014-06-23 10:08:06','admin','管理员','2015-05-29 14:09:17','admin','管理员'),('8a8ab0de46c66d490146c67b3590000c','common.change.style','Change Style','en','2014-06-23 10:08:21','admin','管理员','2014-06-23 10:08:21','admin','管理员'),('8a8ab0de46c66d490146c683c4ea0012','common.browser.recommend','(推荐使用IE8+,谷歌浏览器可以获得更快,更安全的页面响应速度) 技术支持：','zh-cn','2014-06-23 10:17:42','admin','管理员','2014-06-23 11:05:48','admin','管理员'),('8a8ab0de46c66d490146c68486160014','common.browser.recommend','(Recommend IE+, Google browser) Support: ','en','2014-06-23 10:18:32','admin','管理员','2014-06-23 10:18:32','admin','管理员'),('8a8ab0e8476756d8014767594f500001','common.mutilang','多语言','zh-cn','2014-07-24 15:50:12','8a8ab0b246dc81120146dc8181950052','admin','2014-07-24 15:50:12','admin','管理员'),('8a8ab0e8476756d801476759b8930003','common.mutilang','Muti Language','en','2014-07-24 15:50:38','8a8ab0b246dc81120146dc8181950052','admin','2014-07-24 15:50:38','admin','管理员'),('8a8c8d1c475192970147519e89800004','common.description','Description','en','2014-07-20 10:34:10','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 10:35:01','8a8ab0b246dc81120146dc8181950052','admin'),('8a8c8d1c475192970147519eae6d0006','common.description','描述','zh-cn','2014-07-20 10:34:19','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 10:34:19','admin','管理员'),('8a8c8d1c4751c965014751cb1ff50001','common.langcontext.exist','该内容已经存在，请不要重复添加','zh-cn','2014-07-20 11:22:52','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 11:22:52','admin','管理员'),('8a8c8d1c4751c965014751cd221a0003','common.langcontext.exist','Lang context exist already, don\'t add it again','en','2014-07-20 11:25:03','8a8ab0b246dc81120146dc8181950052','admin','2014-07-20 11:25:03','admin','管理员'),('8b4f561992c84eaa958b10c7912896b8','common.weak','弱','zh-cn','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('8ca84db9bbcb44bfb39746822a976907','common.role','Role','en','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('95903aa116c74bdb95b5be510a89c79d','common.tel','办公电话','zh-cn','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('9c3a8db4891a4d4390f6093ae2fd81af','common.strong','强','zh-cn','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('9f750fb969ed4bdcbbdb212c43746112','common.lock.user','lock user','en','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('a8e5a8e8c5e44576a1500c3b5f57937b','select.byrole','According to the role select','en','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('ac43aecc3356487c8eb5fa869149412f','common.repeat.password','重复密码','zh-cn','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('aec73ffa01b5499db0253b3b34194560','username.rang2to10','用户账号范围在2~10位字符','zh-cn','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('b8865c9032054772b39d43efda9ba0c8','role.muti.select','The role of multiple choices','en','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('b8dae445b3ef468db87167ddd8cd1b64','please.select.department','请选择组织机构','zh-cn','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('c150726fac0d43fd9bf28f4590018950','common.username','User Account','en','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('caaf209a7acb413ea59bbdf30e944f20','common.common.mail','Mail','en','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('ce8b2968f1fc49bba1a636ca18e7f08f','usename.range2to10','User account need 2~10 bits','en','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('d136cd1f25cc42fe8a0fae2dddc5de23','common.weak','Weak','en','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('dc787a2087ea4f248a394f8a88a5792c','common.real.name','用户名称','zh-cn','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('df075bc6373b4658afcfaff33b088952','common.role','角色','zh-cn','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('e1fb12b3993b4d1ea35bd536801ada1f','common.common.mail','常用邮箱','zh-cn','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2015-04-02 23:10:33','admin','管理员'),('e547fec1826c4811b6d759f2d81153f8','common.password.reset','Password Reset','en','2014-07-03 18:39:42','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('f9f74528bde04a0f9e25e29cbc87d9fb','fill.realname','填写个人真实姓名','zh-cn','2014-07-04 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-04 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('fa07850cb8ed4c268cc91ffd31e7ace1','common.password','Password','en','2014-07-03 18:39:43','4028818d46f764fb0146f7661cb60052','admin','2014-07-02 23:27:53','4028818d46f764fb0146f7661cb60052','admin'),('jglongjba487c37d001487c488a4d000','common.querybuilder','高级查询','zh-cn','2015-04-28 10:26:41','8a8ab0b246dc81120146dc8181950052','admin','2015-04-28 10:30:20','admin','管理员'),('jglongjba487c37d001487c488a4d001','common.code.range','编码范围在2~8位字符','zh-cn','2015-06-01 10:21:46','8a8ab0b246dc81120146dc8181950052','admin','2015-06-01 10:22:49','admin','admin'),('jglongjba487c37d001487c488a4d002','common.code.range','The coding in the range of 2~8 characters','en','2015-06-01 10:29:43','8a8ab0b246dc81120146dc8181950052','admin','2015-06-01 10:30:54','admin','admin'),('jglongjba487c37d001487c488a4d003','common.name.range','名称范围在2~10位字符','zh-cn','2015-06-01 10:49:33','8a8ab0b246dc81120146dc8181950052','admin','2015-06-01 10:49:57','admin','admin'),('jglongjba487c37d001487c488a4d004','common.name.range','The name in the range of 2~10 characters','en','2015-06-01 10:51:35','8a8ab0b246dc81120146dc8181950052','admin','2015-06-01 10:51:48','admin','admin'),('jglongjba487c37d001487c488a4d005','menu.graph.configuration','Online图表配置','zh-cn','2015-06-02 11:29:43','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 11:30:02','admin','admin'),('jglongjba487c37d001487c488a4d006','menu.graph.configuration','The graph configuration','en','2015-06-02 11:31:12','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 11:31:26','admin','admin'),('jglongjba487c37d001487c488a4d007','menu.input.demo','事例录入','zh-cn','2015-06-02 11:40:30','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 11:40:43','admin','admin'),('jglongjba487c37d001487c488a4d008','menu.input.demo','input demo','en','2015-06-02 11:41:39','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 11:41:29','admin','admin'),('jglongjba487c37d001487c488a4d009','menu.push.message','消息推送','zh-cn','2015-06-02 11:45:36','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 11:45:48','admin','admin'),('jglongjba487c37d001487c488a4d010','menu.push.message','push message','en','2015-06-02 11:46:40','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 11:46:55','admin','admin'),('jglongjba487c37d001487c488a4d011','menu.business.management','业务SQL','zh-cn','2015-06-02 11:49:31','8a8ab0b246dc81120146dc8181950052','admin','2015-10-15 10:37:04','admin','管理员'),('jglongjba487c37d001487c488a4d012','menu.business.management','Business Sql','en','2015-06-02 11:50:48','8a8ab0b246dc81120146dc8181950052','admin','2015-10-15 10:37:16','admin','管理员'),('jglongjba487c37d001487c488a4d013','menu.message.template','消息模板','zh-cn','2015-06-02 11:54:02','8a8ab0b246dc81120146dc8181950052','admin','2015-10-15 10:31:53','admin','管理员'),('jglongjba487c37d001487c488a4d014','menu.message.template','Message template','en','2015-06-02 11:54:52','8a8ab0b246dc81120146dc8181950052','admin','2015-10-15 10:32:24','admin','管理员'),('jglongjba487c37d001487c488a4d015','menu.Business.configuration','业务配置','zh-cn','2015-06-02 11:58:40','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 11:58:58','admin','admin'),('jglongjba487c37d001487c488a4d016','menu.Business.configuration','Business configuration','en','2015-06-02 11:58:20','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 11:59:01','admin','admin'),('jglongjba487c37d001487c488a4d017','menu.send.message','消息中心','zh-cn','2015-06-02 12:02:31','8a8ab0b246dc81120146dc8181950052','admin','2015-10-15 10:34:49','admin','管理员'),('jglongjba487c37d001487c488a4d018','menu.send.message','Message Center','en','2015-06-02 12:02:54','8a8ab0b246dc81120146dc8181950052','admin','2015-10-15 10:35:01','admin','管理员'),('jglongjba487c37d001487c488a4d019','menu.sort.management','分类管理','zh-cn','2015-06-02 12:07:04','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 12:07:23','admin','admin'),('jglongjba487c37d001487c488a4d020','menu.sort.management','sort management','en','2015-06-02 12:07:08','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 12:07:27','admin','admin'),('jglongjba487c37d001487c488a4d021','menu.nice.list','漂亮列表','zh-cn','2015-06-02 12:11:09','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 12:11:29','admin','admin'),('jglongjba487c37d001487c488a4d022','menu.nice.list','Nice list','en','2015-06-02 12:11:12','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 12:11:26','admin','admin'),('jglongjba487c37d001487c488a4d023','menu.data.permission','数据权限','zh-cn','2015-06-02 12:14:25','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 12:14:39','admin','admin'),('jglongjba487c37d001487c488a4d024','menu.data.permission','data permission','en','2015-06-02 12:14:22','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 12:14:58','admin','admin'),('jglongjba487c37d001487c488a4d025','menu.user.management','用户管理','zh-cn','2015-06-02 13:14:19','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 13:14:32','admin','admin'),('jglongjba487c37d001487c488a4d026','menu.user.management','user management','en','2015-06-02 13:14:16','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 13:14:44','admin','admin'),('jglongjba487c37d001487c488a4d027','menu.Leave.data.access','OL请假数据权限','zh-cn','2015-06-02 13:19:51','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 13:20:10','admin','admin'),('jglongjba487c37d001487c488a4d028','menu.Leave.data.access','Leave the data access','en','2015-06-02 13:19:55','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 13:20:13','admin','admin'),('jglongjba487c37d001487c488a4d029','menu.form.validation','表单验证','zh-cn','2015-06-02 14:49:50','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 14:55:01','admin','admin'),('jglongjba487c37d001487c488a4d030','menu.form.validation','Form validation','en','2015-06-02 14:49:54','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 14:55:13','admin','admin'),('jglongjba487c37d001487c488a4d031','menu.demo.example','综合Demo','zh-cn','2015-06-02 14:58:43','8a8ab0b246dc81120146dc8181950052','admin','2016-03-15 12:32:22','admin','管理员'),('jglongjba487c37d001487c488a4d032','menu.demo.example','Main Demo','en','2015-06-02 14:58:46','8a8ab0b246dc81120146dc8181950052','admin','2016-03-15 12:32:33','admin','管理员'),('jglongjba487c37d001487c488a4d033','menu.minidao.example','minidao例子','zh-cn','2015-06-02 15:03:49','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:04:04','admin','admin'),('jglongjba487c37d001487c488a4d034','menu.minidao.example','minidao example','en','2015-06-02 15:03:52','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:04:10','admin','admin'),('jglongjba487c37d001487c488a4d035','menu.form.model','表单模型','zh-cn','2015-06-02 15:13:44','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:13:59','admin','admin'),('jglongjba487c37d001487c488a4d036','menu.form.model','The form model','en','2015-06-02 15:13:47','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:14:02','admin','admin'),('jglongjba487c37d001487c488a4d037','menu.one_to_many.model','一对多模型','zh-cn','2015-06-02 15:17:51','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:18:18','admin','admin'),('jglongjba487c37d001487c488a4d038','menu.one_to_many.model','one-to-many model','en','2015-06-02 15:17:54','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:18:21','admin','admin'),('jglongjba487c37d001487c488a4d039','menu.import_export.excel','Excel导入导出','zh-cn','2015-06-02 15:23:03','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:23:39','admin','admin'),('jglongjba487c37d001487c488a4d040','menu.import_export.excel','import and export of the excel ','en','2015-06-02 15:23:06','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:23:43','admin','admin'),('jglongjba487c37d001487c488a4d041','menu.uploads_downloads','上传下载','zh-cn','2015-06-02 15:31:48','8a8ab0b246dc81120146dc8181950052','admin','2016-03-21 16:49:07','admin','管理员'),('jglongjba487c37d001487c488a4d042','menu.uploads_downloads','Upload','en','2015-06-02 15:31:51','8a8ab0b246dc81120146dc8181950052','admin','2016-03-21 16:49:19','admin','管理员'),('jglongjba487c37d001487c488a4d043','menu.JqueryFileUpload.example','Jquery上传示例','zh-cn','2015-06-02 15:35:07','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:35:30','admin','admin'),('jglongjba487c37d001487c488a4d044','menu.JqueryFileUpload.example','JqueryUploadDemo','en','2015-06-02 15:35:09','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:35:32','admin','admin'),('jglongjba487c37d001487c488a4d045','menu.no.paging','无分页列表','zh-cn','2015-06-02 15:39:15','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:39:34','admin','admin'),('jglongjba487c37d001487c488a4d046','menu.no.paging','No paging  list','en','2015-06-02 15:39:17','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:39:37','admin','admin'),('jglongjba487c37d001487c488a4d047','menu.jdbc.example','jdbc示例','zh-cn','2015-06-02 15:42:32','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:42:49','admin','admin'),('jglongjba487c37d001487c488a4d048','menu.jdbc.example','jdbc example','en','2015-06-02 15:42:34','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:42:52','admin','admin'),('jglongjba487c37d001487c488a4d049','menu.sql.separation','SQL分离','zh-cn','2015-06-02 15:47:02','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:47:17','admin','admin'),('jglongjba487c37d001487c488a4d050','menu.sql.separation','SQL separation','en','2015-06-02 15:47:04','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:47:23','admin','admin'),('jglongjba487c37d001487c488a4d051','menu.dictionary.labels','字典标签','zh-cn','2015-06-02 15:49:48','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:50:34','admin','admin'),('jglongjba487c37d001487c488a4d052','menu.dictionary.labels','The dictionary labels','en','2015-06-02 15:50:21','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:50:40','admin','admin'),('jglongjba487c37d001487c488a4d053','menu.form.thePop_UpStyle','表单弹出风格','zh-cn','2015-06-02 15:54:56','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:55:13','admin','admin'),('jglongjba487c37d001487c488a4d054','menu.form.thePop_UpStyle','Form the pop-up style','en','2015-06-02 15:54:57','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:55:15','admin','admin'),('jglongjba487c37d001487c488a4d055','menu.special.layout','左右布局','zh-cn','2015-06-02 15:58:36','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:58:57','admin','admin'),('jglongjba487c37d001487c488a4d056','menu.special.layout','page layout','en','2015-06-02 15:58:38','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 15:58:59','admin','admin'),('jglongjba487c37d001487c488a4d057','menu.single.table','单表例子（无tag）','zh-cn','2015-06-02 16:02:33','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:02:52','admin','admin'),('jglongjba487c37d001487c488a4d058','menu.single.table','Single table example(no tag)','en','2015-06-02 16:02:36','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:02:54','admin','admin'),('jglongjba487c37d001487c488a4d059','menu.one_to_many.example','一对多例子（无tag）','zh-cn','2015-06-02 16:06:06','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:08:01','admin','admin'),('jglongjba487c37d001487c488a4d060','menu.one_to_many.example','one to many example(no tag)','en','2015-06-02 16:07:43','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:08:04','admin','admin'),('jglongjba487c37d001487c488a4d061','menu.html.editor','HTML编辑器','zh-cn','2015-06-02 16:11:39','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:12:00','admin','admin'),('jglongjba487c37d001487c488a4d062','menu.html.editor','HTML editor','en','2015-06-02 16:11:42','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:12:03','admin','admin'),('jglongjba487c37d001487c488a4d063','menu.word.online','在线word(IE)','zh-cn','2015-06-02 16:14:36','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:14:55','admin','admin'),('jglongjba487c37d001487c488a4d064','menu.word.online','word online(IE)','en','2015-06-02 16:14:38','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:14:58','admin','admin'),('jglongjba487c37d001487c488a4d065','menu.webOfficeo.fficialExample','WebOffice官方例子','zh-cn','2015-06-02 16:19:45','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:20:05','admin','admin'),('jglongjba487c37d001487c488a4d066','menu.webOfficeo.fficialExample','The official example of WebOffice','en','2015-06-02 16:19:48','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:20:07','admin','admin'),('jglongjba487c37d001487c488a4d067','menu.moreAccessoriesManagement','多附件管理','zh-cn','2015-06-02 16:24:18','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:24:36','admin','admin'),('jglongjba487c37d001487c488a4d068','menu.moreAccessoriesManagement','More accessories management','en','2015-06-02 16:24:21','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:24:39','admin','admin'),('jglongjba487c37d001487c488a4d069','menu.datagridHandHtml','Datagrid自定义查询条件','zh-cn','2015-06-02 16:28:48','8a8ab0b246dc81120146dc8181950052','admin','2015-12-22 16:58:46','admin','管理员'),('jglongjba487c37d001487c488a4d070','menu.datagridHandHtml','Datagrid Custom Condition','en','2015-06-02 16:28:50','8a8ab0b246dc81120146dc8181950052','admin','2015-12-22 16:59:27','admin','管理员'),('jglongjba487c37d001487c488a4d071','menu.materialPom','树列表','zh-cn','2015-06-02 16:37:09','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:37:27','admin','admin'),('jglongjba487c37d001487c488a4d072','menu.materialPom','tree list','en','2015-06-02 16:37:11','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:37:29','admin','admin'),('jglongjba487c37d001487c488a4d073','menu.ckfinderDemo','ckfinder例子','zh-cn','2015-06-02 16:40:05','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:40:26','admin','admin'),('jglongjba487c37d001487c488a4d074','menu.ckfinderDemo','ckfinder demo','en','2015-06-02 16:40:07','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:40:28','admin','admin'),('jglongjba487c37d001487c488a4d075','menu.queryEditor','查询编辑器','zh-cn','2015-06-02 16:44:01','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:44:34','admin','admin'),('jglongjba487c37d001487c488a4d076','menu.queryEditor','The query editor','en','2015-06-02 16:44:04','8a8ab0b246dc81120146dc8181950052','admin','2015-06-02 16:44:38','admin','admin'),('jglongjba87c37d001487c488a4d0001','common.wage','wage','en','2015-06-03 16:34:36','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:34:52','admin','admin'),('jglongjba87c37d001487c488a4d0002','common.clear.localstorage','清除缓存','zh-cn','2015-04-28 10:26:41','8a8ab0b246dc81120146dc8181950052','admin','2015-05-25 16:30:20','admin','管理员'),('jglongjba87c37d001487c488a4d0003','common.clear.localstorage','Clear Cache','en','2015-04-28 10:26:41','8a8ab0b246dc81120146dc8181950052','admin','2015-05-25 16:30:20','admin','管理员'),('jglongjba87c37d001487c488a4d0004','common.messageSend.record','消息发送记录表','zh-cn','2015-06-03 10:50:30','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 10:50:48','admin','admin'),('jglongjba87c37d001487c488a4d0005','common.messageSend.record','data record to send message','en','2015-06-03 10:50:33','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 10:50:50','admin','admin'),('jglongjba87c37d001487c488a4d0006','common.messageHeader','消息标题','zh-cn','2015-06-03 11:05:23','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:05:46','admin','admin'),('jglongjba87c37d001487c488a4d0007','common.messageHeader','message header','en','2015-06-03 11:05:25','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:05:49','admin','admin'),('jglongjba87c37d001487c488a4d0008','common.messageType','消息类型','zh-cn','2015-06-03 11:09:09','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:09:35','admin','admin'),('jglongjba87c37d001487c488a4d0009','common.messageType','message type','en','2015-06-03 11:09:13','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:09:38','admin','admin'),('jglongjba87c37d001487c488a4d0010','common.sender','发送人','zh-cn','2015-06-03 11:13:05','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:13:26','admin','admin'),('jglongjba87c37d001487c488a4d0011','common.sender','sender','en','2015-06-03 11:13:09','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:13:29','admin','admin'),('jglongjba87c37d001487c488a4d0012','common.receiver','接收人','zh-cn','2015-06-03 11:15:57','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:16:21','admin','admin'),('jglongjba87c37d001487c488a4d0013','common.receiver','receiver','en','2015-06-03 11:16:00','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:16:24','admin','admin'),('jglongjba87c37d001487c488a4d0014','common.content_2','内容','zh-cn','2015-06-03 11:19:49','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:20:13','admin','admin'),('jglongjba87c37d001487c488a4d0015','common.content_2','content','en','2015-06-03 11:19:53','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:20:16','admin','admin'),('jglongjba87c37d001487c488a4d0016','common.dateCreated','创建日期','zh-cn','2015-06-03 11:22:32','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:22:55','admin','admin'),('jglongjba87c37d001487c488a4d0017','common.dateCreated','date created','en','2015-06-03 11:22:34','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:22:59','admin','admin'),('jglongjba87c37d001487c488a4d0018','common.sendtime','发送时间','zh-cn','2015-06-03 11:25:43','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:26:02','admin','admin'),('jglongjba87c37d001487c488a4d0019','common.sendtime','sendtime','en','2015-06-03 11:25:46','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:26:05','admin','admin'),('jglongjba87c37d001487c488a4d0020','common.sendState','发送状态','zh-cn','2015-06-03 11:30:01','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:30:23','admin','admin'),('jglongjba87c37d001487c488a4d0021','common.sendState','send state','en','2015-06-03 11:30:04','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:30:26','admin','admin'),('jglongjba87c37d001487c488a4d0022','common.remark','备注','zh-cn','2015-06-03 11:32:37','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:32:56','admin','admin'),('jglongjba87c37d001487c488a4d0023','common.remark','remark','en','2015-06-03 11:32:41','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:33:00','admin','admin'),('jglongjba87c37d001487c488a4d0024','common.esId','主键','zh-cn','2015-06-03 11:37:16','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:37:38','admin','admin'),('jglongjba87c37d001487c488a4d0025','common.esId','ID','en','2015-06-03 11:37:19','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:37:41','admin','admin'),('jglongjba87c37d001487c488a4d0026','common.iconEdit','消息修正','zh-cn','2015-06-03 11:40:50','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:41:09','admin','admin'),('jglongjba87c37d001487c488a4d0027','common.iconEdit','Message modification','en','2015-06-03 11:40:52','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:41:11','admin','admin'),('jglongjba87c37d001487c488a4d0028','common.businessSqlTable','业务SQL表','zh-cn','2015-06-03 11:50:24','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:50:48','admin','admin'),('jglongjba87c37d001487c488a4d0029','common.businessSqlTable','The SQL table of business','en','2015-06-03 11:50:27','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:50:52','admin','admin'),('jglongjba87c37d001487c488a4d0030','common.sqlName','SQL名称','zh-cn','2015-06-03 11:53:08','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:53:28','admin','admin'),('jglongjba87c37d001487c488a4d0031','common.sqlName','SQL name','en','2015-06-03 11:53:11','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:53:33','admin','admin'),('jglongjba87c37d001487c488a4d0032','common.sqlContent','SQL内容','zh-cn','2015-06-03 11:55:25','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:55:47','admin','admin'),('jglongjba87c37d001487c488a4d0033','common.sqlContent','SQL content','en','2015-06-03 11:55:28','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:55:49','admin','admin'),('jglongjba87c37d001487c488a4d0034','common.operate','操作','zh-cn','2015-06-03 11:57:51','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:58:13','admin','admin'),('jglongjba87c37d001487c488a4d0035','common.operate','operate','en','2015-06-03 11:57:54','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 11:58:16','admin','admin'),('jglongjba87c37d001487c488a4d0036','common.delete_2','删除','zh-cn','2015-06-03 12:01:21','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:01:48','admin','admin'),('jglongjba87c37d001487c488a4d0037','common.delete_2','delete','en','2015-06-03 12:01:25','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:01:51','admin','admin'),('jglongjba87c37d001487c488a4d0038','common.add_2','录入','zh-cn','2015-06-03 12:04:03','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:04:28','admin','admin'),('jglongjba87c37d001487c488a4d0039','common.add_2','add','en','2015-06-03 12:04:06','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:04:31','admin','admin'),('jglongjba87c37d001487c488a4d0040','common.edit_2','编辑','zh-cn','2015-06-03 12:06:22','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:06:46','admin','admin'),('jglongjba87c37d001487c488a4d0041','common.edit_2','edit','en','2015-06-03 12:06:26','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:06:50','admin','admin'),('jglongjba87c37d001487c488a4d0042','common.batchDelete','批量删除','zh-cn','2015-06-03 12:09:29','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:09:52','admin','admin'),('jglongjba87c37d001487c488a4d0043','common.batchDelete','Batch Delete','en','2015-06-03 12:09:32','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:09:57','admin','admin'),('jglongjba87c37d001487c488a4d0044','common.search','查询','zh-cn','2015-06-03 12:12:58','8a8ab0b246dc81120146dc8181950052','admin','2015-11-30 12:37:34','admin','管理员'),('jglongjba87c37d001487c488a4d0045','common.search','check','en','2015-06-03 12:13:01','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 12:13:17','admin','admin'),('jglongjba87c37d001487c488a4d0046','common.isId','主键','zh-cn','2015-06-03 14:29:46','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:30:06','admin','admin'),('jglongjba87c37d001487c488a4d0047','common.isId','ID','en','2015-06-03 14:29:49','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:30:13','admin','admin'),('jglongjba87c37d001487c488a4d0048','common.createName','创建人名称','zh-cn','2015-06-03 14:32:21','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:32:41','admin','admin'),('jglongjba87c37d001487c488a4d0049','common.createName','createName','en','2015-06-03 14:32:24','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:32:45','admin','admin'),('jglongjba87c37d001487c488a4d0050','common.create.By','创建人登录名','zh-cn','2015-06-03 14:35:43','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:36:23','admin','admin'),('jglongjba87c37d001487c488a4d0051','common.create.By','createBy','en','2015-06-03 14:35:47','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:36:27','admin','admin'),('jglongjba87c37d001487c488a4d0052','common.createDate','创建日期','zh-cn','2015-06-03 14:38:14','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:38:42','admin','admin'),('jglongjba87c37d001487c488a4d0053','common.createDate','createDate','en','2015-06-03 14:38:17','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:38:45','admin','admin'),('jglongjba87c37d001487c488a4d0054','common.updateName','更新人名称','zh-cn','2015-06-03 14:41:16','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:41:34','admin','admin'),('jglongjba87c37d001487c488a4d0055','common.updateName','updateName','en','2015-06-03 14:41:19','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:41:37','admin','admin'),('jglongjba87c37d001487c488a4d0056','common.updateByName','更新人登录名称','zh-cn','2015-06-03 14:44:11','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:44:30','admin','admin'),('jglongjba87c37d001487c488a4d0057','common.updateByName','updateByName','en','2015-06-03 14:44:14','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:44:34','admin','admin'),('jglongjba87c37d001487c488a4d0058','common.updateDate','更新日期','zh-cn','2015-06-03 14:46:24','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:46:41','admin','admin'),('jglongjba87c37d001487c488a4d0059','common.updateDate','updateDate','en','2015-06-03 14:46:27','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:46:44','admin','admin'),('jglongjba87c37d001487c488a4d0060','common.templateName','模板名称','zh-cn','2015-06-03 14:49:29','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:49:54','admin','admin'),('jglongjba87c37d001487c488a4d0061','common.templateName','templateName','en','2015-06-03 14:49:31','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:49:49','admin','admin'),('jglongjba87c37d001487c488a4d0062','common.templateType','模板类型','zh-cn','2015-06-03 14:51:59','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:52:18','admin','admin'),('jglongjba87c37d001487c488a4d0063','common.templateType','templateType','en','2015-06-03 14:52:02','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:52:21','admin','admin'),('jglongjba87c37d001487c488a4d0064','common.templateContent','模板内容','zh-cn','2015-06-03 14:54:41','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:55:00','admin','admin'),('jglongjba87c37d001487c488a4d0065','common.templateContent','templateContent','en','2015-06-03 14:54:46','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:55:04','admin','admin'),('jglongjba87c37d001487c488a4d0066','common.opt','操作','zh-cn','2015-06-03 14:56:50','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:57:13','admin','admin'),('jglongjba87c37d001487c488a4d0067','common.opt','opt','en','2015-06-03 14:56:55','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 14:57:15','admin','admin'),('jglongjba87c37d001487c488a4d0068','common.deleteTo','删除','zh-cn','2015-06-03 15:01:04','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:01:22','admin','admin'),('jglongjba87c37d001487c488a4d0069','common.deleteTo','delete','en','2015-06-03 15:01:07','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:01:25','admin','admin'),('jglongjba87c37d001487c488a4d0070','common.icon.add','录入','zh-cn','2015-06-03 15:03:55','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:04:15','admin','admin'),('jglongjba87c37d001487c488a4d0071','common.icon.add','add','en','2015-06-03 15:03:58','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:04:18','admin','admin'),('jglongjba87c37d001487c488a4d0072','common.icon.edit','编辑','zh-cn','2015-06-03 15:06:14','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:06:34','admin','admin'),('jglongjba87c37d001487c488a4d0073','common.icon.edit','edit','en','2015-06-03 15:06:17','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:06:38','admin','admin'),('jglongjba87c37d001487c488a4d0074','common.icon.remove','批量删除','zh-cn','2015-06-03 15:08:37','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:08:55','admin','admin'),('jglongjba87c37d001487c488a4d0075','common.icon.remove','Batch Delete','en','2015-06-03 15:08:40','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:08:58','admin','admin'),('jglongjba87c37d001487c488a4d0076','common.icon.search','查询','zh-cn','2015-06-03 15:10:42','8a8ab0b246dc81120146dc8181950052','admin','2015-11-30 12:36:46','admin','管理员'),('jglongjba87c37d001487c488a4d0077','common.icon.search','search','en','2015-06-03 15:10:46','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:11:10','admin','admin'),('jglongjba87c37d001487c488a4d0078','common.msgTemplateTable','消息模板表','zh-cn','2015-06-03 15:14:16','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:14:35','admin','admin'),('jglongjba87c37d001487c488a4d0079','common.msgTemplateTable','message template table','en','2015-06-03 15:14:19','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:14:39','admin','admin'),('jglongjba87c37d001487c488a4d0080','common.sqlDataTable','消息模板_业务SQL配置表','zh-cn','2015-06-03 15:29:43','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:30:01','admin','admin'),('jglongjba87c37d001487c488a4d0081','common.sqlDataTable','message template_sql configuration','en','2015-06-03 15:29:46','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:30:04','admin','admin'),('jglongjba87c37d001487c488a4d0082','common.createLoginName','创建人登录名称','zh-cn','2015-06-03 15:46:04','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:46:25','admin','admin'),('jglongjba87c37d001487c488a4d0083','common.createLoginName','create by name to login','en','2015-06-03 15:46:07','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:46:30','admin','admin'),('jglongjba87c37d001487c488a4d0084','common.configurationCODE','配置CODE','zh-cn','2015-06-03 15:50:40','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:50:57','admin','admin'),('jglongjba87c37d001487c488a4d0085','common.configurationCODE','configurationCODE','en','2015-06-03 15:50:43','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:51:00','admin','admin'),('jglongjba87c37d001487c488a4d0086','common.configurationName','配置名称','zh-cn','2015-06-03 15:53:03','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:53:19','admin','admin'),('jglongjba87c37d001487c488a4d0087','common.configurationName','configurationName','en','2015-06-03 15:53:06','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:53:22','admin','admin'),('jglongjba87c37d001487c488a4d0088','common.sqlBusinessId','业务SQLID','zh-cn','2015-06-03 15:56:38','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:56:59','admin','admin'),('jglongjba87c37d001487c488a4d0089','common.sqlBusinessId','ID of SQL business','en','2015-06-03 15:56:40','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 15:57:01','admin','admin'),('jglongjba87c37d001487c488a4d0090','common.msgModeliD','消息模本ID','zh-cn','2015-06-03 16:01:19','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:01:49','admin','admin'),('jglongjba87c37d001487c488a4d0091','common.msgModeliD','message model ID ','en','2015-06-03 16:01:23','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:01:52','admin','admin'),('jglongjba87c37d001487c488a4d0092','common.pushTest','推送测试','zh-cn','2015-06-03 16:04:56','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:05:13','admin','admin'),('jglongjba87c37d001487c488a4d0093','common.pushTest','push test','en','2015-06-03 16:04:58','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:05:16','admin','admin'),('jglongjba87c37d001487c488a4d0094','common.moblePhone','手机','zh-cn','2015-06-03 16:24:12','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:24:29','admin','admin'),('jglongjba87c37d001487c488a4d0095','common.moblePhone','moble phone','en','2015-06-03 16:24:15','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:24:33','admin','admin'),('jglongjba87c37d001487c488a4d0096','common.age','年龄','zh-cn','2015-06-03 16:26:36','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:26:54','admin','admin'),('jglongjba87c37d001487c488a4d0097','common.age','age','en','2015-06-03 16:26:38','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:26:57','admin','admin'),('jglongjba87c37d001487c488a4d0098','common.email','电子邮箱','zh-cn','2015-06-03 16:29:02','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:29:19','admin','admin'),('jglongjba87c37d001487c488a4d0099','common.email','email','en','2015-06-03 16:29:05','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:29:22','admin','admin'),('jglongjba87c37d001487c488a4d0100','common.wage','工资','zh-cn','2015-06-03 16:34:33','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:34:49','admin','admin'),('jglongjba87c37d001487c499a4d0002','common.sex','性别','zh-cn','2015-06-03 16:37:19','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:37:36','admin','admin'),('jglongjba87c37d001487c499a4d0003','common.sex','sex','en','2015-06-03 16:37:23','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:37:39','admin','admin'),('jglongjba87c37d001487c499a4d0004','common.birthday','生日','zh-cn','2015-06-03 16:40:24','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:40:49','admin','admin'),('jglongjba87c37d001487c499a4d0005','common.birthday','birthday','en','2015-06-03 16:40:27','8a8ab0b246dc81120146dc8181950052','admin','2015-06-03 16:40:53','admin','admin'),('jglongjba87c37d001487c499a4d0022','common.sendSuccess','发送成功','zh-cn','2015-06-05 10:38:37','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:38:53','admin','admin'),('jglongjba87c37d001487c499a4d0023','common.sendSuccess','send success','en','2015-06-05 10:38:41','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:38:55','admin','admin'),('jglongjba87c37d001487c499a4d0024','common.failToSend','发送失败','zh-cn','2015-06-05 10:42:42','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:42:58','admin','admin'),('jglongjba87c37d001487c499a4d0025','common.failToSend','fail to send','en','2015-06-05 10:42:44','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:43:01','admin','admin'),('jglongjba87c37d001487c499a4d0026','common.didNotSend','未发送','zh-cn','2015-06-05 10:47:58','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:48:18','admin','admin'),('jglongjba87c37d001487c499a4d0027','common.didNotSend','Did not send','en','2015-06-05 10:48:00','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:48:20','admin','admin'),('jglongjba87c37d001487c499a4d0028','common.smsAlerts','短信提醒','zh-cn','2015-06-05 10:51:28','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:51:42','admin','admin'),('jglongjba87c37d001487c499a4d0029','common.smsAlerts','SMS alerts','en','2015-06-05 10:51:30','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:51:45','admin','admin'),('jglongjba87c37d001487c499a4d0030','common.emailAlerts','邮件提醒','zh-cn','2015-06-05 10:58:42','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:58:55','admin','admin'),('jglongjba87c37d001487c499a4d0031','common.emailAlerts',' Email Alerts','en','2015-06-05 10:58:44','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 10:58:57','admin','admin'),('jglongjba87c37d001487c499a4d0032','common.sysAlerts','系统提醒','zh-cn','2015-06-05 11:02:54','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 11:03:08','admin','admin'),('jglongjba87c37d001487c499a4d0033','common.sysAlerts','SYS alerts','en','2015-06-05 11:02:56','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 11:03:10','admin','admin'),('jglongjba87c37d001487c499a4d0034','common.smsAlertsModel','短信提醒模板','zh-cn','2015-06-05 11:07:30','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 11:07:43','admin','admin'),('jglongjba87c37d001487c499a4d0035','common.smsAlertsModel','SMS alerts model','en','2015-06-05 11:07:31','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 11:07:45','admin','admin'),('jglongjba87c37d001487c499a4d0036','common.emailAlertsModel','邮件提醒模板','zh-cn','2015-06-05 11:11:57','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 11:12:12','admin','admin'),('jglongjba87c37d001487c499a4d0037','common.emailAlertsModel','Email alerts model','en','2015-06-05 11:12:00','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 11:12:14','admin','admin'),('jglongjba87c37d001487c499a4d1111','common.lock.user.tips','确定锁定用户吗','zh-cn','2015-06-05 16:56:09','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 16:56:23','admin','admin'),('jglongjba87c37d001487c499a4d1112','common.lock.user.tips','is confirm lock user','en','2015-06-05 16:56:11','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 16:56:26','admin','admin'),('jglongjba87c37d001487c499a4d1113','common.unlock.user.tips','确定激活用户吗','zh-cn','2015-06-05 16:59:20','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 16:59:34','admin','admin'),('jglongjba87c37d001487c499a4d1114','common.unlock.user.tips','Sure to activate user','en','2015-06-05 16:59:22','8a8ab0b246dc81120146dc8181950052','admin','2015-06-05 16:59:36','admin','admin');
/*!40000 ALTER TABLE `t_s_muti_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_icon`
--

DROP TABLE IF EXISTS `t_s_icon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_icon` (
  `ID` varchar(32) NOT NULL COMMENT 'id',
  `extend` varchar(255) DEFAULT NULL COMMENT '图片后缀',
  `iconclas` varchar(200) DEFAULT NULL COMMENT '类型',
  `content` blob COMMENT '图片流内容',
  `name` varchar(100) NOT NULL COMMENT '名字',
  `path` longtext COMMENT '路径',
  `type` smallint(6) DEFAULT NULL COMMENT '类型 1系统图标/2菜单图标/3桌面图标',
  `url` varchar(200) DEFAULT NULL COMMENT '图片访问路径',
  `attach_id` varchar(36) DEFAULT NULL COMMENT '附件id',
  `is_delete` char(2) DEFAULT NULL COMMENT '是否删除 0-未删除 1-删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_icon`
--

LOCK TABLES `t_s_icon` WRITE;
/*!40000 ALTER TABLE `t_s_icon` DISABLE KEYS */;
INSERT INTO `t_s_icon` VALUES ('8a8ab0b246dc81120146dc8180460000','png','default',NULL,'默认','plug-in/accordion/images/default.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180800001','png','back',NULL,'返回','plug-in/accordion/images/back.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180810002','png','pie',NULL,'小饼状图','plug-in/accordion/images/pie.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180820003','png','pictures',NULL,'图片','plug-in/accordion/images/pictures.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180830004','png','pencil',NULL,'笔','plug-in/accordion/images/pencil.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180850005','png','map',NULL,'小地图','plug-in/accordion/images/map.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180860006','png','group_add',NULL,'组','plug-in/accordion/images/group_add.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180880007','png','calculator',NULL,'计算器','plug-in/accordion/images/calculator.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180890008','png','folder',NULL,'文件夹','plug-in/accordion/images/folder.png',1,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180dd001e','png','deskIcon',NULL,'用户管理','plug-in/sliding/icon/Finder.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180e10020','png','deskIcon',NULL,'角色管理','plug-in/sliding/icon/friendgroup.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180e50022','png','deskIcon',NULL,'菜单管理','plug-in/sliding/icon/kaikai.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180eb0024','png','deskIcon',NULL,'数据字典管理','plug-in/sliding/icon/friendnear.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180f00026','png','deskIcon',NULL,'系统图标','plug-in/sliding/icon/kxjy.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8180fb002a','png','deskIcon',NULL,'用户分析','plug-in/sliding/icon/User.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc818102002c','png','deskIcon',NULL,'Online表单开发','plug-in/sliding/icon/Applications Folder.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc81810d002f','png','deskIcon',NULL,'数据监控','plug-in/sliding/icon/Super Disk.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8181150031','png','deskIcon',NULL,'系统日志','plug-in/sliding/icon/fastsearch.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8181210033','png','deskIcon',NULL,'定时任务','plug-in/sliding/icon/Utilities.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8181290035','png','deskIcon',NULL,'表单验证','plug-in/sliding/icon/qidianzhongwen.png',3,NULL,NULL,'0'),('8a8ab0b246dc81120146dc8181560043','png','deskIcon',NULL,'特殊布局','plug-in/sliding/icon/xiami.png',3,NULL,NULL,'0');
/*!40000 ALTER TABLE `t_s_icon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_gather_test_type`
--

DROP TABLE IF EXISTS `data_gather_test_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_gather_test_type` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `type_name` varchar(100) DEFAULT NULL COMMENT '数据采集试验类型名',
  `type_pid` varchar(36) DEFAULT NULL COMMENT '试验类型父id',
  `test_type_code` varchar(20) DEFAULT NULL COMMENT '试验类型值',
  `test_type` varchar(20) DEFAULT NULL COMMENT '试验类型 mechanics-力学试验 site-现场试验',
  PRIMARY KEY (`id`),
  UNIQUE KEY `test_type_code` (`test_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据采集试验类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_gather_test_type`
--

LOCK TABLES `data_gather_test_type` WRITE;
/*!40000 ALTER TABLE `data_gather_test_type` DISABLE KEYS */;
INSERT INTO `data_gather_test_type` VALUES ('40288258612dtwop6p4516aqwd16e119000c',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:03:46',NULL,'0','波纹管荷载下径向刚度','402882586f1c166d016f1c16dfe80000','88','mechanics'),('40288258612sa166d016asad16e119000c',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:03:46',NULL,'0','土工格栅拉伸','402882586f1c166d016f1c16dfe80000','84','mechanics'),('40288258612sa166p4516aqwd16e119000c',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:03:46',NULL,'0','连接点极限剥离力','402882586f1c166d016f1c16dfe80000','86','mechanics'),('40288258612sa166p4516asad16e119000c',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:03:46',NULL,'0','梯形撕破强力','402882586f1c166d016f1c16dfe80000','85','mechanics'),('40288258612saoop6p4516aqwd16e119000c',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:03:46',NULL,'0','防水材料拉伸','402882586f1c166d016f1c16dfe80000','87','mechanics'),('402882586f1bf9b3016f1bfa4ca30000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','水泥试验',NULL,'74','mechanics'),('402882586f1bf9b3016f1bfa55710001',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:23',NULL,'0','建筑砂浆抗压',NULL,'5','mechanics'),('402882586f1bf9b3016f1bfa55850002',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:23',NULL,'0','砌筑砂浆抗压',NULL,'6','mechanics'),('402882586f1bf9b3016f1bfa55cf0004',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:18',NULL,'0','水泥胶砂抗折','402882586f1bf9b3016f1bfa4ca30000','1','mechanics'),('402882586f1bf9b3016f1bfa55e30005',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:19',NULL,'0','水泥胶砂抗压','402882586f1bf9b3016f1bfa4ca30000','2','mechanics'),('402882586f1bfc0e016f1bfc7dd20000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','水泥净浆',NULL,'75','mechanics'),('402882586f1bfc0e016f1bfc7e2f0001',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:22',NULL,'0','水泥净浆抗折','402882586f1bfc0e016f1bfc7dd20000','3','mechanics'),('402882586f1bfc0e016f1bfc7e500002',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:22',NULL,'0','水泥净浆抗压','402882586f1bfc0e016f1bfc7dd20000','4','mechanics'),('402882586f1c0124016f1c01ac700000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','混凝土强度',NULL,'76','mechanics'),('402882586f1c0124016f1c01aca60001',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:23',NULL,'0','混凝土抗压','402882586f1c0124016f1c01ac700000','7','mechanics'),('402882586f1c0124016f1c01acc60002',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:23',NULL,'0','混凝土圆柱体轴心抗压','402882586f1c0124016f1c01ac700000','8','mechanics'),('402882586f1c0124016f1c01acdf0003',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:23',NULL,'0','混凝土棱柱体轴心抗压','402882586f1c0124016f1c01ac700000','9','mechanics'),('402882586f1c0124016f1c01acf30004',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:32:23',NULL,'0','混凝土圆柱体劈裂强度','402882586f1c0124016f1c01ac700000','10','mechanics'),('402882586f1c0124016f1c01ad1c0006',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:39:03',NULL,'0','混凝土抗弯拉强度','402882586f1c0124016f1c01ac700000','12','mechanics'),('402882586f1c0124016f1c01ad320007',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:38',NULL,'0','混凝土抗压弹性模量(棱柱体)','402882586f1c0124016f1c01ac700000','19','mechanics'),('402882586f1c0628016f1c076a050002',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','金属材料',NULL,'77','mechanics'),('402882586f1c0628016f1c076b790003',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:16:08',NULL,'0','金属拉伸','402882586f1c0628016f1c076a050002','13','mechanics'),('402882586f1c0628016f1c076b9c0004',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:38',NULL,'0','钢筋焊接','402882586f1c0628016f1c076a050002','14','mechanics'),('402882586f1c0628016f1c076bb20005',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:38',NULL,'0','机械连接','402882586f1c0628016f1c076a050002','15','mechanics'),('402882586f1c0628016f1c076bc60006',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','钢绞线','402882586f1c0628016f1c076a050002','16','mechanics'),('402882586f1c0628016f1c076bda0007',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','最大力总伸长率','402882586f1c0628016f1c076a050002','20','mechanics'),('402882586f1c0628016f1c076bef0008',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','钢筋焊接网抗剪力','402882586f1c0628016f1c076a050002','21','mechanics'),('402882586f1c0ad0016f1c0b40840000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','桥梁支座',NULL,'78','mechanics'),('402882586f1c0ad0016f1c0b40c10001',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座抗压弹性模量','402882586f1c0ad0016f1c0b40840000','22','mechanics'),('402882586f1c0ad0016f1c0b40d40002',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座抗剪弹性模量','402882586f1c0ad0016f1c0b40840000','23','mechanics'),('402882586f1c0ad0016f1c0b40e80003',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座极限抗压强度','402882586f1c0ad0016f1c0b40840000','24','mechanics'),('402882586f1c0ad0016f1c0b410a0004',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座抗剪粘结性能','402882586f1c0ad0016f1c0b40840000','25','mechanics'),('402882586f1c0ad0016f1c0b411f0005',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座抗剪老化','402882586f1c0ad0016f1c0b40840000','26','mechanics'),('402882586f1c0ad0016f1c0b41340006',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座竖向压缩变形','402882586f1c0ad0016f1c0b40840000','27','mechanics'),('402882586f1c0ad0016f1c0b41470007',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座盆环径向变形','402882586f1c0ad0016f1c0b40840000','28','mechanics'),('402882586f1c0ad0016f1c0b415d0008',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座摩擦系数','402882586f1c0ad0016f1c0b40840000','29','mechanics'),('402882586f1c0ad0016f1c0b41710009',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座竖向压缩刚度','402882586f1c0ad0016f1c0b40840000','30','mechanics'),('402882586f1c0ad0016f1c0b4186000a',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','支座压缩位移','402882586f1c0ad0016f1c0b40840000','31','mechanics'),('402882586f1c1124016f1c119f0d0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','土工合成材料',NULL,'79','mechanics'),('402882586f1c1124016f1c119fa80005',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','土工合成材料CBR顶破强力','402882586f1c1124016f1c119f0d0000','36','mechanics'),('402882586f1c1124016f1c11a027000a',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','耐压扁平率','402882586f1c1124016f1c119f0d0000','41','mechanics'),('402882586f1c1124016f1c11a03b000b',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 13:47:39',NULL,'0','刺破强力','402882586f1c1124016f1c119f0d0000','73','mechanics'),('402882586f1c166d016asad16e119000c',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:03:46',NULL,'0','土工合成材料拉伸','402882586f1c166d016f1c16dfe80000','83','mechanics'),('402882586f1c166d016f1c16dfe80000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','防水材料',NULL,'17','mechanics'),('402882586f1c166d016f1c16e105000b',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:03:46',NULL,'0','防水材料撕裂强度','402882586f1c166d016f1c16dfe80000','52','mechanics'),('402882586f1c166d016f1c16e119000c',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:03:46',NULL,'0','异形片抗压强度','402882586f1c166d016f1c16dfe80000','53','mechanics'),('402882586f1c166d016f1c16e1920012',NULL,NULL,NULL,'海特江良','jiangliang','2019-12-30 15:22:31',NULL,'0','防水材料剥离强度','402882586f1c166d016f1c16dfe80000','59','mechanics'),('402882586f1c193c016f1c19acae0000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','可扰金属电线保护套管',NULL,'80','mechanics'),('402882586f1c193c016f1c19acf70001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','套管拉伸性能','402882586f1c193c016f1c19acae0000','65','mechanics'),('402882586f1c193c016f1c19ad0b0002',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','套管抗压性能','402882586f1c193c016f1c19acae0000','66','mechanics'),('402882586f1c1b07016f1c1b75470000',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','波纹管',NULL,'81','mechanics'),('402882586f1c1b07016f1c1b75800001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','波纹管环刚度','402882586f1c1b07016f1c1b75470000','67','mechanics'),('402882586f1c1b07016f1c1b75930002',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','波纹管局部横向荷载','402882586f1c1b07016f1c1b75470000','68','mechanics'),('402882586f1c1b07016f1c1b75a80003',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','波纹管纵向荷载','402882586f1c1b07016f1c1b75470000','69','mechanics'),('402882586f1c1b07016f1c1b75be0004',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','波纹管拉伸性能','402882586f1c1b07016f1c1b75470000','70','mechanics'),('402882586f1c1b07016f1c1b75e6000u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','桩基检测','','82','site');
/*!40000 ALTER TABLE `data_gather_test_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_gather_test_filed`
--

DROP TABLE IF EXISTS `data_gather_test_filed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_gather_test_filed` (
  `id` varchar(36) NOT NULL,
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) DEFAULT NULL COMMENT '创建人登录名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) DEFAULT NULL COMMENT '更新人登录名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `sys_company_code` varchar(50) DEFAULT NULL COMMENT '所属公司',
  `is_delete` char(2) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `test_type_code` varchar(20) DEFAULT NULL COMMENT '试验类型值',
  `test_type` varchar(100) DEFAULT NULL COMMENT '试验类型',
  `test_type_id` varchar(36) DEFAULT NULL COMMENT '试验类型id',
  `order_num` int(4) DEFAULT NULL COMMENT '字段排序',
  `filed_name` varchar(100) DEFAULT NULL COMMENT '字段名',
  `filed_chinese_name` varchar(100) DEFAULT NULL COMMENT '字段中文名',
  `is_show` varchar(2) DEFAULT NULL COMMENT '前端是否展示字段 0-展示 1-不展示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据采集试验字段表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_gather_test_filed`
--

LOCK TABLES `data_gather_test_filed` WRITE;
/*!40000 ALTER TABLE `data_gather_test_filed` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_gather_test_filed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_backlog`
--

DROP TABLE IF EXISTS `t_s_backlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_backlog` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `module_name` varchar(100) NOT NULL COMMENT '模块名称:(委托/收费/实验检测/复核/审核/批准/打印/发放/归档, 详见BacklogEntity)',
  `qry_scope` varchar(255) NOT NULL DEFAULT 'D' COMMENT '查询范围: P:个人, D:部门',
  `name` varchar(255) NOT NULL COMMENT '待办事项名称',
  `backlog_explain` varchar(1000) DEFAULT NULL COMMENT '事项说明',
  `sql_str` varchar(2048) NOT NULL COMMENT '查询待办事项值的sql, 需要填入参数的地方用半角问号(?)代替',
  `sql_param` varchar(1024) DEFAULT NULL COMMENT '查询待办事项值sql的参数, 多个以逗号分隔, 用户id以{userId}代替',
  `priority` varchar(20) NOT NULL COMMENT '优先级: H:高, M:中, L:低',
  `sort_num` int(10) NOT NULL DEFAULT '0' COMMENT '排序号',
  `is_delete` varchar(2) DEFAULT '0' COMMENT '是否删除 0: 未  1:已',
  `sys_company_code` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_backlog`
--

LOCK TABLES `t_s_backlog` WRITE;
/*!40000 ALTER TABLE `t_s_backlog` DISABLE KEYS */;
INSERT INTO `t_s_backlog` VALUES ('1','试验检测','D','已超期试验数量','超过委托要求的报告日期还未完成的任务数量','SELECT count(1) FROM t_test_task ttt \r\n	LEFT JOIN t_consign_info tci on ttt.consign_info_id = tci.id\r\nWHERE cast(ttt.status as UNSIGNED INTEGER) < 30\r\n	AND tci.require_report_date IS NOT NULL\r\n	AND tci.require_report_date < NOW();',NULL,'H',0,'0','A03','lilf','lilf','2019-05-05 16:36:43',NULL,NULL,NULL),('10','试验检测','P','回退到检测的数量(个人)','当前登录人名下被回退到检测的任务数量','SELECT COUNT(DISTINCT(tt.id)) FROM t_test_task_person ttp\r\n	LEFT JOIN t_test_task tt on ttp.test_task_id = tt.id\r\nWHERE tt.workflow_status = \'2\' AND tt.status = \'20\'\r\n	AND ttp.user_id = ?\r\n	AND ttp.type = \'0\';','{userId}','H',8,'0','A03',NULL,NULL,NULL,'admin','管理员','2019-12-16 18:17:20'),('11','审核','D','回退到审核的报告数量','回退到审核的报告数量','SELECT COUNT(1) FROM t_report WHERE bpm_status = \'0\' AND report_status = \'15\';',NULL,'M',9,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('12','审核','P','回退到审核的报告数量(个人)','当前登录人负责审核的被回退到审核的报告数量','SELECT COUNT(DISTINCT(tr.id)) FROM t_report_person trp\r\n	LEFT JOIN t_report tr on trp.report_id = tr.id\r\nWHERE tr.bpm_status = \'0\' AND tr.report_status = \'15\'\r\n	AND trp.user_id = ?\r\n	AND trp.type = \'4\';','{userId}','M',10,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('13','委托','D','未付清费用的委托','未付清费用的委托数量','SELECT COUNT(DISTINCT(tci.id)) FROM t_fee_model fm\r\n	LEFT JOIN t_consign_info tci on fm.object_id = tci.id\r\nWHERE fm.status = \'3\' OR fm.status = \'2\'',NULL,'M',11,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('14','委托','D','7天内将超期但未付清费用的委托','7天内将超期但未付清费用的委托数量','SELECT COUNT(DISTINCT(tci.id)) FROM t_fee_model fm\r\n	LEFT JOIN t_consign_info tci on fm.object_id = tci.id\r\nWHERE tci.consign_date > NOW()\r\n	AND DATEDIFF(tci.consign_date, NOW()) <= 7\r\n	AND (fm.status = \'3\' OR fm.status = \'2\')\r\n',NULL,'M',12,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('15','批准','D','回退到批准的报告数量','回退到批准的报告数量','SELECT COUNT(1) FROM t_report WHERE bpm_status = \'0\' AND report_status = \'20\';',NULL,'M',13,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('16','批准','P','回退到批准的报告数量(个人)','当前登录人负责批准的被回退到批准的报告数量','SELECT COUNT(DISTINCT(tr.id)) FROM t_report_person trp\r\n	LEFT JOIN t_report tr on trp.report_id = tr.id\r\nWHERE tr.bpm_status = \'0\' AND tr.report_status = \'20\'\r\n	AND trp.user_id = ?\r\n	AND trp.type = \'5\';','{userId}','M',14,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('17','收费','D','待审批的合同','待审批的合同份数','SELECT count(1) FROM t_fee_contract_main WHERE status = \'3\';',NULL,'M',15,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('18','主题资料上报','P','超期未上报主题数量','资料上报超期未上报主题数量',' SELECT\r\n	COUNT(*)\r\nFROM\r\n	t_data_collection td\r\nLEFT JOIN (\r\n	SELECT\r\n		COUNT(*) num,\r\n		d.data_collection_id contentId\r\n	FROM\r\n		t_data_collection_content d\r\n	LEFT JOIN t_data_collection_content_person d1 ON d1.data_collection_content_id = d.id\r\n	WHERE\r\n		d.data_collection_node_date < CURDATE()\r\n	AND d.is_deleted = \'0\'\r\n	AND d1.is_deleted = \'0\'\r\n	AND d1.person_status = \'0\'\r\n	AND d1.person_id = ?\r\n	GROUP BY\r\n		d.id\r\n) td1 ON td.id = td1.contentId\r\nWHERE\r\n	td.is_deleted = \'0\'\r\nAND td1.num > 0','{userId}','H',16,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('19','主题资料上报','P','7天内需要上报但未上报的主题数量','资料上报7天内需要上报但未上报的主题数量','SELECT\r\n\r\n	COUNT(*)\r\nFROM\r\n	t_data_collection td\r\nLEFT JOIN (\r\n	SELECT\r\n		COUNT(*) num,\r\n		d.data_collection_id contentId\r\n	FROM\r\n		t_data_collection_content d\r\n	LEFT JOIN t_data_collection_content_person d1 ON d1.data_collection_content_id = d.id\r\n	LEFT JOIN (\r\n		SELECT\r\n			n.data_collection_id collectionId,\r\n			MIN(n.node_date) curDate\r\n		FROM\r\n			t_data_collection_node n\r\n		WHERE\r\n			n.node_date > CURDATE()\r\n		AND n.is_deleted = \'0\'\r\n		GROUP BY\r\n			n.data_collection_id\r\n	) d2 ON d2.collectionId = d.data_collection_id\r\n	WHERE\r\n		d2.curDate IS NOT NULL\r\n	AND d2.curDate between CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)\r\n	AND d.is_deleted = \'0\'\r\n	AND d1.is_deleted = \'0\'\r\n	AND d1.person_status = \'0\'\r\n	AND d1.person_id = ?\r\n	GROUP BY\r\n		d.id\r\n) td1 ON td.id = td1.contentId\r\nWHERE\r\n	td.is_deleted = \'0\'\r\nAND td1.num > 0','{userId}','H',17,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('2','试验检测','P','已超期试验数量(个人)','当前登录人员名下的已超过委托要求的报告日期但还未完成的任务数量','SELECT COUNT(DISTINCT(ttt.id)) FROM t_test_task_person ttp\r\n	LEFT JOIN t_test_task ttt on ttp.test_task_id = ttt.id\r\n	LEFT JOIN t_consign_info tci on ttt.consign_info_id = tci.id\r\nWHERE cast(ttt.status as UNSIGNED INTEGER) < 30\r\n	AND tci.require_report_date IS NOT NULL\r\n	AND tci.require_report_date < NOW()\r\n	AND ttp.user_id = ?\r\n	AND ttp.type = \'0\'','{userId}','H',1,'0','A03',NULL,NULL,'2019-05-05 16:58:15',NULL,NULL,NULL),('20','主题资料上报','P','当前需要上报但尚未上报的主题数量','资料上报当前需要上报但尚未上报的主题数量',' SELECT\r\n	COUNT(*)\r\nFROM\r\n	t_data_collection td\r\nLEFT JOIN (\r\n	SELECT\r\n		COUNT(*) num,\r\n		d.data_collection_id contentId,d.data_collection_node_date\r\n	FROM\r\n		t_data_collection_content d\r\n	LEFT JOIN t_data_collection_content_person d1 ON d1.data_collection_content_id = d.id\r\n	WHERE\r\n		d.data_collection_node_date = (\r\n			SELECT\r\n				MIN(n.node_date) \r\n			FROM\r\n				t_data_collection_node n\r\n			WHERE\r\n				n.data_collection_id = d.data_collection_id\r\n			AND n.is_deleted = \'0\'\r\n      AND n.node_date > CURDATE()\r\n		)\r\n	AND d.is_deleted = \'0\'\r\n	AND d1.is_deleted = \'0\'\r\n	AND d1.person_status = \'0\'\r\n	AND d1.person_id = ?\r\n	GROUP BY\r\n		d.id\r\n) td1 ON td.id = td1.contentId\r\nWHERE\r\n	td.is_deleted = \'0\' AND td1.num >0','{userId}','M',18,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('21','主题管理','P','超期未上报主题数量','主题管理超期未上报主题数量',' SELECT\r\n	COUNT(*)\r\nFROM\r\n	t_data_collection td\r\nLEFT JOIN (\r\n	SELECT\r\n		COUNT(*) num,\r\n		d.data_collection_id contentId\r\n	FROM\r\n		t_data_collection_content d\r\n	LEFT JOIN t_data_collection_content_person d1 ON d1.data_collection_content_id = d.id\r\n	WHERE\r\n		d.data_collection_node_date < CURDATE()\r\n	AND d.is_deleted = \'0\'\r\n	AND d1.is_deleted = \'0\'\r\n	AND d1.person_status = \'0\'\r\n	AND d1.person_id = ?\r\n	GROUP BY\r\n		d.id\r\n) td1 ON td.id = td1.contentId\r\nWHERE\r\n	td.is_deleted = \'0\'\r\nAND td1.num > 0','{userId}','H',19,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('22','主题管理','P','7天内需要上报但未上报的主题数量','主题管理7天内需要上报但未上报的主题数量','SELECT\r\n\r\n	COUNT(*)\r\nFROM\r\n	t_data_collection td\r\nLEFT JOIN (\r\n	SELECT\r\n		COUNT(*) num,\r\n		d.data_collection_id contentId\r\n	FROM\r\n		t_data_collection_content d\r\n	LEFT JOIN t_data_collection_content_person d1 ON d1.data_collection_content_id = d.id\r\n	LEFT JOIN (\r\n		SELECT\r\n			n.data_collection_id collectionId,\r\n			MIN(n.node_date) curDate\r\n		FROM\r\n			t_data_collection_node n\r\n		WHERE\r\n			n.node_date > CURDATE()\r\n		AND n.is_deleted = \'0\'\r\n		GROUP BY\r\n			n.data_collection_id\r\n	) d2 ON d2.collectionId = d.data_collection_id\r\n	WHERE\r\n		d2.curDate IS NOT NULL\r\n	AND d2.curDate between CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)\r\n	AND d.is_deleted = \'0\'\r\n	AND d1.is_deleted = \'0\'\r\n	AND d1.person_status = \'0\'\r\n	AND d1.person_id = ?\r\n	GROUP BY\r\n		d.id\r\n) td1 ON td.id = td1.contentId\r\nWHERE\r\n	td.is_deleted = \'0\'\r\nAND td1.num > 0','{userId}','H',20,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('23','主题管理','P','当前需要上报但尚未上报的主题数量','主题管理当前需要上报但尚未上报的主题数量',' SELECT\r\n	COUNT(*)\r\nFROM\r\n	t_data_collection td\r\nLEFT JOIN (\r\n	SELECT\r\n		COUNT(*) num,\r\n		d.data_collection_id contentId,d.data_collection_node_date\r\n	FROM\r\n		t_data_collection_content d\r\n	LEFT JOIN t_data_collection_content_person d1 ON d1.data_collection_content_id = d.id\r\n	WHERE\r\n		d.data_collection_node_date = (\r\n			SELECT\r\n				MIN(n.node_date) \r\n			FROM\r\n				t_data_collection_node n\r\n			WHERE\r\n				n.data_collection_id = d.data_collection_id\r\n			AND n.is_deleted = \'0\'\r\n      AND n.node_date > CURDATE()\r\n		)\r\n	AND d.is_deleted = \'0\'\r\n	AND d1.is_deleted = \'0\'\r\n	AND d1.person_status = \'0\'\r\n	AND d1.person_id = ?\r\n	GROUP BY\r\n		d.id\r\n) td1 ON td.id = td1.contentId\r\nWHERE\r\n	td.is_deleted = \'0\' AND td1.num >0','{userId}','M',21,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('3','委托','D','退回到委托','当前时间节点委托状态为退回的委托数量','SELECT count(1) FROM t_consign_info where status=\'40\';',NULL,'H',2,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('4','委托','D','通知修改委托','当前时间节点委托状态为通知修改的委托数量','SELECT count(1) FROM t_consign_info where status=\'50\';',NULL,'M',3,'0','A03',NULL,NULL,NULL,'zh','张红','2019-05-07 14:34:00'),('5','试验检测','D','龄期已到期任务','龄期到期且未检测的样品下的任务数量','SELECT COUNT(DISTINCT(ttp.test_task_id)) FROM t_test_task_param ttp\r\n	LEFT JOIN t_test_object_param top on ttp.test_object_param_id = top.id\r\n	LEFT JOIN t_test_object tto on top.test_object_id = tto.id\r\nWHERE EXISTS(\r\n		SELECT 1 FROM t_test_object_period topr \r\n		WHERE topr.test_object_id = tto.id \r\n			AND DATE_ADD(topr.forming_date, INTERVAL topr.hours HOUR) <= NOW()\r\n			AND topr.is_tested = \'0\'\r\n	);',NULL,'H',4,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('6','委托','D','超期7天未付清费用的委托','超过委托日期指定天数未付清费用的委托数量','SELECT COUNT(DISTINCT(tci.id)) FROM t_fee_model fm\r\n	LEFT JOIN t_consign_info tci on fm.object_id = tci.id\r\nWHERE DATEDIFF(NOW(), tci.consign_date) > ?\r\n	AND (fm.status = \'3\' OR fm.status = \'2\')','7','H',5,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('7','试验检测','D','7天内将超期的任务数量','指定天数内将超过委托要求报告日期的任务数量','SELECT COUNT(1) FROM t_test_task ttt \r\n	LEFT JOIN t_consign_info tci on ttt.consign_info_id = tci.id\r\nWHERE cast(ttt.status as UNSIGNED INTEGER) < 30\r\n	AND tci.require_report_date IS NOT NULL\r\n	AND tci.require_report_date > NOW()\r\n	AND DATEDIFF(tci.require_report_date, NOW()) <= ?;\r\n','7','M',6,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('8','试验检测','P','7天内将超期的任务数量(个人)','当前登录人名下的7天内将超期的任务数量','SELECT COUNT(DISTINCT(ttt.id)) FROM t_test_task_person ttp\r\n	LEFT JOIN t_test_task ttt on ttp.test_task_id = ttt.id\r\n	LEFT JOIN t_consign_info tci on ttt.consign_info_id = tci.id\r\nWHERE cast(ttt.status as UNSIGNED INTEGER) < 30\r\n	AND tci.require_report_date IS NOT NULL\r\n	AND tci.require_report_date > NOW()\r\n	AND DATEDIFF(tci.require_report_date, NOW()) <= ?\r\n	AND ttp.user_id = ?\r\n	AND ttp.type = \'0\';','7,{userId}','M',7,'0','A03',NULL,NULL,NULL,NULL,NULL,NULL),('9','试验检测','D','回退到检测的数量','回退到检测的任务数量','SELECT count(1) FROM t_test_task WHERE workflow_status = \'2\' AND status = \'20\';',NULL,'M',8,'0','A03',NULL,NULL,NULL,'admin','管理员','2019-12-23 09:51:24');
/*!40000 ALTER TABLE `t_s_backlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_project_all_authority`
--

DROP TABLE IF EXISTS `t_s_project_all_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_project_all_authority` (
  `id` varchar(36) NOT NULL,
  `name` varchar(36) DEFAULT NULL,
  `comment` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_project_all_authority`
--

LOCK TABLES `t_s_project_all_authority` WRITE;
/*!40000 ALTER TABLE `t_s_project_all_authority` DISABLE KEYS */;
INSERT INTO `t_s_project_all_authority` VALUES ('222210','分配权限','勾选此项后，当前人员拥有对所有检测参数的任务分配权限'),('222211','检测权限','勾选此项后，当前人员拥有对所有检测参数的试验检测权限'),('222212','复核权限','勾选此项后，当前人员拥有对所有检测参数的试验复核权限'),('222213','审核权限','勾选此项后，当前人员拥有对所有检测参数的报告审核权限'),('222214','批准权限','勾选此项后，当前人员拥有对所有检测参数的报告批准权限');
/*!40000 ALTER TABLE `t_s_project_all_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_s_message_type`
--

DROP TABLE IF EXISTS `t_s_message_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_s_message_type` (
  `id` varchar(36) NOT NULL COMMENT 'id',
  `name` varchar(500) DEFAULT NULL COMMENT '消息类型名称',
  `message_title` varchar(1024) NOT NULL COMMENT '该类消息的标题',
  `sys_company_code` varchar(255) DEFAULT NULL COMMENT '组织机构代码',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人账号',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人账号',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `update_name` varchar(255) DEFAULT NULL COMMENT '更新人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_s_message_type`
--

LOCK TABLES `t_s_message_type` WRITE;
/*!40000 ALTER TABLE `t_s_message_type` DISABLE KEYS */;
INSERT INTO `t_s_message_type` VALUES ('001','新预委托通知','您好，您收到一则新预委托通知',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('002','新检测任务到达','您好，您有新检测任务到达',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('003','检测任务检测人员发生变化','您好，有1份检测任务检测人员发生变化，请知悉',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('004','委托被退回到委托收样','您好，有1份委托被退回到委托收样',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('005','任务被退回到任务分配','您好，有1份任务被退回到任务分配',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('006','任务被退回到试验检测','您好，有1份检测任务被退回到试验检测',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('007','报告被退回报告编制','您好，有1份检测报告被退回报告编制',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('008','报告被退回到报告审核','您好，有1份检测报告被退回到报告审核',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('009','报告被退回到报告批准','您好，有1份检测报告被退回到报告批准',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('010','新的事务提醒','您有一条新的事务提醒',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('011','流程需要您审核','您好，有1条流程需要您审核，请及时进行处理',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('012','资料需要上报','你好，你有资料需要上报,请及时进行处理',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('013','留样样品到期提醒','留样样品到期提醒',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('014','委托被通知修改','您好，有1份委托被通知修改',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('015','报告档案压缩完成通知','报告档案压缩完成通知',NULL,'lilf','2020-04-30 09:31:19','lilf',NULL,NULL,NULL),('016','归档资料压缩完成通知','您好,归档资料压缩已完成,请及时下载',NULL,'lilf','2020-07-06 16:15:37','lilf',NULL,NULL,NULL),('100','资料需要归档通知','您好,有资料需要归档',NULL,'lilf','2020-07-09 10:18:44','lilf',NULL,NULL,NULL);
/*!40000 ALTER TABLE `t_s_message_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-10 10:17:56


--- user
INSERT INTO t_s_base_user (ID, activitiSync, browser, password, realname, signature, status, userkey, username, departid, delete_flag) VALUES ('8a8ab0b246dc81120146dc8181950052', null, null, '2b5707f48e0914d2', '管理员', null, 1, '管理员', 'admin', '8a8ab0b246dc81120146dc8180a20016', 0);
INSERT INTO t_s_user (id, email, mobilePhone, officePhone, signatureFile, sign_photo, job_title, certificate_no, login_times, update_name, update_date, update_by, create_name, create_date, create_by, birth_day, icon_url) VALUES ('8a8ab0b246dc81120146dc8181950052', '', '', '', '', 'http://47.108.26.139:8801/fileShare/A03/images/2019/d7c28284-926d-459c-83d9-6c921bbadb0e.jpg', '', '1', 2557, '管理员', '2020-07-09 17:23:25', 'admin', null, '2016-07-20 16:26:15', null, '2019-11-16 00:00:00', 'http://47.108.26.139:8801/fileShare/A03/images/2020/714cefc8-5658-4cfc-bfac-d3ad16512bec.jpg');

--- role
INSERT INTO t_s_role (ID, rolecode, rolename, update_name, update_date, update_by, create_name, create_date, create_by) VALUES ('8a8ab0b246dc81120146dc8181870050', 'admin', '管理员', null, null, null, null, null, null);

--- role user
INSERT INTO t_s_role_user (ID, roleid, userid) VALUES ('2c9110817332a55d017332e351730046', '8a8ab0b246dc81120146dc8181870050', '8a8ab0b246dc81120146dc8181950052');

--- org

INSERT INTO t_s_depart (ID, departname, extendname, description, parentdepartid, org_code, org_type, phone, complaint_phone, contacts, mobile, fax, address, postcode, depart_order, bank_name, bank_account, is_test_org, is_deleted) VALUES ('8a8ab0b246dc81120146dc8180ba0017', '初始值', null, '', null, 'A03', '1', '', null, null, null, null, null, null, null, '', '', '0', '0');
INSERT INTO t_s_user_org (ID, user_id, org_id) VALUES ('2c9110817332a55d017332e351350045', '8a8ab0b246dc81120146dc8181950052', '8a8ab0b246dc81120146dc8180ba0017');


--- role function
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee57110f', null, '40288220689cca2801689dd06a400280', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1110', null, '40288220689cca2801689dd1958e0282', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1111', null, '40288220689cca2801689dd276ed0284', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1112', null, '40288220689cca2801689dd3b3d00286', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1113', null, '40288220689cca2801689dd4f3ce0288', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1114', null, '40288220689cca2801689dd67338028a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1115', null, '40288220689cca2801689dd753cc028c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1116', null, '40288220689cca2801689dd87ef4028e', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1117', null, '40288220689cca2801689dd982060290', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136df7e044016dfcedee5f1118', null, '402882846b62f99d016b64fdc80a0125', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a621eda', null, '4028822068989f1a016898a804290003', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641edb', null, '4028822068989f1a016898ad3b210005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641edc', null, '4028822068989f1a016898b269020007', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641edd', null, '4028822068989f1a016898b6d7f3000c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641ede', null, '4028822068989f1a016898df54440017', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641edf', null, '4028822068989f1a016898e0ea4e0019', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641ee0', null, '4028822068989f1a016898e19ca8001b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641ee1', null, '4028822068989f1a016898e84ac6004a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641ee2', null, '4028822068989f1a016898e9340f004c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641ee3', null, '4028822068989f1a016898ea58d9004f', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641ee4', null, '4028822068989f1a016898eba3010051', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641ee5', null, '402882016e5e1a22016e5e22613c0002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136ed60e7e016ef3ec9a641ee6', null, '402882016e5e7c30016e5ebd266d0000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f847dd6016f84e1634003be', null, '4028822069b966cb0169b97bfb430040', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f847dd6016f84e1634403bf', null, '4028822069b966cb0169b98235d50054', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8986e08d08b8', null, '402882206f63d1f3016f641dfbb30005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8986e08e08b9', null, '402882206f63d1f3016f641f691f0008', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987709a08ba', null, '402882206f63d1f3016f645fac5000ca', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987709c08bb', null, '402882206f63d1f3016f6466f75b00d0', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987709c08bc', null, '402882206f63d1f3016f6469208000d2', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987709c08bd', null, '402882206f63d1f3016f6469b08b00d4', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987709c08be', null, '402882206f63d1f3016f64abfb6300d6', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987709c08bf', null, '402882206f63d1f3016f64ad67ba00d8', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987808e08c0', null, '402882206f63d1f3016f64e97c7200f6', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987808f08c1', null, '402882206f63d1f3016f64ea611a00f8', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987809008c2', null, '402882206f63d1f3016f64eafadd00fa', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987809008c3', null, '402882206f63d1f3016f64efd15000fc', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987809008c4', null, '402882206f63d1f3016f64f18af900fe', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987809008c5', null, '402882206f63d1f3016f64f22cd50100', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987809008c6', null, '402882206f63d1f3016f64f3e9be0102', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987809008c7', null, '402882206f63d1f3016f64f5dc6a0104', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987809008c8', null, '402882206f63d1f3016f64f6d8440106', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89878d2708c9', null, '402882206f63d1f3016f64c55af700ed', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89878d2808ca', null, '402882206f63d1f3016f64c7a7f400ef', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89878d2808cb', null, '402882206f63d1f3016f64c9346e00f1', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89878d2808cc', null, '402882206f63d1f3016f64cb4f4000f3', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf8f08ce', null, '402882206ed416f3016ed4921b210000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9208cf', null, '402882206f63d1f3016f653b40ae0123', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d0', null, '402882206f63d1f3016f653c23ca0125', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d1', null, '402882206f63d1f3016f653d59cc0127', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d2', null, '402882206f63d1f3016f653431980113', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d3', null, '402882206f63d1f3016f6534ca7d0115', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d4', null, '402882206f63d1f3016f6535ab390117', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d5', null, '402882206f63d1f3016f653630cc0119', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d6', null, '402882206f63d1f3016f653714ce011b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d7', null, '402882206f63d1f3016f6537b080011d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d8', null, '402882206f63d1f3016f6538082c011f', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f8987cf9308d9', null, '402882206f63d1f3016f6538ced10121', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f898823c908ee', null, '402882206f63d1f3016f658f903f01bc', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f898823ca08ef', null, '402882206f63d1f3016f658ffcd601be', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f898823ca08f0', null, '402882206f63d1f3016f6590a02501c0', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f898823ca08f1', null, '402882206f63d1f3016f65918c2001c2', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89883db808f2', null, '402882206f691b82016f694948980008', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89883db908f3', null, '402882206f691b82016f6949cbc8000a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89883db908f4', null, '402882206f691b82016f694a6cdc000c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89883db908f5', null, '402882206f691b82016f694b4522000e', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89883db908f6', null, '402882206f691b82016f694cb6710010', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89883db908f7', null, '402882206f691b82016f694d8dd30012', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89884ae508f8', null, '402882206f691b82016f694fe6170014', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f89884ae608f9', null, '402882206f691b82016f6950d0010016', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f898858d208fa', null, '402882206f59b754016f5aafebf10074', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f898858d308fb', null, '402882206f59b754016f5ab166f80076', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f898858d408fc', null, '402882206f59b754016f5ab2431f0078', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9136f887ab1016f898858d408fd', null, '402882206f59b754016f5ab3270f007a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137116459601711683bc580079', null, '402882016fc1870b016fc1a226d20153', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137116459601711683bc5a007a', null, '402882016fc1870b016fc1a165bb0151', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac160508c6', null, '402882206f63d1f3016f6579cf9501aa', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208c7', null, '402882206f63d1f3016f657a477601ac', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208c8', null, '402882206f63d1f3016f657b267801ae', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208c9', null, '402882206f63d1f3016f657ca07f01b0', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208ca', null, '402882206f63d1f3016f657d489701b2', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208cb', null, '402882206f63d1f3016f657ef4b001b4', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208cc', null, '402882206f63d1f3016f6584e30601b6', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208cd', null, '402882206f63d1f3016f6587742501b8', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208ce', null, '402882206f63d1f3016f65891d7501ba', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208cf', null, '402882207133c73f017133dd41bd0001', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208d0', null, '402882207133c73f017133de362a0003', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cac161208d1', null, '402882207133c73f017133dff7270005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b9137155f04a01715cf4a4e30cc8', null, '4028825a713438a5017134737b00040b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c50ec0241', null, '40288220689cca2801689d9897100240', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c50f30242', null, '40288220689cca2801689d9948500242', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c50f30243', null, '40288220689cca2801689d99ef370244', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c50f30244', null, '40288220689cca2801689d9a77700246', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c50f30245', null, '40288220689cca2801689d9b85fb0248', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c50f30246', null, '40288220689cca2801689d9c3ca0024a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c50f30247', null, '40288220689cca2801689da75b06024c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c50f30248', null, '4028820e71bf3bea0171bf601ac90000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c73fc0249', null, '40288220689cca2801689df3fc1702ba', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c7403024a', null, '40288220689cca2801689df4e71702bc', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c7403024b', null, '40288220689cca2801689df5b9ba02be', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c7403024c', null, '40288220689cca2801689df6721702c0', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c7403024d', null, '40288220689cca2801689df7595c02c2', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c7403024e', null, '402882206f63d1f3016f6447fa22004d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c7403024f', null, '40288220690e851701690eb66ecc003c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c74030250', null, '4028820e718099d6017180e592ae0018', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c74030251', null, '4028820e718099d6017180ec5dab001a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c74030252', null, '4028820e718099d6017180bbf251000d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c74030253', null, '4028820e718099d6017180c5598e0011', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c74030254', null, '4028820e718099d6017180cb70fe0013', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c74030255', null, '4028820e718099d6017180dd02750016', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13c74030256', null, '4028820e718099d6017180c0d7fc000f', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13cb2c50271', null, '4028822069b966cb0169b9b3d2f100a6', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13cb2c90272', null, '4028822069b966cb0169b9b4b64100a8', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13cb2c90273', null, '4028822069b966cb0169b9b539aa00aa', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13cb2c90274', null, '4028822069b966cb0169b9b617d100ac', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13cb2c90275', null, '4028822069b966cb0169b9b8bb1100ae', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('2c98b91371c133e40171c13cb2c90276', null, '4028820e718099d6017180fbcaed001c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce84c0001', null, '402882206786a29b016787605f900036', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce8630002', null, '402882206786a29b0167875fd3a00034', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce8630003', null, '402882206786a29b0167875f5c780032', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce8640004', null, '402882206786a29b0167875e91ee0030', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce8640005', null, '402882206786a29b0167875da42b002e', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce8640006', null, '402882206786a29b0167875be8f5002c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce8640007', null, '402882206786a29b01678758d8c80028', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce8640008', null, '402882206786a29b016787584fa30026', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce8640009', null, '402882206786a29b01678757cf230024', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce864000a', null, '402882206786a29b016787574a680022', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce864000b', null, '4028822067812815016781f818660012', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce864000c', null, '402882017098d3d3017098f0a6420002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78ce864000d', null, '402882017098d3d3017098f22ad40004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4453000e', null, '402882d35ebd7a23015ebd9300530030', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e000f', null, '402882d35f0f3e58015f0f4281a80004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0010', null, '402882d35ebd7a23015ebd93e3720034', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0011', null, '402882d35ebd7a23015ebd9375830032', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0012', null, '402882d35ebd7a23015ebd94d5c90039', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0013', null, '402882d35ebd7a23015ebd9560d0003b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0014', null, '402882016dbd7430016dbdaa8a3c0004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0015', null, '402882105ebd2ee7015ebd3365ce0000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0016', null, '402882105f4c1d6d015f4daea41f0049', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0017', null, '402882105ebd2ee7015ebd34fbc80004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0018', null, '402882846a4e15d3016a62b967fd01a3', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e0019', null, '402882105fdc2b54015fdc813d58000b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e001a', null, '402882d360d3935d0160d39772700008', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e001b', null, '402882106159aac901615a1cbd6b0004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e001c', null, '402882d360d3935d0160d398ddb4000c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e001d', null, '402882016ea19d99016ea1b3b4d00000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455e001e', null, '402882016ea19d99016ea1b44fae0002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f001f', null, '402882016ea19d99016ea1b5441c0005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0020', null, '402882016ea19d99016ea1b5da400007', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0021', null, '402882016ea19d99016ea1b668430009', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0022', null, '4028826370f6e2e90170f6f0e8cd00e9', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0023', null, '4028820e65ea58bd0165eabead440065', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0024', null, '402882016c65f1fb016c6687f3680377', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0026', null, '402882105e5b5362015e5b5745960009', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0027', null, '4028826371146135017114babfbd0004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0028', null, '402882636ccd1eb9016ccd23ad4a0002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0029', null, '4028825a708445000170847698f30002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f002a', null, '402882846f020c7f016f0274f0a70779', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f002b', null, '402882846f020c7f016f0277f3d507a2', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f002c', null, '402882586f31a2b5016f31a8e2f90004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f002d', null, '402882cc5e2d0e90015e2d36e62d0004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f002e', null, '402882cd5f52cb58015f52cce3370000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f002f', null, '402882cd5f572480015f5725137d0000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0030', null, '402882cc5e2d0e90015e2d38d1a40007', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d455f0031', null, '4028826366e8b9190166e8bd76180002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600032', null, '4028826367065b49016706633a070002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600033', null, '4028822066bf20530166bf239d620000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600034', null, '40288220667a7ac801667a801ef00002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600035', null, '402882016eab9318016eab9fc98b0002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600036', null, '4028826367a513a10167a51d2ddd0002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600037', null, '4028826367bae4d90167baf33c6f0001', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600038', null, '4028826367a513a10167a51fae120005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600039', null, '402882cd5f9952fa015f9954b12c0000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560003a', null, '402882cd5f9952fa015f998520050039', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560003b', null, '402882636b4e6ca7016b4e8039800002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560003c', null, '402882016d008dda016d008f6cd00002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560003d', null, '402882636b53d8e3016b53dec8a30002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560003e', null, '402882636b53d8e3016b53f5b2840065', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560003f', null, '402882636b53d8e3016b5550bddf015f', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600040', null, '4028821e6dbf968f016dbfbac1eb0006', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600041', null, '2c98b9136f26e10d016f26f4781100c9', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600042', null, '402882846eb4dadc016eb61dfdfc04c8', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600043', null, '4028821e6eaa6374016eaaa5d291007e', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600044', null, '402882846ec41ef6016ec5d08d1d0186', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600045', null, '402882586e86e906016e87341bab0016', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600046', null, '402882586e86e906016e87372379007b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600047', null, '402882586e86e906016e87379e37007d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600048', null, '4028824761c03b0e0161c180947d0034', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45600049', null, '402882106159aac901615a1cbd6b00i8', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560004a', null, '2c98b9136f26e10d016f26f5df0f00cb', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560004b', null, '402882206a05e84e016a060a53e6000b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560004c', null, '402882206a05e84e016a060b57be000d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560004d', null, '8a8ab0b246dc81120146dc8180f60028', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4560004e', null, '8a8ab0b246dc81120146dc8180ee0025', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561004f', null, '402882105e4c439d015e4c46e9480003', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610050', null, '402882105e4c439d015e4c47e7800005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610051', null, '402882105e4c439d015e4c4af2a50007', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610052', null, '402882105e5b5362015e5b55abd60003', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610053', null, '402882105e5b5362015e5b5649880005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610054', null, '402882105e5b5362015e5b57bbba000b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610055', null, '402882105e5b5362015e5b584f90000d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610056', null, '402882105e5b5362015e5b56af9c0007', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610057', null, '402882105e5b5362015e5b59391d000f', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610058', null, '8a8ab0b246dc81120146dc8180e30021', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610059', null, '402882cd5f47ddbe015f47f73a520006', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561005a', null, '402882cc5e6fe887015e700c338e0003', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561005b', null, '8a8ab0b246dc81120146dc8180df001f', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561005c', null, '402882636ccd1eb9016ccd2235fe0000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561005d', null, '402882636ccd3c69016ccd424ad60001', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561005e', null, '4028821e6cff9753016d015c24c70042', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561005f', null, '8a8ab0b246dc81120146dc8180d2001a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610060', null, '4028829d60d35dd00160d4e223390005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610061', null, '40288263677d2f5901677d330fd10002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610062', null, '402882206dd3541d016dd37669fe0004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610063', null, '4028821e6d65de4f016d6657f3090074', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610064', null, '297ed4995dd0879a015dd088f6ef0003', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610065', null, '4028821e6d65de4f016d66525ed30012', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610066', null, '402880ea53303a060153304a9ad50001', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610067', null, '402882206a67ed0d016a6806c82b0000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610068', null, '40288210631f662101631f8ae14d0002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45610069', null, '402882206685e73d016685e9d1c70000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561006a', null, '4028821062d1832a0162d195681a0001', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561006b', null, '297ed4995dd0879a015dd08a3de10006', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561006c', null, '8a8ab0b246dc81120146dc8180e70023', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4561006d', null, '8a8ab0b246dc81120146dc8180f30027', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4562006e', null, '8a8ab0b246dc81120146dc8180d9001d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d4562006f', null, '8a8ab0b246dc81120146dc8181100030', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45620070', null, '402882cc5e172240015e17271cc90003', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45620071', null, '402882cc5e1c5d52015e1c6622760002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45620072', null, '8a8ab0b246dc81120146dc81811d0032', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45620073', null, '8a8ab0b246dc81120146dc8181250034', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45620074', null, '402882cc5e1d8f42015e1d91347a0005', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45620075', null, '4028bc934869765001486977f0980001', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45620076', null, '402882cc5e02d32f015e02e69ffb0006', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e78d45620077', null, '402882cc5e02d32f015e02e736c60008', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfae0180', null, '402882016cf0d13b016cf11bdf9f0004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70181', null, '402882016cf5ac5e016cf5cd16db0002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70182', null, '402882016cf5ac5e016cf5d007d90004', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70183', null, '402882016cf5ac5e016cf5d91c5f0006', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70184', null, '402882016cf5ac5e016cf5dabf1e0008', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70185', null, '402882016cf5ac5e016cf5db9481000a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70186', null, '402882016cf5ac5e016cf5ddf865000c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70187', null, '402882016cf5ac5e016cf5dea75e000e', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70188', null, '402882016cf5ac5e016cf5df6daf0010', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70189', null, '402882016cf5ac5e016cf5e353be0012', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd7018a', null, '402882016cf5ac5e016cf5e63ece0014', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd7018b', null, '402882016cf0d13b016cf18e26d00024', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd7018c', null, '402882016cf5ac5e016cf5e751e40016', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd7018d', null, '402882016cf5ac5e016cf5e8d0ea0018', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd7018e', null, '402882016cf5ac5e016cf5ea8c2c001a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd7018f', null, '402882016cf5ac5e016cf5f1bbed001c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70190', null, '402882016cf5ac5e016cf5f2b167001e', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70191', null, '402882016cf5ac5e016cf5f34dfe0020', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70192', null, '4028820171861d630171862242040000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70193', null, '402882016cf0d13b016cf18eb7450026', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70194', null, '402882016cf1a598016cf1adee170006', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70195', null, '402882016cf1a598016cf1f1486f0009', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70196', null, '402882016cf1a598016cf1f9a3ab000b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70197', null, '402882016cf1a598016cf1fb57ee000d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70198', null, '402882016cf1a598016cf1fc874d000f', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd70199', null, '402882016cf5ac5e016cf5b099c10000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820171e78b1f0171e810bfd7019a', null, '4028820171e78b1f0171e81050c2017e', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288201722be0e501722c51ce780024', null, '4028820171b9bcb80171b9c02b500000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288201726d9eea01726ddc58f2000f', null, '40288201726d9eea01726dace7ef0001', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a18003f', null, '4028826370f6e2e90170f6e83c2a0007', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a1b0040', null, '4028826370f6e2e90170f6ee206600de', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a1c0041', null, '40288263710a1b8e01710b50fd6f010b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a1c0042', null, '4028826370f6e2e90170f6eebcb400e0', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a1c0043', null, '4028826370f6e2e90170f6effd6f00e5', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a1c0044', null, '4028826370f6e2e90170f6f05b6300e7', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a1c0045', null, '843cf96eaae64133ba959d6806db50b7', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a1c0046', null, '4028826371146135017114b9fa800002', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882017296c0c6017297101a1c0047', null, '4028826371be5d2d0171bfcd3cb0008c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300100000', null, '40288220729178c60172918539a2000a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300710001', null, '4028822072837c8c017283a7b2b90018', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300720002', null, '4028822072837c8c017283a8e5c6001c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300720003', null, '4028822072837c8c017283aade9a001f', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300720004', null, '4028822072837c8c017283bba79c0021', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300720005', null, '4028822072837c8c017283bd4f610023', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300720006', null, '4028822072837c8c017283bef0540025', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300720007', null, '4028822072837c8c017283c06ee50028', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300720008', null, '4028822072837c8c017283c2a2dc002a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172a69f300172a6a300720009', null, '4028822072837c8c017283c5b0580031', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172febde80172fec0c5ee0002', null, '4028822071e8210d0171e8e4a7af308d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('4028820172febde80172fec0c5f00003', null, '4028820172febde80172fec0028a0000', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee0c001b', null, '4028822069b966cb0169b99b2506006a', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f001c', null, '4028822069b966cb0169b990aabc005d', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f001d', null, '4028822069b966cb0169b99bb295006c', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f001e', null, '4028822069b966cb0169b99190340062', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f001f', null, '4028822069b966cb0169b99c6e6f006e', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f0020', null, '4028822069b966cb0169b9942f910067', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f0021', null, '4028822069b966cb0169b99df7af0070', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f0022', null, '4028822069b966cb0169b9ab38750078', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f0023', null, '4028822069b966cb0169b9aeac360087', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882206b493563016b49aaee3f0024', null, '402882206b493563016b49aa5eb50019', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288263689ccdce01689d5d2cbe015a', null, '40288220689cca2801689d45320001db', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288263689ccdce01689d5d2cca015b', null, '40288220689cca2801689d45c4ff01dd', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288263689ccdce01689d5d2cca015c', null, '40288220689cca2801689d46729f01df', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288263689ccdce01689d5d2cca015d', null, '40288220689cca2801689d474f4f01e1', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288263689ccdce01689d5d2cca015e', null, '40288220689cca2801689d48493b01e3', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288263689ccdce01689dad69f30184', null, '40288220689cca2801689d6259c20203', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288263689ccdce01689dad6a090185', null, '40288220689cca2801689d61c1f00201', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('40288263689ccdce01689dad6a090186', null, '40288220689cca2801689d630d270205', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104bbc0d00cb', null, '40288220689cca2801689d3223880179', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104bbc1c00cc', null, '40288220689cca2801689d335b7b017b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104bbc1d00cd', null, '40288220689cca2801689d3c0ef101cd', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104bbc1d00ce', null, '40288220689cca2801689d3e732101cf', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104bbc1d00cf', null, '40288220689cca2801689d40126b01d1', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104bbc1d00d0', null, '40288220689cca2801689d41631301d5', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104bbc1d00d1', null, '40288220689cca2801689d427b9001d7', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104c3bbc00d2', null, '40288220689cca2801689d49371501e5', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104c3bbe00d3', null, '40288220689cca2801689d4a0b1801e7', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104c3bbe00d4', null, '40288220689cca2801689d4b2eb201e9', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104c3bbe00d5', null, '40288220689cca2801689d4c01f301eb', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104c3bbf00d6', null, '40288220689cca2801689d4dd96701ed', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104c3bbf00d7', null, '40288220689cca2801689d5019d301ef', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636a0f1529016a104c3bbf00d8', null, '40288220689cca2801689d512eaa01f1', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636afc01e3016afd63b867002a', null, '4028826367ce4df50167ce5f19de0010', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636afc01e3016afd704c4c002b', null, '4028822069c78f410169c7f9a8c30013', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636afc01e3016afd704c5a002c', null, '4028822069c78f410169c7fb2e470015', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636afc01e3016afd704c5a002d', null, '4028822069c78f410169c7fbe4980017', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636afc01e3016afd704c5a002e', null, '4028822069c78f410169c7fcb26a0019', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882636afc01e3016afd704c5b002f', null, '4028822069c78f410169c7fd6228001b', '8a8ab0b246dc81120146dc8181870050', null);
INSERT INTO t_s_role_function (ID, operation, functionid, roleid, datarule) VALUES ('402882637215d29c0172164305240049', null, '402882637215d29c017216426d460047', '8a8ab0b246dc81120146dc8181870050', null);


--- authority
INSERT INTO t_s_user_project_all_authority (id, all_authority_id, user_id) VALUES ('2c98b9136dbd8541016dbd8be945001e', '222212', '8a8ab0b246dc81120146dc8181950052');
INSERT INTO t_s_user_project_all_authority (id, all_authority_id, user_id) VALUES ('2c98b9136dbd8541016dbd8be945001f', '222213', '8a8ab0b246dc81120146dc8181950052');
INSERT INTO t_s_user_project_all_authority (id, all_authority_id, user_id) VALUES ('2c98b9136dbd8541016dbd8be9450020', '222214', '8a8ab0b246dc81120146dc8181950052');
INSERT INTO t_s_user_project_all_authority (id, all_authority_id, user_id) VALUES ('2c98b9136f5a3089016f5a45e8a0004a', '222210', '8a8ab0b246dc81120146dc8181950052');
INSERT INTO t_s_user_project_all_authority (id, all_authority_id, user_id) VALUES ('2c98b9136f5a3089016f5a45e8a3004b', '222211', '8a8ab0b246dc81120146dc8181950052');