/*
MySQL Data Transfer
Source Host: localhost
Source Database: shopp_database
Target Host: localhost
Target Database: shopp_database
Date: 2016/12/22 3:17:09
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for comment_reply
-- ----------------------------
CREATE TABLE `comment_reply` (
  `id` varchar(36) NOT NULL,
  `content` text NOT NULL,
  `comment_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `creation_time` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_address
-- ----------------------------
CREATE TABLE `shopp_address` (
  `id` char(36) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_auth_group
-- ----------------------------
CREATE TABLE `shopp_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` char(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_auth_group_access
-- ----------------------------
CREATE TABLE `shopp_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_auth_rule
-- ----------------------------
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
-- Table structure for shopp_authority
-- ----------------------------
CREATE TABLE `shopp_authority` (
  `id` char(36) NOT NULL,
  `describe` varchar(250) NOT NULL,
  `rule` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_cart
-- ----------------------------
CREATE TABLE `shopp_cart` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_cart_commodity
-- ----------------------------
CREATE TABLE `shopp_cart_commodity` (
  `id` char(36) NOT NULL,
  `commodity_id` char(36) NOT NULL,
  `cart_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_comment
-- ----------------------------
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
-- Table structure for shopp_comment_images
-- ----------------------------
CREATE TABLE `shopp_comment_images` (
  `id` char(36) NOT NULL,
  `comment_id` char(36) NOT NULL,
  `image` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_commodity
-- ----------------------------
CREATE TABLE `shopp_commodity` (
  `id` char(36) NOT NULL,
  `title` varchar(250) NOT NULL,
  `describe` text,
  `staistics` int(11) NOT NULL,
  `parameter` text NOT NULL,
  `creation_time` varchar(50) NOT NULL,
  `out_time` varchar(50) NOT NULL,
  `type_id` char(36) NOT NULL,
  `repertory` int(10) DEFAULT NULL,
  `price` double(20,0) NOT NULL,
  `grade` double(2,0) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_commodity_images
-- ----------------------------
CREATE TABLE `shopp_commodity_images` (
  `id` char(36) NOT NULL,
  `commodity_id` char(36) NOT NULL,
  `image` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_feedback
-- ----------------------------
CREATE TABLE `shopp_feedback` (
  `id` varchar(36) NOT NULL,
  `title` varchar(250) NOT NULL,
  `content` text NOT NULL,
  `creation_time` varchar(40) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_order
-- ----------------------------
CREATE TABLE `shopp_order` (
  `id` char(36) NOT NULL,
  `status` int(2) NOT NULL,
  `user_id` char(36) NOT NULL,
  `order_commodity_id` char(36) NOT NULL,
  `order_number` varchar(100) NOT NULL,
  `order_time` date NOT NULL,
  `pay_time` date NOT NULL,
  `succeed_time` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_order_commodity
-- ----------------------------
CREATE TABLE `shopp_order_commodity` (
  `id` char(36) NOT NULL,
  `order_id` char(36) NOT NULL,
  `commodity_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_role
-- ----------------------------
CREATE TABLE `shopp_role` (
  `id` char(36) NOT NULL,
  `content` varchar(250) NOT NULL,
  `describe` varchar(250) NOT NULL,
  `authority_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_type
-- ----------------------------
CREATE TABLE `shopp_type` (
  `id` char(36) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_user
-- ----------------------------
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
-- Records 
-- ----------------------------
INSERT INTO `shopp_commodity` VALUES ('62201991-76D9-8C50-F355-0707D95C5E9C', '苹果6s', '港版支持移动4G联通4G，一个 新的装逼利器', '0', '{\"CPU\\u578b\\u53f7\":\"A9\",\"\\u5c4f\\u5e55\\u5c3a\\u5bf8\":\"4.7\\u82f1\\u5bf8\",\"\\u54c1\\u724c\":\"Apple\\/\\u82f9\\u679c\"}', '1482336124', '1482249600', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '100', '3900', '0');
INSERT INTO `shopp_commodity` VALUES ('9A296D34-49D9-4D08-C46D-4E945A3239AC', '潮流男装【卫衣】', ' 秋冬休闲男士卫衣男冬季修身韩版T恤修身潮上衣流男士外套T恤衫潮  秋冬休闲男士卫衣男冬季修身韩版T恤修身潮上衣流男士外套T恤衫潮', '0', '{\"\\u5c3a\\u7801\":\"M\",\"\\u989c\\u8272\":\"\\u9ed1\\u8272\",\"\\u54c1\\u724c\":\"\\u97e9\\u6d41\\u70ed\\u6d6a\"}', '1482341201', '1514563200', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '400', '29', '0');
INSERT INTO `shopp_commodity` VALUES ('BB67BA6A-3AD3-1152-D15E-F88927B5F67C', '冬季新款男士高档纯色立领修身加厚保暖白鸭绒羽绒服外套短款男装 ', '冬季新款男士高档纯色立领修身加厚保暖白鸭绒羽绒服外套短款男装 ', '0', '{\"\\u989c\\u8272\":\"\\u7ea2\\u8272\",\"\\u54c1\\u724c\":\"\\u5176\\u5b83\\/other\",\"\\u539a\\u8584\":\"\\u5e38\\u89c4\",\"\\u586b\\u5145\\u7269\":\"\\u767d\\u9e2d\\u7ed2\",\"\\u5c3a\\u7801\":\"M\",\"\\u9002\\u7528\\u5bf9\\u8c61\":\"\\u7537-\\u9752\\u5e74\"}', '1482344319', '1485014400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '236', '438', '0');
INSERT INTO `shopp_commodity_images` VALUES ('2A74119C-46D6-5F07-65E0-DD705ABD833A', '62201991-76D9-8C50-F355-0707D95C5E9C', '5B12C73E-8A2F-0442-7D95-8609AF63EB5A.jpg');
INSERT INTO `shopp_commodity_images` VALUES ('37705449-B85A-1C81-B318-EC061C510EA6', 'BB67BA6A-3AD3-1152-D15E-F88927B5F67C', 'DADC0096-B1CE-9C46-A296-2C1555EF7988.png');
INSERT INTO `shopp_commodity_images` VALUES ('57D9C4B1-C9A3-07B6-7123-3D852440FE70', '62201991-76D9-8C50-F355-0707D95C5E9C', '39EB6743-9CDB-4684-3180-FB0831603AD1.jpg');
INSERT INTO `shopp_commodity_images` VALUES ('5D405906-9402-B991-6A5A-0517E9AEC582', 'BB67BA6A-3AD3-1152-D15E-F88927B5F67C', 'BE6F6B28-5244-7528-4A52-75A58AEDBD4A.png');
INSERT INTO `shopp_commodity_images` VALUES ('939F67FF-47CE-0036-6534-88D051884A1E', '62201991-76D9-8C50-F355-0707D95C5E9C', '525F32F5-531F-D08C-78AB-D8A4D4CE6BD4.jpg');
INSERT INTO `shopp_commodity_images` VALUES ('A582E981-8233-CFE8-493F-F5F5DA2BF13C', '9A296D34-49D9-4D08-C46D-4E945A3239AC', '4D066D0D-8E6C-BE12-5EE3-0AB5EB3F5B9A.png');
INSERT INTO `shopp_commodity_images` VALUES ('E5C619A4-035E-CCF6-894D-5F2501AAADD9', '62201991-76D9-8C50-F355-0707D95C5E9C', 'B8604197-AC21-0A97-82F7-E7DC8808ED4A.jpg');
INSERT INTO `shopp_commodity_images` VALUES ('FF999015-C262-B7D9-7188-E72F35B1166A', '9A296D34-49D9-4D08-C46D-4E945A3239AC', 'BAF7C6B2-53D7-78B7-0489-FE461D5DFD3C.png');
INSERT INTO `shopp_type` VALUES ('035979B6-A44A-32EA-646F-28A51C607A73', '手机数码');
INSERT INTO `shopp_type` VALUES ('57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '服装');
INSERT INTO `shopp_type` VALUES ('B619C389-BE62-40B1-0F25-4B5E60B356D2', '家电');
INSERT INTO `shopp_type` VALUES ('D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '日常用品');
INSERT INTO `shopp_type` VALUES ('F994FC1C-7A5F-16A6-70E4-1672633B13D6', '美妆');
INSERT INTO `shopp_type` VALUES ('FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '图书');
INSERT INTO `shopp_user` VALUES ('5D754767-F3D5-1D93-E588-856B288B08CC', 'admin@qq.com', 'admin', '0ec0cebaee2a51bb93589ef32bb8341a228f320d', null, '11111', '201612161528083417.png', '', null);
