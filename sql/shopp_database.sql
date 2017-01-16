/*
MySQL Data Transfer
Source Host: localhost
Source Database: shopp_database
Target Host: localhost
Target Database: shopp_database
Date: 2017/1/16 22:50:58
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
  `grade` double(2,0) NOT NULL,
  `states` int(2) NOT NULL,
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
  `order_number` varchar(100) NOT NULL,
  `order_time` varchar(20) NOT NULL,
  `pay_time` varchar(20) NOT NULL,
  `succeed_time` varchar(20) NOT NULL,
  `address_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shopp_order_specification
-- ----------------------------
CREATE TABLE `shopp_order_specification` (
  `id` char(36) NOT NULL,
  `order_id` char(36) NOT NULL,
  `specification_id` char(36) NOT NULL,
  `count` int(10) NOT NULL,
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
INSERT INTO `shopp_address` VALUES ('58B47E1E-2AC2-3972-3294-48A8764F2A74', '077128384858', '广西壮族自治区 柳州市 柳州职业技术学院', '5D754767-F3D5-1D93-E588-856B288B08CC', '爱丽丝');
INSERT INTO `shopp_commodity` VALUES ('1C26D516-A5F1-7C2E-7158-8A658A3F9083', '27寸大屏2K液晶电脑显示器 IPS高清1080PS4游戏制图显示屏HDMI ', '                                                            27寸大屏幕 IPS屏 高清分辨率 游戏 PS4                                                 ', '0', '{\"\\u5236\\u9020\\u5546\\u540d\\u79f0\":\"\\u6df1\\u5733\\u5e02\\u540e\\u601d\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\",\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u6db2\\u6676\\u663e\\u793a\\u5668\",\"\\u578b\\u53f7\":\"BKA270\",\"\\u6444\\u50cf\\u5934\\u7c7b\\u578b\":\"\\u65e0\\u6444\\u50cf\\u5934\",\"\\u7535\\u6c60\":\"6000\\u6beb\\u5b89\"}', '1482860943', '1483718400', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('37B10231-4225-C269-DB28-F1C40A6CA448', '雪纺白衬衫女长袖韩版休闲百搭职业女装秋冬季加绒加厚保暖衬衣寸', '衬衫', '0', '{\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u805a\\u916f\\u7ea4\\u7ef495% \\u805a\\u6c28\\u916f\\u5f39\\u6027\\u7ea4\",\"\\u670d\\u88c5\\u7248\\u578b\":\"\\u4fee\\u8eab\",\"\\u98ce\\u683c\":\"\\u901a\\u52e4\",\"\\u901a\\u52e4\":\"\\u97e9\\u7248\",\"\\u8863\\u95e8\\u895f\":\" \\u5355\\u6392\\u591a\\u6263\",\"\\u5c3a\\u7801\":\"S M L XL XXL 3XL 4XL\"}', '1484576598', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('934AE8D8-B061-C383-3FE1-6566C597B7F4', '明治雪吻草莓绿茶牛奶可可豆年货巧克力62g 送男女友批发小吃零食 ', '巧克力', '0', '{\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u7f6e\\u4e8e\\u9634\\u51c9\\u5e72\\u71e5\\u5904\",\"\\u6210\\u5206\\u542b\\u91cf\":\"26%\",\"\\u98df\\u54c1\\u53e3\\u5473\":\"\\u725b\\u5976\\u53e3\\u5473 \\u8349\\u8393\\u53e3\\u5473 \\u7cbe\\u9009\\u53ef\\u53ef\",\"\\u5305\\u88c5\\u79cd\\u7c7b\":\"\\u76d2\\u88c5\",\"\\u662f\\u5426\\u542b\\u6709\\u4ee3\\u53ef\\u53ef\\u8102\":\"\\u5426\",\"\\u4ea7\\u5730\":\"\\u4e2d\\u56fd\\u5927\\u9646\",\"\\u4fdd\\u8d28\\u671f\":\"300\\u5929\"}', '1484577647', '1486742400', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'SPAO明星AOA同款女式休闲高领套头毛衣韩版针织衫线衫SAKW64TG04 ', '毛衣', '0', '{\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u805a\\u4e19\\u70ef\\u8148\\u7ea4\\u7ef4(\\u8148\\u7eb6)100%\",\"\\u8863\\u957f\":\"\\u5e38\\u89c4\\u6b3e\",\"\\u8896\\u957f\":\"\\u957f\\u8896\",\"\\u54c1\\u724c\":\"SPAO\",\"\\u5c3a\\u7801\":\"S M L\"}', '1484578225', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', 'diy明信片定制lomo卡贺卡定做自制文艺明星片制作创意古风明信片 ', '明信片', '0', '{\"\\u98ce\\u683c\":\"\\u521b\\u610f\\u6f6e\\u6d41\",\"\\u578b\\u53f7\":\"\\u660e\\u4fe1\\u7247\\u5b9a\\u5236\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"350g\\u91d1\\u724c\\u94dc\\u677f\\u5355\\u9762 350g\\u91d1\\u724c\"}', '1484578028', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('D708E35B-239A-0E3B-3988-B7EA5C3A3066', 'SW床垫 进口乳胶床垫1.5 1.8m弹簧椰棕垫软硬定做席梦思床垫 ', 'SW床垫', '0', '{\"\\u4e73\\u80f6\\u539a\\u5ea6\":\"20mm\",\"\\u5e8a\\u57ab\\u8f6f\\u786c\\u5ea6\":\" \\u8f6f\\u786c\\u4e24\\u7528\",\"\\u6bdb\\u91cd\":\"55\",\"\\u54c1\\u724cv\":\"Sweetnight\",\"\\u6d77\\u7ef5\\u7c7b\\u578b\":\"\\u666e\\u901a\\u6d77\\u7ef5\",\"\\u9762\\u6599\\u5206\\u7c7b\":\"\\u9488\\u7ec7\\u9762\\u6599\"}', '1484576363', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('E1A02C6D-C1C6-A748-983D-A236648BDCD4', '现货 2016.8月30日产 日本专柜FANCL卸妆油120ml 净化修护卸妆液 ', '现货 2016.8月30日产 日本专柜FANCL卸妆油120ml 净化修护卸妆液 ', '0', '{\"\\u539f\\u6599\\u6210\\u5206\":\"\\u725b\\u5976 \\u67e0\\u6aac\\u9a6c\\u97ad\\u8349 \\u6708\\u89c1\\u8349 \\u5176\",\"\\u9002\\u5408\\u80a4\\u8d28\":\" \\u4efb\\u4f55\\u80a4\\u8d28\",\"\\u54c1\\u724c\":\"Fancl\\/\\u65e0\\u6dfb\\u52a0\",\"\\u4ea7\\u5730\":\"\\u65e5\\u672c\"}', '1484570726', '1486742400', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('F396C933-04BC-E46D-012F-AE67F7DD37EE', '清风抽纸原木纯品3层面巾纸婴儿家用纸巾整箱家庭装 ', '清风抽纸原木纯品3层面巾纸婴儿家用纸巾整箱家庭装 ', '0', '{\"\\u54c1\\u724c\":\"\\u6e05\\u98ce\",\"\\u662f\\u5426\\u91cf\\u8d29\\u88c5\":\"\\u5426\",\"\\u9762\\u5dfe\\u7eb8\\u79cd\\u7c7b\":\"\\u8f6f\\u5305\\u88c5\\u9762\\u5dfe\\u7eb8\",\"\\u539f\\u6750\\u6599\\u6210\\u5206\":\"\\u539f\\u751f\\u6d46\"}', '1484575927', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('F72A0711-12B1-2360-6A79-023E0A6FB6BF', '正山小种茶叶 红茶茶叶 武夷山正山小种茶叶散装600克 五虎红茶', '正山小种茶叶 红茶茶叶 武夷山正山小种茶叶散装600克 五虎红茶 ', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u4e94\\u864e 150\\u514b*4 \\u6b63\\u5c71\\u5c0f\\u79cd\",\"\\u51c0\\u542b\\u91cf\":\"600g\",\"\\u5305\\u88c5\\u65b9\\u5f0f:\":\"\\u5305\\u88c5\"}', '1484570266', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('FB498C2A-0CB1-403B-A836-D602ABC96AB8', '秋冬季健身服男套装健身房三四五件套运动透气速干长袖跑步紧身衣', '秋冬季健身服男套装健身房三四五件套运动透气速干长袖跑步紧身衣', '0', '{\"\\u4e0a\\u88c5\\u6b3e\\u5f0f\":\"\\u957f\\u8896\",\"\\u529f\\u80fd\":\"\\u5438\\u6e7f\\u6392\\u6c57 \\u901f\\u5e72 \\u900f\\u6c14 \\u8d85\\u5f3a\\u5f39\\u6027\",\"\\u5c3a\\u7801\":\"M L XL XXL\",\"\\u4e0b\\u88c5\\u88e4\\u957f\":\"\\u957f\\u88e4\"}', '1484576146', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '2017春装新款女韩版时尚鱼尾红裙子小香风明星同款蕾丝红色连衣裙 ', '连衣裙', '0', '{\"\\u8896\\u578b\":\"\\u5e38\\u89c4\",\"\\u6d41\\u884c\\u5143\\u7d20\":\"\\u62fc\\u63a5 \\u62c9\\u94fe \\u857e\\u4e1d\",\"\\u8863\\u95e8\\u895f\":\"\\u5957\\u5934\",\"\\u56fe\\u6848\":\"\\u7eaf\\u8272\",\"\\u88d9\\u957f\":\"\\u4e2d\\u88d9\",\"\\u8170\\u578b:\":\"\\u9ad8\\u8170\"}', '1484577839', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity_images` VALUES ('0BF0872F-1938-4913-F73B-73B9448914C5', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', '5C5BDFF5-0994-E920-5329-6C442D94090E.png');
INSERT INTO `shopp_commodity_images` VALUES ('1392DEEA-1C96-1926-ED21-A07BF51CFC23', 'F396C933-04BC-E46D-012F-AE67F7DD37EE', 'B10C4D0E-DC6B-E713-601B-295AD39E3082.png');
INSERT INTO `shopp_commodity_images` VALUES ('15667DF7-9FAC-22DF-03AD-00E467EDFEE3', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'D4C56046-57DD-C8E0-E3BA-57FAF9B6FBC7.png');
INSERT INTO `shopp_commodity_images` VALUES ('28F9FADC-4EAB-A587-A934-66EE3FC931DA', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', 'F8FDC530-B0A7-D38E-F728-32FA3E6E5960.png');
INSERT INTO `shopp_commodity_images` VALUES ('3288E1BE-6DFF-3712-EC7C-406C53B3D370', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF', '46197659-86BD-5714-0C2B-CEDE85DE5B41.png');
INSERT INTO `shopp_commodity_images` VALUES ('45F3D285-124F-63AF-B128-5ADBB4692750', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', '238A1288-FFBC-5FD4-A0DE-B53F79BA48BD.png');
INSERT INTO `shopp_commodity_images` VALUES ('48AEC2D0-9DFE-9A4C-277D-A09693DD3542', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '5B82284D-D583-9E48-BD71-2DB7F9DCF779.png');
INSERT INTO `shopp_commodity_images` VALUES ('52753AF0-0AE7-0C03-FD03-72E006A350F0', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', 'DD003367-BE0B-5942-6582-7A5E26DE8ADA.png');
INSERT INTO `shopp_commodity_images` VALUES ('558B1843-F7AA-A7FC-B7BB-10321225A0A1', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF', '23D2D5D4-E656-41D0-E656-66C29FACFF24.png');
INSERT INTO `shopp_commodity_images` VALUES ('57F0F7B0-6C79-B401-B214-82F3E09774B1', '934AE8D8-B061-C383-3FE1-6566C597B7F4', 'F19A377F-166D-FDB7-9216-356E060E7125.png');
INSERT INTO `shopp_commodity_images` VALUES ('5F3DDB72-DE2A-6A74-75BF-56C716B7D861', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8', '8823B821-3A03-FB0C-633F-D60EED429CE2.png');
INSERT INTO `shopp_commodity_images` VALUES ('643F82EF-7F61-3C9B-6C76-62D5255C2557', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'B3195156-9300-44C5-56FB-552D8D67FFD7.png');
INSERT INTO `shopp_commodity_images` VALUES ('673D94FA-01E2-6F9F-D35F-9F87C3CA22F7', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', '6350699E-CD5B-DC0A-198C-78320274A619.png');
INSERT INTO `shopp_commodity_images` VALUES ('7B5A092C-F92E-3032-40DB-80299977754D', '37B10231-4225-C269-DB28-F1C40A6CA448', 'B1146293-F799-9106-575F-C4B6C0B1AF73.png');
INSERT INTO `shopp_commodity_images` VALUES ('8424C292-BD6F-2491-F6CD-CFCDAB9EA8B5', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8', 'D378C0BD-532B-A999-D988-01384C0A5708.png');
INSERT INTO `shopp_commodity_images` VALUES ('869CD882-5FB6-3F00-0A4E-2C4EB51924D1', '934AE8D8-B061-C383-3FE1-6566C597B7F4', 'A17ACA04-F280-E772-D52B-F55D49DD0CCD.png');
INSERT INTO `shopp_commodity_images` VALUES ('86E7BA6E-4A64-B962-D39B-62AA28347098', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '28B656EC-ABAF-B5B4-6F1B-C2BE11321F1D.png');
INSERT INTO `shopp_commodity_images` VALUES ('9DFBE04C-CA62-7FD7-580D-CB875B00014D', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '8197BF6B-16CE-A046-33A9-3D731E2E3D11.png');
INSERT INTO `shopp_commodity_images` VALUES ('A258E03C-C85F-A856-DF40-6842D6CCF63C', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'FAF79646-6C06-14DD-58C2-493F260D9448.png');
INSERT INTO `shopp_commodity_images` VALUES ('A4A73C7A-46AD-F92B-DC43-F6279FB5306E', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'C48809C5-1916-F829-8490-3A99D06CC7C8.png');
INSERT INTO `shopp_commodity_images` VALUES ('A78D62A0-E0D0-970C-703E-B96CF7701470', '934AE8D8-B061-C383-3FE1-6566C597B7F4', '580D5E61-87CF-50C7-3F53-5F4A1D886580.png');
INSERT INTO `shopp_commodity_images` VALUES ('AB688D8F-D99C-41FA-E672-1D3CEBC9C2BC', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '9AD3F274-6DD5-EF22-88E9-FAE738C2F085.png');
INSERT INTO `shopp_commodity_images` VALUES ('ADE35F01-19B3-597A-2B24-A33CF4B157DA', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'C6D7C71D-7826-A291-6321-B440785E72D0.png');
INSERT INTO `shopp_commodity_images` VALUES ('B9FF52B8-95F2-18E8-55A5-994465A1CDA6', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'B8227999-745C-4AB6-C95D-C57E1924AED8.png');
INSERT INTO `shopp_commodity_images` VALUES ('BEFF68EF-B07E-B032-36FB-850F0FFBC50E', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'E56FA03A-738D-500E-F9C4-C84636B61F6F.png');
INSERT INTO `shopp_commodity_images` VALUES ('C0B7D3CA-73BC-2ABD-0CE4-E61A4E829B23', '37B10231-4225-C269-DB28-F1C40A6CA448', '1942A9BD-1C3B-3951-4019-C949EA86E993.png');
INSERT INTO `shopp_commodity_images` VALUES ('C2A118C9-1095-2765-EFD0-376C66BC6B09', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '4CA86FB7-9258-BC3A-C0C4-1F21005B59E9.png');
INSERT INTO `shopp_commodity_images` VALUES ('C8A8BAE2-418D-8F27-37D7-2969A761F2DC', 'F396C933-04BC-E46D-012F-AE67F7DD37EE', '7875BFCD-4332-B52D-797B-3F00FE252FF1.png');
INSERT INTO `shopp_commodity_images` VALUES ('CB420F6D-2768-F2BB-EE1B-31CCF0ABA4F5', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', '32156F6D-2601-5460-EE18-6499A4A08901.png');
INSERT INTO `shopp_commodity_images` VALUES ('EA9C9F7D-83C9-6327-35D3-08713DBE2D92', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', 'B521368A-73CA-C9E1-A427-F8CBC92E73A0.png');
INSERT INTO `shopp_commodity_images` VALUES ('F1E81D5D-8330-5595-EED8-19F1805C1FBE', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', '89F7EE4C-1CA5-9245-D06E-EA9439918A75.png');
INSERT INTO `shopp_order` VALUES ('3D6DBFA3-624E-69DB-E8DE-5D26B9E33968', '2', '5D754767-F3D5-1D93-E588-856B288B08CC', '1483776627', '1483776627', '1483776627', '1483776627', '051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9');
INSERT INTO `shopp_order` VALUES ('8630AB36-897C-F23D-961E-B4ACB15D9C8A', '2', '5D754767-F3D5-1D93-E588-856B288B08CC', '1483030733', '1483030733', '1483030733', '1483030733', '051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9');
INSERT INTO `shopp_order_specification` VALUES ('11E20DE9-8F7E-A426-B390-34FADFADAAE9', '8630AB36-897C-F23D-961E-B4ACB15D9C8A', '7D118229-AF8E-3C21-D440-6A3E4B94424A', '2');
INSERT INTO `shopp_order_specification` VALUES ('FB3FB3ED-EA8D-C17A-B0A7-EEDB49463133', '3D6DBFA3-624E-69DB-E8DE-5D26B9E33968', '64D63924-E57B-C610-6CEF-4E528BE1D391', '4');
INSERT INTO `shopp_specification` VALUES ('0D6B0C51-712A-6270-08E9-39811DA6A3D1', '350g', '20', '1000', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1');
INSERT INTO `shopp_specification` VALUES ('119CD58F-4126-CF58-BEC2-1567ADB34E05', '1800x2000mm', '2000', '200', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066');
INSERT INTO `shopp_specification` VALUES ('143FDD53-49C8-A58C-CEC6-740FD97D479E', '1件', '179', '200', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC');
INSERT INTO `shopp_specification` VALUES ('1765D5F3-BE45-6B06-24FA-DB7DE1DA942C', '600g', '68', '200', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF');
INSERT INTO `shopp_specification` VALUES ('38BE888F-837B-B57D-E0ED-FB358C7AF49A', '一件', '200', '2000', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7');
INSERT INTO `shopp_specification` VALUES ('583AD147-7DC7-4E13-A4F2-59ADDF81F1D0', '1件', '20', '200', '37B10231-4225-C269-DB28-F1C40A6CA448');
INSERT INTO `shopp_specification` VALUES ('64D63924-E57B-C610-6CEF-4E528BE1D391', '高配2K高清版', '999', '12', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('6C584A55-081F-D42C-F5F4-9F6810931FF9', '160抽', '13', '200', 'F396C933-04BC-E46D-012F-AE67F7DD37EE');
INSERT INTO `shopp_specification` VALUES ('6E4D44E5-6E5D-3ECE-C1DA-9D6A3BB1FA56', '200ml', '102', '200', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4');
INSERT INTO `shopp_specification` VALUES ('A927A4FD-79FA-7DE2-F15C-2EEDDD0A5EC5', '四件套', '178', '200', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8');
INSERT INTO `shopp_specification` VALUES ('BDE33C6F-A44C-ECC3-4585-6B493AD223F3', '白色普通版', '800', '20', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('BE3CB921-D7EF-AFD4-863A-630BDFD766D5', '62g', '19', '1000', '934AE8D8-B061-C383-3FE1-6566C597B7F4');
INSERT INTO `shopp_specification` VALUES ('D29F12CC-3CCF-5749-E84F-BD61DAC7E61C', '黑色普通版', '800', '26', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_type` VALUES ('035979B6-A44A-32EA-646F-28A51C607A73', '手机数码');
INSERT INTO `shopp_type` VALUES ('25D26743-4E79-4489-AB85-C6B773BA6588', '美食');
INSERT INTO `shopp_type` VALUES ('57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '服装');
INSERT INTO `shopp_type` VALUES ('B619C389-BE62-40B1-0F25-4B5E60B356D2', '家电');
INSERT INTO `shopp_type` VALUES ('D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '日常用品');
INSERT INTO `shopp_type` VALUES ('F994FC1C-7A5F-16A6-70E4-1672633B13D6', '美妆');
INSERT INTO `shopp_type` VALUES ('FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '图书');
INSERT INTO `shopp_user` VALUES ('5D754767-F3D5-1D93-E588-856B288B08CC', 'admin@qq.com', 'admin', '0ec0cebaee2a51bb93589ef32bb8341a228f320d', null, '11111', '201612161528083417.png', '', null);
INSERT INTO `shopp_user` VALUES ('843B2B6B-4D6C-14C0-8C0B-184BEC722BD3', 'test2@qq.com', 'test2', '9e8fa5ab3be86fd237c16f2f358216de81118c18', null, '22222', '201612231058437310.png', '', null);
INSERT INTO `shopp_user` VALUES ('C6C5BE9C-76CB-AC21-0476-942224A29F96', 'test1@qq.com', 'test1', '0cff20526af50e37b8fe8c49313f2ae1a1e622ab', null, '111111111', '201612231008219460.png', '', null);
