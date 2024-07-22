/*
 Navicat Premium Data Transfer

 Source Server         : MySQL - Local
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : hoa_chat_thi_nghiem

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 22/07/2024 20:51:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_admin
-- ----------------------------
DROP TABLE IF EXISTS `account_admin`;
CREATE TABLE `account_admin`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_role_admin` int NOT NULL,
  `id_status_acc` int NOT NULL,
  `passwordAD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_change_pass` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE,
  INDEX `id_status_acc`(`id_status_acc` ASC) USING BTREE,
  INDEX `id_role_admin`(`id_role_admin` ASC) USING BTREE,
  CONSTRAINT `account_admin_ibfk_1` FOREIGN KEY (`id_status_acc`) REFERENCES `status_acc` (`id_status_acc`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `account_admin_ibfk_2` FOREIGN KEY (`id_role_admin`) REFERENCES `role_admin` (`id_role_admin`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of account_admin
-- ----------------------------
INSERT INTO `account_admin` VALUES ('dangthevu', 2, 1, '123456', '2024-07-15 12:44:09', '2024-07-15 12:44:09', 'Đặng Thế Vũ');
INSERT INTO `account_admin` VALUES ('nguyenphutai', 2, 1, '123456', '2024-07-15 12:44:09', '2024-07-15 12:44:09', 'Nguyễn Phú Tài');
INSERT INTO `account_admin` VALUES ('nguyenthuylinh', 2, 1, '123456', '2024-07-15 12:44:09', '2024-07-15 12:44:09', 'Nguyễn Thùy Linh');
INSERT INTO `account_admin` VALUES ('nguyenvanlenh', 2, 1, '123456', '2024-07-15 12:44:09', '2024-07-15 12:44:09', 'Nguyễn Văn Lênh');
INSERT INTO `account_admin` VALUES ('tranminhtuyen', 1, 1, '123456', '2024-07-15 12:44:09', '2024-07-15 12:44:09', 'Trần Minh Tuyên');

-- ----------------------------
-- Table structure for account_customer
-- ----------------------------
DROP TABLE IF EXISTS `account_customer`;
CREATE TABLE `account_customer`  (
  `id_user_customer` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pass` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_status_acc` int NOT NULL,
  `id_city` int NOT NULL,
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sex` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email_customer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone_customer` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `time_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_change_pass` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user_customer`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `id_status_acc`(`id_status_acc` ASC) USING BTREE,
  INDEX `id_city`(`id_city` ASC) USING BTREE,
  CONSTRAINT `account_customer_ibfk_1` FOREIGN KEY (`id_status_acc`) REFERENCES `status_acc` (`id_status_acc`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `account_customer_ibfk_2` FOREIGN KEY (`id_city`) REFERENCES `city` (`id_city`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of account_customer
-- ----------------------------
INSERT INTO `account_customer` VALUES (1, 'abc@gmail.com', '0000', 1, 1, NULL, NULL, NULL, NULL, NULL, '2024-07-15 15:34:20', '2024-07-20 16:04:29');

-- ----------------------------
-- Table structure for bill_detail
-- ----------------------------
DROP TABLE IF EXISTS `bill_detail`;
CREATE TABLE `bill_detail`  (
  `id_bill` int NOT NULL,
  `id_product` int NOT NULL,
  `quantity` int NOT NULL,
  `listed_price` bigint NOT NULL,
  `current_price` bigint NOT NULL,
  PRIMARY KEY (`id_bill`, `id_product`) USING BTREE,
  INDEX `id_product`(`id_product` ASC) USING BTREE,
  CONSTRAINT `bill_detail_ibfk_1` FOREIGN KEY (`id_bill`) REFERENCES `bills` (`id_bill`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bill_detail_ibfk_2` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of bill_detail
-- ----------------------------
INSERT INTO `bill_detail` VALUES (13, 17, 3, 3688100, 3543400);
INSERT INTO `bill_detail` VALUES (14, 29, 3, 2110000, 1990500);
INSERT INTO `bill_detail` VALUES (15, 8, 3, 2719400, 2655400);
INSERT INTO `bill_detail` VALUES (16, 25, 3, 4049300, 3958300);
INSERT INTO `bill_detail` VALUES (17, 33, 1, 2513700, 2408800);

-- ----------------------------
-- Table structure for bills
-- ----------------------------
DROP TABLE IF EXISTS `bills`;
CREATE TABLE `bills`  (
  `id_bill` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_status_bill` int NOT NULL,
  `id_city` int NOT NULL,
  `fullname_customer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_customer` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_customer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_customer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill_price` bigint NOT NULL,
  `total_price` bigint NOT NULL,
  `time_order` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_bill`) USING BTREE,
  INDEX `id_user`(`id_user` ASC) USING BTREE,
  INDEX `id_status_bill`(`id_status_bill` ASC) USING BTREE,
  INDEX `id_city`(`id_city` ASC) USING BTREE,
  CONSTRAINT `bills_ibfk_2` FOREIGN KEY (`id_status_bill`) REFERENCES `status_bill` (`id_status_bill`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bills_ibfk_3` FOREIGN KEY (`id_city`) REFERENCES `city` (`id_city`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `bills_ibfk_4` FOREIGN KEY (`id_user`) REFERENCES `account_customer` (`id_user_customer`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of bills
-- ----------------------------
INSERT INTO `bills` VALUES (13, 1, 4, 1, 'abc@gmail.com', '0123456789', 'customer@gmail.com', '123 ABC st.', 10630200, 10630200, '2024-07-22 13:31:06');
INSERT INTO `bills` VALUES (14, 1, 3, 1, 'abc@gmail.com', '0123456789', 'customer@gmail.com', '123 ABC st.', 5971500, 5971500, '2024-07-22 13:31:14');
INSERT INTO `bills` VALUES (15, 1, 1, 1, 'abc@gmail.com', '0123456789', 'customer@gmail.com', '123 ABC st.', 7966200, 7966200, '2024-07-22 13:31:24');
INSERT INTO `bills` VALUES (16, 1, 2, 1, 'abc@gmail.com', '0123456789', 'customer@gmail.com', '123 ABC st.', 11874900, 11874900, '2024-07-22 13:31:31');
INSERT INTO `bills` VALUES (17, 1, 3, 1, 'abc@gmail.com', '0123456789', 'customer@gmail.com', '123 ABC st.', 2408800, 2408800, '2024-07-22 13:31:38');

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city`  (
  `id_city` int NOT NULL AUTO_INCREMENT,
  `name_city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transport` bigint NOT NULL,
  PRIMARY KEY (`id_city`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of city
-- ----------------------------
INSERT INTO `city` VALUES (1, 'An Giang', 30000);
INSERT INTO `city` VALUES (2, 'Bà Rịa-Vũng Tàu', 30000);
INSERT INTO `city` VALUES (3, 'Bạc Liêu', 30000);
INSERT INTO `city` VALUES (4, 'Bắc Kạn', 30000);
INSERT INTO `city` VALUES (5, 'Bắc Giang', 30000);
INSERT INTO `city` VALUES (6, 'Bắc Ninh', 30000);
INSERT INTO `city` VALUES (7, 'Bến Tre', 30000);
INSERT INTO `city` VALUES (8, 'Bình Dương', 30000);
INSERT INTO `city` VALUES (9, 'Bình Định', 30000);
INSERT INTO `city` VALUES (10, 'Bình Phước', 30000);
INSERT INTO `city` VALUES (11, 'Bình Thuận', 30000);
INSERT INTO `city` VALUES (12, 'Cà Mau', 30000);
INSERT INTO `city` VALUES (13, 'Cao Bằng', 30000);
INSERT INTO `city` VALUES (14, 'TP Cần Thơ', 30000);
INSERT INTO `city` VALUES (15, 'TP Đà Nẵng', 30000);
INSERT INTO `city` VALUES (16, 'Đắk Lắk', 30000);
INSERT INTO `city` VALUES (17, 'Đắk Nông', 30000);
INSERT INTO `city` VALUES (18, 'Điện Biên', 30000);
INSERT INTO `city` VALUES (19, 'Đồng Nai', 30000);
INSERT INTO `city` VALUES (20, 'Đồng Tháp', 30000);
INSERT INTO `city` VALUES (21, 'Gia Lai', 30000);
INSERT INTO `city` VALUES (22, 'Hà Giang', 30000);
INSERT INTO `city` VALUES (23, 'Hà Nam', 30000);
INSERT INTO `city` VALUES (24, 'TP Hà Nội', 30000);
INSERT INTO `city` VALUES (25, 'Hà Tĩnh', 30000);
INSERT INTO `city` VALUES (26, 'Hải Dương', 30000);
INSERT INTO `city` VALUES (27, 'TP Hải Phòng', 30000);
INSERT INTO `city` VALUES (28, 'Hòa Bình', 30000);
INSERT INTO `city` VALUES (29, 'TP Hồ Chí Minh', 30000);
INSERT INTO `city` VALUES (30, 'Hậu Giang', 30000);
INSERT INTO `city` VALUES (31, 'Hưng Yên', 30000);
INSERT INTO `city` VALUES (32, 'Khánh Hòa', 30000);
INSERT INTO `city` VALUES (33, 'Kiên Giang', 30000);
INSERT INTO `city` VALUES (34, 'Kon Tum', 30000);
INSERT INTO `city` VALUES (35, 'Lai Châu', 30000);
INSERT INTO `city` VALUES (36, 'Lào Cai', 30000);
INSERT INTO `city` VALUES (37, 'Lạng Sơn', 30000);
INSERT INTO `city` VALUES (38, 'Lâm Đồng', 30000);
INSERT INTO `city` VALUES (39, 'Long An', 30000);
INSERT INTO `city` VALUES (40, 'Nam Định', 30000);
INSERT INTO `city` VALUES (41, 'Nghệ An', 30000);
INSERT INTO `city` VALUES (42, 'Ninh Bình', 30000);
INSERT INTO `city` VALUES (43, 'Ninh Thuận', 30000);
INSERT INTO `city` VALUES (44, 'Phú Thọ', 30000);
INSERT INTO `city` VALUES (45, 'Phú Yên', 30000);
INSERT INTO `city` VALUES (46, 'Quảng Bình', 30000);
INSERT INTO `city` VALUES (47, 'Quảng Nam', 30000);
INSERT INTO `city` VALUES (48, 'Quảng Ngãi', 30000);
INSERT INTO `city` VALUES (49, 'Quảng Ninh', 30000);
INSERT INTO `city` VALUES (50, 'Quảng Trị', 30000);
INSERT INTO `city` VALUES (51, 'Sóc Trăng', 30000);
INSERT INTO `city` VALUES (52, 'Sơn La', 30000);
INSERT INTO `city` VALUES (53, 'Tây Ninh', 30000);
INSERT INTO `city` VALUES (54, 'Thái Bình', 30000);
INSERT INTO `city` VALUES (55, 'Thái Nguyên', 30000);
INSERT INTO `city` VALUES (56, 'Thanh Hóa', 30000);
INSERT INTO `city` VALUES (57, 'Thừa Thiên Huế', 30000);
INSERT INTO `city` VALUES (58, 'Tiền Giang', 30000);
INSERT INTO `city` VALUES (59, 'Trà Vinh', 30000);
INSERT INTO `city` VALUES (60, 'Tuyên Quang', 30000);
INSERT INTO `city` VALUES (61, 'Vĩnh Long', 30000);
INSERT INTO `city` VALUES (62, 'Vĩnh Phúc', 30000);
INSERT INTO `city` VALUES (63, 'Yên Bái', 30000);

-- ----------------------------
-- Table structure for comment_news
-- ----------------------------
DROP TABLE IF EXISTS `comment_news`;
CREATE TABLE `comment_news`  (
  `id_comment` int NOT NULL AUTO_INCREMENT,
  `id_news` int NOT NULL,
  `id_user_customer` int NOT NULL,
  `time_comment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_comment`) USING BTREE,
  INDEX `id_news`(`id_news` ASC) USING BTREE,
  INDEX `id_user_customer`(`id_user_customer` ASC) USING BTREE,
  CONSTRAINT `comment_news_ibfk_1` FOREIGN KEY (`id_news`) REFERENCES `news` (`id_news`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_news_ibfk_2` FOREIGN KEY (`id_user_customer`) REFERENCES `account_customer` (`id_user_customer`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment_news
-- ----------------------------

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact`  (
  `id_contact` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `problem_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_problem` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_insert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_contact`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contact
-- ----------------------------

-- ----------------------------
-- Table structure for infor_web
-- ----------------------------
DROP TABLE IF EXISTS `infor_web`;
CREATE TABLE `infor_web`  (
  `id_infor` int NOT NULL AUTO_INCREMENT,
  `phone_web` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_web` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_web` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_infor`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of infor_web
-- ----------------------------

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id_news` int NOT NULL AUTO_INCREMENT,
  `title_news` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_news` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url_img_news` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `date_posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `quantity_comment` int NOT NULL DEFAULT 0,
  `nameAdmin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_news`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------

-- ----------------------------
-- Table structure for price_product
-- ----------------------------
DROP TABLE IF EXISTS `price_product`;
CREATE TABLE `price_product`  (
  `id_product` int NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `listed_price` bigint NOT NULL,
  `current_price` bigint NOT NULL,
  `nameAdmin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_product`, `date`) USING BTREE,
  CONSTRAINT `price_product_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of price_product
-- ----------------------------
INSERT INTO `price_product` VALUES (1, '2024-07-22 13:25:04', 4996000, 4916700, 'tuyen');
INSERT INTO `price_product` VALUES (2, '2024-07-22 13:25:04', 2536500, 2397400, 'tuyen');
INSERT INTO `price_product` VALUES (3, '2024-07-22 13:25:04', 3590500, 3590500, 'tuyen');
INSERT INTO `price_product` VALUES (4, '2024-07-22 13:25:04', 1663400, 1663400, 'tuyen');
INSERT INTO `price_product` VALUES (5, '2024-07-22 13:25:04', 1425200, 1342600, 'tuyen');
INSERT INTO `price_product` VALUES (6, '2024-07-22 13:25:04', 4627100, 4627100, 'tuyen');
INSERT INTO `price_product` VALUES (7, '2024-07-22 13:25:04', 4461100, 4461100, 'tuyen');
INSERT INTO `price_product` VALUES (8, '2024-07-22 13:25:04', 2719400, 2655400, 'tuyen');
INSERT INTO `price_product` VALUES (9, '2024-07-22 13:25:04', 3119100, 3036000, 'tuyen');
INSERT INTO `price_product` VALUES (10, '2024-07-22 13:25:04', 2438500, 2438500, 'tuyen');
INSERT INTO `price_product` VALUES (11, '2024-07-22 13:25:04', 959300, 959300, 'tuyen');
INSERT INTO `price_product` VALUES (12, '2024-07-22 13:25:04', 3762200, 3649800, 'tuyen');
INSERT INTO `price_product` VALUES (13, '2024-07-22 13:25:04', 4053000, 3986700, 'tuyen');
INSERT INTO `price_product` VALUES (14, '2024-07-22 13:25:04', 3605800, 3539800, 'tuyen');
INSERT INTO `price_product` VALUES (15, '2024-07-22 13:25:04', 933300, 845200, 'tuyen');
INSERT INTO `price_product` VALUES (16, '2024-07-22 13:25:04', 3892100, 3892100, 'tuyen');
INSERT INTO `price_product` VALUES (17, '2024-07-22 13:25:04', 3688100, 3543400, 'tuyen');
INSERT INTO `price_product` VALUES (18, '2024-07-22 13:25:04', 1129100, 983800, 'tuyen');
INSERT INTO `price_product` VALUES (19, '2024-07-22 13:25:04', 3627500, 3627500, 'tuyen');
INSERT INTO `price_product` VALUES (20, '2024-07-22 13:25:04', 4385200, 4385200, 'tuyen');
INSERT INTO `price_product` VALUES (21, '2024-07-22 13:25:04', 1080200, 1080200, 'tuyen');
INSERT INTO `price_product` VALUES (22, '2024-07-22 13:25:04', 1464500, 1464500, 'tuyen');
INSERT INTO `price_product` VALUES (23, '2024-07-22 13:25:04', 4545600, 4545600, 'tuyen');
INSERT INTO `price_product` VALUES (24, '2024-07-22 13:25:04', 501100, 501100, 'tuyen');
INSERT INTO `price_product` VALUES (25, '2024-07-22 13:25:04', 4049300, 3958300, 'tuyen');
INSERT INTO `price_product` VALUES (26, '2024-07-22 13:25:04', 939900, 939900, 'tuyen');
INSERT INTO `price_product` VALUES (27, '2024-07-22 13:25:04', 1697600, 1563600, 'tuyen');
INSERT INTO `price_product` VALUES (28, '2024-07-22 13:25:04', 2029400, 1917700, 'tuyen');
INSERT INTO `price_product` VALUES (29, '2024-07-22 13:25:04', 2110000, 1990500, 'tuyen');
INSERT INTO `price_product` VALUES (30, '2024-07-22 13:25:04', 4151500, 4008600, 'tuyen');
INSERT INTO `price_product` VALUES (31, '2024-07-22 13:25:04', 1391100, 1391100, 'tuyen');
INSERT INTO `price_product` VALUES (32, '2024-07-22 13:25:04', 2307300, 2254600, 'tuyen');
INSERT INTO `price_product` VALUES (33, '2024-07-22 13:25:04', 2408800, 2408800, 'tuyen');
INSERT INTO `price_product` VALUES (34, '2024-07-22 13:25:04', 1580300, 1580300, 'tuyen');
INSERT INTO `price_product` VALUES (35, '2024-07-22 13:25:04', 4122200, 3987800, 'tuyen');
INSERT INTO `price_product` VALUES (36, '2024-07-22 13:25:04', 2398900, 2398900, 'tuyen');
INSERT INTO `price_product` VALUES (37, '2024-07-22 13:25:04', 4730000, 4648300, 'tuyen');
INSERT INTO `price_product` VALUES (38, '2024-07-22 13:25:04', 4192100, 4192100, 'tuyen');
INSERT INTO `price_product` VALUES (39, '2024-07-22 13:25:04', 415700, 415700, 'tuyen');
INSERT INTO `price_product` VALUES (40, '2024-07-22 13:25:04', 4062800, 3968200, 'tuyen');
INSERT INTO `price_product` VALUES (41, '2024-07-22 13:25:04', 4334900, 4334900, 'tuyen');
INSERT INTO `price_product` VALUES (42, '2024-07-22 13:25:04', 1865600, 1798800, 'tuyen');
INSERT INTO `price_product` VALUES (43, '2024-07-22 13:25:04', 411300, 411300, 'tuyen');
INSERT INTO `price_product` VALUES (44, '2024-07-22 13:25:04', 2286700, 2140800, 'tuyen');
INSERT INTO `price_product` VALUES (45, '2024-07-22 13:25:04', 549900, 462600, 'tuyen');
INSERT INTO `price_product` VALUES (46, '2024-07-22 13:25:04', 4209000, 4209000, 'tuyen');
INSERT INTO `price_product` VALUES (47, '2024-07-22 13:25:04', 4831700, 4780100, 'tuyen');
INSERT INTO `price_product` VALUES (48, '2024-07-22 13:25:04', 4412300, 4412300, 'tuyen');
INSERT INTO `price_product` VALUES (49, '2024-07-22 13:25:04', 1217200, 1217200, 'tuyen');
INSERT INTO `price_product` VALUES (50, '2024-07-22 13:25:04', 3804800, 3688300, 'tuyen');
INSERT INTO `price_product` VALUES (51, '2024-07-22 13:25:04', 2947700, 2855600, 'tuyen');
INSERT INTO `price_product` VALUES (52, '2024-07-22 13:25:04', 484700, 366900, 'tuyen');
INSERT INTO `price_product` VALUES (53, '2024-07-22 13:25:04', 4035700, 3900800, 'tuyen');
INSERT INTO `price_product` VALUES (54, '2024-07-22 13:25:04', 4267300, 4160800, 'tuyen');
INSERT INTO `price_product` VALUES (55, '2024-07-22 13:25:04', 4263400, 4186200, 'tuyen');
INSERT INTO `price_product` VALUES (56, '2024-07-22 13:25:04', 2252300, 2156800, 'tuyen');
INSERT INTO `price_product` VALUES (57, '2024-07-22 13:25:04', 667200, 667200, 'tuyen');
INSERT INTO `price_product` VALUES (58, '2024-07-22 13:25:04', 822500, 744400, 'tuyen');
INSERT INTO `price_product` VALUES (59, '2024-07-22 13:25:04', 4639900, 4639900, 'tuyen');
INSERT INTO `price_product` VALUES (60, '2024-07-22 13:25:04', 3718200, 3591100, 'tuyen');
INSERT INTO `price_product` VALUES (61, '2024-07-22 13:25:04', 1110300, 1110300, 'tuyen');
INSERT INTO `price_product` VALUES (62, '2024-07-22 13:25:04', 2464000, 2464000, 'tuyen');
INSERT INTO `price_product` VALUES (63, '2024-07-22 13:25:04', 347400, 347400, 'tuyen');
INSERT INTO `price_product` VALUES (64, '2024-07-22 13:25:04', 1057200, 1057200, 'tuyen');
INSERT INTO `price_product` VALUES (65, '2024-07-22 13:25:04', 639800, 499600, 'tuyen');
INSERT INTO `price_product` VALUES (66, '2024-07-22 13:25:04', 1275100, 1275100, 'tuyen');
INSERT INTO `price_product` VALUES (67, '2024-07-22 13:25:04', 4376300, 4270600, 'tuyen');
INSERT INTO `price_product` VALUES (68, '2024-07-22 13:25:04', 1809600, 1668200, 'tuyen');
INSERT INTO `price_product` VALUES (69, '2024-07-22 13:25:04', 3155300, 3155300, 'tuyen');
INSERT INTO `price_product` VALUES (70, '2024-07-22 13:25:04', 2354200, 2284200, 'tuyen');
INSERT INTO `price_product` VALUES (71, '2024-07-22 13:25:04', 978200, 893000, 'tuyen');
INSERT INTO `price_product` VALUES (72, '2024-07-22 13:25:04', 4817500, 4817500, 'tuyen');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id_product` int NOT NULL AUTO_INCREMENT,
  `id_type_product` int NOT NULL,
  `id_status_product` int NOT NULL,
  `id_supplier` int NOT NULL,
  `name_product` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description_product` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `url_img_product` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `quantity_product` int NOT NULL,
  `date_inserted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `star_review` tinyint NULL DEFAULT 4,
  `nameAdmin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_product`) USING BTREE,
  INDEX `id_type_product`(`id_type_product` ASC) USING BTREE,
  INDEX `id_status_product`(`id_status_product` ASC) USING BTREE,
  INDEX `id_supplier`(`id_supplier` ASC) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`id_type_product`) REFERENCES `type_product` (`id_type_product`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`id_status_product`) REFERENCES `status_product` (`id_status_product`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_ibfk_3` FOREIGN KEY (`id_supplier`) REFERENCES `suppliers` (`id_supplier`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 1, 1, 1, 'Air Force 1 - \'07 LV8', 'Thoải mái, bền bỉ và vượt thời gian—không có lý do gì nó là số 1. Cấu trúc cổ điển của thập niên 80 được kết hợp với các chi tiết lấy cảm hứng từ môn chơi gôn để tạo nên phong cách phù hợp cho dù bạn đang ở trên sân hay đang di chuyển.', '/Content/Images/Products/Giay/Nike/air-force-one-2.jpg', 100, '2024-07-22 12:53:08', 4, 'tuyen');
INSERT INTO `products` VALUES (2, 1, 1, 1, 'Air Force 1 Low By You', 'Tỏa sáng với chất sa-tanh, vẫn cổ điển với vải canvas hoặc sang trọng với chất liệu da. Cho dù bạn chọn gì thì những chiếc AF-1 này đều là về bạn. 12 lựa chọn màu sắc và tùy chọn cao su bổ sung cho đế duy nhất có nghĩa là thiết kế của bạn sẽ trở thành độc nhất vô nhị—giống như bạn.', '/Content/Images/Products/Giay/Nike/air-force-one-black-white.png', 100, '2024-07-22 12:54:14', 4, 'tuyen');
INSERT INTO `products` VALUES (3, 1, 1, 1, 'Air Forec 1 Shadow Black', 'Turf X Crazyfast.3  Adidas Turf X Crazyfast.3 \"Bright Royal\" ID9338 là mẫu giày đá bóng dành cho sân cỏ nhân tạo được thiết kế để mang đến tốc độ và sự linh hoạt tối ưu cho người chơi. Đặc điểm chi tiết: Thiết kế hiện đại, trẻ trung: Gam màu \"Bright Royal\" nổi bật kết hợp với các đường nét.', '/Content/Images/Products/Giay/Nike/air-force-one.jpg', 37, '2022-12-01 14:34:15', 5, 'tai');
INSERT INTO `products` VALUES (4, 1, 1, 1, 'Air Max 95 Houston Away', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Nike/air-max-95-houston-away.jpg', 78, '2022-12-06 13:43:09', 5, 'lenh');
INSERT INTO `products` VALUES (5, 1, 3, 1, 'Air Max Asix Adiform', 'Air Max Asix \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Nike/air-max-asix.jpg', 50, '2022-12-06 13:56:13', 5, 'tuyen');
INSERT INTO `products` VALUES (6, 1, 4, 1, 'Nike Cortez Originals', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Nike/nike-cortez.png', 130, '2022-12-06 13:56:35', 5, 'lenh');
INSERT INTO `products` VALUES (7, 1, 1, 1, 'PG-4 Black Adilette', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Nike/pg-4-black.jpg', 500, '2022-12-06 14:01:28', 5, 'tuyen');
INSERT INTO `products` VALUES (8, 1, 3, 1, 'Sakai Black Nylon', 'Sakai Black Nylon \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Nike/sakai-black-nylon.jpg', 786, '2022-12-06 14:03:01', 5, 'lenh');
INSERT INTO `products` VALUES (9, 1, 1, 1, 'X Sacai Blazer Low', 'X Sacai Blazer Low \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Nike/x-sacai-blazer-low.png', 232, '2022-12-06 14:05:41', 4, 'lenh');
INSERT INTO `products` VALUES (10, 2, 2, 2, 'Forum 84 Low', 'Forum 84 Low \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Adidas/forum-84-low.png', 0, '2022-12-06 14:07:25', 5, 'lenh');
INSERT INTO `products` VALUES (11, 2, 4, 2, 'Neo VL 2.0 Cream Brow', 'Bạn đang tìm kiếm một đôi giày mang đậm phong cách thể thao và đồng thời cực kỳ thoải mái? Đừng bỏ qua mẫu Giày Adidas Neo VL Court 2.0 Cream Brown ID6016. Với thiết kế tinh tế, chất liệu chất lượng và sự kết hợp màu sắc độc đáo, đôi giày này sẽ là sự lựa chọn hoàn hảo cho những người yêu thích thời trang và các hoạt động thể thao.\r\n\r\n', '/Content/Images/Products/Giay/Adidas/neo-vl-court-2.0-cream-brow.jpg', 100, '2024-07-22 13:02:14', 4, 'tuyen');
INSERT INTO `products` VALUES (12, 2, 3, 2, 'Neo Entrap \'Cloud White\'', 'Bạn không chỉ là một người hâm mộ. Bạn đã yêu thích bóng rổ kể từ khi bạn có thể nhớ được. Đó là trò chơi của bạn. Đôi giày lấy cảm hứng từ bóng rổ adidas này sẽ kể cho mọi người nghe về niềm đam mê và phong cách suốt đời của bạn mà không cần nói một lời. Lớp đệm sang trọng giúp bạn thoải mái cả ngày, vì vậy bạn có thể thoải mái đi lại.', '/Content/Images/Products/Giay/Adidas/neo-entrap.png', 100, '2024-07-22 13:00:38', 4, 'tuyen');
INSERT INTO `products` VALUES (13, 2, 2, 2, 'Racer FY6075 2B', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Adidas/racer.jpg', 0, '2022-12-08 14:58:00', 5, 'tai');
INSERT INTO `products` VALUES (14, 2, 2, 2, 'Runfalcon Running', 'Runfalcon Running \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Adidas/runfalcon-3-tr-running.jpg', 0, '2022-12-14 15:08:31', 4, 'tuyen');
INSERT INTO `products` VALUES (15, 2, 3, 2, 'Stan Smith 7', 'Cuộn với cổ điển. Ngày xưa Stan Smith thắng lớn trên sân quần vợt. Hãy mang vào đôi giày adidas xứng đáng với tên tuổi của anh ấy và bạn sẽ thắng lớn trên đường phố. Từ trên xuống dưới, những đôi giày này mang phong cách thiết yếu của nguyên bản năm 1971, với chất liệu da tối giản và đường viền gọn gàng.', '/Content/Images/Products/Giay/Adidas/stan-smith.jpg', 100, '2024-07-22 13:04:04', 4, 'tuyen');
INSERT INTO `products` VALUES (16, 2, 3, 2, 'Superstar Adifom', 'Đôi giày adidas Superstar đang tiến vào metaverse với cách biến tấu kiểu dáng mũi vỏ sò độc đáo này. Phiên bản slip-on hầm hố này làm bằng mút xốp có sử dụng cây mía để tạo ra một thiết kế độc nhất vô nhị. Đây là bước tiến tiên phong vào phát triển bền vững và tương lai của thời trang.', '/Content/Images/Products/Giay/Adidas/superstar-adifom.jpg', 100, '2024-07-22 13:05:25', 4, 'tuyen');
INSERT INTO `products` VALUES (17, 2, 1, 2, 'X Plrphase Tiger GSM', 'Hãy để lớp đệm siêu mềm mại của đôi giày adidas này là lời nhắc bạn ra ngoài hít thở không khí trong lành. Dạo bước ngoài công viên. Đi bộ về văn phòng. Đôi giày này có thiết kế giúp bạn di chuyển thoải mái và dễ chịu. Với đế giữa BOOST và Bounce, từng sải bước đều thật nhẹ nhàng.\r\n', '/Content/Images/Products/Giay/Adidas/x-plrphase.jpg', 97, '2024-07-22 13:06:14', 4, 'tuyen');
INSERT INTO `products` VALUES (18, 3, 1, 1, 'Air Jordan 1 Low', 'Đôi giày Air Jordan 1 Low Smoke Grey này là một phối màu hoàn toàn mới của Air Jordan 1 huyền thoại, được chế tác từ sự pha trộn độc đáo của da cao cấp cùng ba tone màu xám, trắng và đen chủ đạo bao chọn toàn độ đôi giày vô cùng ấn tượng mà bạn khó có thể tìm ra ở đôi giày khác bởi cách chặn màu vô cùng gọn gàng, khéo léo. Và tất nhiên không thể thiếu Nike Swoosh bóng loáng quen thuộc hài hòa nổi bật với tone nền trắng sáng, cùng logo Jumpman trên phần lưỡi gà và wings logo đặc trưng  mỗi đôi AJ1 thêu nổi phía sau gót giày.', '/Content/Images/Products/Giay/Jordan/air-jordan-1-low.png', 100, '2024-02-06 13:07:45', 4, 'tuyen');
INSERT INTO `products` VALUES (19, 3, 3, 1, 'CZ0790 Low University Red', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Jordan/cz0790-161-low-og-university-red.png', 961, '2021-04-06 10:46:44', 5, 'tai');
INSERT INTO `products` VALUES (20, 3, 3, 1, 'Dunk Low Core', 'Hãy biến sải chân của bạn trở thành biểu tượng với đôi Air Jordan 1. Đôi da màu xám trung bình cổ điển với chi tiết lông đuôi ngựa xuyên suốt, trong khi các chi tiết được chế tác thủ công như phần cứng logo Metal Silver Wings tăng thêm vẻ sang trọng cho bất kỳ chiếc giày nào \'vừa vặn\'. Sự hoàn thiện cuối cùng? Lớp đệm khí dưới chân giúp bạn giữ tốc độ một cách thoải mái, do đó, không gì có thể ngăn cản bạn thể hiện vẻ ngoài huyền thoại của mình.', '/Content/Images/Products/Giay/Jordan/dunk-low.jpg', 957, '2006-07-21 22:52:26', 5, 'linh');
INSERT INTO `products` VALUES (21, 3, 1, 1, 'Jordan Series ES', 'Nếu chúng tôi chỉ sản xuất một loại giày chạy bộ thì đó sẽ là Fresh Foam X 1080. Sự kết hợp độc đáo giữa sự thoải mái đáng tin cậy và hiệu suất cao mang đến sự linh hoạt kéo dài hàng ngày cho đến ngày đua. Lớp đệm đế giữa Fresh Foam X được thiết kế để chuyển tiếp suôn sẻ từ tiếp đất sang đẩy, trong khi mặt trên bằng lưới kiểu lớp da thứ hai thoáng khí và hỗ trợ.', '/Content/Images/Products/Giay/Jordan/jordan-series-es.jpg', 700, '2014-01-05 02:43:03', 5, 'lenh');
INSERT INTO `products` VALUES (22, 3, 1, 1, 'Jordan Stadium 90', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Jordan/jordan-stadium-90.jpg', 134, '2009-08-04 18:48:37', 5, 'lenh');
INSERT INTO `products` VALUES (23, 4, 4, 2, 'Yeezy Pirate Black BB5350', 'Ngày này là của riêng bạn. Đừng ngần ngại. Hãy bước vào đôi giày adidas NMD_V3 của thiếu niên này và theo đuổi nó. Dựa trên một dây chuyền luôn tiến bộ, chúng mang đến sự thoải mái ở mức độ cao hơn cho đôi chân của bạn với đế giữa BOOST có độ đàn hồi cao và thân giày bằng vải dệt vừa vặn. Các chi tiết minh bạch? Những thứ đó thêm một chút phong cách tương lai để giữ cho cái nhìn của bạn sắc nét. Vậy thì cứ đi. Ra khỏi đây. Khám phá. Xem những gì bạn có thể tạo ra. Được làm bằng nhiều loại vật liệu tái chế, phần trên này có hàm lượng tái chế ít nhất 50%. Sản phẩm này chỉ là một trong những giải pháp của chúng tôi nhằm giúp chấm dứt rác thải nhựa.', '/Content/Images/Products/Giay/Yeezy/yeezy-boost-350-pirate-black-bb5350.jpg', 300, '2006-05-31 18:45:50', 5, 'tai');
INSERT INTO `products` VALUES (24, 4, 4, 2, 'Yeezy Boost 350 V2 Zebra', 'Dù đi trên sân cỏ hay trên đường phố, giày adidas Samba OG vẫn giữ đúng phong cách của bạn. Đế cao su mang tính biểu tượng và điểm nhấn bằng da lộn đã đưa Samba trở nên nổi tiếng trong thời trang. Da mịn bao bọc bàn chân tạo cảm giác thoải mái theo phong cách cổ điển khi 3 Sọc răng cưa tạo thêm điểm nhấn tương phản. Các ngón chân được gia cố có thể chịu được những cú đá tự phát và lớp lót dệt giúp mọi thứ luôn thoải mái. Từ kho lưu trữ nhưng luôn nhìn về phía trước, Samba OG tiếp tục định nghĩa lại phong cách thông thường sành điệu sau 70 năm.', '/Content/Images/Products/Giay/Yeezy/yeezy-boost-350-v2-zebra.jpg', 120, '2007-07-03 12:16:44', 4, 'tuyen');
INSERT INTO `products` VALUES (25, 4, 4, 2, 'Yeezy Boost 350', 'Yeezy 350 V2 CMPCT Slate Bone là một phiên bản giày thể thao độc đáo trong dòng Yeezy hợp tác giữa Adidas và Kanye West. Với gam màu Slate Bone (xám xương), đây là một sự lựa chọn phong cách và hiện đại cho người yêu thích sneaker.', '/Content/Images/Products/Giay/Yeezy/yeezy-boost-350.jpg', 97, '2024-07-12 13:10:02', 4, 'tuyen');
INSERT INTO `products` VALUES (26, 4, 3, 2, 'Yeezy Boost 700 V2 Static', 'Yeezy Boost 700 V2 Static \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Yeezy/yeezy-boost-700-v2-static.png', 504, '2004-06-03 02:43:54', 4, 'lenh');
INSERT INTO `products` VALUES (27, 5, 2, 9, 'Asics Gel Kahana 8 Grey Red', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/NewBalance/asics-gel‑kahana-8-grey-red.png', 0, '2011-12-29 09:32:19', 5, 'lenh');
INSERT INTO `products` VALUES (28, 5, 2, 9, 'AsicsGel Kahana 8', 'AsicsGel Kahana 8 \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/NewBalance/asics-gel‑kahana-8.png', 0, '2014-04-30 22:14:28', 4, 'tai');
INSERT INTO `products` VALUES (29, 5, 3, 9, 'New Balance', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/NewBalance/new-balance.png', 117, '2019-11-04 02:54:16', 4, 'tai');
INSERT INTO `products` VALUES (30, 5, 2, 9, 'Puma Redeem Profoam', 'Puma Redeem Profoam \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/NewBalance/puma-redeem-profoam.png', 0, '2014-05-22 22:19:47', 4, 'tai');
INSERT INTO `products` VALUES (31, 6, 3, 4, 'New Balance Fresh Foam', 'New Balance Fresh Foam \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/MLB/new-balance-fresh-foam.png', 35, '2012-09-25 02:32:18', 5, 'tuyen');
INSERT INTO `products` VALUES (32, 6, 3, 4, 'Onitsuka Tiger Machu Racer', 'Onitsuka Tiger Machu Racer \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/MLB/onitsuka-tiger-machu-racer.png', 522, '2008-11-14 23:39:45', 5, 'lenh');
INSERT INTO `products` VALUES (33, 7, 4, 8, 'ML610TMB New Balance', 'ML610TMB New Balance \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/AlexanderMcQueen/ml610tmb-newbalance.jpg', 232, '2019-01-21 10:40:02', 4, 'tai');
INSERT INTO `products` VALUES (34, 7, 3, 8, 'Puma Tori Pixie', 'Puma Tori Pixie \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/AlexanderMcQueen/puma-tori-pixie.png', 70, '2002-03-19 19:43:52', 4, 'linh');
INSERT INTO `products` VALUES (35, 7, 1, 8, 'Wkairlg1 New Balance', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/AlexanderMcQueen/wkairlg1-new-balance.jpg', 12, '2021-11-07 01:03:15', 5, 'lenh');
INSERT INTO `products` VALUES (36, 8, 1, 6, 'Asic Main Square', 'Asic Main Square \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Balenciaga/asic-main-square.png', 67, '2016-08-03 18:02:22', 4, 'tai');
INSERT INTO `products` VALUES (37, 8, 3, 6, 'New Balance 997H Red', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Balenciaga/new-balance-new-balance-997h-white-black-red.jpg', 428, '2015-10-10 15:29:27', 5, 'lenh');
INSERT INTO `products` VALUES (38, 8, 3, 6, 'Slipstream Green', 'Slipstream Green \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Balenciaga/slipstream-green.png', 70, '2019-04-14 01:10:34', 5, 'linh');
INSERT INTO `products` VALUES (39, 9, 1, 1, 'Converse Blue Low 566757C', 'Converse Blue Low 566757C \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Others/converse-blue-low-566757c.png', 100, '2018-02-08 14:13:48', 4, 'lenh');
INSERT INTO `products` VALUES (40, 9, 3, 2, 'New Balance 550 BB550SE1', 'New Balance 550 BB550SE1 \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Others/new-balance-550-bb550se1.jpg', 303, '2005-06-14 02:34:00', 5, 'linh');
INSERT INTO `products` VALUES (41, 9, 4, 4, 'Puma Super Liga', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Others/puma-super-liga.jpg', 540, '2018-05-06 23:28:43', 5, 'tai');
INSERT INTO `products` VALUES (42, 9, 1, 5, 'RS X Candy', 'RS X Candy \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Others/rs-x-candy.jpg', 414, '2019-01-25 15:08:30', 4, 'tuyen');
INSERT INTO `products` VALUES (43, 9, 2, 3, 'Skye Clean Peach Skin', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Others/skye-clean-peach-skin.png', 0, '2006-06-18 23:17:33', 5, 'tai');
INSERT INTO `products` VALUES (44, 9, 3, 2, 'Slip on Nam Vans Knu Skool', 'NIKE COURT ROYALE \"WHITE BLUE\" 833535-109 Giày Nike Court Royale \"White Blue\" 833535-109 mang đến sự kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại. Lấy cảm hứng từ thiết kế tennis thập niên 70, mẫu giày này có phần trên bằng da mịn với các lớp phủ bằng da lộn để tăng thêm độ sang trọng.', '/Content/Images/Products/Giay/Others/slip-on-nam-vans-knu-skool.jpg', 276, '2005-07-10 21:34:18', 5, 'lenh');
INSERT INTO `products` VALUES (45, 10, 3, 2, 'Adilette Aqua - Black / Black', 'Tắm sạch sau khi bơi lội với đôi dép sandal thân thiện với vòi sen này. Với sự đơn giản, đôi giày lười mềm mại bộc lộ DNA adidas với 3 Sọc đặc trưng. Lớp đệm mềm mang lại sự thoải mái sang trọng cho đôi chân mệt mỏi.', '/Content/Images/Products/Dep/Adidas/sandal-1.png', 556, '2012-10-11 00:35:43', 4, 'tai');
INSERT INTO `products` VALUES (46, 10, 3, 2, 'Sandal 2000R', 'Thiết kế độc đáo và sự thoải mái của guốc Classic Mega Crush hiện đã có phiên bản sandal. Đế cao su được nâng cấp với chiều cao nâng cao và các rãnh đậm tạo thêm điểm nhấn đặc biệt cho trang phục của bạn. Dây đeo kép có lỗ nhỏ cho phép bạn thể hiện bản thân bằng bộ sưu tập bùa Jibbitz™ đầy màu sắc. Bạn đã sẵn sàng nâng tầm phong cách của mình cùng Crush chưa?', '/Content/Images/Products/Dep/Adidas/sandal-2.png', 100, '2024-06-01 13:13:06', 4, 'tuyen');
INSERT INTO `products` VALUES (47, 10, 1, 2, 'Adilette Aqua - Vapour Pink', 'Một phong cách mang tính biểu tượng cho bề mặt trơn. Những đường trượt khô nhanh này có 3 sọc dọc phía trên kiểu băng bó. Lớp đệm sang trọng ở tấm lót chân mang đến sự thoải mái tối đa trong và ngoài phòng tắm.', '/Content/Images/Products/Dep/Adidas/sandal-3.png', 436, '2012-06-12 22:02:16', 4, 'lenh');
INSERT INTO `products` VALUES (48, 10, 3, 2, 'Adilette 22 - Wonder Clay', 'Để thiết kế những slide adidas này, chúng tôi đã xem xét các bản đồ địa hình minh họa các chuyến thám hiểm tới Sao Hỏa và các giai đoạn không gian của một hành tinh mới. Và những rung cảm tương lai không kết thúc ở đó. Chúng được xây dựng bằng vật liệu một phần từ mía, một bước trên con đường hướng tới một tương lai bền vững hơn. Mang chúng trên nhiều địa hình khác nhau từ ẩm ướt đến khô ráo. Những slide này được làm bằng vật liệu tự nhiên và tái tạo như một phần trong hành trình của chúng tôi nhằm thiết kế các nguồn tài nguyên hữu hạn và giúp chấm dứt rác thải nhựa.', '/Content/Images/Products/Dep/Adidas/sandal-4.jpg', 78, '2003-07-19 09:18:52', 5, 'tuyen');
INSERT INTO `products` VALUES (49, 11, 3, 1, 'Offcourt Slide - Alabama A&M', 'Sự rạng rỡ vẫn tồn tại trong Nike Air Force 1 \'07, biểu tượng b-ball mang đến một luồng gió mới mẻ cho những gì bạn biết rõ nhất: da sắc nét, màu sắc đậm và lượng ánh sáng hoàn hảo giúp bạn tỏa sáng.', '/Content/Images/Products/Dep/Nike/sandal-5.jpg', 151, '2020-08-19 13:45:26', 5, 'tuyen');
INSERT INTO `products` VALUES (50, 11, 3, 1, 'Offcourt Slide - Kansas Royals', 'Cổ vũ đội của bạn giành chiến thắng một cách thoải mái với Nike Offcourt (MLB Kansas City Royals) Slide. Dây đeo bằng da tổng hợp êm ái có logo của đội bạn, trong khi đế giữa bằng xốp cải tiến giúp cho chiếc trượt này trở nên thoải mái đến mức bạn sẽ không bao giờ muốn tháo nó ra.', '/Content/Images/Products/Dep/Nike/sandal-6.jpg', 735, '2006-06-11 09:02:25', 5, 'tai');
INSERT INTO `products` VALUES (51, 11, 3, 1, 'Offcourt Slide - Black / Gold', 'Những slide này được thiết kế để giúp bạn thư giãn và nạp lại năng lượng. Đế giày bằng xốp hai lớp cải tiến kết hợp với dây đeo sang trọng mang lại sự thoải mái, trong khi họa tiết vòng tròn xoay AF-1 mang tính biểu tượng ở đế ngoài và thương hiệu chữ cái khối ngẫu nhiên gợi nhớ đến những chiếc vòng di sản. Bạn còn chờ gì nữa? Hãy thư giãn.', '/Content/Images/Products/Dep/Nike/sandal-7.jpg', 802, '2000-02-22 09:06:48', 5, 'tuyen');
INSERT INTO `products` VALUES (52, 12, 1, 5, 'LiteRide™ 360 Clog - Bone', 'Cảm nhận bước đột phá mới về sự thoải mái với bộ sưu tập Crocs LiteRide ™. Những đôi giày được tích hợp lớp đệm LiteRide ™ êm ái làm tăng thêm độ mềm mại cho bàn chân. Kiểu dáng cổ điển của dòng clog giúp bạn tận hưởng những bước đi thư thả nhất trên từng chặng đường.', '/Content/Images/Products/Dep/Crocs/sandal-8.jpg', 110, '2003-09-01 13:33:36', 5, 'tuyen');
INSERT INTO `products` VALUES (53, 12, 3, 5, 'LiteRide™ 360 Clog - Pepper', 'Cảm nhận bước đột phá mới về sự thoải mái với bộ sưu tập Crocs LiteRide ™. Những đôi giày được tích hợp lớp đệm LiteRide ™ êm ái làm tăng thêm độ mềm mại cho bàn chân. Kiểu dáng cổ điển của dòng clog giúp bạn tận hưởng những bước đi thư thả nhất trên từng chặng đường.', '/Content/Images/Products/Dep/Crocs/sandal-9.png', 51, '2014-10-09 10:28:11', 4, 'tai');
INSERT INTO `products` VALUES (54, 12, 1, 5, 'LiteRide™ 360 Clog - Carmer', 'Trang phục chơi gôn hiệu suất cao dành cho những người chơi nghiêm túc, có tinh thần cạnh tranh. Từ thô đến xanh lục, chiếc quần adidas co giãn 4 chiều này chuyển động theo từng chuyển động của bạn. Vải dệt đôi bền bỉ uốn cong khi bạn đi trên sân, giúp bạn luôn thoải mái qua 18 lỗ trở lên. Được thiết kế để mang lại hiệu suất và tính di động không bị phân tâm, bạn luôn tập trung vào lần chụp tiếp theo chứ không phải quần áo. Sản phẩm này được làm bằng ít nhất 70% vật liệu tái chế. Bằng cách tái sử dụng các vật liệu đã được tạo ra, chúng tôi giúp giảm thiểu chất thải và sự phụ thuộc vào nguồn tài nguyên hữu hạn, đồng thời giảm dấu ấn của các sản phẩm chúng tôi tạo ra.', '/Content/Images/Products/Dep/Crocs/sandal-10.png', 595, '2016-12-25 05:44:55', 5, 'tuyen');
INSERT INTO `products` VALUES (55, 12, 1, 5, 'LiteRide™ 360 Clog - Shore', 'Ban đầu được tạo ra cho gỗ cứng, Dunk sau đó đã xuất hiện trên đường phố—và như người ta nói, phần còn lại là lịch sử. Hơn 35 năm sau khi ra mắt, hình dáng này vẫn mang phong cách táo bạo, thách thức và vẫn là vẻ ngoài được các đội đua ở cả thể thao và văn hóa thèm muốn.', '/Content/Images/Products/Dep/Crocs/sandal-11.jpg', 143, '2014-01-31 12:49:12', 5, 'tai');
INSERT INTO `products` VALUES (56, 12, 3, 5, 'LiteRide™ 360 Clog - Beach', 'Ví này được trang trí với họa tiết \'KENZO Target\' đại diện cho HOA BOKE được cung cấp trong phiên bản nghệ thuật đại chúng của logo The Who. Nó có không gian để đựng tiền giấy nhờ cấu trúc mở rộng của nó. Phụ kiện nhỏ gọn này dễ dàng bỏ vào túi của bạn.', '/Content/Images/Products/Dep/Crocs/sandal-12.jpg', 90, '2003-12-03 12:23:31', 4, 'lenh');
INSERT INTO `products` VALUES (57, 13, 3, 3, 'Leadcat Slides - Red', 'Nếu du hành ngược thời gian về những năm 1960, bạn sẽ thấy các cầu thủ bóng đá chuyên nghiệp mang adidas Sambas giống như giày của những thiếu niên này. Vâng, gần giống như họ. Được làm mới cho thế hệ tiếp theo, chúng có lớp lót giày mềm mại mang lại cảm giác thoải mái khi mang cả ngày. Thân giày bằng da, đế cao su và họa tiết 3 Sọc vẫn mang phong cách cổ điển.', '/Content/Images/Products/Dep/Puma/sandal-13.jpg', 891, '2015-08-01 18:43:55', 4, 'tai');
INSERT INTO `products` VALUES (58, 13, 4, 3, 'Leadcat Slides - Black', 'Những đôi giày chạy bộ thời trang này được thiết kế với các tính năng thoải mái và công nghệ giày cao cấp để phù hợp với lối sống năng động của con bạn.', '/Content/Images/Products/Dep/Puma/sandal-14.png', 407, '2010-01-23 01:42:53', 5, 'tai');
INSERT INTO `products` VALUES (59, 13, 3, 3, 'Leadcat Slides - Yellow', 'Nếu du hành ngược thời gian về những năm 1960, bạn sẽ thấy các cầu thủ bóng đá chuyên nghiệp mang adidas Sambas giống như giày của những thiếu niên này. Vâng, gần giống như họ. Được làm mới cho thế hệ tiếp theo, chúng có lớp lót giày mềm mại mang lại cảm giác thoải mái khi mang cả ngày. Thân giày bằng da, đế cao su và họa tiết 3 Sọc vẫn mang phong cách cổ điển.', '/Content/Images/Products/Dep/Puma/sandal-15.jpg', 577, '2013-10-24 17:44:09', 5, 'tai');
INSERT INTO `products` VALUES (60, 13, 4, 3, 'Leadcat Slides - Blue', 'Ví này được trang trí với họa tiết \'KENZO Target\' đại diện cho HOA BOKE được cung cấp trong phiên bản nghệ thuật đại chúng của logo The Who. Nó có không gian để đựng tiền giấy nhờ cấu trúc mở rộng của nó. Phụ kiện nhỏ gọn này dễ dàng bỏ vào túi của bạn.', '/Content/Images/Products/Dep/Puma/sandal-16.png', 65, '2004-09-11 22:15:41', 4, 'linh');
INSERT INTO `products` VALUES (61, 13, 1, 3, 'Leadcat Slides - Green', 'Những đôi giày chạy bộ thời trang này được thiết kế với các tính năng thoải mái và công nghệ giày cao cấp để phù hợp với lối sống năng động của con bạn.', '/Content/Images/Products/Dep/Puma/sandal-17.jpg', 76, '2020-07-19 19:34:41', 4, 'tuyen');
INSERT INTO `products` VALUES (62, 14, 2, 2, 'Backpack D922 - Black', 'Chất liệu: Polyester Waterproof - Chống thấm nước, siêu bền, không nhăn, nhẹ và thoáng khí sẽ giúp bạn luôn thoải mái khi sử dụng sản phẩm.', '/Content/Images/Products/PhuKien/Adidas/accessory-8.jpg', 0, '2012-09-24 20:32:27', 4, 'tuyen');
INSERT INTO `products` VALUES (63, 14, 3, 2, 'The Knight Wallet - BLACK', 'Ban đầu được tạo ra cho gỗ cứng, Dunk sau đó đã xuất hiện trên đường phố—và như người ta nói, phần còn lại là lịch sử. Hơn 35 năm sau khi ra mắt, hình dáng này vẫn mang phong cách táo bạo, thách thức và vẫn là vẻ ngoài được các đội đua ở cả thể thao và văn hóa thèm muốn.', '/Content/Images/Products/PhuKien/Adidas/accessory-9.jpg', 386, '2016-09-03 04:22:05', 4, 'tai');
INSERT INTO `products` VALUES (64, 14, 3, 2, 'No Show Cotton Socks', 'Tất \"vô hình\" bằng cotton màu kem có dải silicon ở gót chân để đảm bảo độ vừa vặn tốt nhất. Không gây dị ứng và phù hợp với mọi loại giày siêu sang trọng. Được chế tác ở mantua, Ý.', '/Content/Images/Products/PhuKien/Adidas/accessory-10.jpg', 100, '2024-06-01 13:15:06', 4, 'tuyen');
INSERT INTO `products` VALUES (65, 14, 4, 2, 'Shoe FLAT Pink', 'Gặp gỡ người lãnh đạo của gói. Đi trên những đám mây phía trên tiếng ồn, Air Max 1 kết hợp thiết kế vượt thời gian với sự thoải mái có đệm. Với kiểu dáng nhanh nhẹn, tấm chắn bùn gợn sóng và Nike Air, biểu tượng cổ điển này xuất hiện vào năm \'87 và tiếp tục là linh hồn của thương hiệu này cho đến ngày nay.', '/Content/Images/Products/PhuKien/Adidas/accessory-11.jpg', 904, '2010-09-25 19:03:48', 5, 'linh');
INSERT INTO `products` VALUES (66, 15, 2, 2, 'Shoe FLAT White', 'DÂY GIÀY FLAT (Dây giày dẹp) - TRẮNG | King shoe laces càng thắt càng phê. @ Kingshoelaces ✓15 Ngày Đổi Hàng ✓Thanh Toán Khi Nhận Hàng.', '/Content/Images/Products/PhuKien/Champion/accessory-5.jpg', 0, '2012-01-03 13:09:36', 5, 'lenh');
INSERT INTO `products` VALUES (67, 15, 1, 5, 'Synthetic Sack - Pink', 'Những đôi giày chạy bộ thời trang này được thiết kế với các tính năng thoải mái và công nghệ giày cao cấp để phù hợp với lối sống năng động của con bạn.', '/Content/Images/Products/PhuKien/Champion/accessory-6.jpg', 308, '2014-04-26 03:08:58', 4, 'tuyen');
INSERT INTO `products` VALUES (68, 15, 2, 1, 'Back of Heel Cushion Inserts', 'Thiết kế công thái học tái tạo đường viền của gót chân, đệm chúng để bảo vệ gót chân của bạn khỏi đau, phồng rộp và vết chai, giảm áp lực và ma sát.', '/Content/Images/Products/PhuKien/Champion/accessory-7.jpg', 0, '2024-05-01 13:17:30', 4, 'tuyen');
INSERT INTO `products` VALUES (69, 16, 1, 2, 'Cylinder Bag D621 - Black', 'Chất liệu chính là Polyester chống thấm nước, độ bền cao kết hợp cùng vải nhung mềm, co giãn và có tính đàn hồi tốt.', '/Content/Images/Products/PhuKien/Front/accessory-1.jpg', 621, '2022-01-09 22:30:06', 4, 'vu');
INSERT INTO `products` VALUES (70, 16, 3, 2, 'Cedar Elements Combination', 'Bàn chải crepe da lộn của saphir® là một phụ kiện bổ sung hữu ích cho bộ dụng cụ làm sạch của bạn. Nó nhẹ nhàng và triệt để loại bỏ vết bẩn và vết bẩn trên da lộn và nabuk, đồng thời dải băng cao su dính sẽ hút bụi bẩn đồng thời khôi phục lại kết cấu và độ hoàn thiện ban đầu cho da.', '/Content/Images/Products/PhuKien/Front/accessory-2.jpg', 100, '2022-12-06 14:01:28', 4, 'tuyen');
INSERT INTO `products` VALUES (71, 17, 3, 1, 'Rambutan Se', 'Trang phục chơi gôn hiệu suất cao dành cho những người chơi nghiêm túc, có tinh thần cạnh tranh. Từ thô đến xanh lục, chiếc quần adidas co giãn 4 chiều này chuyển động theo từng chuyển động của bạn. Vải dệt đôi bền bỉ uốn cong khi bạn đi trên sân, giúp bạn luôn thoải mái qua 18 lỗ trở lên. Được thiết kế để mang lại hiệu suất và tính di động không bị phân tâm, bạn luôn tập trung vào lần chụp tiếp theo chứ không phải quần áo. Sản phẩm này được làm bằng ít nhất 70% vật liệu tái chế. Bằng cách tái sử dụng các vật liệu đã được tạo ra, chúng tôi giúp giảm thiểu chất thải và sự phụ thuộc vào nguồn tài nguyên hữu hạn, đồng thời giảm dấu ấn của các sản phẩm chúng tôi tạo ra.', '/Content/Images/Products/PhuKien/Nike/accessory-3.jpg', 144, '2001-06-27 21:02:43', 4, 'lenh');
INSERT INTO `products` VALUES (72, 17, 1, 1, 'Grape NK-201', 'Những đôi giày chạy bộ thời trang này được thiết kế với các tính năng thoải mái và công nghệ giày cao cấp để phù hợp với lối sống năng động của con bạn.', '/Content/Images/Products/PhuKien/Nike/accessory-4.jpg', 506, '2010-05-05 22:50:41', 5, 'vu');

-- ----------------------------
-- Table structure for role_admin
-- ----------------------------
DROP TABLE IF EXISTS `role_admin`;
CREATE TABLE `role_admin`  (
  `id_role_admin` int NOT NULL,
  `name_role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_role_admin`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_admin
-- ----------------------------
INSERT INTO `role_admin` VALUES (1, 'root');
INSERT INTO `role_admin` VALUES (2, 'member');

-- ----------------------------
-- Table structure for sold_product
-- ----------------------------
DROP TABLE IF EXISTS `sold_product`;
CREATE TABLE `sold_product`  (
  `id_product` int NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quantity_sold` int NOT NULL,
  PRIMARY KEY (`id_product`, `datetime`) USING BTREE,
  CONSTRAINT `sold_product_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sold_product
-- ----------------------------
INSERT INTO `sold_product` VALUES (8, '2024-07-22 13:31:24', 3);
INSERT INTO `sold_product` VALUES (17, '2024-07-22 13:31:06', 3);
INSERT INTO `sold_product` VALUES (25, '2024-07-22 13:31:31', 3);
INSERT INTO `sold_product` VALUES (29, '2024-07-22 13:31:14', 3);
INSERT INTO `sold_product` VALUES (33, '2024-07-22 13:31:38', 1);

-- ----------------------------
-- Table structure for status_acc
-- ----------------------------
DROP TABLE IF EXISTS `status_acc`;
CREATE TABLE `status_acc`  (
  `id_status_acc` int NOT NULL,
  `name_status_acc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_status_acc`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of status_acc
-- ----------------------------
INSERT INTO `status_acc` VALUES (1, 'Bình thường');
INSERT INTO `status_acc` VALUES (2, 'Tạm khóa');
INSERT INTO `status_acc` VALUES (3, 'Khóa vĩnh viễn');

-- ----------------------------
-- Table structure for status_bill
-- ----------------------------
DROP TABLE IF EXISTS `status_bill`;
CREATE TABLE `status_bill`  (
  `id_status_bill` int NOT NULL,
  `name_status_bill` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_status_bill`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of status_bill
-- ----------------------------
INSERT INTO `status_bill` VALUES (1, 'Đang xử lý');
INSERT INTO `status_bill` VALUES (2, 'Đang vận chuyển');
INSERT INTO `status_bill` VALUES (3, 'Đã giao');
INSERT INTO `status_bill` VALUES (4, 'Đã hủy');

-- ----------------------------
-- Table structure for status_product
-- ----------------------------
DROP TABLE IF EXISTS `status_product`;
CREATE TABLE `status_product`  (
  `id_status_product` int NOT NULL,
  `name_status_product` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_status_product`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of status_product
-- ----------------------------
INSERT INTO `status_product` VALUES (1, 'Mới');
INSERT INTO `status_product` VALUES (2, 'Hết hàng');
INSERT INTO `status_product` VALUES (3, 'Còn hàng');
INSERT INTO `status_product` VALUES (4, 'Giảm giá');

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers`  (
  `id_supplier` int NOT NULL,
  `name_supplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_supplier`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
INSERT INTO `suppliers` VALUES (1, 'Nike');
INSERT INTO `suppliers` VALUES (2, 'Adidas');
INSERT INTO `suppliers` VALUES (3, 'PUMA');
INSERT INTO `suppliers` VALUES (4, 'Skechers');
INSERT INTO `suppliers` VALUES (5, 'Vans');
INSERT INTO `suppliers` VALUES (6, 'Converse');
INSERT INTO `suppliers` VALUES (7, 'ASICS');
INSERT INTO `suppliers` VALUES (8, 'Reebok');
INSERT INTO `suppliers` VALUES (9, 'New Balance');

-- ----------------------------
-- Table structure for type_product
-- ----------------------------
DROP TABLE IF EXISTS `type_product`;
CREATE TABLE `type_product`  (
  `id_type_product` int NOT NULL,
  `name_type_product` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_type_product`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of type_product
-- ----------------------------
INSERT INTO `type_product` VALUES (1, 'Giày Nike');
INSERT INTO `type_product` VALUES (2, 'Giày Adidas');
INSERT INTO `type_product` VALUES (3, 'Giày Jordan');
INSERT INTO `type_product` VALUES (4, 'Giày Yeezy');
INSERT INTO `type_product` VALUES (5, 'New Balance');
INSERT INTO `type_product` VALUES (6, 'MLB');
INSERT INTO `type_product` VALUES (7, 'Alexander McQueen');
INSERT INTO `type_product` VALUES (8, 'Balenciaga');
INSERT INTO `type_product` VALUES (9, 'Giày khác');
INSERT INTO `type_product` VALUES (10, 'Dép Adidas');
INSERT INTO `type_product` VALUES (11, 'Dép Nike');
INSERT INTO `type_product` VALUES (12, 'Dép Crocs');
INSERT INTO `type_product` VALUES (13, 'Dép Puma');
INSERT INTO `type_product` VALUES (14, 'Phụ kiện Adidas');
INSERT INTO `type_product` VALUES (15, 'Phụ kiện Champion');
INSERT INTO `type_product` VALUES (16, 'Phụ kiện FRONT');
INSERT INTO `type_product` VALUES (17, 'Phụ kiện Nike');

-- ----------------------------
-- Procedure structure for InsertProductPrice
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertProductPrice`;
delimiter ;;
CREATE PROCEDURE `InsertProductPrice`()
BEGIN
		DECLARE counter INT DEFAULT 1;
	
		WHILE counter < 73 DO
				SET @listed_price = FLOOR(((450000 + RAND() * (5000000 - 450000 + 1)) + 99) / 100) * 100;
				SET @current_price = @listed_price - FLOOR(((50000 + RAND() * (150000 - 50000 + 1)) + 99) / 100) * 100;
				SET @date = FROM_UNIXTIME(UNIX_TIMESTAMP('2022-04-30 14:53:27') + FLOOR(0 + (RAND() * 63072000)));
			
				INSERT INTO `price_product` (`id_product`, `date`, `listed_price`, `current_price`, `nameAdmin`) 
						VALUES (counter, CURRENT_TIMESTAMP, @listed_price, @current_price, 'tuyen');
				SET counter = counter + 1;
		END WHILE;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
