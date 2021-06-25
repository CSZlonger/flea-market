/*
 Navicat MySQL Data Transfer

 Source Server         : taobishe
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 119.45.4.12:3306
 Source Schema         : c_flea

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 08/04/2021 23:56:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chat_message
-- ----------------------------
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `admin_id` int(11) NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '内容',
  `read` tinyint(2) NULL DEFAULT NULL,
  `type` tinyint(2) NULL DEFAULT NULL,
  `msg_type` tinyint(2) NULL DEFAULT NULL,
  `session_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '聊天' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_message
-- ----------------------------
INSERT INTO `chat_message` VALUES (38, 66, 66, '你好', 0, 2, 1, '1616770940684', '2021-03-26 23:02:27');

-- ----------------------------
-- Table structure for flea_advert
-- ----------------------------
DROP TABLE IF EXISTS `flea_advert`;
CREATE TABLE `flea_advert`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `enable` tinyint(4) NULL DEFAULT NULL COMMENT '是否启用，0：禁用，1：启用',
  `link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '广告' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_advert
-- ----------------------------
INSERT INTO `flea_advert` VALUES (1, 'http://localhost:10001/img/banner-1.jpg', 1, NULL, 1, '2021-04-06 13:44:57');
INSERT INTO `flea_advert` VALUES (2, 'http://localhost:10001/img/banner-2.jpg', 1, NULL, 2, '2021-04-07 13:45:13');

-- ----------------------------
-- Table structure for flea_category
-- ----------------------------
DROP TABLE IF EXISTS `flea_category`;
CREATE TABLE `flea_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_category
-- ----------------------------
INSERT INTO `flea_category` VALUES (1, '图书', 'http://localhost:10001/img/icon-1.png', 1, '2021-04-06 19:33:12');
INSERT INTO `flea_category` VALUES (2, '电子产品', 'http://localhost:10001/img/icon-2.png', 2, '2021-04-07 19:35:03');
INSERT INTO `flea_category` VALUES (3, '其他', 'http://localhost:10001/img/icon-3.png', 3, '2021-04-08 19:35:23');

-- ----------------------------
-- Table structure for flea_goods
-- ----------------------------
DROP TABLE IF EXISTS `flea_goods`;
CREATE TABLE `flea_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物品名称',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '分类ID',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '上下架',
  `describe` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `member_id` int(11) NULL DEFAULT NULL COMMENT '会员ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_goods
-- ----------------------------
INSERT INTO `flea_goods` VALUES (2, 'java微信小程序代做', 1, 100.00, 'http://localhost:10001/img/goods-1.jpg', 2, NULL, 66, '2021-04-07 22:10:38');
INSERT INTO `flea_goods` VALUES (3, '正版java编程思想', 2, 100.00, 'http://localhost:10001/img/goods-2.jpg', 2, NULL, 66, '2021-04-07 22:12:05');
INSERT INTO `flea_goods` VALUES (4, '正版java编程思想', 3, 100.00, 'http://localhost:10001/img/goods-3.jpg', 2, NULL, 66, '2021-04-07 22:13:47');
INSERT INTO `flea_goods` VALUES (5, 'springboot代做', 1, 200.00, 'http://localhost:10001/img/goods-4.jpg', 1, NULL, 66, '2021-04-07 22:39:37');
INSERT INTO `flea_goods` VALUES (6, 'vue代做', 1, 200.00, 'http://localhost:10001/img/goods-4.jpg', 1, NULL, 66, '2021-04-06 22:39:40');
INSERT INTO `flea_goods` VALUES (7, 'android代做', 1, 300.00, 'http://localhost:10001/img/goods-5.jpg', 2, NULL, 66, '2021-04-05 22:39:43');
INSERT INTO `flea_goods` VALUES (8, 'springcloud编程', 1, 500.00, 'http://localhost:10001/img/goods-3.jpg', 0, NULL, 66, '2021-04-07 22:39:46');

-- ----------------------------
-- Table structure for flea_goods_pic
-- ----------------------------
DROP TABLE IF EXISTS `flea_goods_pic`;
CREATE TABLE `flea_goods_pic`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品图片' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_goods_pic
-- ----------------------------
INSERT INTO `flea_goods_pic` VALUES (1, 2, 'http://localhost:10001/img/goods-1.jpg');
INSERT INTO `flea_goods_pic` VALUES (2, 3, 'http://localhost:10001/img/goods-2.jpg');
INSERT INTO `flea_goods_pic` VALUES (3, 4, 'http://localhost:10001/img/goods-3.jpg');
INSERT INTO `flea_goods_pic` VALUES (4, 5, 'http://localhost:10001/img/goods-3.jpg');
INSERT INTO `flea_goods_pic` VALUES (5, 6, 'http://localhost:10001/img/goods-3.jpg');
INSERT INTO `flea_goods_pic` VALUES (6, 7, 'http://localhost:10001/img/goods-3.jpg');
INSERT INTO `flea_goods_pic` VALUES (7, 8, 'http://localhost:10001/img/goods-3.jpg');
INSERT INTO `flea_goods_pic` VALUES (13, 16, 'http://localhost:10001/fileupload/20210331/e893c18f-472d-4933-8ab6-783b800f1c67.png');

-- ----------------------------
-- Table structure for flea_member
-- ----------------------------
DROP TABLE IF EXISTS `flea_member`;
CREATE TABLE `flea_member`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信openid',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `real_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `login_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_member
-- ----------------------------
INSERT INTO `flea_member` VALUES (66, 'o1HEb0bbQgdd1aPNyr2ZXvutSU8U', '清风', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK3JVibuZg8wiaKG9ExyVJJT2R4s398eropw2qU7GhJEwgwNB8Y56GWh4dDHPSYTNcJXgmkvz4809SA/132', '1', '李正乐', '18112907714', 'test', '123456', '2021-04-07 11:36:47');
INSERT INTO `flea_member` VALUES (68, NULL, '微服汇', 'http://localhost:10001/img/avatar.png', NULL, '微服汇', '18112907714', 'lzl', '123456', '2021-04-07 14:31:19');

-- ----------------------------
-- Table structure for flea_member_address
-- ----------------------------
DROP TABLE IF EXISTS `flea_member_address`;
CREATE TABLE `flea_member_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NULL DEFAULT NULL COMMENT '会员id',
  `contacts` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `province_id` int(11) NULL DEFAULT NULL COMMENT '省',
  `province_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city_id` int(11) NULL DEFAULT NULL COMMENT '市',
  `city_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `district_id` int(11) NULL DEFAULT NULL COMMENT '区',
  `district_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `zipcode` int(11) NULL DEFAULT NULL COMMENT '邮编',
  `dft` tinyint(1) NULL DEFAULT NULL COMMENT '默认地址',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户地址' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_member_address
-- ----------------------------
INSERT INTO `flea_member_address` VALUES (9, 66, '微服汇', '18112907714', NULL, '北京市', NULL, '北京市', NULL, '东城区', '测试', NULL, 1, '2021-04-08 23:44:27');

-- ----------------------------
-- Table structure for flea_order
-- ----------------------------
DROP TABLE IF EXISTS `flea_order`;
CREATE TABLE `flea_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `order_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单金额',
  `order_status` tinyint(3) NULL DEFAULT NULL COMMENT '订单状态，0：已取消，1：待付款，2：已完成',
  `courier_num` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_order
-- ----------------------------
INSERT INTO `flea_order` VALUES (12, 66, '20210112371745', 300.00, 1, NULL, '', '2021-04-06 19:41:07');
INSERT INTO `flea_order` VALUES (13, 66, '20210113128992', 500.00, 1, NULL, NULL, '2021-04-06 21:44:36');
INSERT INTO `flea_order` VALUES (14, 66, '20210114402619', 500.00, 1, NULL, NULL, '2021-04-07 08:18:35');
INSERT INTO `flea_order` VALUES (15, 66, '20210120108511', 500.00, 1, NULL, NULL, '2021-04-06 16:06:50');
INSERT INTO `flea_order` VALUES (16, 66, '20210120867487', 500.00, 1, NULL, NULL, '2021-04-06 16:07:03');
INSERT INTO `flea_order` VALUES (17, 66, '20210124251284', 40.00, 1, NULL, NULL, '2021-04-05 19:38:22');
INSERT INTO `flea_order` VALUES (19, 66, '20210213615516', 200.00, 1, NULL, NULL, '2021-04-06 16:43:39');
INSERT INTO `flea_order` VALUES (21, 66, '20210213155607', 300.00, 1, NULL, NULL, '2021-04-06 16:50:22');
INSERT INTO `flea_order` VALUES (22, 66, '20210213074477', 300.00, 1, NULL, NULL, '2021-04-07 16:53:13');
INSERT INTO `flea_order` VALUES (23, 66, '20210213310273', 300.00, 2, NULL, NULL, '2021-04-06 16:54:33');
INSERT INTO `flea_order` VALUES (24, 66, '20210213900048', 500.00, 2, NULL, NULL, '2021-04-06 17:16:11');
INSERT INTO `flea_order` VALUES (25, 66, '20210213561945', 500.00, 2, NULL, NULL, '2021-04-06 17:20:56');

-- ----------------------------
-- Table structure for flea_order_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `flea_order_evaluation`;
CREATE TABLE `flea_order_evaluation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` int(11) NULL DEFAULT NULL COMMENT '订单id',
  `member_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评价内容',
  `star` int(11) NULL DEFAULT NULL,
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单评价' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_order_evaluation
-- ----------------------------
INSERT INTO `flea_order_evaluation` VALUES (2, NULL, 66, '请问可以代做springcloud项目吗', NULL, 2, '2021-02-10 19:34:00');
INSERT INTO `flea_order_evaluation` VALUES (3, NULL, 66, '这个是不是全新的呀', NULL, 2, '2021-03-12 00:10:12');

-- ----------------------------
-- Table structure for flea_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `flea_order_goods`;
CREATE TABLE `flea_order_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NULL DEFAULT NULL COMMENT '订单ID',
  `goods_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `num` int(11) NULL DEFAULT NULL COMMENT '数量',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单详情' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_order_goods
-- ----------------------------
INSERT INTO `flea_order_goods` VALUES (12, 12, 7, 'android代做', 1, 'http://localhost:10001/img/goods-5.jpg', 300.00);
INSERT INTO `flea_order_goods` VALUES (13, 13, 8, 'springcloud代做', 1, 'http://localhost:10001/img/goods-3.jpg', 500.00);
INSERT INTO `flea_order_goods` VALUES (14, 14, 8, 'springcloud代做', 1, 'http://localhost:10001/img/goods-3.jpg', 500.00);
INSERT INTO `flea_order_goods` VALUES (15, 15, 8, 'springcloud代做', 1, 'http://localhost:10001/img/goods-3.jpg', 500.00);
INSERT INTO `flea_order_goods` VALUES (16, 16, 8, 'springcloud代做', 1, 'http://localhost:10001/img/goods-3.jpg', 500.00);
INSERT INTO `flea_order_goods` VALUES (17, 17, 7, '家常小炒', 1, 'http://localhost:10001/img/goods-5.jpg', 30.00);
INSERT INTO `flea_order_goods` VALUES (18, 17, 4, '超值炸鸡', 1, 'http://localhost:10001/img/goods-3.jpg', 10.00);
INSERT INTO `flea_order_goods` VALUES (19, 19, 5, 'springboot代做', 1, 'http://localhost:10001/img/goods-4.jpg', 200.00);
INSERT INTO `flea_order_goods` VALUES (21, 21, 7, 'android代做', 1, 'http://localhost:10001/img/goods-5.jpg', 300.00);
INSERT INTO `flea_order_goods` VALUES (22, 22, 7, 'android代做', 1, 'http://localhost:10001/img/goods-5.jpg', 300.00);
INSERT INTO `flea_order_goods` VALUES (23, 23, 7, 'android代做', 1, 'http://localhost:10001/img/goods-5.jpg', 300.00);
INSERT INTO `flea_order_goods` VALUES (24, 24, 8, 'springcloud编程', 1, 'http://localhost:10001/img/goods-3.jpg', 500.00);
INSERT INTO `flea_order_goods` VALUES (25, 25, 8, 'springcloud编程', 1, 'http://localhost:10001/img/goods-3.jpg', 500.00);

-- ----------------------------
-- Table structure for flea_order_shipment
-- ----------------------------
DROP TABLE IF EXISTS `flea_order_shipment`;
CREATE TABLE `flea_order_shipment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `order_id` int(11) NULL DEFAULT NULL COMMENT '订单ID',
  `contacts` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `province_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省名称',
  `city_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市名称',
  `district_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地区名称',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单配送' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flea_order_shipment
-- ----------------------------
INSERT INTO `flea_order_shipment` VALUES (1, 21, NULL, '189111111111', NULL, NULL, NULL, '测试', NULL);
INSERT INTO `flea_order_shipment` VALUES (2, 22, NULL, '18888888888', NULL, NULL, NULL, '测试', NULL);
INSERT INTO `flea_order_shipment` VALUES (3, 23, NULL, '18911111111', NULL, NULL, NULL, '测试', NULL);
INSERT INTO `flea_order_shipment` VALUES (4, 24, NULL, '18888888888', NULL, NULL, NULL, '测试', NULL);
INSERT INTO `flea_order_shipment` VALUES (5, 25, NULL, '18111111111', NULL, NULL, NULL, '测试', NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盐',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d', 'YzcmCZNvbXocrsz9dm8e', '2803180149@qq.com', '18021418906', 1, '2021-04-05 11:11:11');
INSERT INTO `sys_user` VALUES (3, 'test', 'a9d83086409669f369d5deea4c69ca19e2c901408dee1adcbe2123b33f1d1ed5', 'C9P8MLcLjoBHJHOnBKyi', '123456@qq.com', NULL, 1, '2021-02-22 18:24:07');

SET FOREIGN_KEY_CHECKS = 1;
