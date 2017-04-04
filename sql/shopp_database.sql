/*
MySQL Data Transfer
Source Host: localhost
Source Database: shopp_database
Target Host: localhost
Target Database: shopp_database
Date: 2017/4/4 21:47:05
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for shopp_address
-- ----------------------------
CREATE TABLE `shopp_address` (
  `id` char(36) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `user_id` char(36) NOT NULL,
  `user_name` varchar(30) NOT NULL,
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
-- Table structure for shopp_cart_specification
-- ----------------------------
CREATE TABLE `shopp_cart_specification` (
  `id` char(36) NOT NULL,
  `specification_id` char(36) NOT NULL,
  `cart_id` char(36) NOT NULL,
  `count` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_collect
-- ----------------------------
CREATE TABLE `shopp_collect` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `commodity_id` varchar(36) NOT NULL,
  `creation_time` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_comment
-- ----------------------------
CREATE TABLE `shopp_comment` (
  `id` char(36) NOT NULL,
  `content` text NOT NULL,
  `grade` double(2,0) NOT NULL COMMENT '星级1 2 3 4 5 6 7 8 9 10',
  `creation_time` char(255) NOT NULL,
  `user_id` char(36) NOT NULL,
  `specification_id` char(36) NOT NULL,
  `status` varchar(10) NOT NULL,
  `order_id` char(36) NOT NULL,
  `commodity_id` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_comment_images
-- ----------------------------
CREATE TABLE `shopp_comment_images` (
  `id` char(36) NOT NULL,
  `comment_id` char(36) NOT NULL,
  `image` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_comment_reply
-- ----------------------------
CREATE TABLE `shopp_comment_reply` (
  `id` varchar(36) NOT NULL,
  `content` text NOT NULL,
  `comment_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `creation_time` varchar(40) NOT NULL,
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
  `grade` varchar(10) NOT NULL,
  `states` int(2) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
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
-- Table structure for shopp_count
-- ----------------------------
CREATE TABLE `shopp_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipcontent` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL,
  `user` varchar(100) DEFAULT NULL,
  `modle` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1407 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_feedback
-- ----------------------------
CREATE TABLE `shopp_feedback` (
  `id` varchar(36) NOT NULL COMMENT '反馈表',
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
  `order_number` varchar(100) NOT NULL,
  `order_time` varchar(20) NOT NULL,
  `pay_time` varchar(20) DEFAULT NULL,
  `succeed_time` varchar(20) DEFAULT NULL,
  `address_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_order_specification
-- ----------------------------
CREATE TABLE `shopp_order_specification` (
  `id` char(36) NOT NULL COMMENT '单订和规格的中间表',
  `order_id` char(36) NOT NULL,
  `specification_id` char(36) NOT NULL,
  `count` int(10) NOT NULL,
  `price` varchar(10) DEFAULT NULL,
  `specificationcontent` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_refunds
-- ----------------------------
CREATE TABLE `shopp_refunds` (
  `id` char(36) NOT NULL COMMENT '货退表',
  `specification_id` char(36) NOT NULL,
  `type` varchar(100) NOT NULL,
  `content` varchar(250) NOT NULL,
  `order_id` char(36) NOT NULL,
  `creation_time` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL,
  `user_id` char(36) NOT NULL,
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
-- Table structure for shopp_specification
-- ----------------------------
CREATE TABLE `shopp_specification` (
  `id` varchar(36) NOT NULL,
  `content` varchar(250) NOT NULL,
  `price` double(20,0) NOT NULL,
  `repertory` int(10) NOT NULL,
  `commodity_id` varchar(36) NOT NULL,
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
INSERT INTO `shopp_address` VALUES ('051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9', '077128384858', '广西壮族自治区 南宁市 良庆区 南晓镇', '5D754767-F3D5-1D93-E588-856B288B08CC', '你的大兄弟');
INSERT INTO `shopp_address` VALUES ('5168B53E-A892-0D70-B992-75B65DC0ECE3', '1782008688', '广东省 广州市 天河区 棠下街道', '426D79CF-279A-2033-0A77-72166CC15CC1', '小赖宝宝');
INSERT INTO `shopp_address` VALUES ('58B47E1E-2AC2-3972-3294-48A8764F2A74', '077128384858', '广西壮族自治区 柳州市 柳州职业技术学院', '5D754767-F3D5-1D93-E588-856B288B08CC', '爱丽丝');
INSERT INTO `shopp_address` VALUES ('7D930930-7979-70BC-D48B-6586FCAFE0B1', '077128384858', '广东广州天河区', '98EB35BE-CB9E-82A3-C458-5CD2A21BF59D', '筑梦草根');
INSERT INTO `shopp_address` VALUES ('B1A6D755-B3FA-40BD-6500-0BB14CF4A303', '77889966', '广州市 越秀区 越秀越秀', 'AA692D26-B786-D8A0-1420-F8F33264485C', '欢歌');
INSERT INTO `shopp_address` VALUES ('FCA8DF02-398F-5EC8-3549-C7EA83CB8DA7', '1768888', '广东省 广州市 天河区 天河工业园', '98EB35BE-CB9E-82A3-C458-5CD2A21BF59D', '张二二');
INSERT INTO `shopp_cart` VALUES ('34383404-566F-C790-6BAB-48A85225AA1F', '98EB35BE-CB9E-82A3-C458-5CD2A21BF59D');
INSERT INTO `shopp_cart` VALUES ('CD80475B-942E-E686-55D2-302363E3A2A3', '5D754767-F3D5-1D93-E588-856B288B08CC');
INSERT INTO `shopp_cart` VALUES ('E1278ED5-CEE1-6CC4-D63A-788D82D8A4E8', 'AA692D26-B786-D8A0-1420-F8F33264485C');
INSERT INTO `shopp_cart` VALUES ('F77903BE-80A4-B9BD-88F7-058666C0F8F1', '426D79CF-279A-2033-0A77-72166CC15CC1');
INSERT INTO `shopp_cart_specification` VALUES ('4300D42F-93E5-EB46-41B0-008EC77F2ECC', '3FC5CCB0-0160-34C4-E181-C419F0070958', 'CD80475B-942E-E686-55D2-302363E3A2A3', '2');
INSERT INTO `shopp_cart_specification` VALUES ('754776A3-0B1D-E742-14E6-8FD865555313', '3FC5CCB0-0160-34C4-E181-C419F0070958', 'F77903BE-80A4-B9BD-88F7-058666C0F8F1', '1');
INSERT INTO `shopp_cart_specification` VALUES ('7837CB85-6915-162E-B4DA-E8149E65209F', '1FFC4E4C-B777-D0B5-2B79-766B35713043', 'CD80475B-942E-E686-55D2-302363E3A2A3', '1');
INSERT INTO `shopp_cart_specification` VALUES ('9A82E897-199A-9DFF-B814-07C52FDD2DCE', '0959E8FD-75B4-F041-9820-C0038FDD68DD', 'F77903BE-80A4-B9BD-88F7-058666C0F8F1', '1');
INSERT INTO `shopp_cart_specification` VALUES ('A9CC507A-A166-5C17-576D-3694ACF0CFAE', '84231135-44F5-BA48-ADBE-4F2377042F68', 'E1278ED5-CEE1-6CC4-D63A-788D82D8A4E8', '2');
INSERT INTO `shopp_cart_specification` VALUES ('CA811C9A-974C-BF3A-726C-548A4FC8AA22', '3FC5CCB0-0160-34C4-E181-C419F0070958', '34383404-566F-C790-6BAB-48A85225AA1F', '1');
INSERT INTO `shopp_cart_specification` VALUES ('DEAF10C1-E5CD-B8FB-FB3D-0AA01B997111', 'B3A7547B-21AE-FBA4-EBD0-28C1EE3E416E', '34383404-566F-C790-6BAB-48A85225AA1F', '1');
INSERT INTO `shopp_cart_specification` VALUES ('E50A5109-14AA-9E06-8304-C3D4CFE34D9B', '8F1748AD-30E8-7A09-D78D-7ACAE9E8F711', 'E1278ED5-CEE1-6CC4-D63A-788D82D8A4E8', '5');
INSERT INTO `shopp_collect` VALUES ('0933F13F-D5D9-F8B0-7629-C561D8E42DF6', '5D754767-F3D5-1D93-E588-856B288B08CC', '179149C6-2255-FAA2-F9F8-CA6608080FAA', '1487170028');
INSERT INTO `shopp_collect` VALUES ('18986546-E777-C595-DCF8-ADDC3A185B9F', '5D754767-F3D5-1D93-E588-856B288B08CC', '753C793E-1F5D-1DC7-4103-A23D23E016C2', '1487170021');
INSERT INTO `shopp_collect` VALUES ('1E11DADF-860B-27E7-43EB-4C87C92F17E8', '5D754767-F3D5-1D93-E588-856B288B08CC', '22B10E64-2792-9976-E179-2481FBD15CB5', '1487528525');
INSERT INTO `shopp_collect` VALUES ('3819D231-DDB6-035D-E079-E70B0C7F11D3', '5D754767-F3D5-1D93-E588-856B288B08CC', 'D678064A-D80E-EFA2-4A01-873583FF3E9B', '1487170025');
INSERT INTO `shopp_collect` VALUES ('6F588002-A221-016D-EF14-063AB394BCE4', '5D754767-F3D5-1D93-E588-856B288B08CC', '934AE8D8-B061-C383-3FE1-6566C597B7F4', '1485160350');
INSERT INTO `shopp_collect` VALUES ('8053C695-9C0F-75C5-89CA-799A5E298CA8', '5D754767-F3D5-1D93-E588-856B288B08CC', 'C3E30939-86EB-730F-900E-17B582155781', '1486699401');
INSERT INTO `shopp_collect` VALUES ('891EB57B-4EC5-C352-FF06-8276D8708AE2', '5D754767-F3D5-1D93-E588-856B288B08CC', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', '1487526209');
INSERT INTO `shopp_collect` VALUES ('94D1AD21-8345-20E1-52AD-DE8441CE0697', 'AA692D26-B786-D8A0-1420-F8F33264485C', '37B10231-4225-C269-DB28-F1C40A6CA448', '1491013063');
INSERT INTO `shopp_collect` VALUES ('98760AA2-3C09-F263-E561-921E5661520F', '5D754767-F3D5-1D93-E588-856B288B08CC', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '1484745758');
INSERT INTO `shopp_collect` VALUES ('AB923F67-E31D-32EA-C8B5-C1515563C593', 'AA692D26-B786-D8A0-1420-F8F33264485C', 'DBDD6F97-71D8-FF7D-843F-33A2DA965DE1', '1491037064');
INSERT INTO `shopp_collect` VALUES ('BEBB89DB-ECB5-2BC8-D36C-B58DE79BBC8D', '5D754767-F3D5-1D93-E588-856B288B08CC', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '1484728832');
INSERT INTO `shopp_collect` VALUES ('C7A52854-542F-2F9D-214B-1A2FFF7FC2F2', '5D754767-F3D5-1D93-E588-856B288B08CC', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8', '1486699415');
INSERT INTO `shopp_collect` VALUES ('C8A15885-4628-EFB4-AEB6-6AB29CB61108', '5D754767-F3D5-1D93-E588-856B288B08CC', 'D2BCDC64-0970-3775-3193-6D870A490A84', '1487170036');
INSERT INTO `shopp_collect` VALUES ('D9C5A264-E1CC-FCF0-14D8-4F34F15E0506', '5D754767-F3D5-1D93-E588-856B288B08CC', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D', '1487170039');
INSERT INTO `shopp_collect` VALUES ('DDA8EF38-2184-8F3B-532F-0F6774E3C741', '5D754767-F3D5-1D93-E588-856B288B08CC', '72387161-B237-7FC1-3FB3-E78C23533C5C', '1487170033');
INSERT INTO `shopp_collect` VALUES ('E15310D0-8D62-B658-1627-BE3F7560D2B9', 'AA692D26-B786-D8A0-1420-F8F33264485C', 'C3E30939-86EB-730F-900E-17B582155781', '1491013058');
INSERT INTO `shopp_comment` VALUES ('820C8AB5-E75A-8C8F-1696-54FD048F9F7B', '这是非常好的一个屏幕啊！装逼啦！', '4', '1491114211', 'AA692D26-B786-D8A0-1420-F8F33264485C', '64D63924-E57B-C610-6CEF-4E528BE1D391', '0', '9C37472C-EAAD-6298-5335-F08AA95EE596', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_comment` VALUES ('C0A475A4-9EA6-20AD-B8FD-0A3ABBB1D285', '非常棒！来看看效果吧！', '4', '1491116073', '5D754767-F3D5-1D93-E588-856B288B08CC', '64D63924-E57B-C610-6CEF-4E528BE1D391', '0', 'D4C47261-28F9-601F-A516-F3270C883468', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_comment` VALUES ('FEFEE7A9-9629-72A5-6434-C682E22F1A05', '勉勉强强，图我就不上了，买了自己懂', '2', '1491152768', 'AA692D26-B786-D8A0-1420-F8F33264485C', '8F1748AD-30E8-7A09-D78D-7ACAE9E8F711', '0', '5F3E8B10-9CC9-CAA0-BA24-D7057450511A', '61F54F17-89B5-A2B6-2A20-353A55A4F6D5');
INSERT INTO `shopp_comment_images` VALUES ('6CDB0A80-2038-8889-29D9-3F0D4335408C', 'C0A475A4-9EA6-20AD-B8FD-0A3ABBB1D285', 'DDF42A44-ACBA-5007-64B9-CF32FD2131E3.jpeg');
INSERT INTO `shopp_comment_images` VALUES ('78802A49-8AE8-524B-5458-2DBC69A3CEE4', 'C0A475A4-9EA6-20AD-B8FD-0A3ABBB1D285', '4A2073B3-1A1F-5F19-8856-A7477B75FAA1.jpeg');
INSERT INTO `shopp_comment_images` VALUES ('BE25FF2C-EB9B-B352-D462-23B19A1AF62A', '820C8AB5-E75A-8C8F-1696-54FD048F9F7B', 'A3950838-CCCE-FB21-6991-A356B0042541.png');
INSERT INTO `shopp_comment_images` VALUES ('C3D43FC6-ECCB-2528-470F-74DFA77C7374', 'C0A475A4-9EA6-20AD-B8FD-0A3ABBB1D285', '9A6CE1F0-4118-5860-BED6-07A4F2696C27.jpeg');
INSERT INTO `shopp_commodity` VALUES ('00D84306-7B0D-F027-28E4-09D70124D2CB', '包邮 韩国菲诗小铺双头自动旋转眉笔一字眉 防水防汗带眉刷非眉粉', '扁平型笔芯设计，扁平口保护笔芯！扁平眉笔可以大面积的均匀上色，笔芯软硬适中，使眉毛看起来更加自然。眉笔还有一个小技巧，深棕色系眉笔还可以做阴影哈！', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"The Face Shop\",\"\\u51c0\\u542b\\u91cf\":\"0.3g\",\"\\u5f69\\u5986\\u5206\\u7c7b\":\"\\u7709\\u7b14\",\"\\u529f\\u6548\":\"\\u9632\\u6c34 \\u9501\\u8272\",\"\\u4fdd\\u8d28\\u671f\":\"3\\u5e74\"}', '1486201101', '1517673600', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('1581855B-4F44-E6F1-8E95-59AD9A5A0C5D', '重庆磁器口手工陈建平陈麻花500g四川美食特产香酥糕点心零食天津 ', '                    磁器口排队那家！我们是厂家直接送货，质量保证！麻花是易碎物品，在快递过程中我们不能保证不碎，我们只能是保证要尽心尽力的包装好，追求完美的朋友希望慎重，谢谢！2包包邮，全场48元包邮（除新疆西藏内蒙等地）                ', '0', '{\"\\u5382\\u5740\":\"\\u91cd\\u5e86\\u5e02\\u6c99\\u576a\\u575d\\u533a\\u78c1\\u5668\\u53e3\\u6b63\\u885772\",\"\\u4fdd\\u8d28\\u671f\":\"270\"}', '1487261125', '1550332800', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', 'AA55FB3D-7512-7C3A-8ED9-5133660998E7.png');
INSERT INTO `shopp_commodity` VALUES ('179149C6-2255-FAA2-F9F8-CA6608080FAA', '电器插头挂钩 电源线插座支架收纳整理架 创意百货 2个装 ', '极有家认证[优质网店]：11年好店，权威认证，买退无忧', '0', '{\"\\u627f\\u91cd\":\"1kg\\u4ee5\\u4e0b\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u68d5\\u8272 \\u767d\\u8272 \\u9ed1\\u8272 \\u7eff\\u8272\",\"\\u5438\\u9644\\u65b9\\u5f0f\":\"\\u7c98\\u80f6\",\"\\u6750\\u8d28\":\"\\u5851\\u6599\"}', '1486199439', '1580745600', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('1C26D516-A5F1-7C2E-7158-8A658A3F9083', '27寸大屏2K液晶电脑显示器 IPS高清1080PS4游戏制图显示屏HDMI ', '                                                            27寸大屏幕 IPS屏 高清分辨率 游戏 PS4                                                 ', '0', '{\"\\u5236\\u9020\\u5546\\u540d\\u79f0\":\"\\u6df1\\u5733\\u5e02\\u540e\\u601d\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\",\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u6db2\\u6676\\u663e\\u793a\\u5668\",\"\\u578b\\u53f7\":\"BKA270\",\"\\u6444\\u50cf\\u5934\\u7c7b\\u578b\":\"\\u65e0\\u6444\\u50cf\\u5934\",\"\\u7535\\u6c60\":\"6000\\u6beb\\u5b89\"}', '1482860943', '1483718400', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '9', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('21B3CE06-EBCB-ECA1-E311-88D1C759C156', '韩国deHub吸盘衣帽挂钩 厨房浴室卧室尖头无痕免钉不掉落挂钩百货 ', '①钩子为加长型，可挂带子很款的包包。②可贴大头贴，公司logo。③细小的尖头可穿很小的孔洞。④适合挂各种东西，只有您想不到的，没有挂不了的。⑤承重力5kg，粗糙面也可用。⑥ 重点是：此款还包邮哦，亲！', '0', '{\"\\u54c1\\u724c\":\"deHub\",\"\\u627f\\u91cd\":\"3kg(\\u4e0d\\u542b)-5kg\\uff08\\u542b\\uff09\",\"\\u8d27\\u53f7\":\"AHK60\",\"\\u5438\\u9644\\u65b9\\u5f0f\":\"\\u5438\\u76d8\",\"\\u6750\\u8d28\":\"\\u5851\\u6599\"}', '1486199169', '1580745600', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('22B10E64-2792-9976-E179-2481FBD15CB5', 'Apple/苹果 iPhone 7 Plus 苹果7 5.5寸国行港版现货 7p 7代手机 ', '新iphone特性：新增亮面黑，压力感应HOME键，ip67级防水防尘，1200w像素光学防抖，全新A10处理器，续航提升，立体扬声器 ，lightning耳机接入方式，双摄像头。 现货发！按订单顺序发货', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"iPhone 7 Plus\",\"iPhone 7 Plus\":\" 5.5\\u82f1\\u5bf8\",\"\\u7f51\\u7edc\\u7c7b\\u578b:\":\"4G\\u5168\\u7f51\\u901a\",\"\\u5b58\\u50a8\\u5bb9\\u91cf\":\"32GB 128GB 256GB\",\"\\u539a\\u5ea6\":\"7.3 \\u6beb\\u7c73 (0.29 \\u82f1\\u5bf8)\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1200 \\u4e07\\u50cf\\u7d20\\u5e7f\\u89d2\\u53ca\\u957f\"}', '1484925630', '1486742400', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('241411DE-FEBB-E3B4-4FE8-F73BDE54B32B', 'AEJE 5.1家庭影院音响套装家用ktv音箱客厅低音炮蓝牙hdmi功放机 ', 'AEJE发烧高清震撼5.1家庭影院 ● 含一台高清多功能蓝牙5.1功放 + 一套AEJE原装品质高清5.1音箱 ● 功放支持DTS/杜比解码、HDMI高清3入1出端口、单独6声道支持有/无源炮、内置蓝牙、USB、双人同时K歌，FM收音等【可用淘金币抵钱】升级功放享大优惠 ● 下单立赠7件套', '0', '{\"CCC\\u8bc1\\u4e66\\u7f16\\u53f7\":\"2013010802653540\",\"\\u4f4e\\u97f3\\u97f3\\u7bb1\\u4e2a\\u6570\":\"1\\u4e2a\",\"\\u4e2d\\u7f6e(\\u4e3b\\u97f3)\\u97f3\\u7bb1\\u4e2a\\u6570\":\"1\\u4e2a\",\"\\u524d\\u7f6e(\\u5de6\\u53f3)\\u97f3\\u7bb1\\u4e2a\\u6570\":\"2\\u4e2a\",\"\\u540e\\u7f6e(\\u73af\\u7ed5)\\u97f3\\u7bb1\\u4e2a\\u6570\":\"2\\u4e2a\",\"\\u4e3b\\u673a\\u7c7b\\u578b\":\"\\u4ec5\\u6709\\u529f\\u653e\\u65e0\\u789f\\u673a\",\"\\u89c6\\u9891\\u8fde\\u63a5\\u65b9\\u5f0f\":\"HDMI \\u8272\\u5dee\\u5206\\u91cf\",\"\\u97f3\\u6548\\u6a21\\u5f0f\":\"DTS Dolby Digital\"}', '1486188726', '1580745600', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', '拉夏贝尔2017春款新品 条纹方领九分袖衬衫式连衣裙10012162 ', '拉夏贝尔2017春款新品 条纹方领九分袖衬衫式连衣裙10012162 ', '0', '{\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u68c9100%\",\"\\u9500\\u552e\\u6e20\\u9053\\u7c7b\\u578b\":\"\\u5546\\u573a\\u540c\\u6b3e\"}', '1484975106', '1579536000', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('26C82144-FCFB-AA3A-150D-2640FFF623F2', '制ZPLPKK 2017春季新款女士中长款舒适羽绒服修身毛领外套 ', '制ZPLPKK 2017春季新款女士中长款舒适羽绒服修身毛领外套 ', '0', '{\"\\u4e0a\\u5e02\\u5e74\\u4efd\\u5b63\\u8282\":\"2017\\u5e74\\u6625\\u5b63\",\"\\u539a\\u8584\":\"\\u5e38\\u89c4\",\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u7c98\\u80f6\\u7ea4\\u7ef4(\\u7c98\\u7ea4)51% \\u805a\\u916f\\u7ea4\"}', '1484975592', '1548345600', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('28FDD4CE-5DC6-FC44-58EE-47ABB5B33BCF', '四大名著 新课标必读 28000多名读者热评 ', '                    本套丛书包含《红楼梦》《三国演义》《水浒传》《西游记》，这四部著作可谓家喻户晓，在我国有着深远的影响，是汉语文学中不可多得的佳作。其中的故事、场景，已经深深地影响了中国人的思想观念、价值取向。四部著作以其极高的艺术水平、细致的人物刻画和丰富的思想内涵为历代读者所称道。\r\n     本丛书由北京市基层教育骨干教师主编，拥有强大的编写团队（作者均为知名高校中文系博士、硕士），以简洁上口的白话表达，译写、改写；去其糟粕、取其精华，专业插画师在通读文本基础上绘制精美插图，清晰详尽的知识点拓展，双色印刷编排，非常符合青少年阅读心里和阅读习惯。\r\n\r\n     丛书由国内知名的儿童文学作家、上海师范大学教授梅子涵先生写序并推荐。可谓“经典中的经典”。                ', '0', '{\"\\u5370\\u5237\\u65f6\\u95f4\":\"2013\\u5e7409\\u670801\\u65e5\",\"\\u56fd\\u9645\\u6807\\u51c6\\u4e66\\u53f7ISBN\":\"23356962\"}', '1490004693', '1584633600', 'FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '0', '0', '7FFEE1F9-2699-D245-92FC-64F3F0CD0DE4.png');
INSERT INTO `shopp_commodity` VALUES ('2D089988-6636-BF15-676F-15A6AED0433F', '打火机与公主裙 ', '我有我的国王，我是他不二之臣，我愿为他摇旗呐喊 ，也愿为他战死沙场。年度*受欢迎作者Twentine*之作，同名影视剧重磅打造中！ 春风得意每满150减50 文艺分会场>> ', '0', '{\"\\u7248 \\u6b21\":\"1\",\"\\u9875 \\u6570\":\"352\",\"\\u5b57 \\u6570\":\"2000000\",\"\\u56fd\\u9645\\u6807\\u51c6\\u4e66\\u53f7ISBN\":\"9787555247630\",\"\":\"\"}', '1489979760', '1532880000', 'FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '0', '0', '6DF8D5B2-81CB-1E08-822D-968B1FB61778.png');
INSERT INTO `shopp_commodity` VALUES ('37B10231-4225-C269-DB28-F1C40A6CA448', '雪纺白衬衫女长袖韩版休闲百搭职业女装秋冬季加绒加厚保暖衬衣寸', '衬衫', '0', '{\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u805a\\u916f\\u7ea4\\u7ef495% \\u805a\\u6c28\\u916f\\u5f39\\u6027\\u7ea4\",\"\\u670d\\u88c5\\u7248\\u578b\":\"\\u4fee\\u8eab\",\"\\u98ce\\u683c\":\"\\u901a\\u52e4\",\"\\u901a\\u52e4\":\"\\u97e9\\u7248\",\"\\u8863\\u95e8\\u895f\":\" \\u5355\\u6392\\u591a\\u6263\",\"\\u5c3a\\u7801\":\"S M L XL XXL 3XL 4XL\"}', '1484576598', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', '64G/128G顶配【送VR电源+12期分期】Xiaomi/小米 小米Max手机 MIX ', '正品保障，支持官网验货，全国联保！买就送：7H级纳米防爆膜，保护壳，延保一年等！小米MAX配置一览：①:顶配为4G运行内存+128G存储闪存；②:6.44英寸大屏黄金尺寸，④:全网通3.0，4G+；⑤:1600万像素，5片式镜头，f2.0光圈；⑥:4850mAh', '0', '{\"CPU\\u578b\\u53f7\":\"\\u9a81\\u9f99650\",\"\\u4ea7\\u54c1\\u540d\\u79f0:\":\"\\u5c0f\\u7c73Max\",\"\\u7f51\\u7edc\\u7c7b\\u578b:\":\"4G\\u5168\\u7f51\\u901a\",\"\\u952e\\u76d8\\u7c7b\\u578b\":\"\\u865a\\u62df\\u89e6\\u5c4f\\u952e\\u76d8\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1600\\u4e07\"}', '1484983134', '1611849600', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('433DA60D-5065-1301-48B8-76D1BB06CDF0', '现货当天发Huawei/华为 Mate 9 Pro保时捷4G曲屏手机正品mate9pro ', '【华为Mate9Pro原装正品手机现货当天发，下单再送购机豪礼】【收到货晒图分享美照有送好礼哦】(主图具体礼品以套餐为准】', '0', '{\"\\u54c1\\u724c\":\"\\u534e\\u4e3a\",\"cpu\":\"G71 MP8 + \\u5fae\\u667a\\u6838i6\",\"\\u5c4f\\u5e55\\u5c3a\\u5bf8\":\"5.5\\u82f1\\u5bf8 2k\\u53cc\\u66f2\\u9762\",\"\\u6444\\u50cf\\u5934\":\"\\u524d800\\u4e07 + \\u540e2000\\u4e07 + 1200\\u4e07\\u50cf\\u7d20\",\"\\u7535\\u6c60\\u5bb9\\u91cf\":\"4000mah\"}', '1486186369', '1580745600', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('47D002AB-DFA4-11CF-52FB-398122144EF1', '五面取暖器烧烤型家用四面型小太阳全方位烤火器电暖炉电热扇包邮 ', '烧烤型五面烤火炉取暖器升级啦。顶部可调温,烧烤网可直接取下!  普通款特价机:尺寸21*21*37CM ,顶部2根管,无接渣盘。无调温开关,固定脚。网不能直接取下。  顶3管小款烧烤型:顶部3根管,尺寸为21*21*38CM,5面都有调温开关，带接渣盘。轮子脚，5面全开共2200W,顶面烧烤网可以直接取下。  顶3管大款烧烤型:顶部3根管,尺寸为23*23*43CM,5面都有高低调温开关,带接渣盘,轮子脚。5面全开共2200W,顶面烧烤网可以自行取下,  顶4管大款烧烤型:顶面4根管,尺寸为23*23*43CM,5面都有高低调温开关,带接渣盘,轮子脚。5面全开共2400W,顶面烧烤网可以单独取下.  注意:小款的取接渣盘处都有小门条设计,大款都是直接开口的,没有小门条,以图片显示为标准!', '0', '{\"CCC\\u8bc1\\u4e66\\u7f16\\u53f7\":\"2009010707382203\",\"\\u53d6\\u6696\\u5668\\u52a0\\u70ed\\u65b9\\u5f0f\":\"\\u77f3\\u82f1\\u7ba1\\u52a0\\u70ed\",\"\\u667a\\u80fd\\u7c7b\\u578b\":\"\\u4e0d\\u652f\\u6301\\u667a\\u80fd\",\"\\u6700\\u5927\\u91c7\\u6696\\u9762\\u79ef(\\u5e73\\u65b9\\u7c73)\":\"20m^2\\u4ee5\\u4e0b\",\"\\u7535\\u6696\\u5668\\u6700\\u5927\\u529f\\u7387\":\"2000W\\u4ee5\\u4e0a\",\"\\u6863\\u4f4d\":\"5\\u6863\\u53ca\\u4ee5\\u4e0a\"}', '1486198318', '1580745600', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('4CF00EB1-8CBA-C3D9-F93F-DF01511391BE', '原封现货 现货速发Meizu/魅族 魅蓝X全网通4G八核智能手机 ', '                    全新白色现货！！送包邮+延保！！推荐选购套餐，搭使用更方便。 拒绝黄牛，每人限购1台相同类似地址多拍只发一台！双I2活动，现货大礼！！                ', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"Meizu\\/\\u9b45\\u65cf \\u9b45\\u84ddX\",\"CPU\\u54c1\\u724c\":\"\\u8054\\u53d1\\u79d1\",\"CPU\\u578b\\u53f7\":\"Helio P20\",\"\\u5c4f\\u5e55\\u5c3a\\u5bf8\":\"5.5\\u82f1\\u5bf8\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1200\\u4e07\",\"\\u8fd0\\u884c\\u5185\\u5b58RAM\":\"3GB\",\"\\u5b58\\u50a8\\u5bb9\\u91cf\":\"32GB\"}', '1487260706', '1581782400', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '7E70998B-C25C-BC33-971E-2E788CE80504.png');
INSERT INTO `shopp_commodity` VALUES ('511676D4-6E5E-A943-02D2-23838D8A4B2A', '卡丝拉狄 中年大衣女装中国风撞色绣花立领长袖宽松毛呢女士外套 ', '卡丝拉狄 中年大衣女装中国风撞色绣花立领长袖宽松毛呢女士外套 ', '0', '{\"\\u6d41\\u884c\\u5143\\u7d20\\/\\u5de5\\u827a\":\"\\u7ee3\\u82b1\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u9ec4\\u8272 \\u9ed1\\u8272 \\u84dd\\u8272\",\"\\u9886\\u5b50\":\"\\u7acb\\u9886\",\"\\u901a\\u52e4\":\"\\u97e9\\u7248\",\"\\u8863\\u95e8\\u895f\":\"\\u4e00\\u7c92\\u6263\",\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u7f8a\\u6bdb50% \\u805a\\u916f\\u7ea4\\u7ef450%\"}', '1484978091', '1585843200', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('61F54F17-89B5-A2B6-2A20-353A55A4F6D5', '愿你的青春无所畏惧，勇往直前 ', '一部让你在青春十字路口找到努力方向、学会规划人生、懂得设计未来的暖心之作！不曾努力的青春，那是虚度光阴；未曾拼搏的岁月，那是浪费生命！鹿晗、邓超、李晨、乐嘉备受推崇的人生信条！', '2', '{\"\\u5370\\u5237\\u65f6\\u95f4\":\"2016\\u5e7409\\u670815\\u65e5\",\"\\u9875 \\u6570\":\"386\",\"\\u56fd\\u9645\\u6807\\u51c6\\u4e66\\u53f7ISBN\":\"9787510146312\"}', '1490061187', '1553875200', 'FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '2.5', '0', 'D4FD3044-112E-265B-8460-E3C4141290AE.png');
INSERT INTO `shopp_commodity` VALUES ('6275F89C-A2A1-8B7B-A259-94926A84C442', '良品铺子手造麻薯干吃汤圆糕点点心特产美食小吃零食大礼包 组合', '良品铺子祝大家新春快乐大吉大利 咕叽咕叽 ', '0', '{\"\\u751f\\u4ea7\\u8bb8\\u53ef\\u8bc1\\u7f16\\u53f7\":\"QS4401 2401 2230 \",\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u8bf7\\u7f6e\\u4e8e\\u9634\\u51c9\\u5e72\\u71e5\\u5904\",\"\\u4fdd\\u8d28\\u671f\":\"180 \\u5929\",\"\\u98df\\u54c1\\u6dfb\\u52a0\\u5242\":\"\\u5355\\uff0c\\u53cc\\u7518\\u6cb9\\u8102\\u80aa\\u9178\\u916f\",\"\\u51c0\\u542b\\u91cf\":\"1050g\"}', '1486187304', '1517673600', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('629BAE4F-B30D-D852-BFE6-A43A373A2ED8', '家庭居家宿舍寝室必备懒人神器实用创意家居生活日用品小百货商品 ', '自动挤牙膏套装，漱口杯，自动挤牙膏，牙膏家三合一。爱上刷牙，而且是很漂亮的摆件，安装简单，拆洗容易，质量保证，送朋友很好的礼物', '0', '{\"\\u54c1\\u724c\":\"\\u9752\\u9f99\\u9999\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u89c1\\u89c4\\u683c\"}', '1486199874', '1517673600', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('6D025479-654E-5D3F-2B6D-ECF783A2D918', '骆驼男装 2017春季新品青年时尚立领商务休闲外套纯色运动风衣男 ', '骆驼男装 2017春季新品青年时尚立领商务休闲外套纯色运动风衣男 ', '0', '{\"\\u54c1\\u724c\":\"Camel\\/\\u9a86\\u9a7c\",\"\\u57fa\\u7840\\u98ce\\u683c\":\"\\u65f6\\u5c1a\\u90fd\\u5e02\",\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u68c9100%\",\"\\u4e0a\\u5e02\\u5e74\\u4efd\\u5b63\\u8282\":\"2017\\u5e74\\u6625\\u5b63\"}', '1484978236', '1390320000', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('6FFC6691-7F05-8AB8-B1E1-5C839BB4F446', '正版钢铁是怎样炼成的 原著经典世界名著外国外小说文学青少版 少儿童书籍畅销书阅读 初中学生小学生课外必读物图书', '《钢铁是怎样炼成的》被誉为“影响历史的百部经典之一”，“影响中国近代社会的经典译作”。保尔那顽强坚韧，奋发向上的人格力量，对我们的青少年，对我们的民族来说，是永远具有特殊意义的宝贵财富', '0', '{\"     \\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u94a2\\u94c1\\u662f\\u600e\\u6837\\u70bc\\u6210\\u7684\",\"\\u51fa\\u7248\\u793e\\u540d\\u79f0\":\"\\u4e2d\\u56fd\\u6587\\u8054\\u51fa\\u7248\\u793e\",\"\\u4f5c\\u8005\":\"\\u5965\\u65af\\u7279\\u6d1b\\u592b\\u65af\\u57fa\",\"ISBN\\u7f16\\u53f7\":\"9787519006129\"}', '1484925988', '1486742400', 'FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('72387161-B237-7FC1-3FB3-E78C23533C5C', '韩国the saem得鲜口红不脱色咬唇妆哑光豆沙色唇膏大红姨妈色雾面 ', '这款只能按出，不能按进，用多少按多少，千万不要为了满足自己好奇心狂按，否则口红就回去不了哦', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"The Saem\",\"\\u662f\\u5426\\u4e3a\\u7279\\u6b8a\\u7528\\u9014\\u5316\\u5986\\u54c1\":\"\\u5426\",\"\\u529f\\u6548\":\"\\u6ecb\\u6da6 \\u4fdd\\u6e7f\",\"\\u9002\\u5408\\u80a4\\u8d28\":\"\\u4efb\\u4f55\\u80a4\\u8d28\",\"\\u4fdd\\u8d28\\u671f\":\"3\\u5e74\"}', '1486200570', '1517673600', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', 'Apple/苹果 iPhone 6s Plus 苹果6S 5.5香港/美国/官换全新 ', '支持花呗分期 购买送膜+手机壳 iPhone6S五大预测：1，机身材质采用7000铝合金，不再出现弯曲门。2，屏幕加入Force Touch压感触控技术。3，全新A9处理器CPU及GPU。4，2GB的RAM搭配IOS9。5，全新的1200万像素主摄像头。', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"Apple\\/\\u82f9\\u679c iPhone 6s Plus\",\"\\u5c4f\\u5e55\\u5c3a\\u5bf8\":\"5.5\\u82f1\\u5bf8\",\"\\u4e0a\\u5e02\\u65f6\\u95f4\":\"2015\\u5e749\\u6708\",\"CPU\\u54c1\\u724c\":\"Apple\\/\\u82f9\\u679c\",\"CPU\\u578b\\u53f7\":\"\\u5176\\u4ed6\",\"Apple\\u578b\\u53f7\":\"iPhone 6s Plus\",\"\\u7f51\\u7edc\\u7c7b\\u578b\":\"4G+\\u5168\\u7f51\\u901a\",\"\\u673a\\u8eab\\u989c\\u8272\":\"\\u73ab\\u7470\\u91d1 \\u9ed1\\u8272 \\u94f6\\u8272 \\u91d1\\u8272\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1200\\u4e07\",\"\\u64cd\\u4f5c\\u7cfb\\u7edf\":\"IOS9\",\"\\u5b58\\u50a8\\u5bb9\\u91cf\":\"16GB 64GB 128GB\",\"\\u539a\\u5ea6\":\"7.3\\u6beb\\u7c73\\uff080.29\\u82f1\\u5bf8\\uff09\",\"\\u5206\\u8fa8\\u7387\":\"1920 x 1080 \\u50cf\\u7d20\\u5206\\u8fa8\\u7387\"}', '1484979335', '1514563200', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('753C793E-1F5D-1DC7-4103-A23D23E016C2', '歌莉娅女装 2017春季新品V领长袖毛呢外套长款171R6E490 ', '歌莉娅女装 2017春季新品V领长袖毛呢外套长款171R6E490 ', '0', '{\"\\u8d27\\u53f7\":\"171R6E490\",\"\\u670d\\u88c5\\u7248\\u578b\":\" \\u76f4\\u7b52\",\" \\u76f4\\u7b52\":\"\\u6697\\u6263\",\"\\u6697\\u6263\":\"\\u6697\\u6263\"}', '1484977693', '1581091200', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('89C19CC9-AADE-EF8F-3D2A-FD244AC2C51D', '御食园茯苓夹饼500g北京特产传统茯苓饼美食小吃糕点心零食品', '                    御食园多口味茯苓夹饼！独立小包装！                ', '0', '{\"\\u4fdd\\u8d28\\u671f\":\"360\",\"\\u51c0\\u542b\\u91cf\":\"500g\"}', '1487261350', '1518796800', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', '55C34CAB-6FAD-608F-7778-C2DAE4819FD9.png');
INSERT INTO `shopp_commodity` VALUES ('8C5CBC3B-C3A0-F078-2DC1-DD276D203A5E', '新品现货 Meizu/魅族 魅蓝note5全网通4G智能手机note5', '全新白色16G现货！！送快递包邮+延保一年！！推荐选购套餐，搭使用更方便。 拒绝黄牛，每人限购1台相同类似地址多拍只发一台！', '0', '{\"\\u673a\\u8eab\\u989c\\u8272\":\"\\u5168\\u7f51\\u901a\\u767d\\u8272\",\"\\u9b45\\u65cf\\u578b\\u53f7\":\"\\u9b45\\u84ddnote5\",\"\\u5206\\u8fa8\\u7387\":\"1920x1080\",\"\\u8fd0\\u884c\\u5185\\u5b58RAM\":\" 3GB 4GB\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1300\\u4e07\"}', '1484983552', '1548259200', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('900AA834-8BF4-9826-3239-01487EF71BED', '卡丝拉狄 中年大衣女装中国风撞色绣花立领长袖宽松毛呢女士外套 ', '卡丝拉狄 中年大衣女装中国风撞色绣花立领长袖宽松毛呢女士外套 ', '0', '{\"\\u6d41\\u884c\\u5143\\u7d20\\/\\u5de5\\u827a\":\"\\u7ee3\\u82b1\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u9ec4\\u8272 \\u9ed1\\u8272 \\u84dd\\u8272\",\"\\u9886\\u5b50\":\"\\u7acb\\u9886\",\"\\u901a\\u52e4\":\"\\u97e9\\u7248\",\"\\u8863\\u95e8\\u895f\":\"\\u4e00\\u7c92\\u6263\",\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u7f8a\\u6bdb50% \\u805a\\u916f\\u7ea4\\u7ef450%\"}', '1484978092', '1585843200', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('92BAFEFD-CCE6-03EF-60A8-DF9954DDDCA9', '湖南特产麻辣猪蹄熟食 香辣猪脚卤味特色肉类零食真空装美食小吃 ', '                    湖南特产麻辣猪蹄熟食 香辣猪脚卤味特色肉类零食真空装美食小吃                ', '0', '{\"\\u51c0\\u542b\\u91cf\":\"210g\",\"\\u4fdd\\u8d28\\u671f\":\"15\"}', '1487261632', '1550332800', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', 'A51923DC-1E6E-FC0D-C7CD-567C80F1B40C.png');
INSERT INTO `shopp_commodity` VALUES ('934AE8D8-B061-C383-3FE1-6566C597B7F4', '明治雪吻草莓绿茶牛奶可可豆年货巧克力62g 送男女友批发小吃零食 ', '巧克力', '0', '{\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u7f6e\\u4e8e\\u9634\\u51c9\\u5e72\\u71e5\\u5904\",\"\\u6210\\u5206\\u542b\\u91cf\":\"26%\",\"\\u98df\\u54c1\\u53e3\\u5473\":\"\\u725b\\u5976\\u53e3\\u5473 \\u8349\\u8393\\u53e3\\u5473 \\u7cbe\\u9009\\u53ef\\u53ef\",\"\\u5305\\u88c5\\u79cd\\u7c7b\":\"\\u76d2\\u88c5\",\"\\u662f\\u5426\\u542b\\u6709\\u4ee3\\u53ef\\u53ef\\u8102\":\"\\u5426\",\"\\u4ea7\\u5730\":\"\\u4e2d\\u56fd\\u5927\\u9646\",\"\\u4fdd\\u8d28\\u671f\":\"300\\u5929\"}', '1484577647', '1486742400', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'SPAO明星AOA同款女式休闲高领套头毛衣韩版针织衫线衫SAKW64TG04 ', '毛衣', '0', '{\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u805a\\u4e19\\u70ef\\u8148\\u7ea4\\u7ef4(\\u8148\\u7eb6)100%\",\"\\u8863\\u957f\":\"\\u5e38\\u89c4\\u6b3e\",\"\\u8896\\u957f\":\"\\u957f\\u8896\",\"\\u54c1\\u724c\":\"SPAO\",\"\\u5c3a\\u7801\":\"S M L\"}', '1484578225', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('AE6D4A9D-7257-836A-2687-8EE3B440594E', 'BONOSIDAN 水光补水面膜10片 白皙补水保湿滋润嫩肤水光针面膜 ', 'BONOSIDAN 水光补水面膜10片 白皙补水保湿滋润嫩肤水光针面膜 ', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"BONOSIDAN\",\"\\u9762\\u819c\\u5206\\u7c7b\":\"\\u8d34\\u7247\\u5f0f\",\"\\u5316\\u5986\\u54c1\\u51c0\\u542b\\u91cf\":\"10\\u7247\",\"\\u54c1\\u540d\":\"\\u6c34\\u5149\\u9762\\u819c\"}', '1486200249', '1549209600', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1', '高端定制ZPLPKK 2017春季新款女士中长款舒适羽绒服修身毛领外套 ', '制ZPLPKK 2017春季新款女士中长款舒适羽绒服修身毛领外套 ', '0', '{\"\\u5145\\u7ed2\\u91cf\":\"100g\\u4ee5\\u4e0b\",\"\\u542b\\u7ed2\\u91cf\":\"50%\"}', '1484975355', '1611158400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('B4052C46-F17D-CBD1-4BCF-29DF877B6FA5', 'vivo X9前置双摄 全网通4G智能手机 超薄指纹解锁正品分期 vivox9', 'vivo X9前置双摄 全网通4G智能手机 超薄指纹解锁正品分期 vivox9', '0', '{\"\\u5236\\u9020\\u5546\\u540d\\u79f0\":\"\\u7ef4\\u6c83\\u79fb\\u52a8\\u901a\\u4fe1\\u6709\\u9650\\u516c\\u53f8\",\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"TD-LTE\\u6570\\u5b57\\u79fb\\u52a8\\u7535\\u8bdd\\u673a\",\"CPU\\u578b\\u53f7\":\"MSM8953\",\"\\u673a\\u8eab\\u989c\\u8272\":\"\\u91d1\\u8272 \\u73ab\\u7470\\u91d1 \\u661f\\u7a7a\\u7070\",\"\\u5b58\\u50a8\\u5bb9\\u91cf\":\"64G\"}', '1484926494', '1486742400', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', 'diy明信片定制lomo卡贺卡定做自制文艺明星片制作创意古风明信片 ', '明信片', '0', '{\"\\u98ce\\u683c\":\"\\u521b\\u610f\\u6f6e\\u6d41\",\"\\u578b\\u53f7\":\"\\u660e\\u4fe1\\u7247\\u5b9a\\u5236\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"350g\\u91d1\\u724c\\u94dc\\u677f\\u5355\\u9762 350g\\u91d1\\u724c\"}', '1484578028', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('B5037D54-D3D0-F1EE-5939-523BCBF8F2C6', '美的吸尘器家用手持式超静音强力除螨地毯大功率小型迷你C3-L148B', '过年不打烊 热卖20万 限时疯抢领券下单 ', '0', '{\"\\u8bc1\\u4e66\\u7f16\\u53f7\":\"2014010708710614\",\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"Midea\\/\\u7f8e\\u7684 C3-L148B\",\"\\u529f\\u7387\":\"1200W\",\"\\u6700\\u5927\\u566a\\u97f3\":\"82dB\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u7ea2\\u8272\",\"\\u7ebf\\u957f\":\"5m\"}', '1486190888', '1580745600', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('B7391928-0D76-8E49-8911-CF772446F9C1', '荣欣堂红枣味太谷饼2100g特产早餐面包美食糕点零食批发小吃点心 ', '                    近7天生产 0防腐剂 中华老字号                 ', '0', '{\"\\u5382\\u5740\":\"\\u5c71\\u897f\\u7701\\u664b\\u4e2d\\u5e02\\u592a\\u8c37\\u53bf\\u767d\\u57ce\",\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u5e38\\u6e29\\u4fdd\\u5b58\"}', '1487260934', '1581868800', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', '91F817CE-3262-34B0-AFD2-CFE545C115CB.png');
INSERT INTO `shopp_commodity` VALUES ('B763DD16-2E58-C493-0434-3952FA160C17', '绿豆面膜泥补水保湿控油去黑头男女收缩毛孔非清洁亮白祛痘印淡斑 ', '绿豆面膜泥补水保湿控油去黑头男女收缩毛孔非清洁亮白祛痘印淡斑 ', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u4f0a\\u8bd7\\u5170\\u987f \\u7eff\\u8c46\\u6ce5\\u6d46\\u9762\\u819c\",\"\\u9762\\u819c\\u5206\\u7c7b\":\"\\u6c34\\u6d17\\u5f0f\",\"\\u9002\\u5408\\u80a4\\u8d28\":\"\\u4efb\\u4f55\\u80a4\\u8d28\",\"\\u5316\\u5986\\u54c1\\u51c0\\u542b\\u91cf\":\"120g\\/ml\",\"\\u529f\\u6548\":\"\\u8865\\u6c34 \\u4fdd\\u6e7f \\u63a7\\u6cb9 \\u6536\\u7f29\\u6bdb\\u5b54\",\"\\u4fdd\\u8d28\\u671f\":\":3\\u5e74\"}', '1486201364', '1612368000', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('BEC94BE7-D1A0-D643-6B2D-2FAA1F68B2FD', '德国brita碧然德即热净水吧家用厨房自来水过滤直饮滤水壶净水器', '过滤加热一体、一键启动、可调节出水量，100℃急速沸腾科技，烧开不到一分钟，烧开自动出水！活性炭将吸附氯、杀虫剂以及有机杂质，从而改善口感，消除异味和污染物质。离子交换树脂降低的引致石灰垢的硬度 物质，并减少铝、铜和铅等金属的含量。适当保留一些有益矿物质及微量元素。烧开直接饮用', '0', '{\"\\u51c0\\u6c34\\u5668\\u54c1\\u724c\":\"BRITA\\/\\u78a7\\u7136\\u5fb7\",\"\\u578b\\u53f7\":\"\\u5373\\u70ed\\u51c0\\u6c34\\u5427\",\"\\u989d\\u5b9a\\u51fa\\u6c34\\u91cf\":\"60L\\/h\",\"\\u5de5\\u4f5c\\u539f\\u7406\":\"\\u6d3b\\u6027\\u70ad\",\"\\u6ee4\\u82af\":\"\\u6d3b\\u6027\\u70ad+\\u8d85\\u6ee4\"}', '1486197940', '1549209600', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('C3E30939-86EB-730F-900E-17B582155781', 'Huawei/华为 P9全网通4G智能手机', '当天发，下单即送：专用智能皮套+纳米防爆膜+转接头+原装保护壳+懒人支架+保修三年+顺丰包邮。5.2英寸，双1200万+800万莱卡摄像头，八核，麒麟955，指纹解锁，3000毫安电池。标配（3G+32G）高配(4G+64G）；P9 PIUS是5.5英寸【注意：主图礼品以套餐为准，各套餐礼品均不同】', '0', '{\"\\u54c1\\u724c\":\"Huawei\\/\\u534e\\u4e3a\",\"\\u5206\\u8fa8\\u7387\":\"1920x1080\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"\\u53cc1200\\u4e07\",\"\\u534e\\u4e3a\\u578b\\u53f7\":\"P9\\u5168\\u7f51\\u901a\"}', '1484983330', '1610640000', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('D2BCDC64-0970-3775-3193-6D870A490A84', '现货 2016.9月 日本FANCL新版保湿洁面粉50g 泡沫深层清洁 ', '现货 2016.9月 日本FANCL新版保湿洁面粉50g 泡沫深层清洁 ', '0', '{\"\\u89c4\\u683c\\u7c7b\\u578b\":\": Fancl\\/\\u65e0\\u6dfb\\u52a0\",\" \\u4fdd\\u8d28\\u671f\":\": \\u4e00\\u5e74\",\"\\u529f\\u6548:\":\"\\u4fdd\\u6e7f \\u63a7\\u6cb9 \\u6536\\u7f29\\u6bdb\\u5b54  \",\"\\u662f\\u5426\\u4e3a\\u7279\\u6b8a\\u7528\\u9014\\u5316\\u5986\\u54c1:  \":\" \\u5426\",\"\\u4ea7\\u5730:\":\"\\u65e5\\u672c\",\"fancl\\u5355\\u54c1: \":\"\\u4fdd\\u6e7f\\u6d01\\u9762\\u7c89   \",\" \\u54c1\\u724c:\":\" Fancl\\/\\u65e0\\u6dfb\\u52a0     \",\"\":\"\"}', '1484984046', '1420732800', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('D5CD3549-48F1-F39A-F547-EF40372ECC5D', 'RC相纸5寸6寸7寸A4高光防水4R照片纸260g磨砂绸绒面彩色喷墨打印', 'RC相纸5寸6寸7寸A4高光防水4R照片纸260g磨砂绸绒面彩色喷墨打印 ', '0', '{\"     \\u989c\\u8272\\u5206\\u7c7b\":\"6\\u5bf8 260\\u514bRC\\u6cb9\\u753b\\u5e03\\u9762 100\",\"\\u5e45\\u9762:\":\"4r\",\"\\u662f\\u5426\\u5377\\u7b52\\u578b\":\"\\u5426\",\"\\u54c1\\u724c\":\"\\u529b\\u6b66\"}', '1484984199', '1580400000', 'FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('D678064A-D80E-EFA2-4A01-873583FF3E9B', '乐焙芝家用大容量电烤箱 定时温控烘焙蛋糕披萨 多功能烤箱 30L ', ' 乐焙芝家用大容量电烤箱 定时温控烘焙蛋糕披萨 多功能烤箱 30L  新品上架', '0', '{\"\\u529f\\u7387\":\"1201W(\\u542b)-1500W(\\u542b)\",\"\\u52a0\\u70ed\\u7ba1\\u6570\\u91cf\":\"4\\u4e2a\",\"\\u53d1\\u70ed\\u7ba1\\u6750\\u8d28\":\"\\u4e0d\\u9508\\u94a2\",\"\\u578b\\u53f7\":\"TY-281A\",\"\\u5bb9\\u91cf\":\"30L\",\"\\u667a\\u80fd\\u7c7b\\u578b\":\"\\u673a\\u68b0\\u5f0f\",\"\\u6e29\\u63a7\\u65b9\\u5f0f\":\"\\u4e0a\\u4e0b\\u7ba1\\u72ec\\u7acb\\u63a7\\u6e29\",\"\\u5bb9\\u91cf\\u8303\\u56f4\":\"21L(\\u542b)-30L(\\u542b)\"}', '1486198765', '1612368000', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('D708E35B-239A-0E3B-3988-B7EA5C3A3066', 'SW床垫 进口乳胶床垫1.5 1.8m弹簧椰棕垫软硬定做席梦思床垫 ', 'SW床垫', '0', '{\"\\u4e73\\u80f6\\u539a\\u5ea6\":\"20mm\",\"\\u5e8a\\u57ab\\u8f6f\\u786c\\u5ea6\":\" \\u8f6f\\u786c\\u4e24\\u7528\",\"\\u6bdb\\u91cd\":\"55\",\"\\u54c1\\u724cv\":\"Sweetnight\",\"\\u6d77\\u7ef5\\u7c7b\\u578b\":\"\\u666e\\u901a\\u6d77\\u7ef5\",\"\\u9762\\u6599\\u5206\\u7c7b\":\"\\u9488\\u7ec7\\u9762\\u6599\"}', '1484576363', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('DBDD6F97-71D8-FF7D-843F-33A2DA965DE1', '【天天特价】分期免息OPPO R9S拍照智能手机 oppor9s r9 r9splus ', '分期免息，购机领大礼', '0', '{\"\\u54c1\\u724c\":\"OPPO\",\"OPPO\\u578b\\u53f7\":\"R9S\",\"\\u5206\\u8fa8\\u7387\":\"1920*1080\",\"\\u7f51\\u7edc\\u7c7b\\u578b\":\"4G\\u5168\\u7f51\\u901a\",\"\\u7f51\\u7edc\\u6a21\\u5f0f\":\"\\u53cc\\u5361\\u53cc\\u5f85\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1600\\u4e07\",\"\\u8fd0\\u884c\\u5185\\u5b58RAM\":\"4GB\",\"\\u5b58\\u50a8\\u5bb9\\u91cf\":\"64GB\"}', '1486186843', '1612368000', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('E1A02C6D-C1C6-A748-983D-A236648BDCD4', '现货 2016.8月30日产 日本专柜FANCL卸妆油120ml 净化修护卸妆液 ', '现货 2016.8月30日产 日本专柜FANCL卸妆油120ml 净化修护卸妆液 ', '0', '{\"\\u539f\\u6599\\u6210\\u5206\":\"\\u725b\\u5976 \\u67e0\\u6aac\\u9a6c\\u97ad\\u8349 \\u6708\\u89c1\\u8349 \\u5176\",\"\\u9002\\u5408\\u80a4\\u8d28\":\" \\u4efb\\u4f55\\u80a4\\u8d28\",\"\\u54c1\\u724c\":\"Fancl\\/\\u65e0\\u6dfb\\u52a0\",\"\\u4ea7\\u5730\":\"\\u65e5\\u672c\"}', '1484570726', '1486742400', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('EE5D2613-2760-F18C-A447-B8E744FF509D', '原色开心果自然原色无漂白500g开口原味坚果零食本色干果炒货 ', '                    原色开心果自然原色无漂白500g开口原味坚果零食本色干果炒货                ', '0', '{\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u9634\\u51c9\\u5e72\\u71e5\",\"\\u51c0\\u542b\\u91cf\":\"500g\",\"\\u98df\\u54c1\\u53e3\\u5473\":\"\\u76d0\\u7117\\u53e3\\u5473\",\"\\u54c1\\u724c\":\"\\u797a\\u5b9d\",\"\\u4fdd\\u8d28\\u671f:\":\"360\",\"\\u98df\\u54c1\\u6dfb\\u52a0\\u5242\":\"\\u67e0\\u6aac\\u9178\"}', '1484983798', '1585843200', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('F396C933-04BC-E46D-012F-AE67F7DD37EE', '清风抽纸原木纯品3层面巾纸婴儿家用纸巾整箱家庭装 ', '清风抽纸原木纯品3层面巾纸婴儿家用纸巾整箱家庭装 ', '0', '{\"\\u54c1\\u724c\":\"\\u6e05\\u98ce\",\"\\u662f\\u5426\\u91cf\\u8d29\\u88c5\":\"\\u5426\",\"\\u9762\\u5dfe\\u7eb8\\u79cd\\u7c7b\":\"\\u8f6f\\u5305\\u88c5\\u9762\\u5dfe\\u7eb8\",\"\\u539f\\u6750\\u6599\\u6210\\u5206\":\"\\u539f\\u751f\\u6d46\"}', '1484575927', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('F51D327E-3EFE-0E64-BA0A-E122DB83F189', '新品【百草味-蛋黄酥120g】手工糕点蛋黄酥小包装 零食小吃美食 ', '	新品【百草味-蛋黄酥120g】手工糕点蛋黄酥小包装 零食小吃美食  300款零食 一站购 6.9元起开抢 ', '0', '{\"\\u751f\\u4ea7\\u8bb8\\u53ef\\u8bc1\\u7f16\\u53f7\":\"SC10133052100455\",\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u5e38\\u6e29\\u5bc6\\u5c01\\u5b58\\u653e\\uff0c\\u907f\\u514d\\u9ad8\\u6e29\",\"\\u4fdd\\u8d28\\u671f\":\"60\\u5929\",\"\\u98df\\u54c1\\u6dfb\\u52a0\\u5242\":\"\\u89c1\\u5305\\u88c5\"}', '1486187737', '1549209600', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('F72A0711-12B1-2360-6A79-023E0A6FB6BF', '正山小种茶叶 红茶茶叶 武夷山正山小种茶叶散装600克 五虎红茶', '                    正山小种茶叶 红茶茶叶 武夷山正山小种茶叶散装600克 五虎红茶                 ', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u4e94\\u864e 150\\u514b*4 \\u6b63\\u5c71\\u5c0f\\u79cd\",\"\\u51c0\\u542b\\u91cf\":\"600g\",\"\\u5305\\u88c5\\u65b9\\u5f0f:\":\"\\u5305\\u88c5\"}', '1484570266', '1486742400', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', '正品 Meitu/美图M6 秀秀美颜移动智能自拍神器美图手机4G全网通S', '正品 Meitu/美图M6 秀秀美颜移动智能自拍神器美图手机4G全网通S', '0', '{\"CPU\\u578b\\u53f7\":\"MT6755\",\"\\u4e0a\\u5e02\\u65f6\\u95f4\":\"2016\\u5e74\",\"\\u54c1\\u724c\":\"Meitu\\/\\u7f8e\\u56fe\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\" 2100\\u4e07\",\"\\u7f51\\u7edc\\u7c7b\\u578b\":\"4G\\u5168\\u7f51\\u901a\"}', '1484982962', '1489593600', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('F7BC08D4-A15A-0784-3456-04EE6D29C689', '醉牙尖五香藤椒味脱骨鸭掌去骨鸭爪_花椒味卤味美食小吃独立包装 ', '通威太丰鸭掌 品牌原料 真空独立包装 方便携带 ', '0', '{\"\\u751f\\u4ea7\\u8bb8\\u53ef\\u8bc1\\u7f16\\u53f7\":\"QS5101 0401 0044\",\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u5e38\\u6e29\\u4fdd\\u5b58\\uff0c\\u51b7\\u85cf\\u66f4\\u4f73\",\"\\u4fdd\\u8d28\\u671f\":\"90\\u5929\",\"\\u98df\\u54c1\\u6dfb\\u52a0\\u5242\":\"\\u8c37\\u6c28\\u9178\\u94a0\\uff0c\\u4e59\\u57fa\\u9ea6\\u82bd\\u915a\",\"\\u662f\\u5426\\u542b\\u7cd6\":\"\\u542b\\u7cd6\"}', '1486188122', '1549209600', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('FB498C2A-0CB1-403B-A836-D602ABC96AB8', '秋冬季健身服男套装健身房三四五件套运动透气速干长袖跑步紧身衣', '秋冬季健身服男套装健身房三四五件套运动透气速干长袖跑步紧身衣', '0', '{\"\\u4e0a\\u88c5\\u6b3e\\u5f0f\":\"\\u957f\\u8896\",\"\\u529f\\u80fd\":\"\\u5438\\u6e7f\\u6392\\u6c57 \\u901f\\u5e72 \\u900f\\u6c14 \\u8d85\\u5f3a\\u5f39\\u6027\",\"\\u5c3a\\u7801\":\"M L XL XXL\",\"\\u4e0b\\u88c5\\u88e4\\u957f\":\"\\u957f\\u88e4\"}', '1484576146', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '2017春装新款女韩版时尚鱼尾红裙子小香风明星同款蕾丝红色连衣裙 ', '连衣裙', '0', '{\"\\u8896\\u578b\":\"\\u5e38\\u89c4\",\"\\u6d41\\u884c\\u5143\\u7d20\":\"\\u62fc\\u63a5 \\u62c9\\u94fe \\u857e\\u4e1d\",\"\\u8863\\u95e8\\u895f\":\"\\u5957\\u5934\",\"\\u56fe\\u6848\":\"\\u7eaf\\u8272\",\"\\u88d9\\u957f\":\"\\u4e2d\\u88d9\",\"\\u8170\\u578b:\":\"\\u9ad8\\u8170\"}', '1484577839', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity` VALUES ('FF815C07-E3C4-C632-F29C-42FE92C32AF9', '充电式便携榨汁杯电动迷你果汁杯玻璃料理杯多功能小型榨汁机家用', '充电式便携榨汁杯电动迷你果汁杯玻璃料理杯多功能小型榨汁机家用', '0', '{\"\\u4e00\\u6b21\\u6027\\u6700\\u5927\\u51fa\\u6c41\\u91cf\":\"400ml\\u4ee5\\u4e0b\",\"\\u69a8\\u6c41\\u673a\\u9644\\u52a0\\u529f\\u80fd\":\"\\u51b0 \\u5e72\\u78e8 \\u6405\\u62cc \\u548c\\u9762 \\u6253\",\"\\u679c\\u8089\\u6e23\\u6ed3\\u76d2\\u5bb9\\u91cf\":\"500ml\\u4ee5\\u4e0b\\uff08\\u542b500m\",\"\\u54c1\\u724c\":\"\\u897f\\u5e03\\u6717\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u5ae9\\u7c89\\u8272 \\u679c\\u7eff\\u8272 \\u67e0\\u6aac\\u9ec4 \",\"\\u529f\\u7387\":\"150W\"}', '1484984403', '1611849600', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0', '1D7E477D-4EEA-2490-AB16-CA5A7423144D.png');
INSERT INTO `shopp_commodity_images` VALUES ('02B0D106-9139-0BF9-7EF1-12B48BE43E19', '2D089988-6636-BF15-676F-15A6AED0433F', '23411573-FF7B-A732-2F2D-7CFEC60B9109.png');
INSERT INTO `shopp_commodity_images` VALUES ('031079F7-1308-1180-A3D9-504B0B64D018', '8C5CBC3B-C3A0-F078-2DC1-DD276D203A5E', '809FA808-4676-EC6A-66CA-7728D782977E.png');
INSERT INTO `shopp_commodity_images` VALUES ('043D01FA-3E52-D8C8-BFC8-62FF7AAD4019', '47D002AB-DFA4-11CF-52FB-398122144EF1', '91BA1E29-61B8-1429-794B-120B85D4BCB8.png');
INSERT INTO `shopp_commodity_images` VALUES ('04DD0F41-D172-FE71-3715-524E36125CBD', 'AE6D4A9D-7257-836A-2687-8EE3B440594E', '235F5B9E-5EFF-11B5-988A-CCF7C72FCBB4.png');
INSERT INTO `shopp_commodity_images` VALUES ('0924DCA9-D908-C76B-3E83-52B7E2648D21', '00D84306-7B0D-F027-28E4-09D70124D2CB', '3DFC2305-D08D-E885-1895-6FFF9BA13E05.png');
INSERT INTO `shopp_commodity_images` VALUES ('0BF0872F-1938-4913-F73B-73B9448914C5', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', '5C5BDFF5-0994-E920-5329-6C442D94090E.png');
INSERT INTO `shopp_commodity_images` VALUES ('0C0AFBEA-FEF3-FD5E-94E1-A0826B4DB746', '26C82144-FCFB-AA3A-150D-2640FFF623F2', '0564D53A-BCD6-7435-6EE7-0D247C0F3BC5.png');
INSERT INTO `shopp_commodity_images` VALUES ('0C1ADBEB-A0B5-9A8C-4F9A-2C24E4835696', 'BEC94BE7-D1A0-D643-6B2D-2FAA1F68B2FD', '01F38FCE-573C-B1C8-6149-1280BE0C03EC.png');
INSERT INTO `shopp_commodity_images` VALUES ('0D5D1A74-FCA9-334A-F3AE-25B28C4E2C27', '72387161-B237-7FC1-3FB3-E78C23533C5C', 'AC310C10-B63F-9224-48BA-7D3BF667C732.png');
INSERT INTO `shopp_commodity_images` VALUES ('0F969678-3203-FC8B-8412-DD259EB3F634', '1581855B-4F44-E6F1-8E95-59AD9A5A0C5D', '5A41C99F-E0CD-41A9-68D1-763A23FC096A.png');
INSERT INTO `shopp_commodity_images` VALUES ('10E18D83-216D-B2DF-E103-E09E2753BDD0', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', '46090D57-4984-3269-7F54-49A0E7FECCD1.png');
INSERT INTO `shopp_commodity_images` VALUES ('12934A0A-AD7F-985C-0B6C-F321A916B5E6', 'B763DD16-2E58-C493-0434-3952FA160C17', '81B94721-29D4-4E0B-D149-B2C8BED3DE35.png');
INSERT INTO `shopp_commodity_images` VALUES ('1392DEEA-1C96-1926-ED21-A07BF51CFC23', 'F396C933-04BC-E46D-012F-AE67F7DD37EE', 'B10C4D0E-DC6B-E713-601B-295AD39E3082.png');
INSERT INTO `shopp_commodity_images` VALUES ('144B599F-9F4A-83A8-B3C1-5D9C30668018', '753C793E-1F5D-1DC7-4103-A23D23E016C2', 'B1BCB576-36D4-8F6E-3114-206FD038E8B8.png');
INSERT INTO `shopp_commodity_images` VALUES ('145CF272-25BC-51ED-1C34-BA84E35E8B40', '26C82144-FCFB-AA3A-150D-2640FFF623F2', '48E6E0F4-A946-4D2C-0B3C-7B987D1B6F53.png');
INSERT INTO `shopp_commodity_images` VALUES ('15667DF7-9FAC-22DF-03AD-00E467EDFEE3', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'D4C56046-57DD-C8E0-E3BA-57FAF9B6FBC7.png');
INSERT INTO `shopp_commodity_images` VALUES ('15ABACA8-497B-7722-8D9E-333B3C9DA8E1', 'B5037D54-D3D0-F1EE-5939-523BCBF8F2C6', '850B36B7-2D1F-857A-73E3-82B3282E01BC.png');
INSERT INTO `shopp_commodity_images` VALUES ('164A9527-7903-60AA-E1B1-EDA995CD73AB', '92BAFEFD-CCE6-03EF-60A8-DF9954DDDCA9', 'AD4E4503-8FE4-3539-0334-5A0C01AE07EA.png');
INSERT INTO `shopp_commodity_images` VALUES ('18AA7994-65A0-6228-E0BC-9B291626E49C', 'BEC94BE7-D1A0-D643-6B2D-2FAA1F68B2FD', '7503B429-C953-46D1-AE01-74BAF40835C4.png');
INSERT INTO `shopp_commodity_images` VALUES ('18B384BF-252C-055C-867B-0A50CA26BC57', 'D2BCDC64-0970-3775-3193-6D870A490A84', 'B24B12DA-8736-F61D-551C-88F7C7BA3FD7.png');
INSERT INTO `shopp_commodity_images` VALUES ('1997BE04-425C-9751-DD36-74705AEF8DAE', '6275F89C-A2A1-8B7B-A259-94926A84C442', 'B692FC77-20A6-3C5F-2D04-A37A31EC0BCF.png');
INSERT INTO `shopp_commodity_images` VALUES ('1A5E94EB-FD10-2524-3616-8A3EFDF0047B', '92BAFEFD-CCE6-03EF-60A8-DF9954DDDCA9', '090B4D20-D5E7-2A83-F46D-273CA588502B.png');
INSERT INTO `shopp_commodity_images` VALUES ('1B5D4B9C-0573-3AD9-ECEC-53470C1A9FA8', '26C82144-FCFB-AA3A-150D-2640FFF623F2', 'FECF77AC-68AA-DEF5-F18C-A93420E8DBBC.png');
INSERT INTO `shopp_commodity_images` VALUES ('1E23B383-99C5-739E-8F16-DBD0211176E4', 'F7BC08D4-A15A-0784-3456-04EE6D29C689', 'A59BD828-D778-4D4D-429D-6BFB62019F48.png');
INSERT INTO `shopp_commodity_images` VALUES ('1F37B464-4E65-342A-48C8-2E777DC143BF', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', '63A5FF97-4FAE-2B5E-F14D-EFDC3A62812C.png');
INSERT INTO `shopp_commodity_images` VALUES ('20941A17-D45B-17BC-5AFB-C9FA2BC5386B', '900AA834-8BF4-9826-3239-01487EF71BED', '34908851-BA41-5689-7AE7-797CCBF7D7DB.png');
INSERT INTO `shopp_commodity_images` VALUES ('23AE7030-55CB-6A10-1197-6F9A38F6D5DE', 'DBDD6F97-71D8-FF7D-843F-33A2DA965DE1', '52C5EBB9-FA93-56B9-C760-E4878E2FD85C.png');
INSERT INTO `shopp_commodity_images` VALUES ('23D612FC-375D-7425-2485-54DDA2124BE3', 'C3E30939-86EB-730F-900E-17B582155781', '69126D76-B2B3-7B3C-621B-B9F1FB582B25.png');
INSERT INTO `shopp_commodity_images` VALUES ('2428A325-CED3-CC23-70A4-CED147F3E515', '433DA60D-5065-1301-48B8-76D1BB06CDF0', '8B6D484F-FE4B-F3FB-C354-4A384FAD4A68.png');
INSERT INTO `shopp_commodity_images` VALUES ('27D0B112-B400-652A-4B2B-7053126F6D8C', '00D84306-7B0D-F027-28E4-09D70124D2CB', 'A1996EAF-1915-A404-9ACC-BEF176301DEF.png');
INSERT INTO `shopp_commodity_images` VALUES ('28D0E40F-CF7B-1785-B464-17A38349412E', '753C793E-1F5D-1DC7-4103-A23D23E016C2', '2CDE72D3-F3BD-886F-E70A-8F8E8C419D86.png');
INSERT INTO `shopp_commodity_images` VALUES ('28F9FADC-4EAB-A587-A934-66EE3FC931DA', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', 'F8FDC530-B0A7-D38E-F728-32FA3E6E5960.png');
INSERT INTO `shopp_commodity_images` VALUES ('2A8D0474-F326-DD78-CBF8-10A7E0E193D5', '511676D4-6E5E-A943-02D2-23838D8A4B2A', '948CDB85-0B96-D5ED-90EE-362FF68685B0.png');
INSERT INTO `shopp_commodity_images` VALUES ('2BC978EF-DF92-BA80-3DD8-F738397A7A28', 'C3E30939-86EB-730F-900E-17B582155781', 'E0D075A6-ECFF-3F54-71EB-9A66BDAA2570.png');
INSERT INTO `shopp_commodity_images` VALUES ('2C2A28C8-49B8-BB5F-77DB-BB0FBB79A18C', '22B10E64-2792-9976-E179-2481FBD15CB5', 'C75D642C-41E4-B8AC-C161-C1233D990D15.png');
INSERT INTO `shopp_commodity_images` VALUES ('2C6A3859-23F6-45AB-5176-2EC8A73B266F', '179149C6-2255-FAA2-F9F8-CA6608080FAA', '4CE10BB9-E942-5648-12C6-7B4601205A90.png');
INSERT INTO `shopp_commodity_images` VALUES ('2C863D06-CB5C-131F-6B8B-59BFEAADF27F', '21B3CE06-EBCB-ECA1-E311-88D1C759C156', 'E8A37109-AFE6-A91A-7493-014F1AE6D124.png');
INSERT INTO `shopp_commodity_images` VALUES ('2D8F749C-245A-C515-7AB1-596B78975E20', 'DBDD6F97-71D8-FF7D-843F-33A2DA965DE1', '6CABC0BC-87F0-6C1F-7B1F-951FAE9F027B.png');
INSERT INTO `shopp_commodity_images` VALUES ('2F04B13C-FF65-4498-8388-E1368BE0E4A1', 'FF815C07-E3C4-C632-F29C-42FE92C32AF9', 'A25EE1C4-8BDC-8970-C36C-E7B3F92AB82E.png');
INSERT INTO `shopp_commodity_images` VALUES ('2F0EA931-BCAA-E635-0E3F-2587465D4C3E', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', 'CA7FBEEC-9C3A-0F9A-F1DE-31AFFE731670.png');
INSERT INTO `shopp_commodity_images` VALUES ('30559F35-FBF2-007D-BBC3-61976BF530EE', '4CF00EB1-8CBA-C3D9-F93F-DF01511391BE', '5BE7ED92-B1E1-8CE0-B92F-FC76B96958D9.png');
INSERT INTO `shopp_commodity_images` VALUES ('3288E1BE-6DFF-3712-EC7C-406C53B3D370', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF', '46197659-86BD-5714-0C2B-CEDE85DE5B41.png');
INSERT INTO `shopp_commodity_images` VALUES ('340C2B2E-5214-1C4B-8C2F-AC42B00A6D7C', '22B10E64-2792-9976-E179-2481FBD15CB5', '66B366FE-CADE-B854-5EF0-6E2C240732F6.png');
INSERT INTO `shopp_commodity_images` VALUES ('362D1CD8-55B1-6BFD-BE69-71984E31599F', '8C5CBC3B-C3A0-F078-2DC1-DD276D203A5E', '2A61B114-7F8D-346F-DC1A-FE1B1C55C8A4.png');
INSERT INTO `shopp_commodity_images` VALUES ('39842715-6EB9-5D42-8079-CD1D078BC6C4', '47D002AB-DFA4-11CF-52FB-398122144EF1', '332F289D-C88A-BC0A-A459-3A78C29848F1.png');
INSERT INTO `shopp_commodity_images` VALUES ('3B41DE1D-48B2-FA19-2B99-10E7A957CF22', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', 'CF85986E-89DF-6017-C958-217D262E685D.png');
INSERT INTO `shopp_commodity_images` VALUES ('3F53DCF9-A0C8-123E-52E0-A34E0257EA92', 'FF815C07-E3C4-C632-F29C-42FE92C32AF9', 'B4216472-9070-32EE-F833-C6807B97C17A.png');
INSERT INTO `shopp_commodity_images` VALUES ('435EEAF5-2AB9-64EB-57C9-794551A71153', '4CF00EB1-8CBA-C3D9-F93F-DF01511391BE', '340ABD1C-58C6-1082-EBB9-29F88B8D122D.png');
INSERT INTO `shopp_commodity_images` VALUES ('43C3C1CD-050B-4EFD-3AE6-937684AAC3A5', '47D002AB-DFA4-11CF-52FB-398122144EF1', '214C8BC5-6D12-E1C6-5AAC-9D83171AA85F.png');
INSERT INTO `shopp_commodity_images` VALUES ('43FD15FE-3419-FEDB-5347-ECE24F0CAFCA', '2D089988-6636-BF15-676F-15A6AED0433F', '6DF8D5B2-81CB-1E08-822D-968B1FB61778.png');
INSERT INTO `shopp_commodity_images` VALUES ('448D5193-E176-BE27-2C94-2A4EF5A25361', '00D84306-7B0D-F027-28E4-09D70124D2CB', '3075CA8D-C9E4-EDD1-4610-F262E3E86ECF.png');
INSERT INTO `shopp_commodity_images` VALUES ('45F3D285-124F-63AF-B128-5ADBB4692750', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', '238A1288-FFBC-5FD4-A0DE-B53F79BA48BD.png');
INSERT INTO `shopp_commodity_images` VALUES ('461A2944-7E38-B809-4386-5A8E1DF1C54C', 'D678064A-D80E-EFA2-4A01-873583FF3E9B', '4042AB5A-85B8-F240-358A-498D65B8B369.png');
INSERT INTO `shopp_commodity_images` VALUES ('48AEC2D0-9DFE-9A4C-277D-A09693DD3542', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '5B82284D-D583-9E48-BD71-2DB7F9DCF779.png');
INSERT INTO `shopp_commodity_images` VALUES ('48F200D0-CDF2-8267-F997-B8D3D9DC695F', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D', '06CBE955-8C6F-C711-2626-60359FBF0D94.png');
INSERT INTO `shopp_commodity_images` VALUES ('49E34B1F-55BF-F51C-BFCC-C4AC3E567A79', '72387161-B237-7FC1-3FB3-E78C23533C5C', '9D2E4D3E-C307-D5FC-9D1B-DC13D90C5801.png');
INSERT INTO `shopp_commodity_images` VALUES ('4B1DAF4E-E804-8D5F-D1E4-71DE07ED958A', 'BEC94BE7-D1A0-D643-6B2D-2FAA1F68B2FD', 'A498C8BD-22B8-E9A1-B055-53A77674DF9E.png');
INSERT INTO `shopp_commodity_images` VALUES ('4B87F5AF-938E-5946-3356-3485D9245844', '28FDD4CE-5DC6-FC44-58EE-47ABB5B33BCF', '3846486E-A2A3-DD53-1502-60D712122F39.png');
INSERT INTO `shopp_commodity_images` VALUES ('4BBBE5E4-175D-9494-8E08-12210559C8DB', 'B7391928-0D76-8E49-8911-CF772446F9C1', 'CDE7891C-9AA6-54C1-FA8A-09B3EAD2D1A6.png');
INSERT INTO `shopp_commodity_images` VALUES ('4D08BCE4-1787-E5FF-EBE2-9B678882ECD5', '241411DE-FEBB-E3B4-4FE8-F73BDE54B32B', '1BFCFED4-8456-65EC-CABF-F531767DA996.png');
INSERT INTO `shopp_commodity_images` VALUES ('4EA5B7D2-6440-F687-C75B-F5287F516512', 'B4052C46-F17D-CBD1-4BCF-29DF877B6FA5', '22CF38EA-18FF-9F7C-BEBF-6C94F389062C.png');
INSERT INTO `shopp_commodity_images` VALUES ('50AF42C6-862B-8ADC-47B5-25C38DABC8F4', '21B3CE06-EBCB-ECA1-E311-88D1C759C156', 'D439D38F-8A8C-A299-7B1A-4EC47D75E0E9.png');
INSERT INTO `shopp_commodity_images` VALUES ('5185B236-004C-71EF-1048-4E18A11A1F00', '511676D4-6E5E-A943-02D2-23838D8A4B2A', 'B9127AAB-6B8D-2FE3-669E-55F296397595.png');
INSERT INTO `shopp_commodity_images` VALUES ('51CAE369-55B1-0AB7-BF12-0CB54146CF87', 'B7391928-0D76-8E49-8911-CF772446F9C1', '67BE1325-DC90-74FA-43E3-CB19384D1FCE.png');
INSERT INTO `shopp_commodity_images` VALUES ('52753AF0-0AE7-0C03-FD03-72E006A350F0', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', 'DD003367-BE0B-5942-6582-7A5E26DE8ADA.png');
INSERT INTO `shopp_commodity_images` VALUES ('5353F321-1ED4-DAAC-6D9E-3824CAD0C96D', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', '7187256B-2479-F5D7-00EE-A3C35F40C3A0.png');
INSERT INTO `shopp_commodity_images` VALUES ('535FEED5-A75C-2AEF-9EC0-4C605D1EAA13', 'AE6D4A9D-7257-836A-2687-8EE3B440594E', 'C5BFEB2A-9646-64F8-28A7-14FA6BD04E4F.png');
INSERT INTO `shopp_commodity_images` VALUES ('5399D8BD-BD9A-7E22-F74A-E8598977C8D8', 'DBDD6F97-71D8-FF7D-843F-33A2DA965DE1', '6D63A7A8-B945-CACD-5D78-FA4CE02998F6.png');
INSERT INTO `shopp_commodity_images` VALUES ('558B1843-F7AA-A7FC-B7BB-10321225A0A1', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF', '23D2D5D4-E656-41D0-E656-66C29FACFF24.png');
INSERT INTO `shopp_commodity_images` VALUES ('5685F676-AC9D-ECAF-FB5D-B93AC309CA33', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', '7045C8F7-2A0D-37A9-A618-4E3011B6CBF7.png');
INSERT INTO `shopp_commodity_images` VALUES ('57F0F7B0-6C79-B401-B214-82F3E09774B1', '934AE8D8-B061-C383-3FE1-6566C597B7F4', 'F19A377F-166D-FDB7-9216-356E060E7125.png');
INSERT INTO `shopp_commodity_images` VALUES ('59FB4B2C-48EA-791F-59F6-4553C369656F', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', 'BF0520D2-A9C3-8DEE-11F4-04FA8EF6FAD6.png');
INSERT INTO `shopp_commodity_images` VALUES ('5A5E2BF3-F7A1-944F-67C2-A0072B795A9F', 'B763DD16-2E58-C493-0434-3952FA160C17', '51FB105B-6092-584F-9FF2-65F5C151A090.png');
INSERT INTO `shopp_commodity_images` VALUES ('5F3DDB72-DE2A-6A74-75BF-56C716B7D861', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8', '8823B821-3A03-FB0C-633F-D60EED429CE2.png');
INSERT INTO `shopp_commodity_images` VALUES ('640C1B5B-5692-7FCA-0892-D95FAC4A1498', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8', 'B0BE1894-B02E-C1CB-6E8C-A1EF9836DAA2.png');
INSERT INTO `shopp_commodity_images` VALUES ('643F82EF-7F61-3C9B-6C76-62D5255C2557', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'B3195156-9300-44C5-56FB-552D8D67FFD7.png');
INSERT INTO `shopp_commodity_images` VALUES ('6685CE35-D941-FE7B-E3B9-82064F081032', '28FDD4CE-5DC6-FC44-58EE-47ABB5B33BCF', '109F016B-58BD-7648-0449-5061D3662A8B.png');
INSERT INTO `shopp_commodity_images` VALUES ('67281DD3-34A5-9FA1-1E74-E7FB6F0D5CE2', '6FFC6691-7F05-8AB8-B1E1-5C839BB4F446', '33C5B3E9-5A00-6B10-3CDF-B5DAE2F38165.png');
INSERT INTO `shopp_commodity_images` VALUES ('673D94FA-01E2-6F9F-D35F-9F87C3CA22F7', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', '6350699E-CD5B-DC0A-198C-78320274A619.png');
INSERT INTO `shopp_commodity_images` VALUES ('68682B3E-4C3A-2653-9172-AAADA17E6E43', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8', '2015B558-5D42-A24F-ADD8-A218F198AADA.png');
INSERT INTO `shopp_commodity_images` VALUES ('6969DD59-9755-D39E-E3C7-BC29CC3FAF58', '1581855B-4F44-E6F1-8E95-59AD9A5A0C5D', 'BC274C9E-9C6E-7DB5-FA4A-2144C9BE00A7.png');
INSERT INTO `shopp_commodity_images` VALUES ('6A0BCF51-27AF-CF97-EF14-2C3C2D0FF4FC', 'B763DD16-2E58-C493-0434-3952FA160C17', '9796E404-5FCA-D869-3886-FEB1491B55B8.png');
INSERT INTO `shopp_commodity_images` VALUES ('6CDB09E3-6B1A-D0FF-C0A9-AFF9069CAA9E', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D', 'E2D358F8-FA78-D90A-0C16-75B63185C9FD.png');
INSERT INTO `shopp_commodity_images` VALUES ('6D516C12-5107-7895-7028-C9EEF0C8F9FF', '92BAFEFD-CCE6-03EF-60A8-DF9954DDDCA9', 'ECC6053E-3DAA-7304-73C8-0362A0D10384.png');
INSERT INTO `shopp_commodity_images` VALUES ('6EE2613D-FC89-AE02-82A7-7D650D0698EB', 'B4052C46-F17D-CBD1-4BCF-29DF877B6FA5', 'D46A95BE-F796-F431-F482-6734C01B4E71.png');
INSERT INTO `shopp_commodity_images` VALUES ('71C7A57B-9009-C51E-05E6-F04994140EE3', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', '5500728D-D2E8-8AD6-2BAA-D1CDDD814E3C.png');
INSERT INTO `shopp_commodity_images` VALUES ('732BE371-9B32-4E16-6DC7-FB01B28A04CA', '511676D4-6E5E-A943-02D2-23838D8A4B2A', '23067377-7E94-10E7-5C34-21645A37329D.png');
INSERT INTO `shopp_commodity_images` VALUES ('73BACA15-167F-C310-7BBE-63F0E1D6E824', 'AE6D4A9D-7257-836A-2687-8EE3B440594E', '70232E37-76E7-E8C4-B951-5EF7679CC00D.png');
INSERT INTO `shopp_commodity_images` VALUES ('7867AD6A-E236-F756-33CD-51C7874B5CD4', 'B5037D54-D3D0-F1EE-5939-523BCBF8F2C6', 'ADB51A5B-975A-5C4B-20C9-2ED42A64D0A1.png');
INSERT INTO `shopp_commodity_images` VALUES ('7941B3EB-B8EC-4D31-DFE9-144C3398DD46', '2D089988-6636-BF15-676F-15A6AED0433F', '927D140D-EB1F-D98E-CE5C-9DD929FED54E.png');
INSERT INTO `shopp_commodity_images` VALUES ('7AB05D8B-E47E-11B3-5D04-65A1F207FC7A', 'EE5D2613-2760-F18C-A447-B8E744FF509D', '8297B86A-D2A5-D1DB-24C9-4D4CB92D3A07.png');
INSERT INTO `shopp_commodity_images` VALUES ('7B5A092C-F92E-3032-40DB-80299977754D', '37B10231-4225-C269-DB28-F1C40A6CA448', 'B1146293-F799-9106-575F-C4B6C0B1AF73.png');
INSERT INTO `shopp_commodity_images` VALUES ('7CF79B74-B70C-B0EB-2B98-A2ED8A983D11', 'FF815C07-E3C4-C632-F29C-42FE92C32AF9', 'FBD41B53-220E-6EDF-57C7-F40EF67E6B4F.png');
INSERT INTO `shopp_commodity_images` VALUES ('7CF8EDFF-4402-08BB-5CA4-44827EF6F0D8', 'D678064A-D80E-EFA2-4A01-873583FF3E9B', 'F919C117-D5E4-A59D-5FB9-4C8A9A0A8D82.png');
INSERT INTO `shopp_commodity_images` VALUES ('7DB13D3C-18C4-3B1E-6464-7901E11398A9', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', 'A7C465B2-E5B6-FDFE-0C69-A57BE07D7071.png');
INSERT INTO `shopp_commodity_images` VALUES ('7F0B232F-47C3-BBFE-4C23-4C593526313D', '47D002AB-DFA4-11CF-52FB-398122144EF1', '9A6A827D-6D87-3588-44F3-AA5E0D5A2FF5.png');
INSERT INTO `shopp_commodity_images` VALUES ('8424C292-BD6F-2491-F6CD-CFCDAB9EA8B5', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8', 'D378C0BD-532B-A999-D988-01384C0A5708.png');
INSERT INTO `shopp_commodity_images` VALUES ('869CD882-5FB6-3F00-0A4E-2C4EB51924D1', '934AE8D8-B061-C383-3FE1-6566C597B7F4', 'A17ACA04-F280-E772-D52B-F55D49DD0CCD.png');
INSERT INTO `shopp_commodity_images` VALUES ('86E7BA6E-4A64-B962-D39B-62AA28347098', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '28B656EC-ABAF-B5B4-6F1B-C2BE11321F1D.png');
INSERT INTO `shopp_commodity_images` VALUES ('880F85DB-B6B0-A734-3A9F-03187B58E89F', 'B7391928-0D76-8E49-8911-CF772446F9C1', '9FCC8B87-4E94-615D-C720-1C627E2844A1.png');
INSERT INTO `shopp_commodity_images` VALUES ('889D9024-5415-536A-BB48-6D25702DFD68', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8', 'BE1C8D5F-1DA4-8ABC-5C84-E4BEACE81C00.png');
INSERT INTO `shopp_commodity_images` VALUES ('8B2D0B3B-CF2D-CE59-3C7E-6E30FA611B2F', '61F54F17-89B5-A2B6-2A20-353A55A4F6D5', 'CF2E498E-A081-8448-6F8A-858A6AA52FC5.png');
INSERT INTO `shopp_commodity_images` VALUES ('8FFE6AE0-B9AB-A8CE-47CB-5D54AB240FAD', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', 'D0F95870-2579-75A2-26FB-173395EEB45E.png');
INSERT INTO `shopp_commodity_images` VALUES ('91CBA1F6-21A4-DE27-A244-42E3A9840DA7', 'EE5D2613-2760-F18C-A447-B8E744FF509D', '0B6435C4-6E03-D2B0-60B6-2E0D2153A68F.png');
INSERT INTO `shopp_commodity_images` VALUES ('93D33405-3A24-1BEE-EA45-661D472AB43A', '89C19CC9-AADE-EF8F-3D2A-FD244AC2C51D', '97D1C0FD-1A68-3204-FC3B-CF0D9405ADF1.png');
INSERT INTO `shopp_commodity_images` VALUES ('94C8CF9E-04B8-0B0F-8A55-D6D63CE7A452', '179149C6-2255-FAA2-F9F8-CA6608080FAA', 'D9D86B77-4CE4-7DA0-759C-2489FF3B3964.png');
INSERT INTO `shopp_commodity_images` VALUES ('971B6393-73AE-099A-1747-04CC49973F76', 'D678064A-D80E-EFA2-4A01-873583FF3E9B', '38E82FCC-FB99-559C-3398-F89FABFFF18B.png');
INSERT INTO `shopp_commodity_images` VALUES ('983C4329-2A64-7CE5-960C-BD79F9482F88', '433DA60D-5065-1301-48B8-76D1BB06CDF0', '503DA1B8-80F7-F31D-4DD7-A1CFFB9F8C83.png');
INSERT INTO `shopp_commodity_images` VALUES ('9CD73629-7F0D-C139-15A0-30F8BF9C2733', 'D2BCDC64-0970-3775-3193-6D870A490A84', '703BFFC9-E206-E21A-772A-F8E9A869A952.png');
INSERT INTO `shopp_commodity_images` VALUES ('9CE91289-6BC7-B64E-9B34-AE9ECFC6D47C', 'B5037D54-D3D0-F1EE-5939-523BCBF8F2C6', '8D02BA0F-B785-F10B-79DA-3EC279E32D8A.png');
INSERT INTO `shopp_commodity_images` VALUES ('9D02D13E-A08D-B554-F789-742E5F03980A', 'C3E30939-86EB-730F-900E-17B582155781', '123F7DC5-5222-AF32-C0A8-648F51DF0324.png');
INSERT INTO `shopp_commodity_images` VALUES ('9DE11212-A2DA-5DE8-1F9E-A05283AD771B', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8', 'E8BC7D81-7CBB-DE52-DE35-3DB9727BD1C7.png');
INSERT INTO `shopp_commodity_images` VALUES ('9DFBE04C-CA62-7FD7-580D-CB875B00014D', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '8197BF6B-16CE-A046-33A9-3D731E2E3D11.png');
INSERT INTO `shopp_commodity_images` VALUES ('9ECA2961-DC76-0605-52AB-6F4094EA951F', '179149C6-2255-FAA2-F9F8-CA6608080FAA', 'D07AC7DA-6F17-9EC6-EA9C-7DDE1A466D43.png');
INSERT INTO `shopp_commodity_images` VALUES ('A0C78B47-0606-A78D-FAB7-9D0E27CCB771', '179149C6-2255-FAA2-F9F8-CA6608080FAA', '3EC38AD2-1CC7-0373-78A4-032EEA15B676.png');
INSERT INTO `shopp_commodity_images` VALUES ('A0D58D68-BDDB-F909-CBB6-494C75BB1206', 'D2BCDC64-0970-3775-3193-6D870A490A84', '6CB82C67-F8A9-BFE2-8F59-21524B90D7A4.png');
INSERT INTO `shopp_commodity_images` VALUES ('A206D89D-4B0E-DE89-3540-47EF6F3EDB4C', '28FDD4CE-5DC6-FC44-58EE-47ABB5B33BCF', '7C095CDE-A08F-17E4-B073-75725BCC04DA.png');
INSERT INTO `shopp_commodity_images` VALUES ('A258E03C-C85F-A856-DF40-6842D6CCF63C', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'FAF79646-6C06-14DD-58C2-493F260D9448.png');
INSERT INTO `shopp_commodity_images` VALUES ('A26C6F8F-62BD-7011-4728-1A8C06C0B59B', 'F7BC08D4-A15A-0784-3456-04EE6D29C689', '2A3D0094-9CDB-F12F-7789-5FA986097EF5.png');
INSERT INTO `shopp_commodity_images` VALUES ('A4A73C7A-46AD-F92B-DC43-F6279FB5306E', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'C48809C5-1916-F829-8490-3A99D06CC7C8.png');
INSERT INTO `shopp_commodity_images` VALUES ('A6163558-46AE-63A3-1C47-6A28ACB119F5', 'B5037D54-D3D0-F1EE-5939-523BCBF8F2C6', '428B2F0E-08DB-BC4F-9FAF-5A46B6A9BAC1.png');
INSERT INTO `shopp_commodity_images` VALUES ('A78D62A0-E0D0-970C-703E-B96CF7701470', '934AE8D8-B061-C383-3FE1-6566C597B7F4', '580D5E61-87CF-50C7-3F53-5F4A1D886580.png');
INSERT INTO `shopp_commodity_images` VALUES ('AB688D8F-D99C-41FA-E672-1D3CEBC9C2BC', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '9AD3F274-6DD5-EF22-88E9-FAE738C2F085.png');
INSERT INTO `shopp_commodity_images` VALUES ('AD7C7006-DDAD-5BC4-6979-BE52BCB347E4', '753C793E-1F5D-1DC7-4103-A23D23E016C2', '998CC4B9-2DBA-631E-8604-20B1FF70EE38.png');
INSERT INTO `shopp_commodity_images` VALUES ('ADD99A97-DA0B-0623-0AC4-82D1E537B1FD', '6FFC6691-7F05-8AB8-B1E1-5C839BB4F446', '59395775-928E-A845-172F-1284CFCE87E2.png');
INSERT INTO `shopp_commodity_images` VALUES ('ADE35F01-19B3-597A-2B24-A33CF4B157DA', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'C6D7C71D-7826-A291-6321-B440785E72D0.png');
INSERT INTO `shopp_commodity_images` VALUES ('B0B7D637-E98A-5F02-27F2-BB169330D1DC', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', '1B35A50B-7845-92A9-0E06-EFBB32F01631.png');
INSERT INTO `shopp_commodity_images` VALUES ('B24B6CA7-B4B4-A6AE-170F-1F31568EE89B', '433DA60D-5065-1301-48B8-76D1BB06CDF0', '6AB942BE-5142-231F-6923-6624B7317021.png');
INSERT INTO `shopp_commodity_images` VALUES ('B2D87EB9-9A0D-A577-77AF-24138822CAD7', '21B3CE06-EBCB-ECA1-E311-88D1C759C156', '0F916C0D-AE01-944F-6AE1-F0931811FC38.png');
INSERT INTO `shopp_commodity_images` VALUES ('B40B3100-E0B7-498D-8F39-3B19F9BB325F', 'B7391928-0D76-8E49-8911-CF772446F9C1', 'D57F1CAC-A569-558D-B9C4-0365447AA8E0.png');
INSERT INTO `shopp_commodity_images` VALUES ('B4166F4B-E34C-A579-45EB-25BE37104937', '433DA60D-5065-1301-48B8-76D1BB06CDF0', 'BA5A4691-D21F-9516-EE0F-736228662D95.png');
INSERT INTO `shopp_commodity_images` VALUES ('B4339413-D5A6-E1DB-5931-CCD56B703891', '2D089988-6636-BF15-676F-15A6AED0433F', '014ABA05-3A66-B41B-CDBE-14FFFD7DC4E2.png');
INSERT INTO `shopp_commodity_images` VALUES ('B53D8581-817D-B622-F3C3-DE249C6AEB34', '241411DE-FEBB-E3B4-4FE8-F73BDE54B32B', '4D0C74AC-FBA4-4229-0820-36C4EE9E11E1.png');
INSERT INTO `shopp_commodity_images` VALUES ('B8B0CDEC-2F40-DD0D-E3F8-C752D05F99E0', '1581855B-4F44-E6F1-8E95-59AD9A5A0C5D', '080CA9D6-CD5A-9D18-471C-167F94F71703.png');
INSERT INTO `shopp_commodity_images` VALUES ('B9FF52B8-95F2-18E8-55A5-994465A1CDA6', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'B8227999-745C-4AB6-C95D-C57E1924AED8.png');
INSERT INTO `shopp_commodity_images` VALUES ('BA6A2FF8-B830-E558-3420-AF95D7F58707', '22B10E64-2792-9976-E179-2481FBD15CB5', '92C835A4-5DA5-0E43-8386-5C32378CC77C.png');
INSERT INTO `shopp_commodity_images` VALUES ('BAFCF423-02AE-098E-2BBA-CEC87D969A66', '21B3CE06-EBCB-ECA1-E311-88D1C759C156', '87EA97DE-47A3-C080-165B-7E8BDCD578C1.png');
INSERT INTO `shopp_commodity_images` VALUES ('BAFDF589-1479-7D92-0D21-3D9FA7CA388F', '6D025479-654E-5D3F-2B6D-ECF783A2D918', 'B59440A9-3A93-B9E8-EBBA-53425F78A136.png');
INSERT INTO `shopp_commodity_images` VALUES ('BEFF68EF-B07E-B032-36FB-850F0FFBC50E', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'E56FA03A-738D-500E-F9C4-C84636B61F6F.png');
INSERT INTO `shopp_commodity_images` VALUES ('BFF7FD66-077A-46E7-FADA-2925CA3B1AA0', '89C19CC9-AADE-EF8F-3D2A-FD244AC2C51D', '92357BBF-C8CB-45D9-DB8D-67F1C84EDE0C.png');
INSERT INTO `shopp_commodity_images` VALUES ('C0B7D3CA-73BC-2ABD-0CE4-E61A4E829B23', '37B10231-4225-C269-DB28-F1C40A6CA448', '1942A9BD-1C3B-3951-4019-C949EA86E993.png');
INSERT INTO `shopp_commodity_images` VALUES ('C2A118C9-1095-2765-EFD0-376C66BC6B09', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '4CA86FB7-9258-BC3A-C0C4-1F21005B59E9.png');
INSERT INTO `shopp_commodity_images` VALUES ('C8A8BAE2-418D-8F27-37D7-2969A761F2DC', 'F396C933-04BC-E46D-012F-AE67F7DD37EE', '7875BFCD-4332-B52D-797B-3F00FE252FF1.png');
INSERT INTO `shopp_commodity_images` VALUES ('C8F57565-F79D-0598-B4BA-4FA271A41E36', 'B5037D54-D3D0-F1EE-5939-523BCBF8F2C6', 'ED9D8930-505A-B2A3-48E6-5C16212B5E1C.png');
INSERT INTO `shopp_commodity_images` VALUES ('CB0253E0-FEE9-8D20-9471-BC9F05B55615', '61F54F17-89B5-A2B6-2A20-353A55A4F6D5', 'C42846B3-6FFB-8819-1D80-3F798D0F5979.png');
INSERT INTO `shopp_commodity_images` VALUES ('CB420F6D-2768-F2BB-EE1B-31CCF0ABA4F5', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', '32156F6D-2601-5460-EE18-6499A4A08901.png');
INSERT INTO `shopp_commodity_images` VALUES ('CCACBE2E-C88F-0283-8F1B-537D65E854D5', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1', 'F4BBC2CB-F41D-264B-6865-987381696B76.png');
INSERT INTO `shopp_commodity_images` VALUES ('CFB162FF-99DA-BB66-1C3C-55C91BDF2ABD', 'DBDD6F97-71D8-FF7D-843F-33A2DA965DE1', 'FDAA5580-6CAF-83C2-48EF-6BBB0BA1F307.png');
INSERT INTO `shopp_commodity_images` VALUES ('D007DA3A-5ABB-D49C-9EAF-8AA591735A4F', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', '658CA3F7-2F95-C52C-3465-1B70EF681B29.png');
INSERT INTO `shopp_commodity_images` VALUES ('D0799476-AA5F-24DC-4271-B3CD5FA807E7', '72387161-B237-7FC1-3FB3-E78C23533C5C', 'ADE170F9-0E29-D207-4AC9-FCD0F3EA02F7.png');
INSERT INTO `shopp_commodity_images` VALUES ('D1FA4618-99AA-4EFD-CFDC-DE8A91266EC4', '241411DE-FEBB-E3B4-4FE8-F73BDE54B32B', 'B2E59875-9654-B43B-938C-DB104C750334.png');
INSERT INTO `shopp_commodity_images` VALUES ('D70A6647-B13B-520F-8CF0-3E89C2DADC6A', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', '1CE754AB-E7A0-5DE6-0959-91EC7A74735E.png');
INSERT INTO `shopp_commodity_images` VALUES ('D8A3CE6F-794A-FF93-E091-AD8C1DBE4AAC', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8', '62ADF60A-590F-1D1E-B75B-05979257AF90.png');
INSERT INTO `shopp_commodity_images` VALUES ('D9F1B3E1-3679-6621-771A-37C4CA1CE331', '00D84306-7B0D-F027-28E4-09D70124D2CB', 'CFEDF8F6-749A-5565-F853-DA50C5878664.png');
INSERT INTO `shopp_commodity_images` VALUES ('DF70CE22-CB98-85AA-1C3A-B7C234B432AF', '6D025479-654E-5D3F-2B6D-ECF783A2D918', '5E975A04-3F5F-6DE9-83DF-7D4764C2103C.png');
INSERT INTO `shopp_commodity_images` VALUES ('E12DFC1F-969F-2CED-0422-B75C8250B099', 'B4052C46-F17D-CBD1-4BCF-29DF877B6FA5', 'C5AF23EC-756A-DB9E-99A5-8DA2B7D31EE5.png');
INSERT INTO `shopp_commodity_images` VALUES ('E45E5E01-40D7-4896-BD53-5EB15A2FDF97', '61F54F17-89B5-A2B6-2A20-353A55A4F6D5', 'B370C11B-25F3-A9CF-E4A7-697971DB8FDD.png');
INSERT INTO `shopp_commodity_images` VALUES ('E6456732-6563-0B1A-E5E2-B52D4C6686B2', 'F51D327E-3EFE-0E64-BA0A-E122DB83F189', 'D89107BB-03E6-3353-B29F-CA5FFE5051E8.png');
INSERT INTO `shopp_commodity_images` VALUES ('E7927A03-898A-81E8-92A9-1DAF7696EE82', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1', 'C6A718A3-4005-B19D-3C1A-DCCDB794D9DD.png');
INSERT INTO `shopp_commodity_images` VALUES ('E89B23AF-F90E-E165-6ECF-D0E63771A7C6', 'EE5D2613-2760-F18C-A447-B8E744FF509D', '1D6ECD1F-2D1B-4A9C-26BE-C5ACE83CE49E.png');
INSERT INTO `shopp_commodity_images` VALUES ('E8DD390B-8A00-2484-572A-EFB32A807320', '72387161-B237-7FC1-3FB3-E78C23533C5C', '9CFD2B3D-187C-6DCA-D98C-6DFA1ECDFF05.png');
INSERT INTO `shopp_commodity_images` VALUES ('E9036D18-7C64-231D-EB98-010E4559BF8F', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D', 'C58CCEFD-34D8-E784-25C9-40685F4DD880.png');
INSERT INTO `shopp_commodity_images` VALUES ('EA9C9F7D-83C9-6327-35D3-08713DBE2D92', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', 'B521368A-73CA-C9E1-A427-F8CBC92E73A0.png');
INSERT INTO `shopp_commodity_images` VALUES ('EB0675F0-EC22-6EA9-69C5-C62CD6F33E89', 'F7BC08D4-A15A-0784-3456-04EE6D29C689', 'AD9B3BD0-DC94-7FAB-7805-157E0E0F53D6.png');
INSERT INTO `shopp_commodity_images` VALUES ('EB55A182-6913-7F08-E7F4-41821E4F453F', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', 'E841DE8F-35A5-7FC3-795B-4EB50BDACB7B.png');
INSERT INTO `shopp_commodity_images` VALUES ('EBAF7894-9898-3857-7ADC-ED5B87DCF8E3', 'F7BC08D4-A15A-0784-3456-04EE6D29C689', 'BB9230A3-BD03-7C21-F4AB-C4F364BD81AB.png');
INSERT INTO `shopp_commodity_images` VALUES ('ED0BCE47-3943-26D8-B892-761CEF699711', 'DBDD6F97-71D8-FF7D-843F-33A2DA965DE1', 'D2D4BD58-4F9C-6F71-3E80-6C61B01C5DD7.png');
INSERT INTO `shopp_commodity_images` VALUES ('ED2B445C-4844-0E94-C2C5-990971DC81E4', '6275F89C-A2A1-8B7B-A259-94926A84C442', 'CF2FFDF4-2229-9D44-523E-10DDA3138F86.png');
INSERT INTO `shopp_commodity_images` VALUES ('ED60B1A2-A44A-F830-BF16-6300ED800322', 'D678064A-D80E-EFA2-4A01-873583FF3E9B', 'DDDC1140-0CE9-3A1C-CA05-DA867E9A6750.png');
INSERT INTO `shopp_commodity_images` VALUES ('EDD1DE37-1BBB-E76B-40C7-59A2D7753B54', 'F51D327E-3EFE-0E64-BA0A-E122DB83F189', '8E362734-3D60-5F96-211C-2001A835B13E.png');
INSERT INTO `shopp_commodity_images` VALUES ('EE4AD4EF-2C0A-3334-6A55-0707F48E9FB9', '28FDD4CE-5DC6-FC44-58EE-47ABB5B33BCF', 'EB9C3F18-0424-8630-923C-3FE05FB7B439.png');
INSERT INTO `shopp_commodity_images` VALUES ('F1E81D5D-8330-5595-EED8-19F1805C1FBE', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', '89F7EE4C-1CA5-9245-D06E-EA9439918A75.png');
INSERT INTO `shopp_commodity_images` VALUES ('F2560095-2487-8A82-7317-A2B4A69DAB4B', 'AE6D4A9D-7257-836A-2687-8EE3B440594E', '8C293BCC-337D-EB61-3960-2F4064D9109D.png');
INSERT INTO `shopp_commodity_images` VALUES ('F25E0629-8307-4807-5AD8-A664EC90AD00', 'B763DD16-2E58-C493-0434-3952FA160C17', '68068479-31AB-11C9-6827-04F61B03BF3F.png');
INSERT INTO `shopp_commodity_images` VALUES ('F56969D2-3DC7-20CD-6159-CEF4DC50B32A', 'B763DD16-2E58-C493-0434-3952FA160C17', 'F5688214-D4BD-08CF-F4BF-4A50A48B6311.png');
INSERT INTO `shopp_commodity_images` VALUES ('F9F60FD9-3B1C-1504-D0F9-6065B14B10F2', '72387161-B237-7FC1-3FB3-E78C23533C5C', '94E94A81-ADE7-DF43-354D-8C4CEA132FAC.png');
INSERT INTO `shopp_commodity_images` VALUES ('FC5CA25C-C2D8-6826-6548-E94562843927', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1', '5205796A-3BCE-0D01-2D39-1D6B66B84053.png');
INSERT INTO `shopp_commodity_images` VALUES ('FC7C5A24-E620-FD6E-FAFE-99DBC8672C75', '6D025479-654E-5D3F-2B6D-ECF783A2D918', 'B5E3030F-C5B2-4BF8-8F7E-E4199175D58F.png');
INSERT INTO `shopp_commodity_images` VALUES ('FDD891B5-59FB-8E89-31C9-B0F1F9F098E8', 'F51D327E-3EFE-0E64-BA0A-E122DB83F189', 'EA4D61E2-2E6B-B9D2-1549-6CF433674687.png');
INSERT INTO `shopp_count` VALUES ('128', '::1', '1487524671', '', 'home');
INSERT INTO `shopp_count` VALUES ('129', '::1', '1487525785', 'admin', 'home');
INSERT INTO `shopp_count` VALUES ('130', '::1', '1487526503', '', 'home');
INSERT INTO `shopp_count` VALUES ('131', '::1', '1487526520', 'admin', 'home');
INSERT INTO `shopp_count` VALUES ('132', '::1', '1487528159', '', 'home');
INSERT INTO `shopp_count` VALUES ('133', '::1', '1487528168', 'admin', 'home');
INSERT INTO `shopp_count` VALUES ('134', '::1', '1487528192', 'admin', 'home');
INSERT INTO `shopp_count` VALUES ('135', '::1', '1487528529', 'admin', 'home');
INSERT INTO `shopp_count` VALUES ('136', '::1', '1487562386', '', 'home');
INSERT INTO `shopp_count` VALUES ('137', '::1', '1487562405', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('138', '::1', '1487563148', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('139', '::1', '1487563157', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('140', '::1', '1487563164', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('141', '::1', '1487563250', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('142', '::1', '1487563346', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('143', '::1', '1487563361', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('144', '::1', '1487563843', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('145', '::1', '1487565371', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('146', '::1', '1487565402', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('147', '::1', '1487565407', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('148', '::1', '1487565411', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('149', '::1', '1487566112', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('150', '::1', '1487568109', '', 'home');
INSERT INTO `shopp_count` VALUES ('151', '::1', '1487568127', '', 'home');
INSERT INTO `shopp_count` VALUES ('152', '::1', '1487568736', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('153', '::1', '1487569817', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('154', '::1', '1487595141', '', 'home');
INSERT INTO `shopp_count` VALUES ('155', '::1', '1487595166', '', 'home');
INSERT INTO `shopp_count` VALUES ('156', '::1', '1487926600', '', 'home');
INSERT INTO `shopp_count` VALUES ('157', '::1', '1487926627', '', 'home');
INSERT INTO `shopp_count` VALUES ('158', '::1', '1487926635', '', 'home');
INSERT INTO `shopp_count` VALUES ('159', '::1', '1487926664', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('160', '::1', '1487926667', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('161', '::1', '1487926671', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('162', '::1', '1487926674', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('163', '::1', '1487926677', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('164', '::1', '1487926686', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('165', '::1', '1487926689', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('166', '::1', '1487926727', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('167', '::1', '1487926735', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('168', '::1', '1487926739', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('169', '::1', '1487926756', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('170', '::1', '1487926759', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('171', '::1', '1487926785', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('172', '::1', '1487927039', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('173', '::1', '1487927721', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('174', '::1', '1489159217', '', 'home');
INSERT INTO `shopp_count` VALUES ('175', '::1', '1489159233', '', 'home');
INSERT INTO `shopp_count` VALUES ('176', '::1', '1489159248', '', 'home');
INSERT INTO `shopp_count` VALUES ('177', '::1', '1489159288', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('178', '::1', '1489159296', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('179', '::1', '1489159397', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('180', '::1', '1489159427', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('181', '::1', '1489159659', '', 'home');
INSERT INTO `shopp_count` VALUES ('182', '::1', '1489159835', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('183', '::1', '1489159846', '', 'home');
INSERT INTO `shopp_count` VALUES ('184', '::1', '1489160067', '', 'home');
INSERT INTO `shopp_count` VALUES ('185', '::1', '1489160108', '', 'home');
INSERT INTO `shopp_count` VALUES ('186', '::1', '1489160133', '', 'home');
INSERT INTO `shopp_count` VALUES ('187', '::1', '1489160153', '', 'home');
INSERT INTO `shopp_count` VALUES ('188', '::1', '1489160187', '', 'home');
INSERT INTO `shopp_count` VALUES ('189', '::1', '1489160839', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('190', '::1', '1489160844', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('191', '::1', '1489162054', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('192', '::1', '1489162260', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('193', '::1', '1489162263', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('194', '::1', '1489162311', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('195', '::1', '1489162313', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('196', '::1', '1489162321', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('197', '::1', '1489162913', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('198', '::1', '1489162916', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('199', '::1', '1489162919', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('200', '::1', '1489162923', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('201', '::1', '1489163018', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('202', '::1', '1489163069', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('203', '::1', '1489163113', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('204', '::1', '1489163152', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('205', '::1', '1489163183', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('206', '::1', '1489163247', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('207', '::1', '1489163304', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('208', '::1', '1489163335', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('209', '::1', '1489163339', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('210', '::1', '1489163365', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('211', '::1', '1489198675', '', 'home');
INSERT INTO `shopp_count` VALUES ('212', '::1', '1489198703', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('213', '::1', '1489198706', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('214', '::1', '1489198711', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('215', '::1', '1489198716', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('216', '::1', '1489198740', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('217', '::1', '1489200364', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('218', '::1', '1489200376', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('219', '::1', '1489200379', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('220', '::1', '1489200385', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('221', '::1', '1489200407', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('222', '::1', '1489200411', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('223', '::1', '1489200425', '欢歌', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('224', '::1', '1489200442', '欢歌', 'home/User/placeOrdersHandle');
INSERT INTO `shopp_count` VALUES ('225', '::1', '1489200443', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('226', '::1', '1489200475', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('227', '::1', '1489200481', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('228', '::1', '1489200484', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('229', '::1', '1489200492', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('230', '::1', '1489200497', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('231', '::1', '1489200502', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('232', '::1', '1489200505', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('233', '::1', '1489200512', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('234', '::1', '1489200527', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('235', '::1', '1489200534', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('236', '::1', '1489200537', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('237', '::1', '1489200540', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('238', '::1', '1489201230', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('239', '::1', '1489201235', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('240', '::1', '1489202376', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('241', '::1', '1489202380', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('242', '::1', '1489202383', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('243', '::1', '1489202386', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('244', '::1', '1489202660', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('245', '::1', '1489202759', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('246', '::1', '1489202800', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('247', '::1', '1489202854', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('248', '::1', '1489202905', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('249', '::1', '1489202981', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('250', '::1', '1489203015', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('251', '::1', '1489203177', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('252', '::1', '1489203180', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('253', '::1', '1489206400', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('254', '::1', '1489206429', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('255', '::1', '1489206458', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('256', '::1', '1489206525', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('257', '::1', '1489206658', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('258', '::1', '1489206810', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('259', '::1', '1489206991', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('260', '::1', '1489207037', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('261', '::1', '1489207084', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('262', '::1', '1489207126', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('263', '::1', '1489207245', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('264', '::1', '1489207479', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('265', '::1', '1489207551', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('266', '::1', '1489207731', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('267', '::1', '1489208020', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('268', '::1', '1489208076', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('269', '::1', '1489208242', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('270', '::1', '1489208256', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('271', '::1', '1489208435', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('272', '::1', '1489208699', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('273', '::1', '1489208706', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('274', '::1', '1489208840', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('275', '::1', '1489209257', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('276', '::1', '1489209380', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('277', '::1', '1489209408', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('278', '::1', '1489209427', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('279', '::1', '1489212860', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('280', '::1', '1489212953', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('281', '::1', '1489212978', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('282', '::1', '1489213035', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('283', '::1', '1489214964', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('284', '::1', '1489214968', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('285', '::1', '1489214970', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('286', '::1', '1489214982', '欢歌', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('287', '::1', '1489214995', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('288', '::1', '1489215971', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('289', '::1', '1489215975', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('290', '::1', '1489218119', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('291', '::1', '1489218120', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('292', '::1', '1489218121', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('293', '::1', '1489218122', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('294', '::1', '1489218123', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('295', '::1', '1489218124', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('296', '::1', '1489218125', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('297', '::1', '1489218126', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('298', '::1', '1489218127', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('299', '::1', '1489218128', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('300', '::1', '1489218129', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('301', '::1', '1489218130', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('302', '::1', '1489218131', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('303', '::1', '1489218132', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('304', '::1', '1489218133', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('305', '::1', '1489218134', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('306', '::1', '1489218135', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('307', '::1', '1489218136', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('308', '::1', '1489220667', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('309', '::1', '1489220773', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('310', '::1', '1489220815', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('311', '::1', '1489220838', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('312', '::1', '1489221876', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('313', '::1', '1489222084', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('314', '::1', '1489222168', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('315', '::1', '1489222269', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('316', '::1', '1489222340', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('317', '::1', '1489222914', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('318', '::1', '1489222991', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('319', '::1', '1489223547', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('320', '::1', '1489223583', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('321', '::1', '1489240631', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('322', '::1', '1489240815', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('323', '::1', '1489240864', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('324', '::1', '1489241577', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('325', '::1', '1489241810', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('326', '::1', '1489242077', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('327', '::1', '1489243337', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('328', '::1', '1489243429', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('329', '::1', '1489243438', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('330', '::1', '1489243479', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('331', '::1', '1489243821', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('332', '::1', '1489243895', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('333', '::1', '1489244041', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('334', '::1', '1489244073', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('335', '::1', '1489244123', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('336', '::1', '1489244139', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('337', '::1', '1489244163', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('338', '::1', '1489244215', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('339', '::1', '1489244475', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('340', '::1', '1489244533', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('341', '::1', '1489244570', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('342', '::1', '1489244717', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('343', '::1', '1489244819', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('344', '::1', '1489244941', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('345', '::1', '1489245011', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('346', '::1', '1489245198', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('347', '::1', '1489245206', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('348', '::1', '1489245225', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('349', '::1', '1489245276', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('350', '::1', '1489245286', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('351', '::1', '1489245467', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('352', '::1', '1489246682', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('353', '::1', '1489246715', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('354', '::1', '1489246798', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('355', '::1', '1489246816', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('356', '::1', '1489246860', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('357', '::1', '1489246986', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('358', '::1', '1489247776', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('359', '::1', '1489247874', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('360', '::1', '1489247876', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('361', '::1', '1489248839', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('362', '::1', '1489248865', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('363', '::1', '1489248954', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('364', '::1', '1489249027', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('365', '::1', '1489249128', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('366', '::1', '1489249201', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('367', '::1', '1489249290', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('368', '::1', '1489249421', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('369', '::1', '1489249560', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('370', '::1', '1489249655', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('371', '::1', '1489249963', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('372', '::1', '1489250007', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('373', '127.0.0.1', '1489286514', '', 'home');
INSERT INTO `shopp_count` VALUES ('374', '127.0.0.1', '1489286538', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('375', '127.0.0.1', '1489286541', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('376', '127.0.0.1', '1489286548', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('377', '127.0.0.1', '1489286552', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('378', '127.0.0.1', '1489287063', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('379', '127.0.0.1', '1489287145', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('380', '127.0.0.1', '1489287257', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('381', '127.0.0.1', '1489287584', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('382', '127.0.0.1', '1489287679', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('383', '127.0.0.1', '1489287749', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('384', '::1', '1489288133', '', 'home');
INSERT INTO `shopp_count` VALUES ('385', '::1', '1489288154', 'test3', 'home');
INSERT INTO `shopp_count` VALUES ('386', '::1', '1489288157', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('387', '127.0.0.1', '1489288280', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('388', '127.0.0.1', '1489288526', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('389', '127.0.0.1', '1489288560', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('390', '127.0.0.1', '1489289680', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('391', '127.0.0.1', '1489289685', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('392', '127.0.0.1', '1489289690', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('393', '127.0.0.1', '1489289884', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('394', '127.0.0.1', '1489289939', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('395', '127.0.0.1', '1489290033', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('396', '127.0.0.1', '1489290086', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('397', '127.0.0.1', '1489290098', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('398', '127.0.0.1', '1489290100', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('399', '127.0.0.1', '1489290102', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('400', '127.0.0.1', '1489290108', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('401', '127.0.0.1', '1489290112', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('402', '::1', '1489291192', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('403', '::1', '1489303236', 'test3', 'home');
INSERT INTO `shopp_count` VALUES ('404', '127.0.0.1', '1489303735', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('405', '127.0.0.1', '1489303738', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('406', '127.0.0.1', '1489303761', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('407', '127.0.0.1', '1489304325', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('408', '127.0.0.1', '1489304331', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('409', '127.0.0.1', '1489304335', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('410', '127.0.0.1', '1489304368', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('411', '127.0.0.1', '1489304730', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('412', '127.0.0.1', '1489304935', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('413', '::1', '1489304942', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('414', '::1', '1489304953', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('415', '127.0.0.1', '1489304969', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('416', '127.0.0.1', '1489304974', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('417', '127.0.0.1', '1489304993', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('418', '::1', '1489305001', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('419', '::1', '1489305003', 'test3', 'home');
INSERT INTO `shopp_count` VALUES ('420', '::1', '1489305006', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('421', '::1', '1489305009', 'test3', 'home/User/logOut');
INSERT INTO `shopp_count` VALUES ('422', '::1', '1489305010', '', 'home');
INSERT INTO `shopp_count` VALUES ('423', '::1', '1489305026', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('424', '::1', '1489305030', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('425', '::1', '1489305035', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('426', '::1', '1489305040', '欢歌', 'home/User/logOut');
INSERT INTO `shopp_count` VALUES ('427', '::1', '1489305041', '', 'home');
INSERT INTO `shopp_count` VALUES ('428', '127.0.0.1', '1489305365', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('429', '127.0.0.1', '1489305369', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('430', '127.0.0.1', '1489305373', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('431', '127.0.0.1', '1489305377', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('432', '127.0.0.1', '1489305381', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('433', '127.0.0.1', '1489305393', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('434', '127.0.0.1', '1489305395', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('435', '127.0.0.1', '1489305428', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('436', '127.0.0.1', '1489305431', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('437', '127.0.0.1', '1489305480', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('438', '127.0.0.1', '1489305483', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('439', '127.0.0.1', '1489305692', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('440', '127.0.0.1', '1489305695', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('441', '127.0.0.1', '1489305701', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('442', '127.0.0.1', '1489330816', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('443', '127.0.0.1', '1489330929', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('444', '::1', '1489332962', 'test3', 'home');
INSERT INTO `shopp_count` VALUES ('445', '::1', '1489332970', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('446', '::1', '1489333109', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('447', '::1', '1489333119', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('448', '::1', '1489333124', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('449', '::1', '1489333282', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('450', '::1', '1489333314', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('451', '::1', '1489333328', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('452', '::1', '1489333440', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('453', '::1', '1489333493', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('454', '::1', '1489333495', 'test3', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('455', '::1', '1489333550', 'test3', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('456', '::1', '1489333562', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('457', '::1', '1489333602', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('458', '::1', '1489333611', 'test3', 'home/User/buyOneHandle');
INSERT INTO `shopp_count` VALUES ('459', '::1', '1489333612', 'test3', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('460', '::1', '1489333621', 'test3', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('461', '::1', '1489333627', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('462', '::1', '1489333631', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('463', '::1', '1489333637', 'test3', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('464', '::1', '1489333642', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('465', '::1', '1489333645', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('466', '::1', '1489333648', 'test3', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('467', '::1', '1489333704', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('468', '::1', '1489333706', 'test3', 'home');
INSERT INTO `shopp_count` VALUES ('469', '::1', '1489365728', '', 'home');
INSERT INTO `shopp_count` VALUES ('470', '::1', '1489365796', '', 'home');
INSERT INTO `shopp_count` VALUES ('471', '::1', '1489365832', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('472', '::1', '1489365839', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('473', '::1', '1489365843', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('474', '::1', '1489365847', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('475', '::1', '1489365889', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('476', '::1', '1489367326', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('477', '::1', '1489367329', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('478', '::1', '1489367349', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('479', '::1', '1489367362', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('480', '::1', '1489367781', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('481', '::1', '1489367785', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('482', '::1', '1489367790', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('483', '::1', '1489367815', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('484', '::1', '1489367820', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('485', '::1', '1489367824', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('486', '::1', '1489367828', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('487', '::1', '1489367831', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('488', '::1', '1489367945', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('489', '::1', '1489367970', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('490', '::1', '1489367975', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('491', '::1', '1489367979', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('492', '::1', '1489367981', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('493', '::1', '1489368029', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('494', '::1', '1489368034', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('495', '::1', '1489368039', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('496', '::1', '1489368096', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('497', '::1', '1489368191', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('498', '::1', '1489368200', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('499', '::1', '1489368223', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('500', '::1', '1489368239', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('501', '::1', '1489368295', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('502', '::1', '1489368389', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('503', '::1', '1489368445', '欢歌', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('504', '::1', '1489368558', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('505', '::1', '1489368568', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('506', '::1', '1489368572', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('507', '::1', '1489368574', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('508', '::1', '1489368576', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('509', '::1', '1489368617', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('510', '::1', '1489368632', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('511', '::1', '1489368634', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('512', '::1', '1489368641', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('513', '::1', '1489368741', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('514', '::1', '1489368744', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('515', '::1', '1489368746', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('516', '::1', '1489368748', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('517', '::1', '1489368861', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('518', '::1', '1489368871', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('519', '::1', '1489368926', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('520', '::1', '1489368932', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('521', '::1', '1489368935', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('522', '::1', '1489368956', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('523', '::1', '1489368959', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('524', '::1', '1489368964', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('525', '::1', '1489368967', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('526', '::1', '1489368970', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('527', '::1', '1489368971', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('528', '::1', '1489368975', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('529', '::1', '1489369050', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('530', '::1', '1489369108', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('531', '::1', '1489369114', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('532', '::1', '1489369990', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('533', '::1', '1489370123', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('534', '::1', '1489370158', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('535', '::1', '1489370227', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('536', '::1', '1489370264', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('537', '::1', '1489370458', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('538', '::1', '1489370524', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('539', '::1', '1489370544', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('540', '::1', '1489370622', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('541', '::1', '1489370676', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('542', '::1', '1489370720', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('543', '::1', '1489370727', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('544', '::1', '1489370730', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('545', '::1', '1489370732', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('546', '::1', '1489370735', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('547', '::1', '1489372002', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('548', '::1', '1489372010', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('549', '::1', '1489372017', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('550', '::1', '1489372019', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('551', '::1', '1489372123', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('552', '::1', '1489372144', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('553', '::1', '1489372147', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('554', '::1', '1489372158', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('555', '::1', '1489372198', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('556', '::1', '1489372957', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('557', '::1', '1489373041', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('558', '::1', '1489373044', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('559', '::1', '1489373048', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('560', '::1', '1489373106', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('561', '::1', '1489373196', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('562', '::1', '1489373257', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('563', '::1', '1489373267', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('564', '::1', '1489373271', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('565', '::1', '1489373292', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('566', '::1', '1489373344', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('567', '::1', '1489373368', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('568', '::1', '1489373405', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('569', '::1', '1489373440', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('570', '::1', '1489373664', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('571', '::1', '1489373781', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('572', '::1', '1489373785', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('573', '::1', '1489373788', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('574', '::1', '1489373820', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('575', '::1', '1489373825', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('576', '::1', '1489373827', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('577', '::1', '1489373842', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('578', '::1', '1489374001', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('579', '::1', '1489374049', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('580', '::1', '1489374054', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('581', '::1', '1489374057', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('582', '::1', '1489374173', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('583', '::1', '1489374177', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('584', '::1', '1489374204', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('585', '::1', '1489374209', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('586', '::1', '1489374399', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('587', '::1', '1489374426', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('588', '::1', '1489374449', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('589', '::1', '1489374458', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('590', '::1', '1489374503', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('591', '::1', '1489374537', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('592', '::1', '1489374548', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('593', '::1', '1489374878', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('594', '::1', '1489374922', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('595', '::1', '1489374938', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('596', '::1', '1489374991', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('597', '::1', '1489376193', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('598', '::1', '1489376242', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('599', '::1', '1489376287', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('600', '::1', '1489376392', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('601', '::1', '1489376395', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('602', '::1', '1489376398', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('603', '::1', '1489376808', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('604', '::1', '1489376833', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('605', '::1', '1489377457', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('606', '::1', '1489377757', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('607', '::1', '1489377789', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('608', '::1', '1489377792', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('609', '::1', '1489377798', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('610', '::1', '1489377805', '欢歌', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('611', '::1', '1489377811', '欢歌', 'home/User/buyOneHandle');
INSERT INTO `shopp_count` VALUES ('612', '::1', '1489377812', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('613', '::1', '1489377822', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('614', '::1', '1489377832', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('615', '::1', '1489377863', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('616', '::1', '1489377878', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('617', '::1', '1489377912', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('618', '::1', '1489384868', 'test3', 'home');
INSERT INTO `shopp_count` VALUES ('619', '::1', '1489384888', 'test3', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('620', '::1', '1489384895', 'test3', 'home/User/buyOneHandle');
INSERT INTO `shopp_count` VALUES ('621', '::1', '1489384896', 'test3', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('622', '::1', '1489384905', 'test3', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('623', '::1', '1489384910', 'test3', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('624', '::1', '1489384970', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('625', '::1', '1489384993', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('626', '::1', '1489384996', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('627', '::1', '1489385002', 'test3', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('628', '::1', '1489385005', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('629', '::1', '1489385020', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('630', '::1', '1489385037', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('631', '::1', '1489385039', '欢歌', 'admin/Commodity/commodityDetailed');
INSERT INTO `shopp_count` VALUES ('632', '::1', '1489385091', '欢歌', 'admin/Type/index');
INSERT INTO `shopp_count` VALUES ('633', '::1', '1489385097', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('634', '::1', '1489385103', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('635', '::1', '1489385108', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('636', '::1', '1489385113', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('637', '::1', '1489385154', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('638', '::1', '1489385168', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('639', '::1', '1489385189', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('640', '::1', '1489385213', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('641', '::1', '1489385233', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('642', '::1', '1489385236', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('643', '::1', '1489385286', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('644', '::1', '1489385303', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('645', '::1', '1489385309', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('646', '::1', '1489385393', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('647', '::1', '1489385456', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('648', '::1', '1489385491', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('649', '::1', '1489385504', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('650', '::1', '1489385520', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('651', '::1', '1489385674', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('652', '::1', '1489385707', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('653', '::1', '1489385721', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('654', '::1', '1489385732', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('655', '::1', '1489385774', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('656', '::1', '1489385779', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('657', '::1', '1489385803', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('658', '::1', '1489385988', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('659', '::1', '1489386039', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('660', '::1', '1489386057', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('661', '::1', '1489386061', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('662', '::1', '1489386064', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('663', '::1', '1489386068', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('664', '::1', '1489386071', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('665', '::1', '1489386075', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('666', '::1', '1489386083', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('667', '::1', '1489386376', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('668', '::1', '1489386507', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('669', '::1', '1489386524', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('670', '::1', '1489386555', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('671', '::1', '1489386594', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('672', '::1', '1489386608', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('673', '::1', '1489386635', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('674', '::1', '1489386656', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('675', '::1', '1489386661', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('676', '::1', '1489386672', 'test3', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('677', '::1', '1489386679', 'test3', 'home/User/placeOrdersHandle');
INSERT INTO `shopp_count` VALUES ('678', '::1', '1489386680', 'test3', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('679', '::1', '1489386684', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('680', '::1', '1489386686', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('681', '::1', '1489386693', 'test3', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('682', '::1', '1489386702', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('683', '::1', '1489386706', 'test3', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('684', '::1', '1489387635', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('685', '::1', '1489387645', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('686', '::1', '1489387651', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('687', '::1', '1489387741', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('688', '::1', '1489387746', 'test3', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('689', '::1', '1489387824', 'test3', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('690', '::1', '1489387855', 'test3', 'home');
INSERT INTO `shopp_count` VALUES ('691', '::1', '1489387876', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('692', '::1', '1489387878', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('693', '::1', '1489387888', 'test3', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('694', '::1', '1489387895', 'test3', 'home/User/placeOrdersHandle');
INSERT INTO `shopp_count` VALUES ('695', '::1', '1489387913', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('696', '::1', '1489387917', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('697', '::1', '1489388103', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('698', '::1', '1489388144', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('699', '::1', '1489388148', 'test3', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('700', '::1', '1489388150', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('701', '::1', '1489388157', 'test3', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('702', '::1', '1489388160', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('703', '::1', '1489388166', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('704', '::1', '1489388170', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('705', '::1', '1489388421', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('706', '::1', '1489388424', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('707', '::1', '1489388476', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('708', '::1', '1489388893', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('709', '::1', '1489388914', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('710', '::1', '1489388955', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('711', '::1', '1489388981', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('712', '::1', '1489389242', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('713', '::1', '1489389245', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('714', '::1', '1489389281', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('715', '::1', '1489389287', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('716', '::1', '1489389300', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('717', '::1', '1489389336', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('718', '::1', '1489389339', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('719', '::1', '1489389342', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('720', '::1', '1489389348', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('721', '::1', '1489389351', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('722', '::1', '1489389352', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('723', '::1', '1489389354', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('724', '::1', '1489389360', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('725', '::1', '1489389365', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('726', '::1', '1489389369', 'test3', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('727', '::1', '1489389374', 'test3', 'home/User/placeOrdersHandle');
INSERT INTO `shopp_count` VALUES ('728', '::1', '1489389389', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('729', '::1', '1489389392', 'test3', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('730', '::1', '1489389509', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('731', '::1', '1489389624', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('732', '::1', '1489389638', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('733', '::1', '1489389687', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('734', '::1', '1489389733', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('735', '::1', '1489389746', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('736', '::1', '1489389748', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('737', '::1', '1489389766', 'test3', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('738', '::1', '1489389770', 'test3', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('739', '::1', '1489389775', 'test3', 'home/User/placeOrdersHandle');
INSERT INTO `shopp_count` VALUES ('740', '::1', '1489389776', 'test3', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('741', '::1', '1489389786', 'test3', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('742', '::1', '1489389789', 'test3', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('743', '::1', '1489389799', 'test3', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('744', '::1', '1489389881', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('745', '::1', '1489390063', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('746', '::1', '1489390068', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('747', '::1', '1489390409', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('748', '::1', '1489390584', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('749', '::1', '1489390652', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('750', '::1', '1489391003', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('751', '::1', '1489391072', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('752', '::1', '1489392442', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('753', '::1', '1489392906', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('754', '::1', '1489392955', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('755', '::1', '1489393412', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('756', '::1', '1489393452', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('757', '::1', '1489393493', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('758', '::1', '1489393675', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('759', '::1', '1489393689', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('760', '::1', '1489393733', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('761', '::1', '1489393972', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('762', '::1', '1489394051', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('763', '::1', '1489394072', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('764', '::1', '1489394105', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('765', '::1', '1489394334', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('766', '::1', '1489396633', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('767', '::1', '1489396653', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('768', '::1', '1489396955', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('769', '::1', '1489397334', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('770', '::1', '1489397462', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('771', '::1', '1489397498', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('772', '::1', '1489397649', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('773', '::1', '1489398200', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('774', '::1', '1489398639', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('775', '::1', '1489400139', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('776', '::1', '1489400290', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('777', '::1', '1489452357', '', 'home');
INSERT INTO `shopp_count` VALUES ('778', '::1', '1489452375', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('779', '::1', '1489452381', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('780', '::1', '1489452402', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('781', '::1', '1489452405', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('782', '::1', '1489452410', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('783', '::1', '1489452414', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('784', '::1', '1489452416', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('785', '::1', '1489452426', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('786', '::1', '1489454223', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('787', '::1', '1489454343', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('788', '::1', '1489455710', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('789', '::1', '1489455714', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('790', '::1', '1489455720', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('791', '::1', '1489455740', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('792', '::1', '1489455750', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('793', '::1', '1489455753', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('794', '::1', '1489455758', '欢歌', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('795', '::1', '1489455764', '欢歌', 'home/User/placeOrdersHandle');
INSERT INTO `shopp_count` VALUES ('796', '::1', '1489455765', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('797', '::1', '1489455773', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('798', '::1', '1489455815', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('799', '::1', '1489455825', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('800', '::1', '1489455983', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('801', '::1', '1489456080', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('802', '::1', '1489456083', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('803', '::1', '1489456087', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('804', '::1', '1489456152', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('805', '::1', '1489456280', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('806', '::1', '1489456719', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('807', '::1', '1489456723', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('808', '::1', '1489456796', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('809', '::1', '1489456978', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('810', '::1', '1489457000', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('811', '::1', '1489457019', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('812', '::1', '1489457077', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('813', '::1', '1489457080', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('814', '::1', '1489457090', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('815', '::1', '1489457093', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('816', '::1', '1489457095', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('817', '::1', '1489457208', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('818', '::1', '1489457259', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('819', '::1', '1489457268', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('820', '::1', '1489457281', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('821', '::1', '1489457288', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('822', '::1', '1489457297', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('823', '::1', '1489457303', '欢歌', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('824', '::1', '1489457316', '欢歌', 'home/User/placeOrdersHandle');
INSERT INTO `shopp_count` VALUES ('825', '::1', '1489457317', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('826', '::1', '1489457331', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('827', '::1', '1489457339', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('828', '::1', '1489457341', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('829', '::1', '1489458862', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('830', '::1', '1489458935', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('831', '::1', '1489459194', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('832', '::1', '1489459197', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('833', '::1', '1489459234', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('834', '::1', '1489459237', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('835', '::1', '1489459257', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('836', '::1', '1489459288', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('837', '::1', '1489459292', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('838', '::1', '1489459296', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('839', '::1', '1489459314', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('840', '::1', '1489459342', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('841', '::1', '1489459346', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('842', '::1', '1489459349', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('843', '::1', '1489459443', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('844', '::1', '1489459446', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('845', '::1', '1489459448', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('846', '::1', '1489459545', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('847', '::1', '1489459548', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('848', '::1', '1489459551', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('849', '::1', '1489459590', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('850', '::1', '1489459593', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('851', '::1', '1489459654', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('852', '::1', '1489459657', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('853', '::1', '1489459710', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('854', '::1', '1489459728', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('855', '::1', '1489459743', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('856', '::1', '1489459780', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('857', '::1', '1489459795', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('858', '::1', '1489459866', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('859', '::1', '1489459944', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('860', '::1', '1489459953', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('861', '::1', '1489460000', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('862', '::1', '1489460205', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('863', '::1', '1489460207', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('864', '::1', '1489460217', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('865', '::1', '1489460242', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('866', '::1', '1489460256', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('867', '::1', '1489460632', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('868', '::1', '1489460673', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('869', '::1', '1489460814', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('870', '::1', '1489460918', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('871', '::1', '1489460943', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('872', '::1', '1489460970', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('873', '::1', '1489460984', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('874', '::1', '1489460988', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('875', '::1', '1489461009', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('876', '::1', '1489461144', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('877', '::1', '1489461149', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('878', '::1', '1489462674', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('879', '::1', '1489462845', '欢歌', 'admin/Order/editOrderDeleteHandle');
INSERT INTO `shopp_count` VALUES ('880', '::1', '1489463131', '欢歌', 'admin/Order/editOrderDeleteHandle');
INSERT INTO `shopp_count` VALUES ('881', '::1', '1489463356', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('882', '::1', '1489463361', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('883', '::1', '1489463366', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('884', '::1', '1489463373', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('885', '::1', '1489464156', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('886', '::1', '1489464186', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('887', '::1', '1489464236', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('888', '::1', '1489464295', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('889', '::1', '1489464301', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('890', '::1', '1489464319', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('891', '::1', '1489464322', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('892', '::1', '1489471315', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('893', '::1', '1489471335', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('894', '::1', '1489471378', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('895', '::1', '1489471385', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('896', '::1', '1489471391', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('897', '::1', '1489471395', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('898', '::1', '1489471399', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('899', '::1', '1489471407', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('900', '::1', '1489471508', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('901', '::1', '1489471599', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('902', '::1', '1489471845', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('903', '::1', '1489472133', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('904', '::1', '1489472435', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('905', '::1', '1489472473', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('906', '::1', '1489472579', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('907', '::1', '1489472690', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('908', '::1', '1489472888', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('909', '::1', '1489472972', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('910', '::1', '1489473038', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('911', '::1', '1489473530', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('912', '::1', '1489473706', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('913', '::1', '1489473856', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('914', '::1', '1489474000', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('915', '::1', '1489474045', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('916', '::1', '1489474240', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('917', '::1', '1489474347', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('918', '::1', '1489474508', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('919', '::1', '1489474626', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('920', '::1', '1489474850', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('921', '::1', '1489474959', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('922', '::1', '1489475119', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('923', '::1', '1489475303', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('924', '::1', '1489475334', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('925', '::1', '1489475375', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('926', '::1', '1489475438', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('927', '::1', '1489475496', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('928', '::1', '1489475576', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('929', '::1', '1489475690', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('930', '::1', '1489475810', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('931', '::1', '1489475870', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('932', '::1', '1489475893', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('933', '::1', '1489475901', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('934', '::1', '1489475934', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('935', '::1', '1489475984', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('936', '::1', '1489476107', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('937', '::1', '1489476132', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('938', '::1', '1489476165', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('939', '::1', '1489476215', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('940', '::1', '1489476450', '', 'home');
INSERT INTO `shopp_count` VALUES ('941', '::1', '1489476484', '', 'home');
INSERT INTO `shopp_count` VALUES ('942', '::1', '1489476497', '', 'home');
INSERT INTO `shopp_count` VALUES ('943', '::1', '1489476513', '', 'home');
INSERT INTO `shopp_count` VALUES ('944', '::1', '1489476538', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('945', '::1', '1489476693', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('946', '::1', '1489476844', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('947', '::1', '1489476874', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('948', '::1', '1489476884', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('949', '::1', '1489476984', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('950', '::1', '1489477844', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('951', '::1', '1489477873', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('952', '::1', '1489477962', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('953', '::1', '1489478289', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('954', '::1', '1489478357', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('955', '::1', '1489478450', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('956', '::1', '1489478484', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('957', '::1', '1489478543', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('958', '::1', '1489478721', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('959', '::1', '1489478771', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('960', '::1', '1489478783', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('961', '::1', '1489478812', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('962', '::1', '1489478822', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('963', '::1', '1489478946', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('964', '::1', '1489478968', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('965', '::1', '1489478977', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('966', '::1', '1489478988', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('967', '::1', '1489479003', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('968', '::1', '1489479016', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('969', '::1', '1489479023', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('970', '::1', '1489479062', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('971', '::1', '1489479076', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('972', '::1', '1489479173', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('973', '::1', '1489479358', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('974', '::1', '1489479416', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('975', '::1', '1489479533', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('976', '::1', '1489479697', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('977', '::1', '1489479731', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('978', '::1', '1489479746', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('979', '::1', '1489479961', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('980', '::1', '1489480199', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('981', '::1', '1489480252', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('982', '::1', '1489480291', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('983', '::1', '1489480304', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('984', '::1', '1489480324', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('985', '::1', '1489480334', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('986', '::1', '1489480342', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('987', '::1', '1489480509', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('988', '::1', '1489480697', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('989', '::1', '1489480719', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('990', '::1', '1489480815', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('991', '::1', '1489480830', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('992', '::1', '1489480834', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('993', '::1', '1489480836', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('994', '::1', '1489480903', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('995', '::1', '1489480910', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('996', '::1', '1489480922', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('997', '::1', '1489480973', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('998', '::1', '1489480976', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('999', '::1', '1489480990', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1000', '::1', '1489480993', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1001', '::1', '1489480995', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('1002', '::1', '1489481038', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1003', '::1', '1489481042', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1004', '::1', '1489481048', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1005', '::1', '1489481059', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1006', '::1', '1489481088', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1007', '::1', '1489481155', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1008', '::1', '1489481158', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1009', '::1', '1489481180', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1010', '::1', '1489481212', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1011', '::1', '1489481238', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1012', '::1', '1489481240', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1013', '::1', '1489481242', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('1014', '::1', '1489481257', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1015', '::1', '1489481368', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1016', '::1', '1489481372', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('1017', '::1', '1489481375', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1018', '::1', '1489481395', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1019', '::1', '1489481507', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1020', '::1', '1489481672', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1021', '::1', '1489482432', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1022', '::1', '1489482849', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1023', '::1', '1489482896', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1024', '::1', '1489482944', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1025', '::1', '1489483187', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1026', '::1', '1489483210', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1027', '::1', '1489483221', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1028', '::1', '1489483222', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1029', '::1', '1489483237', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1030', '::1', '1489483241', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1031', '::1', '1489483635', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1032', '::1', '1489483650', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1033', '::1', '1489485486', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1034', '::1', '1489485511', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1035', '::1', '1489485532', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1036', '::1', '1489485534', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1037', '::1', '1489485566', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1038', '::1', '1489485592', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1039', '::1', '1489485733', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1040', '::1', '1489485737', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1041', '::1', '1489485754', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1042', '::1', '1489485758', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1043', '::1', '1489485761', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1044', '::1', '1489485763', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1045', '::1', '1489485803', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1046', '::1', '1489485817', '欢歌', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('1047', '::1', '1489485822', '欢歌', 'home/User/buyOneHandle');
INSERT INTO `shopp_count` VALUES ('1048', '::1', '1489485823', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1049', '::1', '1489485866', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1050', '::1', '1489485870', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1051', '::1', '1489485880', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1052', '::1', '1489485889', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1053', '::1', '1489485937', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('1054', '::1', '1489486002', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1055', '::1', '1489486005', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1056', '::1', '1489538943', '', 'home');
INSERT INTO `shopp_count` VALUES ('1057', '::1', '1489539007', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1058', '::1', '1489539015', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1059', '::1', '1489539567', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1060', '::1', '1489539571', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1061', '::1', '1489539600', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1062', '::1', '1489539611', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1063', '::1', '1489539622', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1064', '::1', '1489539647', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1065', '::1', '1489539650', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1066', '::1', '1489539656', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1067', '::1', '1489539658', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1068', '::1', '1489539720', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1069', '::1', '1489539724', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1070', '::1', '1489539792', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1071', '::1', '1489539798', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1072', '::1', '1489540179', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1073', '::1', '1489540208', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1074', '::1', '1489540218', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1075', '::1', '1489540338', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1076', '::1', '1489540419', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1077', '::1', '1489540420', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1078', '::1', '1489540422', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1079', '::1', '1489540424', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1080', '::1', '1489540425', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1081', '::1', '1489540427', '欢歌', 'admin/Type/index');
INSERT INTO `shopp_count` VALUES ('1082', '::1', '1489540506', '欢歌', 'admin/Type/add');
INSERT INTO `shopp_count` VALUES ('1083', '::1', '1489540512', '欢歌', 'admin/Type/index');
INSERT INTO `shopp_count` VALUES ('1084', '::1', '1489540516', '欢歌', 'admin/Type/index');
INSERT INTO `shopp_count` VALUES ('1085', '::1', '1489540547', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1086', '::1', '1489540561', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1087', '::1', '1489540568', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1088', '::1', '1489540745', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1089', '::1', '1489540750', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1090', '::1', '1489540770', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1091', '::1', '1489540775', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1092', '::1', '1489540779', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1093', '::1', '1489540823', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1094', '::1', '1489541272', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1095', '::1', '1489541308', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1096', '::1', '1489543365', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1097', '::1', '1489544910', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1098', '::1', '1489544947', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1099', '::1', '1489544977', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1100', '::1', '1489545158', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1101', '::1', '1489545185', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1102', '::1', '1489545188', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1103', '::1', '1489545208', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1104', '::1', '1489545210', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1105', '::1', '1489545215', '欢歌', 'home/User/placeOrder');
INSERT INTO `shopp_count` VALUES ('1106', '::1', '1489545221', '欢歌', 'home/User/placeOrdersHandle');
INSERT INTO `shopp_count` VALUES ('1107', '::1', '1489545222', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1108', '::1', '1489545244', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1109', '::1', '1489545261', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1110', '::1', '1489545274', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1111', '::1', '1489545311', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1112', '::1', '1489545319', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1113', '::1', '1489545341', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1114', '::1', '1489545401', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1115', '::1', '1489545410', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1116', '::1', '1489545423', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1117', '::1', '1489545428', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1118', '::1', '1489545434', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1119', '::1', '1489545438', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('1120', '::1', '1489545454', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1121', '::1', '1489545457', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1122', '::1', '1489545461', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1123', '::1', '1489545466', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1124', '::1', '1489545476', '欢歌', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1125', '::1', '1489545481', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1126', '::1', '1489546709', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1127', '::1', '1489546712', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1128', '::1', '1489546847', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1129', '::1', '1489546979', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1130', '::1', '1489547274', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1131', '::1', '1489547296', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1132', '::1', '1489547495', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1133', '::1', '1489547528', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1134', '::1', '1489547713', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1135', '::1', '1489547827', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1136', '::1', '1489547837', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1137', '::1', '1489547877', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1138', '::1', '1489547985', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1139', '::1', '1489549125', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1140', '::1', '1489549133', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1141', '::1', '1489549139', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1142', '::1', '1489549165', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1143', '::1', '1489549174', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1144', '::1', '1489549188', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1145', '::1', '1489549238', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1146', '::1', '1489549244', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1147', '::1', '1489549266', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1148', '::1', '1489549382', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1149', '::1', '1489549482', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1150', '::1', '1489549534', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1151', '::1', '1489549558', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1152', '::1', '1489549621', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1153', '::1', '1489549626', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1154', '::1', '1489549642', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1155', '::1', '1489549657', '欢歌', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('1156', '::1', '1489549662', '欢歌', 'home/User/buyOneHandle');
INSERT INTO `shopp_count` VALUES ('1157', '::1', '1489549663', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1158', '::1', '1489549673', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1159', '::1', '1489549676', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1160', '::1', '1489549687', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1161', '::1', '1489549692', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1162', '::1', '1489549738', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1163', '::1', '1489549744', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1164', '::1', '1489549777', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1165', '::1', '1489549784', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1166', '::1', '1489549788', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1167', '::1', '1489549791', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1168', '::1', '1489549796', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1169', '::1', '1489549835', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1170', '::1', '1489549868', '欢歌', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1171', '::1', '1489549872', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1172', '::1', '1489549878', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1173', '::1', '1489550058', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1174', '::1', '1489550069', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('1175', '::1', '1489550108', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1176', '::1', '1489560715', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1177', '::1', '1489560771', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1178', '::1', '1489560774', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1179', '::1', '1489560777', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('1180', '::1', '1489650203', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1181', '::1', '1489650206', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1182', '::1', '1489650212', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1183', '::1', '1489659031', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1184', '::1', '1489659040', '欢歌', 'admin/Index/testUUID');
INSERT INTO `shopp_count` VALUES ('1185', '::1', '1489659249', '欢歌', 'admin/Index/test');
INSERT INTO `shopp_count` VALUES ('1186', '::1', '1489979426', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1187', '::1', '1489979430', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1188', '::1', '1489979756', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1189', '::1', '1489979757', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1190', '::1', '1489979758', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1191', '::1', '1489979759', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1192', '::1', '1489982181', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1193', '::1', '1490001586', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1194', '::1', '1490001650', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1195', '::1', '1490001662', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1196', '::1', '1490001669', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1197', '::1', '1490001680', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1198', '::1', '1490001686', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1199', '::1', '1490001732', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1200', '::1', '1490001763', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1201', '::1', '1490001783', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1202', '::1', '1490001819', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1203', '::1', '1490001928', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1204', '::1', '1490002221', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1205', '::1', '1490002237', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1206', '::1', '1490002262', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1207', '::1', '1490002323', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1208', '::1', '1490002695', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1209', '::1', '1490002773', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1210', '::1', '1490002837', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1211', '::1', '1490002950', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1212', '::1', '1490003008', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1213', '::1', '1490003048', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1214', '::1', '1490003608', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1215', '::1', '1490003627', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1216', '::1', '1490003967', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1217', '::1', '1490003986', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1218', '::1', '1490004513', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1219', '::1', '1490004689', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1220', '::1', '1490004690', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1221', '::1', '1490004691', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1222', '::1', '1490004692', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1223', '::1', '1490004730', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1224', '::1', '1490004846', '欢歌', 'admin/Index/testUUID');
INSERT INTO `shopp_count` VALUES ('1225', '::1', '1490057433', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1226', '::1', '1490057456', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1227', '::1', '1490057530', '欢歌', 'admin/Order/sendGoods');
INSERT INTO `shopp_count` VALUES ('1228', '::1', '1490057532', '欢歌', 'admin/Order/refunds');
INSERT INTO `shopp_count` VALUES ('1229', '::1', '1490057574', '欢歌', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1230', '::1', '1490058003', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1231', '::1', '1490058005', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1232', '::1', '1490058215', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1233', '::1', '1490058240', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1234', '::1', '1490058264', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1235', '::1', '1490058331', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1236', '::1', '1490058581', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1237', '::1', '1490059162', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1238', '::1', '1490059299', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1239', '::1', '1490060067', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1240', '::1', '1490060090', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1241', '::1', '1490060129', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1242', '::1', '1490060132', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1243', '::1', '1490060184', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1244', '::1', '1490060232', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1245', '::1', '1490060240', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1246', '::1', '1490060264', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1247', '::1', '1490060274', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1248', '::1', '1490060297', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1249', '::1', '1490060301', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1250', '::1', '1490060323', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1251', '::1', '1490060327', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1252', '::1', '1490060375', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1253', '::1', '1490060382', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1254', '::1', '1490060443', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1255', '::1', '1490060519', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1256', '::1', '1490060538', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1257', '::1', '1490060544', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1258', '::1', '1490060550', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1259', '::1', '1490060570', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1260', '::1', '1490060576', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1261', '::1', '1490060581', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1262', '::1', '1490060586', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1263', '::1', '1490060600', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1264', '::1', '1490060604', '欢歌', 'admin/Commodity/editCommodity');
INSERT INTO `shopp_count` VALUES ('1265', '::1', '1490060954', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1266', '::1', '1490061184', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1267', '::1', '1490061185', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1268', '::1', '1490061186', '欢歌', 'admin/Commodity/uploadImage');
INSERT INTO `shopp_count` VALUES ('1269', '::1', '1490062353', '欢歌', 'admin/Commodity/addCommodity');
INSERT INTO `shopp_count` VALUES ('1270', '::1', '1490062367', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1271', '::1', '1490249104', '', 'home');
INSERT INTO `shopp_count` VALUES ('1272', '::1', '1490324328', '', 'home');
INSERT INTO `shopp_count` VALUES ('1273', '::1', '1490324349', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1274', '::1', '1490324354', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1275', '::1', '1490324357', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1276', '::1', '1490324363', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1277', '::1', '1490324383', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1278', '::1', '1490326674', '', 'home');
INSERT INTO `shopp_count` VALUES ('1279', '::1', '1490326678', '', 'home');
INSERT INTO `shopp_count` VALUES ('1280', '::1', '1490326830', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1281', '::1', '1490326833', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1282', '::1', '1490326834', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1283', '::1', '1490582085', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1284', '::1', '1490582089', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1285', '::1', '1490759789', '', 'home');
INSERT INTO `shopp_count` VALUES ('1286', '::1', '1490759804', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1287', '::1', '1490759808', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1288', '::1', '1490759811', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1289', '::1', '1490759866', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1290', '::1', '1490760603', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1291', '::1', '1490761220', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1292', '::1', '1490761291', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1293', '::1', '1490761348', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1294', '::1', '1490761424', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1295', '::1', '1490761500', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1296', '::1', '1490761815', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1297', '::1', '1490761844', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1298', '::1', '1490761941', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1299', '::1', '1490762090', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1300', '::1', '1490762565', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1301', '::1', '1490765315', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1302', '::1', '1490765519', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1303', '::1', '1490765544', '欢歌', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1304', '::1', '1490851772', '', 'home');
INSERT INTO `shopp_count` VALUES ('1305', '::1', '1490851791', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1306', '::1', '1490851794', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1307', '::1', '1490851798', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('1308', '::1', '1490856644', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1309', '::1', '1490857053', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1310', '::1', '1490860769', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1311', '::1', '1490861316', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1312', '::1', '1490861402', '欢歌', 'home/User/userMessage');
INSERT INTO `shopp_count` VALUES ('1313', '::1', '1490880022', '欢歌', 'home/User/logOut');
INSERT INTO `shopp_count` VALUES ('1314', '::1', '1490880023', '', 'home');
INSERT INTO `shopp_count` VALUES ('1315', '::1', '1490880048', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1316', '::1', '1490927599', '', 'home');
INSERT INTO `shopp_count` VALUES ('1317', '::1', '1490927613', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1318', '::1', '1490927616', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1319', '::1', '1490927619', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1320', '::1', '1490927635', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1321', '::1', '1490927805', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1322', '::1', '1490927809', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1323', '::1', '1490927846', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1324', '::1', '1490927874', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1325', '::1', '1490927977', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1326', '::1', '1490931116', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1327', '::1', '1490931486', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1328', '::1', '1490932022', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1329', '::1', '1490932047', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1330', '::1', '1490932052', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1331', '::1', '1490971925', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1332', '::1', '1490971929', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1333', '::1', '1490971934', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1334', '::1', '1490971936', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1335', '::1', '1490971957', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1336', '::1', '1490971959', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1337', '::1', '1490972014', '欢歌', 'home/User/showCart');
INSERT INTO `shopp_count` VALUES ('1338', '::1', '1491013036', '', 'home');
INSERT INTO `shopp_count` VALUES ('1339', '::1', '1491013050', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1340', '::1', '1491013084', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1341', '::1', '1491114051', '', 'home');
INSERT INTO `shopp_count` VALUES ('1342', '::1', '1491114065', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1343', '::1', '1491114068', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1344', '::1', '1491114071', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1345', '::1', '1491114076', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1346', '::1', '1491114086', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1347', '::1', '1491114107', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('1348', '::1', '1491114220', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1349', '::1', '1491114224', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1350', '::1', '1491115920', '欢歌', 'home/User/logOut');
INSERT INTO `shopp_count` VALUES ('1351', '::1', '1491115921', '', 'home');
INSERT INTO `shopp_count` VALUES ('1352', '::1', '1491115937', 'admin', 'home');
INSERT INTO `shopp_count` VALUES ('1353', '::1', '1491115940', 'admin', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1354', '::1', '1491115944', 'admin', 'home');
INSERT INTO `shopp_count` VALUES ('1355', '::1', '1491115953', 'admin', 'home/User/buyOne');
INSERT INTO `shopp_count` VALUES ('1356', '::1', '1491115959', 'admin', 'home/User/buyOneHandle');
INSERT INTO `shopp_count` VALUES ('1357', '::1', '1491115960', 'admin', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1358', '::1', '1491115970', 'admin', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1359', '::1', '1491115976', 'admin', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('1360', '::1', '1491116277', 'admin', 'home');
INSERT INTO `shopp_count` VALUES ('1361', '::1', '1491149660', 'admin', 'home/User/logOut');
INSERT INTO `shopp_count` VALUES ('1362', '::1', '1491149662', '', 'home');
INSERT INTO `shopp_count` VALUES ('1363', '::1', '1491149678', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1364', '::1', '1491149682', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1365', '::1', '1491149685', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1366', '::1', '1491149690', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1367', '::1', '1491149901', '欢歌', 'home/User/doPay');
INSERT INTO `shopp_count` VALUES ('1368', '::1', '1491149908', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1369', '::1', '1491149911', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1370', '::1', '1491149924', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1371', '::1', '1491152724', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1372', '::1', '1491152733', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1373', '::1', '1491152736', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1374', '::1', '1491152742', '欢歌', 'home/User/comment');
INSERT INTO `shopp_count` VALUES ('1375', '::1', '1491152796', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1376', '::1', '1491152800', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1377', '::1', '1491152803', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1378', '::1', '1491152809', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_count` VALUES ('1379', '::1', '1491152839', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1380', '::1', '1491152842', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1381', '::1', '1491152846', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1382', '::1', '1491162002', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1383', '::1', '1491162006', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1384', '::1', '1491162022', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1385', '::1', '1491162084', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1386', '::1', '1491162966', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1387', '::1', '1491162973', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1388', '::1', '1491162989', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1389', '::1', '1491162993', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1390', '::1', '1491162996', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1391', '::1', '1491162999', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1392', '::1', '1491168148', 'admin', 'admin/Commodity/index');
INSERT INTO `shopp_count` VALUES ('1393', '::1', '1491168152', 'admin', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1394', '::1', '1491168165', 'admin', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1395', '::1', '1491168173', 'admin', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1396', '::1', '1491168199', 'admin', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1397', '::1', '1491168292', 'admin', 'admin/Order/editOrder');
INSERT INTO `shopp_count` VALUES ('1398', '::1', '1491168300', 'admin', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1399', '::1', '1491168309', 'admin', 'admin/Order/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1400', '::1', '1491168315', 'admin', 'admin/Order/orderIndex');
INSERT INTO `shopp_count` VALUES ('1401', '::1', '1491206236', '', 'home');
INSERT INTO `shopp_count` VALUES ('1402', '::1', '1491206252', '欢歌', 'home');
INSERT INTO `shopp_count` VALUES ('1403', '::1', '1491206255', '欢歌', 'home/User/userHome');
INSERT INTO `shopp_count` VALUES ('1404', '::1', '1491206259', '欢歌', 'home/User/userOrders');
INSERT INTO `shopp_count` VALUES ('1405', '::1', '1491206266', '欢歌', 'home/User/orderDetailed');
INSERT INTO `shopp_count` VALUES ('1406', '::1', '1491206270', '欢歌', 'home/User/refunds');
INSERT INTO `shopp_order` VALUES ('4BF65475-29BE-B373-D591-B823D1F897C6', '8', 'AA692D26-B786-D8A0-1420-F8F33264485C', '1491167181', '1491167181', '1491167194', '', 'B1A6D755-B3FA-40BD-6500-0BB14CF4A303');
INSERT INTO `shopp_order` VALUES ('5F3E8B10-9CC9-CAA0-BA24-D7057450511A', '5', 'AA692D26-B786-D8A0-1420-F8F33264485C', '1490949600', '1490949600', '1491149907', '1491162021', 'B1A6D755-B3FA-40BD-6500-0BB14CF4A303');
INSERT INTO `shopp_order` VALUES ('8D4443B2-DB6D-57C8-0255-BCEA8A4AE08B', '7', 'AA692D26-B786-D8A0-1420-F8F33264485C', '1491166422', '1491166422', '1491167021', '', 'B1A6D755-B3FA-40BD-6500-0BB14CF4A303');
INSERT INTO `shopp_order` VALUES ('9C37472C-EAAD-6298-5335-F08AA95EE596', '1', 'AA692D26-B786-D8A0-1420-F8F33264485C', '1490971996', '1490971996', '1491114085', '', 'B1A6D755-B3FA-40BD-6500-0BB14CF4A303');
INSERT INTO `shopp_order` VALUES ('D4C47261-28F9-601F-A516-F3270C883468', '1', '5D754767-F3D5-1D93-E588-856B288B08CC', '1491115959', '1491115959', '1491115969', '', '051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9');
INSERT INTO `shopp_order_specification` VALUES ('03786C5F-78D8-4FE8-A16E-352B1E25235C', '9C37472C-EAAD-6298-5335-F08AA95EE596', '9F2AA23F-FD6B-CC49-55F8-EF5F403D4296', '1', '8999', '6G运存+128G内存玫瑰金');
INSERT INTO `shopp_order_specification` VALUES ('0E39D87F-3F45-1109-455B-3C4121FC5F66', '9C37472C-EAAD-6298-5335-F08AA95EE596', '2E0E5BC1-3A74-DC36-42D0-20F59E7E4924', '1', '1709', '套餐一');
INSERT INTO `shopp_order_specification` VALUES ('4FB90D08-0AB0-ED76-0855-3EEF33D6899A', '4BF65475-29BE-B373-D591-B823D1F897C6', '9447434E-CF88-2D18-D91C-3D7DFBFEC555', '1', '20', '香辣');
INSERT INTO `shopp_order_specification` VALUES ('62C3637D-91BD-431C-7286-FFE0A4C3FDB4', 'D4C47261-28F9-601F-A516-F3270C883468', '64D63924-E57B-C610-6CEF-4E528BE1D391', '1', '999', '高配2K高清版');
INSERT INTO `shopp_order_specification` VALUES ('A4628B2A-70B5-497D-C2BD-22589791ADD4', '9C37472C-EAAD-6298-5335-F08AA95EE596', '64D63924-E57B-C610-6CEF-4E528BE1D391', '1', '999', '高配2K高清版');
INSERT INTO `shopp_order_specification` VALUES ('B41B5C61-DC65-337E-7173-0C51988DA4EC', '8D4443B2-DB6D-57C8-0255-BCEA8A4AE08B', '9BC0A861-E019-15A1-1C13-BE5780F9F497', '1', '23', '官方');
INSERT INTO `shopp_order_specification` VALUES ('C7CB3930-EDA2-2649-86B5-5682FFCB5F7D', '5F3E8B10-9CC9-CAA0-BA24-D7057450511A', '8F1748AD-30E8-7A09-D78D-7ACAE9E8F711', '2', '23', '第一版');
INSERT INTO `shopp_refunds` VALUES ('DF61BB01-A007-E0B0-4377-5872FCC58549', '9F2AA23F-FD6B-CC49-55F8-EF5F403D4296', '2', '到手的时候有刮痕', '9C37472C-EAAD-6298-5335-F08AA95EE596', '1491152834', '0', 'AA692D26-B786-D8A0-1420-F8F33264485C');
INSERT INTO `shopp_refunds` VALUES ('E9D50F5D-20BE-7044-D185-162761AA3C24', 'C5F9E72E-411D-EBE1-BB9B-C03F32FB9685', '2', '摄像头不好用！运输中刮花了！要求换一个！', '9657C994-4A08-5876-ABD5-E7472867E8DB', '1489485998', '0', 'AA692D26-B786-D8A0-1420-F8F33264485C');
INSERT INTO `shopp_specification` VALUES ('023EDF9B-3ED9-935A-81A1-FA3CC96E169C', '棕色', '4', '300', '179149C6-2255-FAA2-F9F8-CA6608080FAA');
INSERT INTO `shopp_specification` VALUES ('0503FD47-F7B9-53F3-B0E7-3BA8F5D10F05', '西部牛仔', '28', '588', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8');
INSERT INTO `shopp_specification` VALUES ('06E57510-C770-4863-BAAD-BDA23210E8A4', '套餐类型: 官方标配 ', '2780', '8', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654');
INSERT INTO `shopp_specification` VALUES ('0959E8FD-75B4-F041-9820-C0038FDD68DD', '官方标配 :银色', '2800', '200', 'C3E30939-86EB-730F-900E-17B582155781');
INSERT INTO `shopp_specification` VALUES ('0A62F5C5-DD15-C6E0-8F6B-C5662E9F7B73', '综合口味', '18', '14', '89C19CC9-AADE-EF8F-3D2A-FD244AC2C51D');
INSERT INTO `shopp_specification` VALUES ('0D1906BE-F994-5DDE-6269-D6C7890DE379', 'M L XL 2XL', '2999', '200', '511676D4-6E5E-A943-02D2-23838D8A4B2A');
INSERT INTO `shopp_specification` VALUES ('0D6B0C51-712A-6270-08E9-39811DA6A3D1', '350g', '20', '1000', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1');
INSERT INTO `shopp_specification` VALUES ('0DD899E6-6D05-44B9-E873-5F5EC3A8EED4', '美的吸尘器', '366', '32', 'B5037D54-D3D0-F1EE-5939-523BCBF8F2C6');
INSERT INTO `shopp_specification` VALUES ('0E034B9B-648E-48D1-78D6-B0D615B6E06F', '165/84(S)', '90', '90', '26C82144-FCFB-AA3A-150D-2640FFF623F2');
INSERT INTO `shopp_specification` VALUES ('0EF2F6DF-6CAE-7DEE-9507-F4DC2C913AFB', '官方标配 :金色', '2500', '2100', 'C3E30939-86EB-730F-900E-17B582155781');
INSERT INTO `shopp_specification` VALUES ('119CD58F-4126-CF58-BEC2-1567ADB34E05', '1800x2000mm', '2000', '200', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066');
INSERT INTO `shopp_specification` VALUES ('143FDD53-49C8-A58C-CEC6-740FD97D479E', '1件', '179', '200', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC');
INSERT INTO `shopp_specification` VALUES ('1789246F-6560-1F5D-2584-704C0918A719', 'M LS M', '2000', '100', '753C793E-1F5D-1DC7-4103-A23D23E016C2');
INSERT INTO `shopp_specification` VALUES ('1D359FA7-6C41-BB91-95DB-55EAF84BB9E4', '黑色', '2799', '0', 'DBDD6F97-71D8-FF7D-843F-33A2DA965DE1');
INSERT INTO `shopp_specification` VALUES ('1DEB1723-8394-4603-B617-24437A8DB27A', '三好学生', '28', '687', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8');
INSERT INTO `shopp_specification` VALUES ('1FFC4E4C-B777-D0B5-2B79-766B35713043', '官方标配1台', '7000', '2294', '22B10E64-2792-9976-E179-2481FBD15CB5');
INSERT INTO `shopp_specification` VALUES ('209CF837-B514-76ED-4839-BF003468C806', '420L', '250', '5200', 'FF815C07-E3C4-C632-F29C-42FE92C32AF9');
INSERT INTO `shopp_specification` VALUES ('2627F13D-D154-2456-B832-88CB1B3A365E', 'AEJE 5.1家庭影院音响套装', '1988', '166', '241411DE-FEBB-E3B4-4FE8-F73BDE54B32B');
INSERT INTO `shopp_specification` VALUES ('293F5C8B-7ACC-89CF-198F-1087811B8C68', '草莓味120g', '20', '67', 'F51D327E-3EFE-0E64-BA0A-E122DB83F189');
INSERT INTO `shopp_specification` VALUES ('2E0E5BC1-3A74-DC36-42D0-20F59E7E4924', '套餐一', '1709', '15', '4CF00EB1-8CBA-C3D9-F93F-DF01511391BE');
INSERT INTO `shopp_specification` VALUES ('30867603-E36D-DF65-AD11-7D6B790CE0B4', '即热净水吧（一机一芯）', '535', '233', 'BEC94BE7-D1A0-D643-6B2D-2FAA1F68B2FD');
INSERT INTO `shopp_specification` VALUES ('33408E74-4295-6354-1CE4-6E50432676EC', 'S码', '99', '10', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1');
INSERT INTO `shopp_specification` VALUES ('351CB270-9EFB-FF1A-9D2F-E8337A56D3F6', '原味120g', '17', '136', 'F51D327E-3EFE-0E64-BA0A-E122DB83F189');
INSERT INTO `shopp_specification` VALUES ('38BE888F-837B-B57D-E0ED-FB358C7AF49A', '一件', '200', '2000', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7');
INSERT INTO `shopp_specification` VALUES ('3BA5EB3D-0119-1B55-2C0C-402066D4EC65', '组合2100g', '55', '299', '6275F89C-A2A1-8B7B-A259-94926A84C442');
INSERT INTO `shopp_specification` VALUES ('3BE1F4C9-E437-BAD8-9019-423F492CF6B8', '16G/玫瑰金', '2999', '30', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('3C0C3BE6-CEBF-931C-FB6D-2FA4B34B39D8', '第二版', '33', '42', '61F54F17-89B5-A2B6-2A20-353A55A4F6D5');
INSERT INTO `shopp_specification` VALUES ('3C5050DC-8239-FCDF-25A2-1047B0C2CA28', '16G/银色', '2999', '30', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('3C5F6EDD-6979-1DAE-A071-021A3155D3C3', '套餐二', '1809', '10', '4CF00EB1-8CBA-C3D9-F93F-DF01511391BE');
INSERT INTO `shopp_specification` VALUES ('3FC5CCB0-0160-34C4-E181-C419F0070958', '100g', '23', '200', 'F7BC08D4-A15A-0784-3456-04EE6D29C689');
INSERT INTO `shopp_specification` VALUES ('406DEDB1-A1C0-7814-EAA6-8E80EEA2A97E', '绿色', '4', '188', '179149C6-2255-FAA2-F9F8-CA6608080FAA');
INSERT INTO `shopp_specification` VALUES ('4549C0D8-3A4F-A148-4B47-A44DED568182', '180g', '28', '15', 'B7391928-0D76-8E49-8911-CF772446F9C1');
INSERT INTO `shopp_specification` VALUES ('467E4794-E139-9D4C-A001-648467AE4B50', 'M码', '199', '9', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1');
INSERT INTO `shopp_specification` VALUES ('48305973-85B5-63FF-5D12-B503B2C7A7E6', '小款白色', '78', '18', '47D002AB-DFA4-11CF-52FB-398122144EF1');
INSERT INTO `shopp_specification` VALUES ('501BCF11-3BC4-756F-5343-FF22FE148F44', '运动少女', '28', '788', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8');
INSERT INTO `shopp_specification` VALUES ('525BAE0A-4415-3A40-769A-564DBF4F55FB', 'M L XL 2XL', '2999', '200', '900AA834-8BF4-9826-3239-01487EF71BED');
INSERT INTO `shopp_specification` VALUES ('55074F79-EE7B-88F4-529F-EDF88A93E753', '小款红色', '68', '15', '47D002AB-DFA4-11CF-52FB-398122144EF1');
INSERT INTO `shopp_specification` VALUES ('572956AB-6B5B-7610-5CD0-3EB3D559B13F', '03水润 红橙色', '55', '10', '72387161-B237-7FC1-3FB3-E78C23533C5C');
INSERT INTO `shopp_specification` VALUES ('583AD147-7DC7-4E13-A4F2-59ADDF81F1D0', '1件', '20', '200', '37B10231-4225-C269-DB28-F1C40A6CA448');
INSERT INTO `shopp_specification` VALUES ('62D3D37D-0296-399E-2CB3-19C605001768', '200g', '45', '266', 'F7BC08D4-A15A-0784-3456-04EE6D29C689');
INSERT INTO `shopp_specification` VALUES ('64D63924-E57B-C610-6CEF-4E528BE1D391', '高配2K高清版', '999', '7', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('68E71FFA-D7C0-874D-76A2-4A4C4F33D3B9', '金色', '2899', '11', 'DBDD6F97-71D8-FF7D-843F-33A2DA965DE1');
INSERT INTO `shopp_specification` VALUES ('6C584A55-081F-D42C-F5F4-9F6810931FF9', '160抽', '13', '200', 'F396C933-04BC-E46D-012F-AE67F7DD37EE');
INSERT INTO `shopp_specification` VALUES ('6E4D44E5-6E5D-3ECE-C1DA-9D6A3BB1FA56', '200ml', '102', '200', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4');
INSERT INTO `shopp_specification` VALUES ('767B904F-ACB2-7C50-C91A-1C4279AF0935', '10片装', '50', '666', 'AE6D4A9D-7257-836A-2687-8EE3B440594E');
INSERT INTO `shopp_specification` VALUES ('7789A9EC-3B7A-403B-92D6-261B0E135D5D', 'S码；白色', '199', '10', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3');
INSERT INTO `shopp_specification` VALUES ('7897433D-81EB-C106-90CC-BA8A9A1C8DA5', '官方标配', '3000', '2000', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851');
INSERT INTO `shopp_specification` VALUES ('7B55E916-FE4D-F45C-51F5-361534DA9651', '32G/黑色', '3999', '45', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('82DEE154-BF19-E15F-A6DD-02630F4571BE', '官方', '299', '12', '28FDD4CE-5DC6-FC44-58EE-47ABB5B33BCF');
INSERT INTO `shopp_specification` VALUES ('84231135-44F5-BA48-ADBE-4F2377042F68', '600g', '68', '200', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF');
INSERT INTO `shopp_specification` VALUES ('843E945A-620F-292E-F2E8-D5FFF45F76B0', '绿豆沙', '18', '15', '1581855B-4F44-E6F1-8E95-59AD9A5A0C5D');
INSERT INTO `shopp_specification` VALUES ('850BB1F2-58D2-5D4E-9E99-1CA26DB1CD9B', '黑色', '4', '198', '179149C6-2255-FAA2-F9F8-CA6608080FAA');
INSERT INTO `shopp_specification` VALUES ('896FE607-CCC9-A127-D58D-2107ABF157F9', '09水润 砖红色', '55', '40', '72387161-B237-7FC1-3FB3-E78C23533C5C');
INSERT INTO `shopp_specification` VALUES ('8BABF928-1F7F-06CA-4EED-C9719DE65CAC', '白色', '4', '200', '179149C6-2255-FAA2-F9F8-CA6608080FAA');
INSERT INTO `shopp_specification` VALUES ('8DC8D527-3111-C885-E49C-C3FFE4778F78', '组合1050g', '35', '200', '6275F89C-A2A1-8B7B-A259-94926A84C442');
INSERT INTO `shopp_specification` VALUES ('8F1748AD-30E8-7A09-D78D-7ACAE9E8F711', '第一版', '23', '39', '61F54F17-89B5-A2B6-2A20-353A55A4F6D5');
INSERT INTO `shopp_specification` VALUES ('91A69DE8-42FD-AC07-9A96-90139AED13D5', '微辣', '19', '162', '92BAFEFD-CCE6-03EF-60A8-DF9954DDDCA9');
INSERT INTO `shopp_specification` VALUES ('9447434E-CF88-2D18-D91C-3D7DFBFEC555', '香辣', '20', '198', '92BAFEFD-CCE6-03EF-60A8-DF9954DDDCA9');
INSERT INTO `shopp_specification` VALUES ('946EEAB5-63B3-F191-6D30-97E7C7DAFD77', '海盗王子', '28', '566', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8');
INSERT INTO `shopp_specification` VALUES ('95A55D72-A26A-44A6-7146-1C20E2976DEE', '300g', '68', '20', 'B7391928-0D76-8E49-8911-CF772446F9C1');
INSERT INTO `shopp_specification` VALUES ('982053A9-49B6-5D90-754F-4A94B4C67133', '官方标配', '1699', '14', '4CF00EB1-8CBA-C3D9-F93F-DF01511391BE');
INSERT INTO `shopp_specification` VALUES ('9BC0A861-E019-15A1-1C13-BE5780F9F497', '官方', '23', '68', '2D089988-6636-BF15-676F-15A6AED0433F');
INSERT INTO `shopp_specification` VALUES ('9C4A4A94-DBAB-20BB-1D39-FE3EB8CD3810', '巧克力', '15', '13', '1581855B-4F44-E6F1-8E95-59AD9A5A0C5D');
INSERT INTO `shopp_specification` VALUES ('9F2AA23F-FD6B-CC49-55F8-EF5F403D4296', '6G运存+128G内存玫瑰金', '8999', '35', '433DA60D-5065-1301-48B8-76D1BB06CDF0');
INSERT INTO `shopp_specification` VALUES ('A024260D-F1BD-ED7E-2672-990E92B46CEB', 'M码', '356', '200', '6D025479-654E-5D3F-2B6D-ECF783A2D918');
INSERT INTO `shopp_specification` VALUES ('A5240E16-887D-D01F-1779-26E854A18728', '官方标配 :黑色', '2800', '200', 'C3E30939-86EB-730F-900E-17B582155781');
INSERT INTO `shopp_specification` VALUES ('A927A4FD-79FA-7DE2-F15C-2EEDDD0A5EC5', '四件套', '178', '200', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8');
INSERT INTO `shopp_specification` VALUES ('ACF18B6E-E144-8F47-ED60-EB9A447C7A9B', '深棕色', '20', '66', '00D84306-7B0D-F027-28E4-09D70124D2CB');
INSERT INTO `shopp_specification` VALUES ('B0EB8443-EC51-0147-8158-48E572A864AF', '4G运存+64G内存玫瑰金', '5099', '30', '433DA60D-5065-1301-48B8-76D1BB06CDF0');
INSERT INTO `shopp_specification` VALUES ('B3A7547B-21AE-FBA4-EBD0-28C1EE3E416E', 'X9官方标配', '2589', '184', 'B4052C46-F17D-CBD1-4BCF-29DF877B6FA5');
INSERT INTO `shopp_specification` VALUES ('B8F3C770-F934-26BB-5FFE-FA59BF184ACB', 'M码；红色', '299', '10', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3');
INSERT INTO `shopp_specification` VALUES ('BBA63FF3-F72F-3255-2CE8-862C13A1A61B', '16G/金色', '2999', '30', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('BDE33C6F-A44C-ECC3-4585-6B493AD223F3', '白色普通版', '800', '20', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('BE3CB921-D7EF-AFD4-863A-630BDFD766D5', '62g', '19', '1000', '934AE8D8-B061-C383-3FE1-6566C597B7F4');
INSERT INTO `shopp_specification` VALUES ('C5F9E72E-411D-EBE1-BB9B-C03F32FB9685', ' 官方标配:白色', '1400', '199', '8C5CBC3B-C3A0-F078-2DC1-DD276D203A5E');
INSERT INTO `shopp_specification` VALUES ('C6985FDC-DD7A-598F-A9A0-D0BF9FE2695F', '浅棕色', '20', '56', '00D84306-7B0D-F027-28E4-09D70124D2CB');
INSERT INTO `shopp_specification` VALUES ('CDA2C9DC-482C-A22F-4809-514EB6A9F0C9', '绿豆面膜泥', '273', '49', 'B763DD16-2E58-C493-0434-3952FA160C17');
INSERT INTO `shopp_specification` VALUES ('D29F12CC-3CCF-5749-E84F-BD61DAC7E61C', '黑色普通版', '800', '26', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('D536225B-D004-D9FE-B36B-550BFF96CE69', '01水润 复古红', '66', '20', '72387161-B237-7FC1-3FB3-E78C23533C5C');
INSERT INTO `shopp_specification` VALUES ('D71DB000-D9C0-5A60-06C6-8E0941F13120', '500g', '50', '99', 'EE5D2613-2760-F18C-A447-B8E744FF509D');
INSERT INTO `shopp_specification` VALUES ('D91F077D-5443-F9AA-877A-BD43D3A9B302', '4G运存+64G内存 银钻灰', '6099', '20', '433DA60D-5065-1301-48B8-76D1BB06CDF0');
INSERT INTO `shopp_specification` VALUES ('DA7CCCC7-2474-D9E5-EC31-4F41FDC62502', '170/88(M)', '100', '50', '26C82144-FCFB-AA3A-150D-2640FFF623F2');
INSERT INTO `shopp_specification` VALUES ('DF488BBD-8100-53C5-F9CE-75C26DA2A52A', '大款白色', '109', '23', '47D002AB-DFA4-11CF-52FB-398122144EF1');
INSERT INTO `shopp_specification` VALUES ('DFA2AC79-D96D-7549-1166-3D71523B7483', '灰棕色', '20', '34', '00D84306-7B0D-F027-28E4-09D70124D2CB');
INSERT INTO `shopp_specification` VALUES ('E3387241-DFB4-7485-DC85-827FF9BA7FD4', '260g', '10', '500', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D');
INSERT INTO `shopp_specification` VALUES ('E9D96852-326D-478C-3C5B-572E70DF5A42', '1本', '20', '200', '6FFC6691-7F05-8AB8-B1E1-5C839BB4F446');
INSERT INTO `shopp_specification` VALUES ('EB21D608-1429-C0C9-6C6F-BA289F2085EC', '32G/玫瑰金', '3999', '50', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('EBC84995-D743-5EBE-732F-B618BDCD4AF2', '紫色', '299', '565', 'D678064A-D80E-EFA2-4A01-873583FF3E9B');
INSERT INTO `shopp_specification` VALUES ('ED97B124-E688-6ECF-A883-8D991264F1FA', '深灰色', '20', '27', '00D84306-7B0D-F027-28E4-09D70124D2CB');
INSERT INTO `shopp_specification` VALUES ('EDC4FAFF-BFBB-C4F1-763C-31011210F0CE', '正常规格 ：50ml', '50', '50', 'D2BCDC64-0970-3775-3193-6D870A490A84');
INSERT INTO `shopp_specification` VALUES ('F1760A94-ED0E-A49F-335C-83A7319DB9B8', '小黄人', '28', '888', '629BAE4F-B30D-D852-BFE6-A43A373A2ED8');
INSERT INTO `shopp_specification` VALUES ('F5FC5833-D59D-66FE-A96A-E628E4A0E6EC', '6G运存+128G内存 银钻灰', '9999', '10', '433DA60D-5065-1301-48B8-76D1BB06CDF0');
INSERT INTO `shopp_specification` VALUES ('F8C4BF69-7FBA-3C5A-427D-48DB44C51DA8', '大款红色', '99', '38', '47D002AB-DFA4-11CF-52FB-398122144EF1');
INSERT INTO `shopp_specification` VALUES ('F8C53600-8CAE-83AA-2683-D8A9F8AD08C7', '白色', '18', '666', '21B3CE06-EBCB-ECA1-E311-88D1C759C156');
INSERT INTO `shopp_type` VALUES ('035979B6-A44A-32EA-646F-28A51C607A73', '手机数码');
INSERT INTO `shopp_type` VALUES ('25D26743-4E79-4489-AB85-C6B773BA6588', '美食');
INSERT INTO `shopp_type` VALUES ('57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '服装');
INSERT INTO `shopp_type` VALUES ('B619C389-BE62-40B1-0F25-4B5E60B356D2', '家电');
INSERT INTO `shopp_type` VALUES ('D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '日常用品');
INSERT INTO `shopp_type` VALUES ('F994FC1C-7A5F-16A6-70E4-1672633B13D6', '美妆');
INSERT INTO `shopp_type` VALUES ('FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '图书');
INSERT INTO `shopp_user` VALUES ('426D79CF-279A-2033-0A77-72166CC15CC1', 'test3@qq.com', 'test3', '5162736a116c118de3794a98cfbad7a17da14180', null, '3333', '201703121108522629.png', '', null);
INSERT INTO `shopp_user` VALUES ('5D754767-F3D5-1D93-E588-856B288B08CC', 'admin@qq.com', 'admin', '0ec0cebaee2a51bb93589ef32bb8341a228f320d', null, '11111', '201702181841206215.png', '', null);
INSERT INTO `shopp_user` VALUES ('98EB35BE-CB9E-82A3-C458-5CD2A21BF59D', 'test1@qq.com', '张三', '0cff20526af50e37b8fe8c49313f2ae1a1e622ab', '张三疯', '7788', '201702130142467173.png', '有个性！没签名！', null);
INSERT INTO `shopp_user` VALUES ('AA692D26-B786-D8A0-1420-F8F33264485C', 'home@qq.com', '欢歌', '67f8fabb2588f0458e77a71eed57eccc3c6771f3', '诡异的微笑', '66666', '201703301606271539.png', '老婆不败家！挣钱给谁花！', null);
