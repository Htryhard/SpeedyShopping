/*
MySQL Data Transfer
Source Host: localhost
Source Database: ms_database
Target Host: localhost
Target Database: ms_database
Date: 2017/2/27 9:26:54
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for ms_content
-- ----------------------------
CREATE TABLE `ms_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creation_time` varchar(50) NOT NULL,
  `no` varchar(100) NOT NULL,
  `name` varchar(10) NOT NULL,
  `st_class` varchar(50) NOT NULL,
  `sex` varchar(5) NOT NULL,
  `nation` varchar(5) NOT NULL,
  `political_status` varchar(5) NOT NULL,
  `st_phone` varchar(50) NOT NULL,
  `st_email` varchar(50) NOT NULL,
  `st_family` varchar(250) NOT NULL,
  `st_identity_card` varchar(100) NOT NULL,
  `st_ka` varchar(100) NOT NULL,
  `st_address` varchar(200) NOT NULL,
  `st_family_phone` varchar(100) NOT NULL,
  `st_bi_num` varchar(5) NOT NULL,
  `st_xiu` varchar(10) NOT NULL,
  `st_pass` varchar(5) NOT NULL,
  `st_bi_pass` varchar(5) NOT NULL,
  `st_me` varchar(10) NOT NULL,
  `st_crp_xin` varchar(10) NOT NULL,
  `st_crp_ke` varchar(10) NOT NULL,
  `st_li` varchar(5) NOT NULL,
  `st_jiuye` varchar(5) NOT NULL,
  `st_jielun` varchar(5) NOT NULL,
  `ms_employment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ms_employment
-- ----------------------------
CREATE TABLE `ms_employment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` varchar(100) NOT NULL,
  `co_phone` varchar(50) NOT NULL,
  `start_time` varchar(50) NOT NULL,
  `creation_time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ms_user
-- ----------------------------
CREATE TABLE `ms_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(100) NOT NULL,
  `name` varchar(10) NOT NULL,
  `creation_time` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `ms_user` VALUES ('1', '20143316001', '陈有欢', '1487319288', '123');
