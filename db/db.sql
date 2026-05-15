DROP TABLE IF EXISTS `alertarchive`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `alertarchive` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `paramquery_id` int(10) unsigned NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `type` int(10) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `wvalue` decimal(10,2) NOT NULL,
  `avalue` decimal(10,2) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_alarmarchive_1` (`paramquery_id`),
  CONSTRAINT `FK_alarmarchive_1` FOREIGN KEY (`paramquery_id`) REFERENCES `paramsqueries` (`paramquery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `analoggroups`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `analoggroups` (
  `analoggroup_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  `username` varchar(55) default NULL,
  PRIMARY KEY  (`analoggroup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED COMMENT='Группы аналоговых значений';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `anlarchive`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `anlarchive` (
  `paramquery_id` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `value` decimal(10,2) default NULL,
  `anlarchive_id` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`anlarchive_id`),
  KEY `Index_2` USING BTREE (`paramquery_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=1241664 DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED COMMENT='Аналоговые архивы';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `archivedays`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `archivedays` (
  `paramquery_id` int(10) unsigned NOT NULL,
  `year` smallint(5) unsigned NOT NULL,
  `value` decimal(10,2) default NULL,
  `month` smallint(5) unsigned NOT NULL,
  `day` smallint(5) unsigned NOT NULL,
  KEY `FK_archivedays_1` (`paramquery_id`),
  KEY `Index_2` (`paramquery_id`,`year`,`month`,`day`),
  CONSTRAINT `FK_archivedays_1` FOREIGN KEY (`paramquery_id`) REFERENCES `paramsqueries` (`paramquery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED COMMENT='Архивы за сутки';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `archivehours`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `archivehours` (
  `year` smallint(5) unsigned NOT NULL,
  `value` decimal(10,2) default NULL,
  `paramquery_id` int(10) unsigned NOT NULL,
  `month` smallint(5) unsigned NOT NULL,
  `day` smallint(5) unsigned NOT NULL,
  `hour` smallint(5) unsigned NOT NULL,
  KEY `FK_archives_1` (`paramquery_id`),
  KEY `Index_2` (`paramquery_id`,`year`,`month`,`day`,`hour`),
  CONSTRAINT `FK_archivehours_1` FOREIGN KEY (`paramquery_id`) REFERENCES `paramsqueries` (`paramquery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED COMMENT='Архивы за часы';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `archivemonthes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `archivemonthes` (
  `paramquery_id` int(10) unsigned NOT NULL,
  `year` smallint(5) unsigned NOT NULL,
  `value` decimal(10,2) default NULL,
  `month` smallint(5) unsigned NOT NULL,
  KEY `FK_archivemonthes_1` (`paramquery_id`),
  KEY `Index_2` (`paramquery_id`,`year`,`month`),
  CONSTRAINT `FK_archivemonthes_1` FOREIGN KEY (`paramquery_id`) REFERENCES `paramsqueries` (`paramquery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED COMMENT='Архивы за месяца';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `arraies`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `arraies` (
  `array_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  `code` varchar(2) default NULL,
  PRIMARY KEY  USING BTREE (`array_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=cp1251 COMMENT='Массивы';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `consumerism`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `consumerism` (
  `consumerism_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  `report_id` int(10) unsigned default NULL,
  `user_id` int(10) unsigned NOT NULL,
  `description` varchar(120) default NULL,
  `subconsumerism_id` int(10) unsigned default NULL,
  `type` int(11) default NULL,
  `tree` int(11) default NULL,
  `wtype` int(11) default NULL,
  `plugin_data` blob,
  PRIMARY KEY  USING BTREE (`consumerism_id`),
  KEY `FK_products_2` (`user_id`),
  KEY `FK_products_4` USING BTREE (`report_id`),
  KEY `FK_consumerism_4` USING BTREE (`subconsumerism_id`),
  CONSTRAINT `FK_consumerism_3` FOREIGN KEY (`report_id`) REFERENCES `reports` (`report_id`),
  CONSTRAINT `FK_consumerism_4` FOREIGN KEY (`subconsumerism_id`) REFERENCES `consumerism` (`consumerism_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_products_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=cp1251 COMMENT='Потребители';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `diagrams`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `diagrams` (
  `diagram_id` int(10) unsigned NOT NULL auto_increment,
  `lvalue` decimal(10,2) default NULL,
  `hvalue` decimal(10,2) default NULL,
  `name` varchar(45) default NULL,
  `consumerism_id` int(10) unsigned NOT NULL,
  `anglelable` int(11) default NULL,
  `dimensionname` varchar(45) default NULL,
  PRIMARY KEY  (`diagram_id`),
  KEY `FK_diagrams_1` USING BTREE (`consumerism_id`),
  CONSTRAINT `FK_diagrams_1` FOREIGN KEY (`consumerism_id`) REFERENCES `consumerism` (`consumerism_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=cp1251 COMMENT='Диаграммы';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `groupsparams`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `groupsparams` (
  `groupparams_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  `user_id` int(10) unsigned NOT NULL,
  `typemeter_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  USING BTREE (`groupparams_id`),
  KEY `FK_groupsparams_1` (`typemeter_id`),
  KEY `FK_groupsparams_2` (`user_id`),
  CONSTRAINT `FK_groupsparams_1` FOREIGN KEY (`typemeter_id`) REFERENCES `typesmeters` (`typemeter_id`),
  CONSTRAINT `FK_groupsparams_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED COMMENT='Группы параметров СП-Сети';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `meters`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `meters` (
  `meter_id` int(10) unsigned NOT NULL auto_increment,
  `enabled` int(10) unsigned NOT NULL,
  `description` varchar(120) default NULL,
  `name` varchar(120) default NULL,
  `user_id` int(10) unsigned NOT NULL,
  `typemeter_id` int(10) unsigned NOT NULL,
  `device` int(10) unsigned default NULL COMMENT 'Номер прибора в INT значении',
  `codegroup` int(11) default NULL,
  PRIMARY KEY  (`meter_id`),
  KEY `FK_meters_1` (`typemeter_id`),
  KEY `FK_meters_2` (`user_id`),
  CONSTRAINT `FK_meters_1` FOREIGN KEY (`typemeter_id`) REFERENCES `typesmeters` (`typemeter_id`),
  CONSTRAINT `FK_meters_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=cp1251 COMMENT='Приборы';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `orders`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `orders` (
  `order` int(11) default NULL,
  `hour` int(10) unsigned default NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `params`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `params` (
  `param_id` int(10) unsigned NOT NULL auto_increment,
  `spparam` int(10) unsigned default NULL,
  `description` varchar(120) default NULL,
  `canal` int(10) unsigned default NULL,
  `typeparam_id` int(10) unsigned default NULL,
  `unitparam_id` int(10) unsigned NOT NULL,
  `groupparams_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`param_id`),
  KEY `FK_params_1` (`typeparam_id`),
  KEY `FK_params_3` (`unitparam_id`),
  KEY `FK_params_2` (`groupparams_id`),
  CONSTRAINT `FK_params_2` FOREIGN KEY (`groupparams_id`) REFERENCES `groupsparams` (`groupparams_id`),
  CONSTRAINT `FK_params_3` FOREIGN KEY (`unitparam_id`) REFERENCES `unitsparams` (`unitparam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16340 DEFAULT CHARSET=cp1251 COMMENT='Параметры СП-Сети';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `paramsanaloggroup`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `paramsanaloggroup` (
  `analoggroup_id` int(10) unsigned NOT NULL auto_increment,
  `paramquery_id` int(10) unsigned NOT NULL,
  `lvalue` decimal(10,2) default NULL COMMENT 'Нижняя граница',
  `svalue` decimal(10,2) default NULL COMMENT 'Предупрежд. граница',
  `hvalue` decimal(10,2) default NULL COMMENT 'Верхняя граница',
  `color` int(10) unsigned default NULL COMMENT 'Цвет на графике',
  PRIMARY KEY  (`analoggroup_id`,`paramquery_id`),
  KEY `FK_paramsanaloggroups_2` (`paramquery_id`),
  CONSTRAINT `FK_paramsanaloggroups_1` FOREIGN KEY (`analoggroup_id`) REFERENCES `analoggroups` (`analoggroup_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_paramsanaloggroups_2` FOREIGN KEY (`paramquery_id`) REFERENCES `paramsqueries` (`paramquery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED COMMENT='Параметры аналоговых групп';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `paramsdiagrams`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `paramsdiagrams` (
  `diagram_id` int(10) unsigned NOT NULL auto_increment,
  `paramquery_id` int(10) unsigned NOT NULL,
  `color` int(10) unsigned default NULL,
  `caption` varchar(45) default NULL,
  `avalue` decimal(10,2) default NULL COMMENT 'Аварийное знач. параметра',
  `wvalue` decimal(10,2) default NULL COMMENT 'Предупреж. знач. параметра',
  `order` int(10) unsigned default NULL COMMENT 'Номер отображения',
  PRIMARY KEY  (`diagram_id`,`paramquery_id`),
  KEY `FK_paramsdiagrams_2` (`paramquery_id`),
  CONSTRAINT `FK_paramsdiagrams_1` FOREIGN KEY (`diagram_id`) REFERENCES `diagrams` (`diagram_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_paramsdiagrams_2` FOREIGN KEY (`paramquery_id`) REFERENCES `paramsqueries` (`paramquery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=cp1251 COMMENT='Параметры диаграмм';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `paramsqueries`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `paramsqueries` (
  `paramquery_id` int(10) unsigned NOT NULL auto_increment,
  `param_id` int(10) unsigned NOT NULL,
  `meter_id` int(10) unsigned NOT NULL,
  `value` decimal(10,2) default NULL COMMENT 'Послед. получ-ое знач.',
  `enabled` tinyint(3) default NULL,
  `name` varchar(255) default NULL,
  `array_id` int(10) unsigned default NULL COMMENT 'Признак массива',
  `lastvalueupdate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT 'Время послед. обновления value',
  `unitparam_id` int(10) unsigned default NULL COMMENT 'Единица измер.',
  PRIMARY KEY  (`paramquery_id`),
  KEY `FK_paramsqueries_1` (`meter_id`),
  KEY `FK_paramsqueries_2` (`param_id`),
  KEY `FK_paramsqueries_3` (`array_id`),
  KEY `FK_paramsqueries_4` (`unitparam_id`),
  CONSTRAINT `FK_paramsqueries_1` FOREIGN KEY (`meter_id`) REFERENCES `meters` (`meter_id`),
  CONSTRAINT `FK_paramsqueries_2` FOREIGN KEY (`param_id`) REFERENCES `params` (`param_id`),
  CONSTRAINT `FK_paramsqueries_3` FOREIGN KEY (`array_id`) REFERENCES `arraies` (`array_id`),
  CONSTRAINT `FK_paramsqueries_4` FOREIGN KEY (`unitparam_id`) REFERENCES `unitsparams` (`unitparam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1619 DEFAULT CHARSET=cp1251 COMMENT='Параметры опроса';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `paramsreports`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `paramsreports` (
  `paramquery_id` int(10) unsigned NOT NULL auto_increment,
  `report_id` int(10) unsigned NOT NULL default '0',
  `sql_param` varchar(10) default NULL COMMENT 'Назв. параметра в SQL запросе',
  `sql_param_number` int(10) unsigned default NULL,
  PRIMARY KEY  (`paramquery_id`,`report_id`),
  KEY `FK_paramsreports_2` (`report_id`),
  CONSTRAINT `FK_paramsreports_1` FOREIGN KEY (`paramquery_id`) REFERENCES `paramsqueries` (`paramquery_id`),
  CONSTRAINT `FK_paramsreports_2` FOREIGN KEY (`report_id`) REFERENCES `reports` (`report_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1619 DEFAULT CHARSET=cp1251 COMMENT='Параметры отчетов';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `reportdatecount`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reportdatecount` (
  `daycount` int(10) unsigned default NULL COMMENT 'Кол. последних дней отображ. пользов.',
  `monthcount` int(10) unsigned default NULL COMMENT 'Кол. последних месяцев отображ. пользов.',
  `reportdatecount_id` int(10) unsigned NOT NULL auto_increment,
  `yearcount` int(11) default NULL COMMENT 'Кол. последних лет отображ. пользов.',
  PRIMARY KEY  (`reportdatecount_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=cp1251 COMMENT='Конфигурация';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `reports`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reports` (
  `report_id` int(10) unsigned NOT NULL auto_increment,
  `data` longblob,
  `sql` longtext,
  `createusername` varchar(55) default NULL,
  `modusername` varchar(55) default NULL,
  `moddatetime` datetime default NULL,
  PRIMARY KEY  (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=cp1251 COMMENT='Отчеты';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `typesmeters`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `typesmeters` (
  `typemeter_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  PRIMARY KEY  (`typemeter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=cp1251 COMMENT='Названия типов приборов';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `unitsparams`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `unitsparams` (
  `unitparam_id` int(10) unsigned NOT NULL auto_increment,
  `unitSN` varchar(45) default NULL,
  `unitPR` varchar(45) default NULL,
  PRIMARY KEY  (`unitparam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=cp1251 COMMENT='Единицы измерения параметров; InnoDB free: 45056 kB';
SET character_set_client = @saved_cs_client;

-----------------------------------------------------------------

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED COMMENT='Пользователи';
SET character_set_client = @saved_cs_client;