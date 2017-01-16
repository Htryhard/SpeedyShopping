/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50715
Source Host           : localhost:3306
Source Database       : shopp_database

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2017-01-16 20:28:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for comment_reply
-- ----------------------------
DROP TABLE IF EXISTS `comment_reply`;
CREATE TABLE `comment_reply` (
  `id` varchar(36) NOT NULL,
  `content` text NOT NULL,
  `comment_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `creation_time` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_reply
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_address
-- ----------------------------
DROP TABLE IF EXISTS `shopp_address`;
CREATE TABLE `shopp_address` (
  `id` char(36) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `user_id` char(36) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_address
-- ----------------------------
INSERT INTO `shopp_address` VALUES ('051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9', '077128384858', '广西壮族自治区 南宁市 良庆区 南晓镇', '5D754767-F3D5-1D93-E588-856B288B08CC', '你的大兄弟');
INSERT INTO `shopp_address` VALUES ('58B47E1E-2AC2-3972-3294-48A8764F2A74', '077128384858', '广西壮族自治区 柳州市 柳州职业技术学院', '5D754767-F3D5-1D93-E588-856B288B08CC', '爱丽丝');

-- ----------------------------
-- Table structure for shopp_authority
-- ----------------------------
DROP TABLE IF EXISTS `shopp_authority`;
CREATE TABLE `shopp_authority` (
  `id` char(36) NOT NULL,
  `describe` varchar(250) NOT NULL,
  `rule` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_authority
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `shopp_auth_group`;
CREATE TABLE `shopp_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` char(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `shopp_auth_group_access`;
CREATE TABLE `shopp_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_auth_group_access
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `shopp_auth_rule`;
CREATE TABLE `shopp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_auth_rule
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopp_cart`;
CREATE TABLE `shopp_cart` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_cart
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_cart_commodity
-- ----------------------------
DROP TABLE IF EXISTS `shopp_cart_commodity`;
CREATE TABLE `shopp_cart_commodity` (
  `id` char(36) NOT NULL,
  `commodity_id` char(36) NOT NULL,
  `cart_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_cart_commodity
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_comment
-- ----------------------------
DROP TABLE IF EXISTS `shopp_comment`;
CREATE TABLE `shopp_comment` (
  `id` char(36) NOT NULL,
  `content` text NOT NULL,
  `grade` double(2,0) NOT NULL COMMENT '星级1 2 3 4 5 6 7 8 9 10',
  `creation_time` date NOT NULL,
  `user_id` char(36) NOT NULL,
  `commodity_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_comment
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_comment_images
-- ----------------------------
DROP TABLE IF EXISTS `shopp_comment_images`;
CREATE TABLE `shopp_comment_images` (
  `id` char(36) NOT NULL,
  `comment_id` char(36) NOT NULL,
  `image` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_comment_images
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_commodity
-- ----------------------------
DROP TABLE IF EXISTS `shopp_commodity`;
CREATE TABLE `shopp_commodity` (
  `id` char(36) NOT NULL,
  `title` varchar(250) NOT NULL,
  `describe` text,
  `staistics` int(11) NOT NULL,
  `parameter` text NOT NULL,
  `creation_time` varchar(50) NOT NULL,
  `out_time` varchar(50) NOT NULL,
  `type_id` char(36) NOT NULL,
  `grade` double(2,0) NOT NULL,
  `states` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_commodity
-- ----------------------------
INSERT INTO `shopp_commodity` VALUES ('1C26D516-A5F1-7C2E-7158-8A658A3F9083', '27寸大屏2K液晶电脑显示器 IPS高清1080PS4游戏制图显示屏HDMI ', '                                                            27寸大屏幕 IPS屏 高清分辨率 游戏 PS4                                                 ', '0', '{\"\\u5236\\u9020\\u5546\\u540d\\u79f0\":\"\\u6df1\\u5733\\u5e02\\u540e\\u601d\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\",\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u6db2\\u6676\\u663e\\u793a\\u5668\",\"\\u578b\\u53f7\":\"BKA270\",\"\\u6444\\u50cf\\u5934\\u7c7b\\u578b\":\"\\u65e0\\u6444\\u50cf\\u5934\",\"\\u7535\\u6c60\":\"6000\\u6beb\\u5b89\"}', '1482860943', '1483718400', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0');

-- ----------------------------
-- Table structure for shopp_commodity_images
-- ----------------------------
DROP TABLE IF EXISTS `shopp_commodity_images`;
CREATE TABLE `shopp_commodity_images` (
  `id` char(36) NOT NULL,
  `commodity_id` char(36) NOT NULL,
  `image` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_commodity_images
-- ----------------------------
INSERT INTO `shopp_commodity_images` VALUES ('643F82EF-7F61-3C9B-6C76-62D5255C2557', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'B3195156-9300-44C5-56FB-552D8D67FFD7.png');
INSERT INTO `shopp_commodity_images` VALUES ('673D94FA-01E2-6F9F-D35F-9F87C3CA22F7', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', '6350699E-CD5B-DC0A-198C-78320274A619.png');
INSERT INTO `shopp_commodity_images` VALUES ('A4A73C7A-46AD-F92B-DC43-F6279FB5306E', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'C48809C5-1916-F829-8490-3A99D06CC7C8.png');
INSERT INTO `shopp_commodity_images` VALUES ('BEFF68EF-B07E-B032-36FB-850F0FFBC50E', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'E56FA03A-738D-500E-F9C4-C84636B61F6F.png');
INSERT INTO `shopp_commodity_images` VALUES ('CB420F6D-2768-F2BB-EE1B-31CCF0ABA4F5', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', '32156F6D-2601-5460-EE18-6499A4A08901.png');

-- ----------------------------
-- Table structure for shopp_feedback
-- ----------------------------
DROP TABLE IF EXISTS `shopp_feedback`;
CREATE TABLE `shopp_feedback` (
  `id` varchar(36) NOT NULL,
  `title` varchar(250) NOT NULL,
  `content` text NOT NULL,
  `creation_time` varchar(40) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_order
-- ----------------------------
DROP TABLE IF EXISTS `shopp_order`;
CREATE TABLE `shopp_order` (
  `id` char(36) NOT NULL,
  `status` int(2) NOT NULL,
  `user_id` char(36) NOT NULL,
  `order_number` varchar(100) NOT NULL,
  `order_time` varchar(20) NOT NULL,
  `pay_time` varchar(20) NOT NULL,
  `succeed_time` varchar(20) NOT NULL,
  `address_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_order
-- ----------------------------
INSERT INTO `shopp_order` VALUES ('3D6DBFA3-624E-69DB-E8DE-5D26B9E33968', '2', '5D754767-F3D5-1D93-E588-856B288B08CC', '1483776627', '1483776627', '1483776627', '1483776627', '051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9');
INSERT INTO `shopp_order` VALUES ('8630AB36-897C-F23D-961E-B4ACB15D9C8A', '2', '5D754767-F3D5-1D93-E588-856B288B08CC', '1483030733', '1483030733', '1483030733', '1483030733', '051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9');

-- ----------------------------
-- Table structure for shopp_order_specification
-- ----------------------------
DROP TABLE IF EXISTS `shopp_order_specification`;
CREATE TABLE `shopp_order_specification` (
  `id` char(36) NOT NULL,
  `order_id` char(36) NOT NULL,
  `specification_id` char(36) NOT NULL,
  `count` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_order_specification
-- ----------------------------
INSERT INTO `shopp_order_specification` VALUES ('11E20DE9-8F7E-A426-B390-34FADFADAAE9', '8630AB36-897C-F23D-961E-B4ACB15D9C8A', '7D118229-AF8E-3C21-D440-6A3E4B94424A', '2');
INSERT INTO `shopp_order_specification` VALUES ('FB3FB3ED-EA8D-C17A-B0A7-EEDB49463133', '3D6DBFA3-624E-69DB-E8DE-5D26B9E33968', '64D63924-E57B-C610-6CEF-4E528BE1D391', '4');

-- ----------------------------
-- Table structure for shopp_role
-- ----------------------------
DROP TABLE IF EXISTS `shopp_role`;
CREATE TABLE `shopp_role` (
  `id` char(36) NOT NULL,
  `content` varchar(250) NOT NULL,
  `describe` varchar(250) NOT NULL,
  `authority_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_role
-- ----------------------------

-- ----------------------------
-- Table structure for shopp_specification
-- ----------------------------
DROP TABLE IF EXISTS `shopp_specification`;
CREATE TABLE `shopp_specification` (
  `id` varchar(36) NOT NULL,
  `content` varchar(250) NOT NULL,
  `price` double(20,0) NOT NULL,
  `repertory` int(10) NOT NULL,
  `commodity_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_specification
-- ----------------------------
INSERT INTO `shopp_specification` VALUES ('64D63924-E57B-C610-6CEF-4E528BE1D391', '高配2K高清版', '999', '12', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('BDE33C6F-A44C-ECC3-4585-6B493AD223F3', '白色普通版', '800', '20', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('D29F12CC-3CCF-5749-E84F-BD61DAC7E61C', '黑色普通版', '800', '26', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');

-- ----------------------------
-- Table structure for shopp_type
-- ----------------------------
DROP TABLE IF EXISTS `shopp_type`;
CREATE TABLE `shopp_type` (
  `id` char(36) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_type
-- ----------------------------
INSERT INTO `shopp_type` VALUES ('035979B6-A44A-32EA-646F-28A51C607A73', '手机数码');
INSERT INTO `shopp_type` VALUES ('57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '服装');
INSERT INTO `shopp_type` VALUES ('B619C389-BE62-40B1-0F25-4B5E60B356D2', '家电');
INSERT INTO `shopp_type` VALUES ('D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '日常用品');
INSERT INTO `shopp_type` VALUES ('F994FC1C-7A5F-16A6-70E4-1672633B13D6', '美妆');
INSERT INTO `shopp_type` VALUES ('FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '图书');

-- ----------------------------
-- Table structure for shopp_user
-- ----------------------------
DROP TABLE IF EXISTS `shopp_user`;
CREATE TABLE `shopp_user` (
  `id` char(36) NOT NULL,
  `email` varchar(30) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `password` varchar(40) NOT NULL,
  `nick_name` varchar(20) DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) NOT NULL,
  `icon` varchar(250) NOT NULL COMMENT '头像',
  `sbasb` varchar(250) DEFAULT '',
  `role_id` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopp_user
-- ----------------------------
INSERT INTO `shopp_user` VALUES ('5D754767-F3D5-1D93-E588-856B288B08CC', 'admin@qq.com', 'admin', '0ec0cebaee2a51bb93589ef32bb8341a228f320d', null, '11111', '201612161528083417.png', '', null);
INSERT INTO `shopp_user` VALUES ('843B2B6B-4D6C-14C0-8C0B-184BEC722BD3', 'test2@qq.com', 'test2', '9e8fa5ab3be86fd237c16f2f358216de81118c18', null, '22222', '201612231058437310.png', '', null);
INSERT INTO `shopp_user` VALUES ('C6C5BE9C-76CB-AC21-0476-942224A29F96', 'test1@qq.com', 'test1', '0cff20526af50e37b8fe8c49313f2ae1a1e622ab', null, '111111111', '201612231008219460.png', '', null);
SET FOREIGN_KEY_CHECKS=1;
