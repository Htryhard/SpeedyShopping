/*
MySQL Data Transfer
Source Host: localhost
Source Database: shopp_database
Target Host: localhost
Target Database: shopp_database
Date: 2017/1/23 21:10:04
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
INSERT INTO `shopp_cart` VALUES ('CD80475B-942E-E686-55D2-302363E3A2A3', '5D754767-F3D5-1D93-E588-856B288B08CC');
INSERT INTO `shopp_cart_specification` VALUES ('8105DF95-B23D-80C1-7A83-FBB49D634D33', '6C584A55-081F-D42C-F5F4-9F6810931FF9', 'CD80475B-942E-E686-55D2-302363E3A2A3', '1');
INSERT INTO `shopp_cart_specification` VALUES ('F07E08FF-CEF9-2764-DBD0-A353852319E0', 'EB21D608-1429-C0C9-6C6F-BA289F2085EC', 'CD80475B-942E-E686-55D2-302363E3A2A3', '2');
INSERT INTO `shopp_cart_specification` VALUES ('F591592D-2587-5A55-7605-FE80C8313D84', 'BDE33C6F-A44C-ECC3-4585-6B493AD223F3', 'CD80475B-942E-E686-55D2-302363E3A2A3', '1');
INSERT INTO `shopp_collect` VALUES ('50049346-3A4F-A593-15D5-7A726586206D', '5D754767-F3D5-1D93-E588-856B288B08CC', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', '1485159050');
INSERT INTO `shopp_collect` VALUES ('55D19864-5589-0797-D6CA-C9C369348885', '5D754767-F3D5-1D93-E588-856B288B08CC', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', '1485157378');
INSERT INTO `shopp_collect` VALUES ('6F588002-A221-016D-EF14-063AB394BCE4', '5D754767-F3D5-1D93-E588-856B288B08CC', '934AE8D8-B061-C383-3FE1-6566C597B7F4', '1485160350');
INSERT INTO `shopp_collect` VALUES ('8EB13B1B-C1EF-A326-ADE1-D8616CEF425F', '5D754767-F3D5-1D93-E588-856B288B08CC', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', '1485155169');
INSERT INTO `shopp_collect` VALUES ('98760AA2-3C09-F263-E561-921E5661520F', '5D754767-F3D5-1D93-E588-856B288B08CC', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '1484745758');
INSERT INTO `shopp_collect` VALUES ('A7D64D58-B488-4E7C-C696-1D1BD07C4FF4', '5D754767-F3D5-1D93-E588-856B288B08CC', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', '1484685505');
INSERT INTO `shopp_collect` VALUES ('BEBB89DB-ECB5-2BC8-D36C-B58DE79BBC8D', '5D754767-F3D5-1D93-E588-856B288B08CC', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '1484728832');
INSERT INTO `shopp_collect` VALUES ('CF8E2046-C4A9-0651-9790-8D0BFDC07FA8', '5D754767-F3D5-1D93-E588-856B288B08CC', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8', '1484745768');
INSERT INTO `shopp_collect` VALUES ('D8118305-9EC1-3C0C-5E6C-DFEE9C223ADB', '5D754767-F3D5-1D93-E588-856B288B08CC', 'F396C933-04BC-E46D-012F-AE67F7DD37EE', '1484745773');
INSERT INTO `shopp_commodity` VALUES ('1C26D516-A5F1-7C2E-7158-8A658A3F9083', '27寸大屏2K液晶电脑显示器 IPS高清1080PS4游戏制图显示屏HDMI ', '                                                            27寸大屏幕 IPS屏 高清分辨率 游戏 PS4                                                 ', '0', '{\"\\u5236\\u9020\\u5546\\u540d\\u79f0\":\"\\u6df1\\u5733\\u5e02\\u540e\\u601d\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\",\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u6db2\\u6676\\u663e\\u793a\\u5668\",\"\\u578b\\u53f7\":\"BKA270\",\"\\u6444\\u50cf\\u5934\\u7c7b\\u578b\":\"\\u65e0\\u6444\\u50cf\\u5934\",\"\\u7535\\u6c60\":\"6000\\u6beb\\u5b89\"}', '1482860943', '1483718400', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('22B10E64-2792-9976-E179-2481FBD15CB5', 'Apple/苹果 iPhone 7 Plus 苹果7 5.5寸国行港版现货 7p 7代手机 ', '新iphone特性：新增亮面黑，压力感应HOME键，ip67级防水防尘，1200w像素光学防抖，全新A10处理器，续航提升，立体扬声器 ，lightning耳机接入方式，双摄像头。 现货发！按订单顺序发货', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"iPhone 7 Plus\",\"iPhone 7 Plus\":\" 5.5\\u82f1\\u5bf8\",\"\\u7f51\\u7edc\\u7c7b\\u578b:\":\"4G\\u5168\\u7f51\\u901a\",\"\\u5b58\\u50a8\\u5bb9\\u91cf\":\"32GB 128GB 256GB\",\"\\u539a\\u5ea6\":\"7.3 \\u6beb\\u7c73 (0.29 \\u82f1\\u5bf8)\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1200 \\u4e07\\u50cf\\u7d20\\u5e7f\\u89d2\\u53ca\\u957f\"}', '1484925630', '1486742400', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', '拉夏贝尔2017春款新品 条纹方领九分袖衬衫式连衣裙10012162 ', '拉夏贝尔2017春款新品 条纹方领九分袖衬衫式连衣裙10012162 ', '0', '{\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u68c9100%\",\"\\u9500\\u552e\\u6e20\\u9053\\u7c7b\\u578b\":\"\\u5546\\u573a\\u540c\\u6b3e\"}', '1484975106', '1579536000', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('26C82144-FCFB-AA3A-150D-2640FFF623F2', '制ZPLPKK 2017春季新款女士中长款舒适羽绒服修身毛领外套 ', '制ZPLPKK 2017春季新款女士中长款舒适羽绒服修身毛领外套 ', '0', '{\"\\u4e0a\\u5e02\\u5e74\\u4efd\\u5b63\\u8282\":\"2017\\u5e74\\u6625\\u5b63\",\"\\u539a\\u8584\":\"\\u5e38\\u89c4\",\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u7c98\\u80f6\\u7ea4\\u7ef4(\\u7c98\\u7ea4)51% \\u805a\\u916f\\u7ea4\"}', '1484975592', '1548345600', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('37B10231-4225-C269-DB28-F1C40A6CA448', '雪纺白衬衫女长袖韩版休闲百搭职业女装秋冬季加绒加厚保暖衬衣寸', '衬衫', '0', '{\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u805a\\u916f\\u7ea4\\u7ef495% \\u805a\\u6c28\\u916f\\u5f39\\u6027\\u7ea4\",\"\\u670d\\u88c5\\u7248\\u578b\":\"\\u4fee\\u8eab\",\"\\u98ce\\u683c\":\"\\u901a\\u52e4\",\"\\u901a\\u52e4\":\"\\u97e9\\u7248\",\"\\u8863\\u95e8\\u895f\":\" \\u5355\\u6392\\u591a\\u6263\",\"\\u5c3a\\u7801\":\"S M L XL XXL 3XL 4XL\"}', '1484576598', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', '64G/128G顶配【送VR电源+12期分期】Xiaomi/小米 小米Max手机 MIX ', '正品保障，支持官网验货，全国联保！买就送：7H级纳米防爆膜，保护壳，延保一年等！小米MAX配置一览：①:顶配为4G运行内存+128G存储闪存；②:6.44英寸大屏黄金尺寸，④:全网通3.0，4G+；⑤:1600万像素，5片式镜头，f2.0光圈；⑥:4850mAh', '0', '{\"CPU\\u578b\\u53f7\":\"\\u9a81\\u9f99650\",\"\\u4ea7\\u54c1\\u540d\\u79f0:\":\"\\u5c0f\\u7c73Max\",\"\\u7f51\\u7edc\\u7c7b\\u578b:\":\"4G\\u5168\\u7f51\\u901a\",\"\\u952e\\u76d8\\u7c7b\\u578b\":\"\\u865a\\u62df\\u89e6\\u5c4f\\u952e\\u76d8\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1600\\u4e07\"}', '1484983134', '1611849600', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('511676D4-6E5E-A943-02D2-23838D8A4B2A', '卡丝拉狄 中年大衣女装中国风撞色绣花立领长袖宽松毛呢女士外套 ', '卡丝拉狄 中年大衣女装中国风撞色绣花立领长袖宽松毛呢女士外套 ', '0', '{\"\\u6d41\\u884c\\u5143\\u7d20\\/\\u5de5\\u827a\":\"\\u7ee3\\u82b1\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u9ec4\\u8272 \\u9ed1\\u8272 \\u84dd\\u8272\",\"\\u9886\\u5b50\":\"\\u7acb\\u9886\",\"\\u901a\\u52e4\":\"\\u97e9\\u7248\",\"\\u8863\\u95e8\\u895f\":\"\\u4e00\\u7c92\\u6263\",\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u7f8a\\u6bdb50% \\u805a\\u916f\\u7ea4\\u7ef450%\"}', '1484978091', '1585843200', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('6D025479-654E-5D3F-2B6D-ECF783A2D918', '骆驼男装 2017春季新品青年时尚立领商务休闲外套纯色运动风衣男 ', '骆驼男装 2017春季新品青年时尚立领商务休闲外套纯色运动风衣男 ', '0', '{\"\\u54c1\\u724c\":\"Camel\\/\\u9a86\\u9a7c\",\"\\u57fa\\u7840\\u98ce\\u683c\":\"\\u65f6\\u5c1a\\u90fd\\u5e02\",\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u68c9100%\",\"\\u4e0a\\u5e02\\u5e74\\u4efd\\u5b63\\u8282\":\"2017\\u5e74\\u6625\\u5b63\"}', '1484978236', '1390320000', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('6FFC6691-7F05-8AB8-B1E1-5C839BB4F446', '正版钢铁是怎样炼成的 原著经典世界名著外国外小说文学青少版 少儿童书籍畅销书阅读 初中学生小学生课外必读物图书', '《钢铁是怎样炼成的》被誉为“影响历史的百部经典之一”，“影响中国近代社会的经典译作”。保尔那顽强坚韧，奋发向上的人格力量，对我们的青少年，对我们的民族来说，是永远具有特殊意义的宝贵财富', '0', '{\"     \\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u94a2\\u94c1\\u662f\\u600e\\u6837\\u70bc\\u6210\\u7684\",\"\\u51fa\\u7248\\u793e\\u540d\\u79f0\":\"\\u4e2d\\u56fd\\u6587\\u8054\\u51fa\\u7248\\u793e\",\"\\u4f5c\\u8005\":\"\\u5965\\u65af\\u7279\\u6d1b\\u592b\\u65af\\u57fa\",\"ISBN\\u7f16\\u53f7\":\"9787519006129\"}', '1484925988', '1486742400', 'FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', 'Apple/苹果 iPhone 6s Plus 苹果6S 5.5香港/美国/官换全新 ', '支持花呗分期 购买送膜+手机壳 iPhone6S五大预测：1，机身材质采用7000铝合金，不再出现弯曲门。2，屏幕加入Force Touch压感触控技术。3，全新A9处理器CPU及GPU。4，2GB的RAM搭配IOS9。5，全新的1200万像素主摄像头。', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"Apple\\/\\u82f9\\u679c iPhone 6s Plus\",\"\\u5c4f\\u5e55\\u5c3a\\u5bf8\":\"5.5\\u82f1\\u5bf8\",\"\\u4e0a\\u5e02\\u65f6\\u95f4\":\"2015\\u5e749\\u6708\",\"CPU\\u54c1\\u724c\":\"Apple\\/\\u82f9\\u679c\",\"CPU\\u578b\\u53f7\":\"\\u5176\\u4ed6\",\"Apple\\u578b\\u53f7\":\"iPhone 6s Plus\",\"\\u7f51\\u7edc\\u7c7b\\u578b\":\"4G+\\u5168\\u7f51\\u901a\",\"\\u673a\\u8eab\\u989c\\u8272\":\"\\u73ab\\u7470\\u91d1 \\u9ed1\\u8272 \\u94f6\\u8272 \\u91d1\\u8272\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1200\\u4e07\",\"\\u64cd\\u4f5c\\u7cfb\\u7edf\":\"IOS9\",\"\\u5b58\\u50a8\\u5bb9\\u91cf\":\"16GB 64GB 128GB\",\"\\u539a\\u5ea6\":\"7.3\\u6beb\\u7c73\\uff080.29\\u82f1\\u5bf8\\uff09\",\"\\u5206\\u8fa8\\u7387\":\"1920 x 1080 \\u50cf\\u7d20\\u5206\\u8fa8\\u7387\"}', '1484979335', '1514563200', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('753C793E-1F5D-1DC7-4103-A23D23E016C2', '歌莉娅女装 2017春季新品V领长袖毛呢外套长款171R6E490 ', '歌莉娅女装 2017春季新品V领长袖毛呢外套长款171R6E490 ', '0', '{\"\\u8d27\\u53f7\":\"171R6E490\",\"\\u670d\\u88c5\\u7248\\u578b\":\" \\u76f4\\u7b52\",\" \\u76f4\\u7b52\":\"\\u6697\\u6263\",\"\\u6697\\u6263\":\"\\u6697\\u6263\"}', '1484977693', '1581091200', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('8C5CBC3B-C3A0-F078-2DC1-DD276D203A5E', '新品现货 Meizu/魅族 魅蓝note5全网通4G智能手机note5', '全新白色16G现货！！送快递包邮+延保一年！！推荐选购套餐，搭使用更方便。 拒绝黄牛，每人限购1台相同类似地址多拍只发一台！', '0', '{\"\\u673a\\u8eab\\u989c\\u8272\":\"\\u5168\\u7f51\\u901a\\u767d\\u8272\",\"\\u9b45\\u65cf\\u578b\\u53f7\":\"\\u9b45\\u84ddnote5\",\"\\u5206\\u8fa8\\u7387\":\"1920x1080\",\"\\u8fd0\\u884c\\u5185\\u5b58RAM\":\" 3GB 4GB\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"1300\\u4e07\"}', '1484983552', '1548259200', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('900AA834-8BF4-9826-3239-01487EF71BED', '卡丝拉狄 中年大衣女装中国风撞色绣花立领长袖宽松毛呢女士外套 ', '卡丝拉狄 中年大衣女装中国风撞色绣花立领长袖宽松毛呢女士外套 ', '0', '{\"\\u6d41\\u884c\\u5143\\u7d20\\/\\u5de5\\u827a\":\"\\u7ee3\\u82b1\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u9ec4\\u8272 \\u9ed1\\u8272 \\u84dd\\u8272\",\"\\u9886\\u5b50\":\"\\u7acb\\u9886\",\"\\u901a\\u52e4\":\"\\u97e9\\u7248\",\"\\u8863\\u95e8\\u895f\":\"\\u4e00\\u7c92\\u6263\",\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u7f8a\\u6bdb50% \\u805a\\u916f\\u7ea4\\u7ef450%\"}', '1484978092', '1585843200', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('934AE8D8-B061-C383-3FE1-6566C597B7F4', '明治雪吻草莓绿茶牛奶可可豆年货巧克力62g 送男女友批发小吃零食 ', '巧克力', '0', '{\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u7f6e\\u4e8e\\u9634\\u51c9\\u5e72\\u71e5\\u5904\",\"\\u6210\\u5206\\u542b\\u91cf\":\"26%\",\"\\u98df\\u54c1\\u53e3\\u5473\":\"\\u725b\\u5976\\u53e3\\u5473 \\u8349\\u8393\\u53e3\\u5473 \\u7cbe\\u9009\\u53ef\\u53ef\",\"\\u5305\\u88c5\\u79cd\\u7c7b\":\"\\u76d2\\u88c5\",\"\\u662f\\u5426\\u542b\\u6709\\u4ee3\\u53ef\\u53ef\\u8102\":\"\\u5426\",\"\\u4ea7\\u5730\":\"\\u4e2d\\u56fd\\u5927\\u9646\",\"\\u4fdd\\u8d28\\u671f\":\"300\\u5929\"}', '1484577647', '1486742400', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'SPAO明星AOA同款女式休闲高领套头毛衣韩版针织衫线衫SAKW64TG04 ', '毛衣', '0', '{\"\\u6750\\u8d28\\u6210\\u5206\":\"\\u805a\\u4e19\\u70ef\\u8148\\u7ea4\\u7ef4(\\u8148\\u7eb6)100%\",\"\\u8863\\u957f\":\"\\u5e38\\u89c4\\u6b3e\",\"\\u8896\\u957f\":\"\\u957f\\u8896\",\"\\u54c1\\u724c\":\"SPAO\",\"\\u5c3a\\u7801\":\"S M L\"}', '1484578225', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1', '高端定制ZPLPKK 2017春季新款女士中长款舒适羽绒服修身毛领外套 ', '制ZPLPKK 2017春季新款女士中长款舒适羽绒服修身毛领外套 ', '0', '{\"\\u5145\\u7ed2\\u91cf\":\"100g\\u4ee5\\u4e0b\",\"\\u542b\\u7ed2\\u91cf\":\"50%\"}', '1484975355', '1611158400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('B4052C46-F17D-CBD1-4BCF-29DF877B6FA5', 'vivo X9前置双摄 全网通4G智能手机 超薄指纹解锁正品分期 vivox9', 'vivo X9前置双摄 全网通4G智能手机 超薄指纹解锁正品分期 vivox9', '0', '{\"\\u5236\\u9020\\u5546\\u540d\\u79f0\":\"\\u7ef4\\u6c83\\u79fb\\u52a8\\u901a\\u4fe1\\u6709\\u9650\\u516c\\u53f8\",\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"TD-LTE\\u6570\\u5b57\\u79fb\\u52a8\\u7535\\u8bdd\\u673a\",\"CPU\\u578b\\u53f7\":\"MSM8953\",\"\\u673a\\u8eab\\u989c\\u8272\":\"\\u91d1\\u8272 \\u73ab\\u7470\\u91d1 \\u661f\\u7a7a\\u7070\",\"\\u5b58\\u50a8\\u5bb9\\u91cf\":\"64G\"}', '1484926494', '1486742400', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', 'diy明信片定制lomo卡贺卡定做自制文艺明星片制作创意古风明信片 ', '明信片', '0', '{\"\\u98ce\\u683c\":\"\\u521b\\u610f\\u6f6e\\u6d41\",\"\\u578b\\u53f7\":\"\\u660e\\u4fe1\\u7247\\u5b9a\\u5236\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"350g\\u91d1\\u724c\\u94dc\\u677f\\u5355\\u9762 350g\\u91d1\\u724c\"}', '1484578028', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('C3E30939-86EB-730F-900E-17B582155781', 'Huawei/华为 P9全网通4G智能手机', '当天发，下单即送：专用智能皮套+纳米防爆膜+转接头+原装保护壳+懒人支架+保修三年+顺丰包邮。5.2英寸，双1200万+800万莱卡摄像头，八核，麒麟955，指纹解锁，3000毫安电池。标配（3G+32G）高配(4G+64G）；P9 PIUS是5.5英寸【注意：主图礼品以套餐为准，各套餐礼品均不同】', '0', '{\"\\u54c1\\u724c\":\"Huawei\\/\\u534e\\u4e3a\",\"\\u5206\\u8fa8\\u7387\":\"1920x1080\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\"\\u53cc1200\\u4e07\",\"\\u534e\\u4e3a\\u578b\\u53f7\":\"P9\\u5168\\u7f51\\u901a\"}', '1484983330', '1610640000', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('D2BCDC64-0970-3775-3193-6D870A490A84', '现货 2016.9月 日本FANCL新版保湿洁面粉50g 泡沫深层清洁 ', '现货 2016.9月 日本FANCL新版保湿洁面粉50g 泡沫深层清洁 ', '0', '{\"\\u89c4\\u683c\\u7c7b\\u578b\":\": Fancl\\/\\u65e0\\u6dfb\\u52a0\",\" \\u4fdd\\u8d28\\u671f\":\": \\u4e00\\u5e74\",\"\\u529f\\u6548:\":\"\\u4fdd\\u6e7f \\u63a7\\u6cb9 \\u6536\\u7f29\\u6bdb\\u5b54  \",\"\\u662f\\u5426\\u4e3a\\u7279\\u6b8a\\u7528\\u9014\\u5316\\u5986\\u54c1:  \":\" \\u5426\",\"\\u4ea7\\u5730:\":\"\\u65e5\\u672c\",\"fancl\\u5355\\u54c1: \":\"\\u4fdd\\u6e7f\\u6d01\\u9762\\u7c89   \",\" \\u54c1\\u724c:\":\" Fancl\\/\\u65e0\\u6dfb\\u52a0     \",\"\":\"\"}', '1484984046', '1420732800', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('D5CD3549-48F1-F39A-F547-EF40372ECC5D', 'RC相纸5寸6寸7寸A4高光防水4R照片纸260g磨砂绸绒面彩色喷墨打印', 'RC相纸5寸6寸7寸A4高光防水4R照片纸260g磨砂绸绒面彩色喷墨打印 ', '0', '{\"     \\u989c\\u8272\\u5206\\u7c7b\":\"6\\u5bf8 260\\u514bRC\\u6cb9\\u753b\\u5e03\\u9762 100\",\"\\u5e45\\u9762:\":\"4r\",\"\\u662f\\u5426\\u5377\\u7b52\\u578b\":\"\\u5426\",\"\\u54c1\\u724c\":\"\\u529b\\u6b66\"}', '1484984199', '1580400000', 'FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('D708E35B-239A-0E3B-3988-B7EA5C3A3066', 'SW床垫 进口乳胶床垫1.5 1.8m弹簧椰棕垫软硬定做席梦思床垫 ', 'SW床垫', '0', '{\"\\u4e73\\u80f6\\u539a\\u5ea6\":\"20mm\",\"\\u5e8a\\u57ab\\u8f6f\\u786c\\u5ea6\":\" \\u8f6f\\u786c\\u4e24\\u7528\",\"\\u6bdb\\u91cd\":\"55\",\"\\u54c1\\u724cv\":\"Sweetnight\",\"\\u6d77\\u7ef5\\u7c7b\\u578b\":\"\\u666e\\u901a\\u6d77\\u7ef5\",\"\\u9762\\u6599\\u5206\\u7c7b\":\"\\u9488\\u7ec7\\u9762\\u6599\"}', '1484576363', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('E1A02C6D-C1C6-A748-983D-A236648BDCD4', '现货 2016.8月30日产 日本专柜FANCL卸妆油120ml 净化修护卸妆液 ', '现货 2016.8月30日产 日本专柜FANCL卸妆油120ml 净化修护卸妆液 ', '0', '{\"\\u539f\\u6599\\u6210\\u5206\":\"\\u725b\\u5976 \\u67e0\\u6aac\\u9a6c\\u97ad\\u8349 \\u6708\\u89c1\\u8349 \\u5176\",\"\\u9002\\u5408\\u80a4\\u8d28\":\" \\u4efb\\u4f55\\u80a4\\u8d28\",\"\\u54c1\\u724c\":\"Fancl\\/\\u65e0\\u6dfb\\u52a0\",\"\\u4ea7\\u5730\":\"\\u65e5\\u672c\"}', '1484570726', '1486742400', 'F994FC1C-7A5F-16A6-70E4-1672633B13D6', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('EE5D2613-2760-F18C-A447-B8E744FF509D', '原色开心果自然原色无漂白500g开口原味坚果零食本色干果炒货 ', '原色开心果自然原色无漂白500g开口原味坚果零食本色干果炒货', '0', '{\"\\u50a8\\u85cf\\u65b9\\u6cd5\":\"\\u9634\\u51c9\\u5e72\\u71e5\",\"\\u51c0\\u542b\\u91cf\":\"500g\",\"\\u98df\\u54c1\\u53e3\\u5473\":\"\\u76d0\\u7117\\u53e3\\u5473\",\"\\u54c1\\u724c\":\"\\u797a\\u5b9d\",\"\\u4fdd\\u8d28\\u671f:\":\"360\",\"\\u98df\\u54c1\\u6dfb\\u52a0\\u5242\":\"\\u67e0\\u6aac\\u9178\"}', '1484983798', '1585843200', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('F396C933-04BC-E46D-012F-AE67F7DD37EE', '清风抽纸原木纯品3层面巾纸婴儿家用纸巾整箱家庭装 ', '清风抽纸原木纯品3层面巾纸婴儿家用纸巾整箱家庭装 ', '0', '{\"\\u54c1\\u724c\":\"\\u6e05\\u98ce\",\"\\u662f\\u5426\\u91cf\\u8d29\\u88c5\":\"\\u5426\",\"\\u9762\\u5dfe\\u7eb8\\u79cd\\u7c7b\":\"\\u8f6f\\u5305\\u88c5\\u9762\\u5dfe\\u7eb8\",\"\\u539f\\u6750\\u6599\\u6210\\u5206\":\"\\u539f\\u751f\\u6d46\"}', '1484575927', '1486742400', 'D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('F72A0711-12B1-2360-6A79-023E0A6FB6BF', '正山小种茶叶 红茶茶叶 武夷山正山小种茶叶散装600克 五虎红茶', '                    正山小种茶叶 红茶茶叶 武夷山正山小种茶叶散装600克 五虎红茶                 ', '0', '{\"\\u4ea7\\u54c1\\u540d\\u79f0\":\"\\u4e94\\u864e 150\\u514b*4 \\u6b63\\u5c71\\u5c0f\\u79cd\",\"\\u51c0\\u542b\\u91cf\":\"600g\",\"\\u5305\\u88c5\\u65b9\\u5f0f:\":\"\\u5305\\u88c5\"}', '1484570266', '1486742400', '25D26743-4E79-4489-AB85-C6B773BA6588', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', '正品 Meitu/美图M6 秀秀美颜移动智能自拍神器美图手机4G全网通S', '正品 Meitu/美图M6 秀秀美颜移动智能自拍神器美图手机4G全网通S', '0', '{\"CPU\\u578b\\u53f7\":\"MT6755\",\"\\u4e0a\\u5e02\\u65f6\\u95f4\":\"2016\\u5e74\",\"\\u54c1\\u724c\":\"Meitu\\/\\u7f8e\\u56fe\",\"\\u540e\\u7f6e\\u6444\\u50cf\\u5934\":\" 2100\\u4e07\",\"\\u7f51\\u7edc\\u7c7b\\u578b\":\"4G\\u5168\\u7f51\\u901a\"}', '1484982962', '1489593600', '035979B6-A44A-32EA-646F-28A51C607A73', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('FB498C2A-0CB1-403B-A836-D602ABC96AB8', '秋冬季健身服男套装健身房三四五件套运动透气速干长袖跑步紧身衣', '秋冬季健身服男套装健身房三四五件套运动透气速干长袖跑步紧身衣', '0', '{\"\\u4e0a\\u88c5\\u6b3e\\u5f0f\":\"\\u957f\\u8896\",\"\\u529f\\u80fd\":\"\\u5438\\u6e7f\\u6392\\u6c57 \\u901f\\u5e72 \\u900f\\u6c14 \\u8d85\\u5f3a\\u5f39\\u6027\",\"\\u5c3a\\u7801\":\"M L XL XXL\",\"\\u4e0b\\u88c5\\u88e4\\u957f\":\"\\u957f\\u88e4\"}', '1484576146', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '2017春装新款女韩版时尚鱼尾红裙子小香风明星同款蕾丝红色连衣裙 ', '连衣裙', '0', '{\"\\u8896\\u578b\":\"\\u5e38\\u89c4\",\"\\u6d41\\u884c\\u5143\\u7d20\":\"\\u62fc\\u63a5 \\u62c9\\u94fe \\u857e\\u4e1d\",\"\\u8863\\u95e8\\u895f\":\"\\u5957\\u5934\",\"\\u56fe\\u6848\":\"\\u7eaf\\u8272\",\"\\u88d9\\u957f\":\"\\u4e2d\\u88d9\",\"\\u8170\\u578b:\":\"\\u9ad8\\u8170\"}', '1484577839', '1486742400', '57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '0', '0');
INSERT INTO `shopp_commodity` VALUES ('FF815C07-E3C4-C632-F29C-42FE92C32AF9', '充电式便携榨汁杯电动迷你果汁杯玻璃料理杯多功能小型榨汁机家用', '充电式便携榨汁杯电动迷你果汁杯玻璃料理杯多功能小型榨汁机家用', '0', '{\"\\u4e00\\u6b21\\u6027\\u6700\\u5927\\u51fa\\u6c41\\u91cf\":\"400ml\\u4ee5\\u4e0b\",\"\\u69a8\\u6c41\\u673a\\u9644\\u52a0\\u529f\\u80fd\":\"\\u51b0 \\u5e72\\u78e8 \\u6405\\u62cc \\u548c\\u9762 \\u6253\",\"\\u679c\\u8089\\u6e23\\u6ed3\\u76d2\\u5bb9\\u91cf\":\"500ml\\u4ee5\\u4e0b\\uff08\\u542b500m\",\"\\u54c1\\u724c\":\"\\u897f\\u5e03\\u6717\",\"\\u989c\\u8272\\u5206\\u7c7b\":\"\\u5ae9\\u7c89\\u8272 \\u679c\\u7eff\\u8272 \\u67e0\\u6aac\\u9ec4 \",\"\\u529f\\u7387\":\"150W\"}', '1484984403', '1611849600', 'B619C389-BE62-40B1-0F25-4B5E60B356D2', '0', '0');
INSERT INTO `shopp_commodity_images` VALUES ('031079F7-1308-1180-A3D9-504B0B64D018', '8C5CBC3B-C3A0-F078-2DC1-DD276D203A5E', '809FA808-4676-EC6A-66CA-7728D782977E.png');
INSERT INTO `shopp_commodity_images` VALUES ('0BF0872F-1938-4913-F73B-73B9448914C5', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', '5C5BDFF5-0994-E920-5329-6C442D94090E.png');
INSERT INTO `shopp_commodity_images` VALUES ('0C0AFBEA-FEF3-FD5E-94E1-A0826B4DB746', '26C82144-FCFB-AA3A-150D-2640FFF623F2', '0564D53A-BCD6-7435-6EE7-0D247C0F3BC5.png');
INSERT INTO `shopp_commodity_images` VALUES ('10E18D83-216D-B2DF-E103-E09E2753BDD0', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', '46090D57-4984-3269-7F54-49A0E7FECCD1.png');
INSERT INTO `shopp_commodity_images` VALUES ('1392DEEA-1C96-1926-ED21-A07BF51CFC23', 'F396C933-04BC-E46D-012F-AE67F7DD37EE', 'B10C4D0E-DC6B-E713-601B-295AD39E3082.png');
INSERT INTO `shopp_commodity_images` VALUES ('144B599F-9F4A-83A8-B3C1-5D9C30668018', '753C793E-1F5D-1DC7-4103-A23D23E016C2', 'B1BCB576-36D4-8F6E-3114-206FD038E8B8.png');
INSERT INTO `shopp_commodity_images` VALUES ('145CF272-25BC-51ED-1C34-BA84E35E8B40', '26C82144-FCFB-AA3A-150D-2640FFF623F2', '48E6E0F4-A946-4D2C-0B3C-7B987D1B6F53.png');
INSERT INTO `shopp_commodity_images` VALUES ('15667DF7-9FAC-22DF-03AD-00E467EDFEE3', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'D4C56046-57DD-C8E0-E3BA-57FAF9B6FBC7.png');
INSERT INTO `shopp_commodity_images` VALUES ('18B384BF-252C-055C-867B-0A50CA26BC57', 'D2BCDC64-0970-3775-3193-6D870A490A84', 'B24B12DA-8736-F61D-551C-88F7C7BA3FD7.png');
INSERT INTO `shopp_commodity_images` VALUES ('1B5D4B9C-0573-3AD9-ECEC-53470C1A9FA8', '26C82144-FCFB-AA3A-150D-2640FFF623F2', 'FECF77AC-68AA-DEF5-F18C-A93420E8DBBC.png');
INSERT INTO `shopp_commodity_images` VALUES ('1F37B464-4E65-342A-48C8-2E777DC143BF', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', '63A5FF97-4FAE-2B5E-F14D-EFDC3A62812C.png');
INSERT INTO `shopp_commodity_images` VALUES ('20941A17-D45B-17BC-5AFB-C9FA2BC5386B', '900AA834-8BF4-9826-3239-01487EF71BED', '34908851-BA41-5689-7AE7-797CCBF7D7DB.png');
INSERT INTO `shopp_commodity_images` VALUES ('23D612FC-375D-7425-2485-54DDA2124BE3', 'C3E30939-86EB-730F-900E-17B582155781', '69126D76-B2B3-7B3C-621B-B9F1FB582B25.png');
INSERT INTO `shopp_commodity_images` VALUES ('28D0E40F-CF7B-1785-B464-17A38349412E', '753C793E-1F5D-1DC7-4103-A23D23E016C2', '2CDE72D3-F3BD-886F-E70A-8F8E8C419D86.png');
INSERT INTO `shopp_commodity_images` VALUES ('28F9FADC-4EAB-A587-A934-66EE3FC931DA', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1', 'F8FDC530-B0A7-D38E-F728-32FA3E6E5960.png');
INSERT INTO `shopp_commodity_images` VALUES ('2A8D0474-F326-DD78-CBF8-10A7E0E193D5', '511676D4-6E5E-A943-02D2-23838D8A4B2A', '948CDB85-0B96-D5ED-90EE-362FF68685B0.png');
INSERT INTO `shopp_commodity_images` VALUES ('2BC978EF-DF92-BA80-3DD8-F738397A7A28', 'C3E30939-86EB-730F-900E-17B582155781', 'E0D075A6-ECFF-3F54-71EB-9A66BDAA2570.png');
INSERT INTO `shopp_commodity_images` VALUES ('2C2A28C8-49B8-BB5F-77DB-BB0FBB79A18C', '22B10E64-2792-9976-E179-2481FBD15CB5', 'C75D642C-41E4-B8AC-C161-C1233D990D15.png');
INSERT INTO `shopp_commodity_images` VALUES ('2F04B13C-FF65-4498-8388-E1368BE0E4A1', 'FF815C07-E3C4-C632-F29C-42FE92C32AF9', 'A25EE1C4-8BDC-8970-C36C-E7B3F92AB82E.png');
INSERT INTO `shopp_commodity_images` VALUES ('2F0EA931-BCAA-E635-0E3F-2587465D4C3E', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', 'CA7FBEEC-9C3A-0F9A-F1DE-31AFFE731670.png');
INSERT INTO `shopp_commodity_images` VALUES ('3288E1BE-6DFF-3712-EC7C-406C53B3D370', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF', '46197659-86BD-5714-0C2B-CEDE85DE5B41.png');
INSERT INTO `shopp_commodity_images` VALUES ('340C2B2E-5214-1C4B-8C2F-AC42B00A6D7C', '22B10E64-2792-9976-E179-2481FBD15CB5', '66B366FE-CADE-B854-5EF0-6E2C240732F6.png');
INSERT INTO `shopp_commodity_images` VALUES ('362D1CD8-55B1-6BFD-BE69-71984E31599F', '8C5CBC3B-C3A0-F078-2DC1-DD276D203A5E', '2A61B114-7F8D-346F-DC1A-FE1B1C55C8A4.png');
INSERT INTO `shopp_commodity_images` VALUES ('3B41DE1D-48B2-FA19-2B99-10E7A957CF22', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', 'CF85986E-89DF-6017-C958-217D262E685D.png');
INSERT INTO `shopp_commodity_images` VALUES ('3F53DCF9-A0C8-123E-52E0-A34E0257EA92', 'FF815C07-E3C4-C632-F29C-42FE92C32AF9', 'B4216472-9070-32EE-F833-C6807B97C17A.png');
INSERT INTO `shopp_commodity_images` VALUES ('45F3D285-124F-63AF-B128-5ADBB4692750', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', '238A1288-FFBC-5FD4-A0DE-B53F79BA48BD.png');
INSERT INTO `shopp_commodity_images` VALUES ('48AEC2D0-9DFE-9A4C-277D-A09693DD3542', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '5B82284D-D583-9E48-BD71-2DB7F9DCF779.png');
INSERT INTO `shopp_commodity_images` VALUES ('48F200D0-CDF2-8267-F997-B8D3D9DC695F', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D', '06CBE955-8C6F-C711-2626-60359FBF0D94.png');
INSERT INTO `shopp_commodity_images` VALUES ('4EA5B7D2-6440-F687-C75B-F5287F516512', 'B4052C46-F17D-CBD1-4BCF-29DF877B6FA5', '22CF38EA-18FF-9F7C-BEBF-6C94F389062C.png');
INSERT INTO `shopp_commodity_images` VALUES ('5185B236-004C-71EF-1048-4E18A11A1F00', '511676D4-6E5E-A943-02D2-23838D8A4B2A', 'B9127AAB-6B8D-2FE3-669E-55F296397595.png');
INSERT INTO `shopp_commodity_images` VALUES ('52753AF0-0AE7-0C03-FD03-72E006A350F0', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', 'DD003367-BE0B-5942-6582-7A5E26DE8ADA.png');
INSERT INTO `shopp_commodity_images` VALUES ('5353F321-1ED4-DAAC-6D9E-3824CAD0C96D', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', '7187256B-2479-F5D7-00EE-A3C35F40C3A0.png');
INSERT INTO `shopp_commodity_images` VALUES ('558B1843-F7AA-A7FC-B7BB-10321225A0A1', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF', '23D2D5D4-E656-41D0-E656-66C29FACFF24.png');
INSERT INTO `shopp_commodity_images` VALUES ('5685F676-AC9D-ECAF-FB5D-B93AC309CA33', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851', '7045C8F7-2A0D-37A9-A618-4E3011B6CBF7.png');
INSERT INTO `shopp_commodity_images` VALUES ('57F0F7B0-6C79-B401-B214-82F3E09774B1', '934AE8D8-B061-C383-3FE1-6566C597B7F4', 'F19A377F-166D-FDB7-9216-356E060E7125.png');
INSERT INTO `shopp_commodity_images` VALUES ('59FB4B2C-48EA-791F-59F6-4553C369656F', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', 'BF0520D2-A9C3-8DEE-11F4-04FA8EF6FAD6.png');
INSERT INTO `shopp_commodity_images` VALUES ('5F3DDB72-DE2A-6A74-75BF-56C716B7D861', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8', '8823B821-3A03-FB0C-633F-D60EED429CE2.png');
INSERT INTO `shopp_commodity_images` VALUES ('643F82EF-7F61-3C9B-6C76-62D5255C2557', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'B3195156-9300-44C5-56FB-552D8D67FFD7.png');
INSERT INTO `shopp_commodity_images` VALUES ('67281DD3-34A5-9FA1-1E74-E7FB6F0D5CE2', '6FFC6691-7F05-8AB8-B1E1-5C839BB4F446', '33C5B3E9-5A00-6B10-3CDF-B5DAE2F38165.png');
INSERT INTO `shopp_commodity_images` VALUES ('673D94FA-01E2-6F9F-D35F-9F87C3CA22F7', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', '6350699E-CD5B-DC0A-198C-78320274A619.png');
INSERT INTO `shopp_commodity_images` VALUES ('6CDB09E3-6B1A-D0FF-C0A9-AFF9069CAA9E', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D', 'E2D358F8-FA78-D90A-0C16-75B63185C9FD.png');
INSERT INTO `shopp_commodity_images` VALUES ('6EE2613D-FC89-AE02-82A7-7D650D0698EB', 'B4052C46-F17D-CBD1-4BCF-29DF877B6FA5', 'D46A95BE-F796-F431-F482-6734C01B4E71.png');
INSERT INTO `shopp_commodity_images` VALUES ('71C7A57B-9009-C51E-05E6-F04994140EE3', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', '5500728D-D2E8-8AD6-2BAA-D1CDDD814E3C.png');
INSERT INTO `shopp_commodity_images` VALUES ('732BE371-9B32-4E16-6DC7-FB01B28A04CA', '511676D4-6E5E-A943-02D2-23838D8A4B2A', '23067377-7E94-10E7-5C34-21645A37329D.png');
INSERT INTO `shopp_commodity_images` VALUES ('7AB05D8B-E47E-11B3-5D04-65A1F207FC7A', 'EE5D2613-2760-F18C-A447-B8E744FF509D', '8297B86A-D2A5-D1DB-24C9-4D4CB92D3A07.png');
INSERT INTO `shopp_commodity_images` VALUES ('7B5A092C-F92E-3032-40DB-80299977754D', '37B10231-4225-C269-DB28-F1C40A6CA448', 'B1146293-F799-9106-575F-C4B6C0B1AF73.png');
INSERT INTO `shopp_commodity_images` VALUES ('7CF79B74-B70C-B0EB-2B98-A2ED8A983D11', 'FF815C07-E3C4-C632-F29C-42FE92C32AF9', 'FBD41B53-220E-6EDF-57C7-F40EF67E6B4F.png');
INSERT INTO `shopp_commodity_images` VALUES ('7DB13D3C-18C4-3B1E-6464-7901E11398A9', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', 'A7C465B2-E5B6-FDFE-0C69-A57BE07D7071.png');
INSERT INTO `shopp_commodity_images` VALUES ('8424C292-BD6F-2491-F6CD-CFCDAB9EA8B5', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8', 'D378C0BD-532B-A999-D988-01384C0A5708.png');
INSERT INTO `shopp_commodity_images` VALUES ('869CD882-5FB6-3F00-0A4E-2C4EB51924D1', '934AE8D8-B061-C383-3FE1-6566C597B7F4', 'A17ACA04-F280-E772-D52B-F55D49DD0CCD.png');
INSERT INTO `shopp_commodity_images` VALUES ('86E7BA6E-4A64-B962-D39B-62AA28347098', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '28B656EC-ABAF-B5B4-6F1B-C2BE11321F1D.png');
INSERT INTO `shopp_commodity_images` VALUES ('8FFE6AE0-B9AB-A8CE-47CB-5D54AB240FAD', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', 'D0F95870-2579-75A2-26FB-173395EEB45E.png');
INSERT INTO `shopp_commodity_images` VALUES ('91CBA1F6-21A4-DE27-A244-42E3A9840DA7', 'EE5D2613-2760-F18C-A447-B8E744FF509D', '0B6435C4-6E03-D2B0-60B6-2E0D2153A68F.png');
INSERT INTO `shopp_commodity_images` VALUES ('9CD73629-7F0D-C139-15A0-30F8BF9C2733', 'D2BCDC64-0970-3775-3193-6D870A490A84', '703BFFC9-E206-E21A-772A-F8E9A869A952.png');
INSERT INTO `shopp_commodity_images` VALUES ('9D02D13E-A08D-B554-F789-742E5F03980A', 'C3E30939-86EB-730F-900E-17B582155781', '123F7DC5-5222-AF32-C0A8-648F51DF0324.png');
INSERT INTO `shopp_commodity_images` VALUES ('9DFBE04C-CA62-7FD7-580D-CB875B00014D', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '8197BF6B-16CE-A046-33A9-3D731E2E3D11.png');
INSERT INTO `shopp_commodity_images` VALUES ('A0D58D68-BDDB-F909-CBB6-494C75BB1206', 'D2BCDC64-0970-3775-3193-6D870A490A84', '6CB82C67-F8A9-BFE2-8F59-21524B90D7A4.png');
INSERT INTO `shopp_commodity_images` VALUES ('A258E03C-C85F-A856-DF40-6842D6CCF63C', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'FAF79646-6C06-14DD-58C2-493F260D9448.png');
INSERT INTO `shopp_commodity_images` VALUES ('A4A73C7A-46AD-F92B-DC43-F6279FB5306E', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'C48809C5-1916-F829-8490-3A99D06CC7C8.png');
INSERT INTO `shopp_commodity_images` VALUES ('A78D62A0-E0D0-970C-703E-B96CF7701470', '934AE8D8-B061-C383-3FE1-6566C597B7F4', '580D5E61-87CF-50C7-3F53-5F4A1D886580.png');
INSERT INTO `shopp_commodity_images` VALUES ('AB688D8F-D99C-41FA-E672-1D3CEBC9C2BC', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066', '9AD3F274-6DD5-EF22-88E9-FAE738C2F085.png');
INSERT INTO `shopp_commodity_images` VALUES ('AD7C7006-DDAD-5BC4-6979-BE52BCB347E4', '753C793E-1F5D-1DC7-4103-A23D23E016C2', '998CC4B9-2DBA-631E-8604-20B1FF70EE38.png');
INSERT INTO `shopp_commodity_images` VALUES ('ADD99A97-DA0B-0623-0AC4-82D1E537B1FD', '6FFC6691-7F05-8AB8-B1E1-5C839BB4F446', '59395775-928E-A845-172F-1284CFCE87E2.png');
INSERT INTO `shopp_commodity_images` VALUES ('ADE35F01-19B3-597A-2B24-A33CF4B157DA', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'C6D7C71D-7826-A291-6321-B440785E72D0.png');
INSERT INTO `shopp_commodity_images` VALUES ('B0B7D637-E98A-5F02-27F2-BB169330D1DC', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E', '1B35A50B-7845-92A9-0E06-EFBB32F01631.png');
INSERT INTO `shopp_commodity_images` VALUES ('B9FF52B8-95F2-18E8-55A5-994465A1CDA6', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7', 'B8227999-745C-4AB6-C95D-C57E1924AED8.png');
INSERT INTO `shopp_commodity_images` VALUES ('BA6A2FF8-B830-E558-3420-AF95D7F58707', '22B10E64-2792-9976-E179-2481FBD15CB5', '92C835A4-5DA5-0E43-8386-5C32378CC77C.png');
INSERT INTO `shopp_commodity_images` VALUES ('BAFDF589-1479-7D92-0D21-3D9FA7CA388F', '6D025479-654E-5D3F-2B6D-ECF783A2D918', 'B59440A9-3A93-B9E8-EBBA-53425F78A136.png');
INSERT INTO `shopp_commodity_images` VALUES ('BEFF68EF-B07E-B032-36FB-850F0FFBC50E', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', 'E56FA03A-738D-500E-F9C4-C84636B61F6F.png');
INSERT INTO `shopp_commodity_images` VALUES ('C0B7D3CA-73BC-2ABD-0CE4-E61A4E829B23', '37B10231-4225-C269-DB28-F1C40A6CA448', '1942A9BD-1C3B-3951-4019-C949EA86E993.png');
INSERT INTO `shopp_commodity_images` VALUES ('C2A118C9-1095-2765-EFD0-376C66BC6B09', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC', '4CA86FB7-9258-BC3A-C0C4-1F21005B59E9.png');
INSERT INTO `shopp_commodity_images` VALUES ('C8A8BAE2-418D-8F27-37D7-2969A761F2DC', 'F396C933-04BC-E46D-012F-AE67F7DD37EE', '7875BFCD-4332-B52D-797B-3F00FE252FF1.png');
INSERT INTO `shopp_commodity_images` VALUES ('CB420F6D-2768-F2BB-EE1B-31CCF0ABA4F5', '1C26D516-A5F1-7C2E-7158-8A658A3F9083', '32156F6D-2601-5460-EE18-6499A4A08901.png');
INSERT INTO `shopp_commodity_images` VALUES ('CCACBE2E-C88F-0283-8F1B-537D65E854D5', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1', 'F4BBC2CB-F41D-264B-6865-987381696B76.png');
INSERT INTO `shopp_commodity_images` VALUES ('D007DA3A-5ABB-D49C-9EAF-8AA591735A4F', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', '658CA3F7-2F95-C52C-3465-1B70EF681B29.png');
INSERT INTO `shopp_commodity_images` VALUES ('D70A6647-B13B-520F-8CF0-3E89C2DADC6A', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654', '1CE754AB-E7A0-5DE6-0959-91EC7A74735E.png');
INSERT INTO `shopp_commodity_images` VALUES ('DF70CE22-CB98-85AA-1C3A-B7C234B432AF', '6D025479-654E-5D3F-2B6D-ECF783A2D918', '5E975A04-3F5F-6DE9-83DF-7D4764C2103C.png');
INSERT INTO `shopp_commodity_images` VALUES ('E12DFC1F-969F-2CED-0422-B75C8250B099', 'B4052C46-F17D-CBD1-4BCF-29DF877B6FA5', 'C5AF23EC-756A-DB9E-99A5-8DA2B7D31EE5.png');
INSERT INTO `shopp_commodity_images` VALUES ('E7927A03-898A-81E8-92A9-1DAF7696EE82', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1', 'C6A718A3-4005-B19D-3C1A-DCCDB794D9DD.png');
INSERT INTO `shopp_commodity_images` VALUES ('E89B23AF-F90E-E165-6ECF-D0E63771A7C6', 'EE5D2613-2760-F18C-A447-B8E744FF509D', '1D6ECD1F-2D1B-4A9C-26BE-C5ACE83CE49E.png');
INSERT INTO `shopp_commodity_images` VALUES ('E9036D18-7C64-231D-EB98-010E4559BF8F', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D', 'C58CCEFD-34D8-E784-25C9-40685F4DD880.png');
INSERT INTO `shopp_commodity_images` VALUES ('EA9C9F7D-83C9-6327-35D3-08713DBE2D92', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', 'B521368A-73CA-C9E1-A427-F8CBC92E73A0.png');
INSERT INTO `shopp_commodity_images` VALUES ('EB55A182-6913-7F08-E7F4-41821E4F453F', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3', 'E841DE8F-35A5-7FC3-795B-4EB50BDACB7B.png');
INSERT INTO `shopp_commodity_images` VALUES ('F1E81D5D-8330-5595-EED8-19F1805C1FBE', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4', '89F7EE4C-1CA5-9245-D06E-EA9439918A75.png');
INSERT INTO `shopp_commodity_images` VALUES ('FC5CA25C-C2D8-6826-6548-E94562843927', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1', '5205796A-3BCE-0D01-2D39-1D6B66B84053.png');
INSERT INTO `shopp_commodity_images` VALUES ('FC7C5A24-E620-FD6E-FAFE-99DBC8672C75', '6D025479-654E-5D3F-2B6D-ECF783A2D918', 'B5E3030F-C5B2-4BF8-8F7E-E4199175D58F.png');
INSERT INTO `shopp_order` VALUES ('3D6DBFA3-624E-69DB-E8DE-5D26B9E33968', '2', '5D754767-F3D5-1D93-E588-856B288B08CC', '1483776627', '1483776627', '1483776627', '1483776627', '051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9');
INSERT INTO `shopp_order` VALUES ('8630AB36-897C-F23D-961E-B4ACB15D9C8A', '2', '5D754767-F3D5-1D93-E588-856B288B08CC', '1483030733', '1483030733', '1483030733', '1483030733', '051403B4-7CAA-66DF-FE3B-BEADD0FFE1E9');
INSERT INTO `shopp_order_specification` VALUES ('11E20DE9-8F7E-A426-B390-34FADFADAAE9', '8630AB36-897C-F23D-961E-B4ACB15D9C8A', '7D118229-AF8E-3C21-D440-6A3E4B94424A', '2');
INSERT INTO `shopp_order_specification` VALUES ('FB3FB3ED-EA8D-C17A-B0A7-EEDB49463133', '3D6DBFA3-624E-69DB-E8DE-5D26B9E33968', '64D63924-E57B-C610-6CEF-4E528BE1D391', '4');
INSERT INTO `shopp_specification` VALUES ('06E57510-C770-4863-BAAD-BDA23210E8A4', '套餐类型: 官方标配 ', '2780', '10', 'F7B2B9AF-0CE7-BCFA-194D-842C08DEA654');
INSERT INTO `shopp_specification` VALUES ('0959E8FD-75B4-F041-9820-C0038FDD68DD', '官方标配 :银色', '2800', '200', 'C3E30939-86EB-730F-900E-17B582155781');
INSERT INTO `shopp_specification` VALUES ('0D1906BE-F994-5DDE-6269-D6C7890DE379', 'M L XL 2XL', '2999', '200', '511676D4-6E5E-A943-02D2-23838D8A4B2A');
INSERT INTO `shopp_specification` VALUES ('0D6B0C51-712A-6270-08E9-39811DA6A3D1', '350g', '20', '1000', 'B45A2DB7-6698-C70C-1AD5-94E3E5E7E6A1');
INSERT INTO `shopp_specification` VALUES ('0E034B9B-648E-48D1-78D6-B0D615B6E06F', '165/84(S)', '90', '90', '26C82144-FCFB-AA3A-150D-2640FFF623F2');
INSERT INTO `shopp_specification` VALUES ('0EF2F6DF-6CAE-7DEE-9507-F4DC2C913AFB', '官方标配 :金色', '2500', '2100', 'C3E30939-86EB-730F-900E-17B582155781');
INSERT INTO `shopp_specification` VALUES ('119CD58F-4126-CF58-BEC2-1567ADB34E05', '1800x2000mm', '2000', '200', 'D708E35B-239A-0E3B-3988-B7EA5C3A3066');
INSERT INTO `shopp_specification` VALUES ('143FDD53-49C8-A58C-CEC6-740FD97D479E', '1件', '179', '200', 'FEF2C2E1-6304-F2CF-C1C7-EA18C9C219EC');
INSERT INTO `shopp_specification` VALUES ('1789246F-6560-1F5D-2584-704C0918A719', 'M LS M', '2000', '100', '753C793E-1F5D-1DC7-4103-A23D23E016C2');
INSERT INTO `shopp_specification` VALUES ('1FFC4E4C-B777-D0B5-2B79-766B35713043', '官方标配1台', '7000', '2300', '22B10E64-2792-9976-E179-2481FBD15CB5');
INSERT INTO `shopp_specification` VALUES ('209CF837-B514-76ED-4839-BF003468C806', '420L', '250', '5200', 'FF815C07-E3C4-C632-F29C-42FE92C32AF9');
INSERT INTO `shopp_specification` VALUES ('33408E74-4295-6354-1CE4-6E50432676EC', 'S码', '99', '10', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1');
INSERT INTO `shopp_specification` VALUES ('38BE888F-837B-B57D-E0ED-FB358C7AF49A', '一件', '200', '2000', '96A28FC7-E21C-2185-D3BC-4DD5FE91ADB7');
INSERT INTO `shopp_specification` VALUES ('3BE1F4C9-E437-BAD8-9019-423F492CF6B8', '16G/玫瑰金', '2999', '30', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('3C5050DC-8239-FCDF-25A2-1047B0C2CA28', '16G/银色', '2999', '30', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('467E4794-E139-9D4C-A001-648467AE4B50', 'M码', '199', '9', 'B33E6242-90AA-0E1A-17AE-3B2F7C20FBC1');
INSERT INTO `shopp_specification` VALUES ('525BAE0A-4415-3A40-769A-564DBF4F55FB', 'M L XL 2XL', '2999', '200', '900AA834-8BF4-9826-3239-01487EF71BED');
INSERT INTO `shopp_specification` VALUES ('583AD147-7DC7-4E13-A4F2-59ADDF81F1D0', '1件', '20', '200', '37B10231-4225-C269-DB28-F1C40A6CA448');
INSERT INTO `shopp_specification` VALUES ('64D63924-E57B-C610-6CEF-4E528BE1D391', '高配2K高清版', '999', '12', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('6C584A55-081F-D42C-F5F4-9F6810931FF9', '160抽', '13', '200', 'F396C933-04BC-E46D-012F-AE67F7DD37EE');
INSERT INTO `shopp_specification` VALUES ('6E4D44E5-6E5D-3ECE-C1DA-9D6A3BB1FA56', '200ml', '102', '200', 'E1A02C6D-C1C6-A748-983D-A236648BDCD4');
INSERT INTO `shopp_specification` VALUES ('7789A9EC-3B7A-403B-92D6-261B0E135D5D', 'S码；白色', '199', '10', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3');
INSERT INTO `shopp_specification` VALUES ('7897433D-81EB-C106-90CC-BA8A9A1C8DA5', '官方标配', '3000', '2000', '38B3FE41-5AB1-F2AF-3446-7E07D8DD8851');
INSERT INTO `shopp_specification` VALUES ('7B55E916-FE4D-F45C-51F5-361534DA9651', '32G/黑色', '3999', '45', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('84231135-44F5-BA48-ADBE-4F2377042F68', '600g', '68', '200', 'F72A0711-12B1-2360-6A79-023E0A6FB6BF');
INSERT INTO `shopp_specification` VALUES ('A024260D-F1BD-ED7E-2672-990E92B46CEB', 'M码', '356', '200', '6D025479-654E-5D3F-2B6D-ECF783A2D918');
INSERT INTO `shopp_specification` VALUES ('A5240E16-887D-D01F-1779-26E854A18728', '官方标配 :黑色', '2800', '200', 'C3E30939-86EB-730F-900E-17B582155781');
INSERT INTO `shopp_specification` VALUES ('A927A4FD-79FA-7DE2-F15C-2EEDDD0A5EC5', '四件套', '178', '200', 'FB498C2A-0CB1-403B-A836-D602ABC96AB8');
INSERT INTO `shopp_specification` VALUES ('B3A7547B-21AE-FBA4-EBD0-28C1EE3E416E', 'X9官方标配', '2589', '200', 'B4052C46-F17D-CBD1-4BCF-29DF877B6FA5');
INSERT INTO `shopp_specification` VALUES ('B8F3C770-F934-26BB-5FFE-FA59BF184ACB', 'M码；红色', '299', '10', '25AA487A-1A8F-A2A1-E1B5-78EA0EEC85A3');
INSERT INTO `shopp_specification` VALUES ('BBA63FF3-F72F-3255-2CE8-862C13A1A61B', '16G/金色', '2999', '30', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('BDE33C6F-A44C-ECC3-4585-6B493AD223F3', '白色普通版', '800', '20', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('BE3CB921-D7EF-AFD4-863A-630BDFD766D5', '62g', '19', '1000', '934AE8D8-B061-C383-3FE1-6566C597B7F4');
INSERT INTO `shopp_specification` VALUES ('C5F9E72E-411D-EBE1-BB9B-C03F32FB9685', ' 官方标配:白色', '1400', '200', '8C5CBC3B-C3A0-F078-2DC1-DD276D203A5E');
INSERT INTO `shopp_specification` VALUES ('D29F12CC-3CCF-5749-E84F-BD61DAC7E61C', '黑色普通版', '800', '26', '1C26D516-A5F1-7C2E-7158-8A658A3F9083');
INSERT INTO `shopp_specification` VALUES ('D500DD51-E503-4E21-4557-93007D0CC931', '500g', '50', '100', 'EE5D2613-2760-F18C-A447-B8E744FF509D');
INSERT INTO `shopp_specification` VALUES ('DA7CCCC7-2474-D9E5-EC31-4F41FDC62502', '170/88(M)', '100', '50', '26C82144-FCFB-AA3A-150D-2640FFF623F2');
INSERT INTO `shopp_specification` VALUES ('E3387241-DFB4-7485-DC85-827FF9BA7FD4', '260g', '10', '500', 'D5CD3549-48F1-F39A-F547-EF40372ECC5D');
INSERT INTO `shopp_specification` VALUES ('E9D96852-326D-478C-3C5B-572E70DF5A42', '1本', '20', '200', '6FFC6691-7F05-8AB8-B1E1-5C839BB4F446');
INSERT INTO `shopp_specification` VALUES ('EB21D608-1429-C0C9-6C6F-BA289F2085EC', '32G/玫瑰金', '3999', '50', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_specification` VALUES ('EDC4FAFF-BFBB-C4F1-763C-31011210F0CE', '正常规格 ：50ml', '50', '50', 'D2BCDC64-0970-3775-3193-6D870A490A84');
INSERT INTO `shopp_specification` VALUES ('F027BB76-65DD-762F-9E55-DFD9E8778FF4', '16G/黑色', '2999', '30', '72599D9A-E2FE-0D2C-B74A-DBDE17AA0E2E');
INSERT INTO `shopp_type` VALUES ('035979B6-A44A-32EA-646F-28A51C607A73', '手机数码');
INSERT INTO `shopp_type` VALUES ('25D26743-4E79-4489-AB85-C6B773BA6588', '美食');
INSERT INTO `shopp_type` VALUES ('57F48D6B-76A0-36DB-5F9B-103D007B9B9C', '服装');
INSERT INTO `shopp_type` VALUES ('B619C389-BE62-40B1-0F25-4B5E60B356D2', '家电');
INSERT INTO `shopp_type` VALUES ('D6B7AFDA-D508-4B1D-0D09-8AE2740A3485', '日常用品');
INSERT INTO `shopp_type` VALUES ('F994FC1C-7A5F-16A6-70E4-1672633B13D6', '美妆');
INSERT INTO `shopp_type` VALUES ('FCDB71E5-E93E-7BBC-6ADD-9DB3EE39B6F4', '图书');
INSERT INTO `shopp_user` VALUES ('5D754767-F3D5-1D93-E588-856B288B08CC', 'admin@qq.com', 'admin', '0ec0cebaee2a51bb93589ef32bb8341a228f320d', null, '11111', '201612161528083417.png', '', null);
