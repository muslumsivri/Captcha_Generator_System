/*Creating DB for capctha generator system*/
CREATE DATABASE Captcha_Generator_System;
USE Captcha_Generator_System;


/*Creating Schemas*/
CREATE SCHEMA Person;
CREATE SCHEMA MathCaptcha;
CREATE SCHEMA ImageCaptcha;
CREATE SCHEMA TextCaptcha;
CREATE SCHEMA SoundCaptcha;



USE Captcha_Generator_System
GO
/*LOGIN MUSLUM*/
CREATE LOGIN [Muslum] WITH PASSWORD = '1234',
DEFAULT_DATABASE = [Captcha_Generator_System],
CHECK_EXPIRATION=ON,
CHECK_POLICY=ON;

/*LOGIN BELEN*/
CREATE LOGIN [Belen] WITH PASSWORD = '4321',
DEFAULT_DATABASE = [Captcha_Generator_System],
CHECK_EXPIRATION=ON,
CHECK_POLICY=ON;

/*Creating users for logins*/
CREATE USER User_Muslum FOR LOGIN Muslum;/*CAN NOT INSERT, DELETE ON Person Schema*/
CREATE USER User_Belen FOR LOGIN Belen; /*CAN NOT UPDATE,DELETE,INSERT,CONTROL on TextCaptcha cause of deny*/



/*Creating user table*/
CREATE TABLE Person.Users
(
	user_id INT NOT NULL,
	name VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	control_captcha BIT,
	active BIT

);

/*user_id added as primary key*/
ALTER TABLE Person.Users
ADD CONSTRAINT PK_Users_user_id
PRIMARY KEY (user_id);


/*Creating Authorizations table*/
CREATE TABLE Person.Authorizations
(
	authorization_id INT NOT NULL,
	system_log_no INT ,
	last_login_date DATETIME,
	current_login_date DATETIME,
	user_id INT 
);


/*authorization_id added as primary key*/
ALTER TABLE Person.Authorizations
ADD CONSTRAINT PK_Authorizations_authorization_id
PRIMARY KEY (authorization_id);

/*user_id  added as foreign key*/
ALTER TABLE Person.Authorizations
ADD CONSTRAINT FK_Authorizations_user_id
FOREIGN KEY (user_id) REFERENCES Person.Users(user_id) ;


/*Creating Verification table*/
CREATE TABLE Person.Verification
(
	verification_id INT NOT NULL IDENTITY(1,1),
	code VARCHAR(50),
	user_id INT 
);


/*verification_id added as primary key*/
ALTER TABLE Person.Verification
ADD CONSTRAINT PK_Verification_verification_id
PRIMARY KEY (verification_id);

/*user_id  added as foreign key*/
ALTER TABLE Person.Verification
ADD CONSTRAINT FK_Verification_user_id
FOREIGN KEY (user_id) REFERENCES Person.Users(user_id) ;


/*Creating Math table*/
CREATE TABLE MathCaptcha.Math
(
	math_id INT NOT NULL,
	first_operand INT NOT NULL,
	second_operand INT NOT NULL,
	operation VARCHAR(50) NOT NULL	
);


/*math_id added as primary key*/
ALTER TABLE MathCaptcha.Math
ADD CONSTRAINT PK_Math_math_id
PRIMARY KEY (math_id);


/*Creating Images table*/
CREATE TABLE ImageCaptcha.Images
(
	image_id INT NOT NULL,
	image_type VARCHAR(50) NOT NULL	
);

/*image_id added as primary key*/
ALTER TABLE ImageCaptcha.Images
ADD CONSTRAINT PK_Images_image_id
PRIMARY KEY (image_id);

/*Creating Images_imagePath table (multivalue)*/
CREATE TABLE ImageCaptcha.Images_imagePath
(
	iip_id INT NOT NULL,
	image_id INT NOT NULL,
	path1 VARCHAR(50) NOT NULL,
	path2 VARCHAR(50) NOT NULL,
	path3 VARCHAR(50) NOT NULL,
	path4 VARCHAR(50) NOT NULL,
	path5 VARCHAR(50) NOT NULL,
	path6 VARCHAR(50) NOT NULL,
	path7 VARCHAR(50) NOT NULL,
	path8 VARCHAR(50) NOT NULL,
	path9 VARCHAR(50) NOT NULL
);


/*image_id and iip_id added as primary key*/
ALTER TABLE ImageCaptcha.Images_imagePath
ADD CONSTRAINT PK_Images_imagePath_image_idANDiip_id
PRIMARY KEY (image_id, iip_id);


/*Creating Images_correctImage_no table (multivalue)*/
CREATE TABLE ImageCaptcha.Images_correctImage_no
(
	icn_id INT NOT NULL,
	image_id INT NOT NULL,
	image_no1 INT NOT NULL,
	image_no2 INT NOT NULL,
	image_no3 INT NOT NULL	
);

/*image_id and icn_id added as primary key*/
ALTER TABLE ImageCaptcha.Images_correctImage_no
ADD CONSTRAINT PK_Images_correctImage_no_image_idANDicn_id
PRIMARY KEY (image_id, icn_id);


/*Creating Background table*/
CREATE TABLE TextCaptcha.Background
(
	bg_id INT NOT NULL,
	bg_image_path VARCHAR(50) NOT NULL,
	opacity FLOAT NOT NULL
);


/*bg_id added as primary key*/
ALTER TABLE TextCaptcha.Background
ADD CONSTRAINT PK_Background_bg_id
PRIMARY KEY (bg_id);


/*Creating Text table*/
CREATE TABLE TextCaptcha.Texts
(
	text_id INT NOT NULL,
	word VARCHAR(50) NOT NULL,
	font_family VARCHAR(50) NOT NULL,
	text_height FLOAT NOT NULL,
	text_width FLOAT NOT NULL,
	char_space INT NOT NULL,
	bg_id INT	
);

/*text_id  added as primary key*/
ALTER TABLE TextCaptcha.Texts
ADD CONSTRAINT PK_Texts_text_id
PRIMARY KEY (text_id);

/*bg_id  added as foreign key*/
ALTER TABLE TextCaptcha.Texts
ADD CONSTRAINT FK_Texts_bg_id
FOREIGN KEY (bg_id) REFERENCES TextCaptcha.Background(bg_id) ;


/*Creating Texts_Color table (multivalue)*/
CREATE TABLE TextCaptcha.Texts_Color
(
	tc_id INT NOT NULL,
	text_id INT NOT NULL,
	color1 VARCHAR(50) NOT NULL,
	color2 VARCHAR(50) NOT NULL,
	color3 VARCHAR(50) NOT NULL,
	color4 VARCHAR(50) NOT NULL	
);


/*tc_id and text_id added as primary key*/
ALTER TABLE TextCaptcha.Texts_Color
ADD CONSTRAINT PK_Texts_Color_tc_idANDtext_id
PRIMARY KEY (tc_id, text_id);


/*Creating Sound table */
CREATE TABLE SoundCaptcha.Sound
(
	sound_id INT NOT NULL,
	sound_sec INT NOT NULL,
	sound_word VARCHAR(50) NOT NULL,
	sound_type VARCHAR(50) NOT NULL
);


/*sound_id added as primary key*/
ALTER TABLE SoundCaptcha.Sound
ADD CONSTRAINT PK_Sound_sound_id
PRIMARY KEY (sound_id);


/*Creating Sound_soundLanguage table (multivalue)*/
CREATE TABLE SoundCaptcha.Sound_soundLanguage
(
	ssl_id INT NOT NULL,
	sound_id INT NOT NULL,
	language1 VARCHAR(50) NOT NULL,
	language2 VARCHAR(50) NOT NULL,
	language3 VARCHAR(50) NOT NULL,
	language4 VARCHAR(50) NOT NULL	
);


/*ssl_id and sound_id added as primary key*/
ALTER TABLE SoundCaptcha.Sound_soundLanguage
ADD CONSTRAINT PK_Sound_soundLanguage_ssl_idANDsound_id
PRIMARY KEY (ssl_id, sound_id);






/***     INSERT OPERATIONS FOR CORRECT TABLES ON THE SYSYTEM         ***/

/*Inserting data to Math Table */
INSERT INTO MathCaptcha.Math(math_id, first_operand, second_operand,operation)
VALUES
(1,10,23,'addition'),
(2,17,21,'addition'),
(3,14,40,'addition'),
(4,32,56,'addition'),
(5,24,30,'addition'),
(6,22,37,'addition'),
(7,41,90,'addition'),
(8,52,12,'addition'),
(9,34,38,'addition'),
(10,61,81,'addition'),
(11,20,10,'subtraction'),
(12,54,30,'subtraction'),
(13,77,9,'subtraction'),
(14,39,29,'subtraction'),
(15,88,66,'subtraction'),
(16,80,21,'subtraction'),
(17,27,11,'subtraction'),
(18,35,23,'subtraction'),
(19,34,6,'subtraction'),
(20,54,52,'subtraction'),
(21,14,40,'multiplication'),
(22,5,10,'multiplication'),
(23,1,40,'multiplication'),
(24,14,5,'multiplication'),
(25,4,7,'multiplication'),
(26,2,20,'multiplication'),
(27,13,4,'multiplication'),
(28,8,17,'multiplication'),
(29,33,11,'multiplication'),
(30,9,90,'multiplication'),
(31,50,10,'division'),
(32,52,26,'division'),
(33,33,11,'division'),
(34,28,7,'division'),
(35,90,5,'division'),
(36,32,16,'division'),
(37,90,3,'division'),
(38,256,2,'division'),
(39,100,5,'division'),
(40,64,16,'division'),
(41,34,13,'addition'),
(42,12,23,'addition'),
(43,45,93,'addition'),
(44,26,16,'addition'),
(45,10,44,'addition'),
(46,108,123,'addition'),
(47,77,17,'addition'),
(48,90,63,'addition'),
(49,61,63,'addition'),
(50,84,95,'addition'),
(51,90,7,'subtraction'),
(52,71,42,'subtraction'),
(53,17,6,'subtraction'),
(54,43,20,'subtraction'),
(55,16,3,'subtraction'),
(56,177,98,'subtraction'),
(57,22,9,'subtraction'),
(58,53,11,'subtraction'),
(59,58,12,'subtraction'),
(60,73,19,'subtraction'),
(61,12,4,'multiplication'),
(62,13,18,'multiplication'),
(63,17,4,'multiplication'),
(64,4,40,'multiplication'),
(65,27,3,'multiplication'),
(66,89,29,'multiplication'),
(67,1,4,'multiplication'),
(68,23,80,'multiplication'),
(69,15,8,'multiplication'),
(70,1,6,'multiplication'),
(71,48,2,'division'),
(72,81,9,'division'),
(73,46,23,'division'),
(74,25,5,'division'),
(75,62,2,'division'),
(76,38,19,'division'),
(77,77,7,'division'),
(78,121,11,'division'),
(79,56,4,'division'),
(80,80,2,'division')




/*Inserting data to Image Table */
INSERT INTO ImageCaptcha.Images(image_id, image_type)
VALUES
(1,'traffic light'),
(2,'bridge'),
(3,'truck'),
(4,'car'),
(5,'crosswalk'),
(6,'fire hydrant'),
(7,'tree'),
(8,'taxi'),
(9,'bus'),
(10,'boat'),
(11,'traffic light'),
(12,'bridge'),
(13,'truck'),
(14,'car'),
(15,'crosswalk'),
(16,'fire hydrant'),
(17,'tree'),
(18,'taxi'),
(19,'bus'),
(20,'boat'),
(21,'traffic light'),
(22,'bridge'),
(23,'truck'),
(24,'car'),
(25,'crosswalk'),
(26,'fire hydrant'),
(27,'tree'),
(28,'taxi'),
(29,'bus'),
(30,'boat'),
(31,'traffic light'),
(32,'bridge'),
(33,'truck'),
(34,'car'),
(35,'crosswalk'),
(36,'fire hydrant'),
(37,'tree'),
(38,'taxi'),
(39,'bus'),
(40,'boat'),
(41,'traffic light'),
(42,'bridge'),
(43,'truck'),
(44,'car'),
(45,'crosswalk'),
(46,'fire hydrant'),
(47,'tree'),
(48,'taxi'),
(49,'bus'),
(50,'boat'),
(51,'traffic light'),
(52,'bridge'),
(53,'truck'),
(54,'car'),
(55,'crosswalk'),
(56,'fire hydrant'),
(57,'tree'),
(58,'taxi'),
(59,'bus'),
(60,'boat'),
(61,'traffic light'),
(62,'bridge'),
(63,'truck'),
(64,'car'),
(65,'crosswalk'),
(66,'fire hydrant'),
(67,'tree'),
(68,'taxi'),
(69,'bus'),
(70,'boat'),
(71,'traffic light'),
(72,'bridge'),
(73,'truck'),
(74,'car'),
(75,'crosswalk'),
(76,'fire hydrant'),
(77,'tree'),
(78,'taxi'),
(79,'bus'),
(80,'boat')



/*Inserting data to Images_imagePath Table(Multivalue) */
INSERT INTO ImageCaptcha.Images_imagePath(iip_id, image_id, path1, path2, path3, path4, path5, path6, path7, path8, path9)
VALUES
(1,1,'../assets/images/p1.png','../assets/images/p2.png','../assets/images/p3.png','../assets/images/p4.png','../assets/images/p5.png', '../assets/images/p6.png', '../assets/images/p7.png', '../assets/images/p8.png', '../assets/images/p9.png'),
(2,2,'../assets/images/a1.png','../assets/images/a2.png','../assets/images/a3.png','../assets/images/a4.png','../assets/images/a5.png', '../assets/images/a6.png', '../assets/images/a7.png', '../assets/images/a8.png', '../assets/images/a9.png'),
(3,3,'../assets/images/b1.png','../assets/images/b2.png','../assets/images/b3.png','../assets/images/b4.png','../assets/images/b5.png', '../assets/images/b6.png', '../assets/images/b7.png', '../assets/images/b8.png', '../assets/images/b9.png'),
(4,4,'../assets/images/c1.png','../assets/images/c2.png','../assets/images/c3.png','../assets/images/c4.png','../assets/images/c5.png', '../assets/images/c6.png', '../assets/images/c7.png', '../assets/images/c8.png', '../assets/images/c9.png'),
(5,5,'../assets/images/d1.png','../assets/images/d2.png','../assets/images/d3.png','../assets/images/d4.png','../assets/images/d5.png', '../assets/images/d6.png', '../assets/images/d7.png', '../assets/images/d8.png', '../assets/images/d9.png'),
(6,6,'../assets/images/e1.png','../assets/images/e2.png','../assets/images/e3.png','../assets/images/e4.png','../assets/images/e5.png', '../assets/images/e6.png', '../assets/images/e7.png', '../assets/images/e8.png', '../assets/images/e9.png'),
(7,7,'../assets/images/f1.png','../assets/images/f2.png','../assets/images/f3.png','../assets/images/f4.png','../assets/images/f5.png', '../assets/images/f6.png', '../assets/images/f7.png', '../assets/images/f8.png', '../assets/images/f9.png'),
(8,8,'../assets/images/g1.png','../assets/images/g2.png','../assets/images/g3.png','../assets/images/g4.png','../assets/images/g5.png', '../assets/images/g6.png', '../assets/images/g7.png', '../assets/images/g8.png', '../assets/images/g9.png'),
(9,9,'../assets/images/h1.png','../assets/images/h2.png','../assets/images/h3.png','../assets/images/h4.png','../assets/images/h5.png', '../assets/images/h6.png', '../assets/images/h7.png', '../assets/images/h8.png', '../assets/images/h9.png'),
(10,10,'../assets/images/i1.png','../assets/images/i2.png','../assets/images/i3.png','../assets/images/i4.png','../assets/images/i5.png', '../assets/images/i6.png', '../assets/images/i7.png', '../assets/images/i8.png', '../assets/images/i9.png'),
(11,11,'../assets/images/j1.png','../assets/images/j2.png','../assets/images/j3.png','../assets/images/j4.png','../assets/images/j5.png', '../assets/images/j6.png', '../assets/images/j7.png', '../assets/images/j8.png', '../assets/images/j9.png'),
(12,12,'../assets/images/k1.png','../assets/images/k2.png','../assets/images/k3.png','../assets/images/k4.png','../assets/images/k5.png', '../assets/images/k6.png', '../assets/images/k7.png', '../assets/images/k8.png', '../assets/images/k9.png'),
(13,13,'../assets/images/l1.png','../assets/images/l2.png','../assets/images/l3.png','../assets/images/l4.png','../assets/images/l5.png', '../assets/images/l6.png', '../assets/images/l7.png', '../assets/images/l8.png', '../assets/images/l9.png'),
(14,14,'../assets/images/m1.png','../assets/images/m2.png','../assets/images/m3.png','../assets/images/m4.png','../assets/images/m5.png', '../assets/images/m6.png', '../assets/images/m7.png', '../assets/images/m8.png', '../assets/images/m9.png'),
(15,15,'../assets/images/n1.png','../assets/images/n2.png','../assets/images/n3.png','../assets/images/n4.png','../assets/images/n5.png', '../assets/images/n6.png', '../assets/images/n7.png', '../assets/images/n8.png', '../assets/images/n9.png'),
(16,16,'../assets/images/o1.png','../assets/images/o2.png','../assets/images/o3.png','../assets/images/o4.png','../assets/images/o5.png', '../assets/images/o6.png', '../assets/images/o7.png', '../assets/images/o8.png', '../assets/images/o9.png'),
(17,17,'../assets/images/q1.png','../assets/images/q2.png','../assets/images/q3.png','../assets/images/q4.png','../assets/images/q5.png', '../assets/images/q6.png', '../assets/images/q7.png', '../assets/images/q8.png', '../assets/images/q9.png'),
(18,18,'../assets/images/r1.png','../assets/images/r2.png','../assets/images/r3.png','../assets/images/r4.png','../assets/images/r5.png', '../assets/images/r6.png', '../assets/images/r7.png', '../assets/images/r8.png', '../assets/images/r9.png'),
(19,19,'../assets/images/s1.png','../assets/images/s2.png','../assets/images/s3.png','../assets/images/s4.png','../assets/images/s5.png', '../assets/images/s6.png', '../assets/images/s7.png', '../assets/images/s8.png', '../assets/images/s9.png'),
(20,20,'../assets/images/t1.png','../assets/images/t2.png','../assets/images/t3.png','../assets/images/t4.png','../assets/images/t5.png', '../assets/images/t6.png', '../assets/images/t7.png', '../assets/images/t8.png', '../assets/images/t9.png'),
(21,21,'../assets/images/u1.png','../assets/images/u2.png','../assets/images/u3.png','../assets/images/u4.png','../assets/images/u5.png', '../assets/images/u6.png', '../assets/images/u7.png', '../assets/images/u8.png', '../assets/images/u9.png'),
(22,22,'../assets/images/v1.png','../assets/images/v2.png','../assets/images/v3.png','../assets/images/v4.png','../assets/images/v5.png', '../assets/images/v6.png', '../assets/images/v7.png', '../assets/images/v8.png', '../assets/images/v9.png'),
(23,23,'../assets/images/y1.png','../assets/images/y2.png','../assets/images/y3.png','../assets/images/y4.png','../assets/images/y5.png', '../assets/images/y6.png', '../assets/images/y7.png', '../assets/images/y8.png', '../assets/images/y9.png'),
(24,24,'../assets/images/z1.png','../assets/images/z2.png','../assets/images/z3.png','../assets/images/z4.png','../assets/images/z5.png', '../assets/images/z6.png', '../assets/images/z7.png', '../assets/images/z8.png', '../assets/images/z9.png'),
(25,25,'../assets/images/w1.png','../assets/images/w2.png','../assets/images/w3.png','../assets/images/w4.png','../assets/images/w5.png', '../assets/images/w6.png', '../assets/images/w7.png', '../assets/images/w8.png', '../assets/images/w9.png'),
(26,26,'../assets/images/aa1.png','../assets/images/aa2.png','../assets/images/aa3.png','../assets/images/aa4.png','../assets/images/aa5.png', '../assets/images/aa6.png', '../assets/images/aa7.png', '../assets/images/aa8.png', '../assets/images/aa9.png'),
(27,27,'../assets/images/bb1.png','../assets/images/bb2.png','../assets/images/bb3.png','../assets/images/bb4.png','../assets/images/bb5.png', '../assets/images/bb6.png', '../assets/images/bb7.png', '../assets/images/bb8.png', '../assets/images/bb9.png'),
(28,28,'../assets/images/cc1.png','../assets/images/cc2.png','../assets/images/cc3.png','../assets/images/cc4.png','../assets/images/cc5.png', '../assets/images/cc6.png', '../assets/images/cc7.png', '../assets/images/cc8.png', '../assets/images/cc9.png'),
(29,29,'../assets/images/dd1.png','../assets/images/dd2.png','../assets/images/dd3.png','../assets/images/dd4.png','../assets/images/dd5.png', '../assets/images/dd6.png', '../assets/images/dd7.png', '../assets/images/dd8.png', '../assets/images/dd9.png'),
(30,30,'../assets/images/ee1.png','../assets/images/ee2.png','../assets/images/ee3.png','../assets/images/ee4.png','../assets/images/ee5.png', '../assets/images/ee6.png', '../assets/images/ee7.png', '../assets/images/ee8.png', '../assets/images/ee9.png'),
(31,31,'../assets/images/ff1.png','../assets/images/ff2.png','../assets/images/ff3.png','../assets/images/ff4.png','../assets/images/ff5.png', '../assets/images/ff6.png', '../assets/images/ff7.png', '../assets/images/ff8.png', '../assets/images/ff9.png'),
(32,32,'../assets/images/gg1.png','../assets/images/gg2.png','../assets/images/gg3.png','../assets/images/gg4.png','../assets/images/gg5.png', '../assets/images/gg6.png', '../assets/images/gg7.png', '../assets/images/gg8.png', '../assets/images/gg9.png'),
(33,33,'../assets/images/hh1.png','../assets/images/hh2.png','../assets/images/hh3.png','../assets/images/hh4.png','../assets/images/hh5.png', '../assets/images/hh6.png', '../assets/images/hh7.png', '../assets/images/hh8.png', '../assets/images/hh9.png'),
(34,34,'../assets/images/ii1.png','../assets/images/ii2.png','../assets/images/ii3.png','../assets/images/ii4.png','../assets/images/ii5.png', '../assets/images/ii6.png', '../assets/images/ii7.png', '../assets/images/ii8.png', '../assets/images/ii9.png'),
(35,35,'../assets/images/jj1.png','../assets/images/jj2.png','../assets/images/jj3.png','../assets/images/jj4.png','../assets/images/jj5.png', '../assets/images/jj6.png', '../assets/images/jj7.png', '../assets/images/jj8.png', '../assets/images/jj9.png'),
(36,36,'../assets/images/kk1.png','../assets/images/kk2.png','../assets/images/kk3.png','../assets/images/kk4.png','../assets/images/kk5.png', '../assets/images/kk6.png', '../assets/images/kk7.png', '../assets/images/kk8.png', '../assets/images/kk9.png'),
(37,37,'../assets/images/ll1.png','../assets/images/ll2.png','../assets/images/ll3.png','../assets/images/ll4.png','../assets/images/ll5.png', '../assets/images/ll6.png', '../assets/images/ll7.png', '../assets/images/ll8.png', '../assets/images/ll9.png'),
(38,38,'../assets/images/mm1.png','../assets/images/mm2.png','../assets/images/mm3.png','../assets/images/mm4.png','../assets/images/mm5.png', '../assets/images/mm6.png', '../assets/images/mm7.png', '../assets/images/mm8.png', '../assets/images/mm9.png'),
(39,39,'../assets/images/nn1.png','../assets/images/nn2.png','../assets/images/nn3.png','../assets/images/nn4.png','../assets/images/nn5.png', '../assets/images/nn6.png', '../assets/images/nn7.png', '../assets/images/nn8.png', '../assets/images/nn9.png'),
(40,40,'../assets/images/oo1.png','../assets/images/oo2.png','../assets/images/oo3.png','../assets/images/oo4.png','../assets/images/oo5.png', '../assets/images/oo6.png', '../assets/images/oo7.png', '../assets/images/oo8.png', '../assets/images/oo9.png'),
(41,41,'../assets/images/pp1.png','../assets/images/pp2.png','../assets/images/pp3.png','../assets/images/pp4.png','../assets/images/pp5.png', '../assets/images/pp6.png', '../assets/images/pp7.png', '../assets/images/pp8.png', '../assets/images/pp9.png'),
(42,42,'../assets/images/rr1.png','../assets/images/rr2.png','../assets/images/rr3.png','../assets/images/rr4.png','../assets/images/rr5.png', '../assets/images/rr6.png', '../assets/images/rr7.png', '../assets/images/rr8.png', '../assets/images/rr9.png'),
(43,43,'../assets/images/ss1.png','../assets/images/ss2.png','../assets/images/ss3.png','../assets/images/ss4.png','../assets/images/ss5.png', '../assets/images/ss6.png', '../assets/images/ss7.png', '../assets/images/ss8.png', '../assets/images/ss9.png'),
(44,44,'../assets/images/tt1.png','../assets/images/tt2.png','../assets/images/tt3.png','../assets/images/tt4.png','../assets/images/tt5.png', '../assets/images/tt6.png', '../assets/images/tt7.png', '../assets/images/tt8.png', '../assets/images/tt9.png'),
(45,45,'../assets/images/uu1.png','../assets/images/uu2.png','../assets/images/uu3.png','../assets/images/uu4.png','../assets/images/uu5.png', '../assets/images/uu6.png', '../assets/images/uu7.png', '../assets/images/uu8.png', '../assets/images/uu9.png'),
(46,46,'../assets/images/vv1.png','../assets/images/vv2.png','../assets/images/vv3.png','../assets/images/vv4.png','../assets/images/vv5.png', '../assets/images/vv6.png', '../assets/images/vv7.png', '../assets/images/vv8.png', '../assets/images/vv9.png'),
(47,47,'../assets/images/yy1.png','../assets/images/yy2.png','../assets/images/yy3.png','../assets/images/yy4.png','../assets/images/yy5.png', '../assets/images/yy6.png', '../assets/images/yy7.png', '../assets/images/yy8.png', '../assets/images/yy9.png'),
(48,48,'../assets/images/zz1.png','../assets/images/zz2.png','../assets/images/zz3.png','../assets/images/zz4.png','../assets/images/zz5.png', '../assets/images/zz6.png', '../assets/images/zz7.png', '../assets/images/zz8.png', '../assets/images/zz9.png'),
(49,49,'../assets/images/qq1.png','../assets/images/qq2.png','../assets/images/qq3.png','../assets/images/qq4.png','../assets/images/qq5.png', '../assets/images/qq6.png', '../assets/images/qq7.png', '../assets/images/qq8.png', '../assets/images/qq9.png'),
(50,50,'../assets/images/ww1.png','../assets/images/ww2.png','../assets/images/ww3.png','../assets/images/ww4.png','../assets/images/ww5.png', '../assets/images/ww6.png', '../assets/images/ww7.png', '../assets/images/ww8.png', '../assets/images/ww9.png'),
(51,51,'../assets/images/A1.png','../assets/images/A2.png','../assets/images/A3.png','../assets/images/A4.png','../assets/images/A5.png', '../assets/images/A6.png', '../assets/images/A7.png', '../assets/images/A8.png', '../assets/images/A9.png'),
(52,52,'../assets/images/B1.png','../assets/images/B2.png','../assets/images/B3.png','../assets/images/B4.png','../assets/images/B5.png', '../assets/images/B6.png', '../assets/images/B7.png', '../assets/images/B8.png', '../assets/images/B9.png'),
(53,53,'../assets/images/C1.png','../assets/images/C2.png','../assets/images/C3.png','../assets/images/C4.png','../assets/images/C5.png', '../assets/images/C6.png', '../assets/images/C7.png', '../assets/images/C8.png', '../assets/images/C9.png'),
(54,54,'../assets/images/D1.png','../assets/images/D2.png','../assets/images/D3.png','../assets/images/D4.png','../assets/images/D5.png', '../assets/images/D6.png', '../assets/images/D7.png', '../assets/images/D8.png', '../assets/images/D9.png'),
(55,55,'../assets/images/E1.png','../assets/images/E2.png','../assets/images/E3.png','../assets/images/E4.png','../assets/images/E5.png', '../assets/images/E6.png', '../assets/images/E7.png', '../assets/images/E8.png', '../assets/images/E9.png'),
(56,56,'../assets/images/F1.png','../assets/images/F2.png','../assets/images/F3.png','../assets/images/F4.png','../assets/images/F5.png', '../assets/images/F6.png', '../assets/images/F7.png', '../assets/images/F8.png', '../assets/images/F9.png'),
(57,57,'../assets/images/G1.png','../assets/images/G2.png','../assets/images/G3.png','../assets/images/G4.png','../assets/images/G5.png', '../assets/images/G6.png', '../assets/images/G7.png', '../assets/images/G8.png', '../assets/images/G9.png'),
(58,58,'../assets/images/H1.png','../assets/images/H2.png','../assets/images/H3.png','../assets/images/H4.png','../assets/images/H5.png', '../assets/images/H6.png', '../assets/images/H7.png', '../assets/images/H8.png', '../assets/images/H9.png'),
(59,59,'../assets/images/I1.png','../assets/images/2.png','../assets/images/I3.png','../assets/images/I4.png','../assets/images/I5.png', '../assets/images/I6.png', '../assets/images/I7.png', '../assets/images/I8.png', '../assets/images/I9.png'),
(60,60,'../assets/images/J1.png','../assets/images/J2.png','../assets/images/J3.png','../assets/images/J4.png','../assets/images/J5.png', '../assets/images/J6.png', '../assets/images/J7.png', '../assets/images/J8.png', '../assets/images/J9.png'),
(61,61,'../assets/images/K1.png','../assets/images/K2.png','../assets/images/K3.png','../assets/images/K4.png','../assets/images/K5.png', '../assets/images/K6.png', '../assets/images/K7.png', '../assets/images/K8.png', '../assets/images/K9.png'),
(62,62,'../assets/images/L1.png','../assets/images/L2.png','../assets/images/L3.png','../assets/images/L4.png','../assets/images/L5.png', '../assets/images/L6.png', '../assets/images/L7.png', '../assets/images/L8.png', '../assets/images/L9.png'),
(63,63,'../assets/images/M1.png','../assets/images/M2.png','../assets/images/M3.png','../assets/images/M4.png','../assets/images/M5.png', '../assets/images/M6.png', '../assets/images/M7.png', '../assets/images/M8.png', '../assets/images/M9.png'),
(64,64,'../assets/images/N1.png','../assets/images/N2.png','../assets/images/N3.png','../assets/images/N4.png','../assets/images/N5.png', '../assets/images/N6.png', '../assets/images/N7.png', '../assets/images/N8.png', '../assets/images/N9.png'),
(65,65,'../assets/images/O1.png','../assets/images/2.png','../assets/images/O3.png','../assets/images/O4.png','../assets/images/O5.png', '../assets/images/O6.png', '../assets/images/O7.png', '../assets/images/O8.png', '../assets/imagesO9.png'),
(66,66,'../assets/images/P1.png','../assets/images/P2.png','../assets/images/P3.png','../assets/images/P4.png','../assets/images/P5.png', '../assets/images/P6.png', '../assets/images/P7.png', '../assets/images/P8.png', '../assets/images/P9.png'),
(67,67,'../assets/images/R1.png','../assets/images/R2.png','../assets/images/R3.png','../assets/images/R4.png','../assets/images/R5.png', '../assets/images/R6.png', '../assets/images/R7.png', '../assets/images/R8.png', '../assets/images/R9.png'),
(68,68,'../assets/images/S1.png','../assets/images/S2.png','../assets/images/S3.png','../assets/images/S4.png','../assets/images/S5.png', '../assets/images/S6.png', '../assets/images/S7.png', '../assets/images/S8.png', '../assets/images/S9.png'),
(69,69,'../assets/images/T1.png','../assets/images/T2.png','../assets/images/T3.png','../assets/images/T4.png','../assets/images/T5.png', '../assets/images/T6.png', '../assets/images/T7.png', '../assets/images/T8.png', '../assets/images/T9.png'),
(70,70,'../assets/images/U1.png','../assets/images/U2.png','../assets/images/U3.png','../assets/images/U4.png','../assets/images/U5.png', '../assets/images/U6.png', '../assets/images/U7.png', '../assets/images/U8.png', '../assets/images/U9.png'),
(71,71,'../assets/images/V1.png','../assets/images/V2.png','../assets/images/V3.png','../assets/images/V4.png','../assets/images/V5.png', '../assets/images/V6.png', '../assets/images/V7.png', '../assets/images/V8.png', '../assets/images/V9.png'),
(72,72,'../assets/images/Y1.png','../assets/images/Y2.png','../assets/images/Y3.png','../assets/images/Y4.png','../assets/images/Y5.png', '../assets/images/Y6.png', '../assets/images/Y7.png', '../assets/images/Y8.png', '../assets/images/Y9.png'),
(73,73,'../assets/images/Z1.png','../assets/images/Z2.png','../assets/images/Z3.png','../assets/images/Z4.png','../assets/images/Z5.png', '../assets/images/Z6.png', '../assets/images/Z7.png', '../assets/images/Z8.png', '../assets/images/Z9.png'),
(74,74,'../assets/images/Q1.png','../assets/images/Q2.png','../assets/images/Q3.png','../assets/images/Q4.png','../assets/images/Q5.png', '../assets/images/Q6.png', '../assets/images/Q7.png', '../assets/images/Q8.png', '../assets/images/Q9.png'),
(75,75,'../assets/images/W1.png','../assets/images/W2.png','../assets/images/W3.png','../assets/images/W4.png','../assets/images/W5.png', '../assets/images/W6.png', '../assets/images/W7.png', '../assets/images/W8.png', '../assets/images/W9.png'),
(76,76,'../assets/images/AA1.png','../assets/images/AA2.png','../assets/images/AA3.png','../assets/images/AA4.png','../assets/images/AA5.png', '../assets/images/AA6.png', '../assets/images/AA7.png', '../assets/images/AA8.png', '../assets/images/AA9.png'),
(77,77,'../assets/images/BB1.png','../assets/images/BB2.png','../assets/images/BB3.png','../assets/images/BB4.png','../assets/images/BB5.png', '../assets/images/BB6.png', '../assets/images/BB7.png', '../assets/images/BB8.png', '../assets/images/BB9.png'),
(78,78,'../assets/images/CC1.png','../assets/images/CC2.png','../assets/images/CC3.png','../assets/images/CC4.png','../assets/images/CC5.png', '../assets/images/CC6.png', '../assets/images/CC7.png', '../assets/images/CC8.png', '../assets/images/CC9.png'),
(79,79,'../assets/images/DD1.png','../assets/images/DD2.png','../assets/images/DD3.png','../assets/images/DD4.png','../assets/images/DD5.png', '../assets/images/DD6.png', '../assets/images/DD7.png', '../assets/images/DD8.png', '../assets/images/DD9.png'),
(80,80,'../assets/images/EE1.png','../assets/images/EE2.png','../assets/images/EE3.png','../assets/images/EE4.png','../assets/images/EE5.png', '../assets/images/EE6.png', '../assets/images/EE7.png', '../assets/images/EE8.png', '../assets/images/EE9.png')



/*Inserting data to Images_correctImage_no Table (Multivalue)*/
INSERT INTO ImageCaptcha.Images_correctImage_no(icn_id, image_id, image_no1, image_no2, image_no3)
VALUES
(1,1,1,3,5),
(2,2,2,4,6),
(3,3,4,9,5),
(4,4,3,4,7),
(5,5,1,5,9),
(6,6,6,4,7),
(7,7,1,8,9),
(8,8,2,4,9),
(9,9,3,9,2),
(10,10,1,8,5),
(11,11,1,3,5),
(12,12,4,3,5),
(13,13,8,3,5),
(14,14,4,2,1),
(15,15,7,3,5),
(16,16,1,9,8),
(17,17,1,4,9),
(18,18,1,7,8),
(19,19,2,4,6),
(20,20,3,9,5),
(21,21,1,3,5),
(22,22,2,4,6),
(23,23,4,9,5),
(24,24,3,4,7),
(25,25,1,5,9),
(26,26,6,4,7),
(27,27,1,8,9),
(28,28,2,4,9),
(29,29,3,9,2),
(30,30,1,8,5),
(31,31,1,3,5),
(32,32,4,3,5),
(33,33,8,3,5),
(34,34,4,2,1),
(35,35,7,3,5),
(36,36,1,9,8),
(37,37,1,4,9),
(38,38,1,7,8),
(39,39,2,4,6),
(40,40,3,9,5),
(41,41,1,4,5),
(42,42,2,9,3),
(43,43,4,9,8),
(44,44,4,7,9),
(45,45,3,7,8),
(46,46,1,2,3),
(47,47,5,8,4),
(48,48,3,2,1),
(49,49,1,7,8),
(50,50,9,7,4),
(51,51,3,4,1),
(52,52,2,7,8),
(53,53,3,7,8),
(54,54,4,5,9),
(55,55,3,7,5),
(56,56,6,9,3),
(57,57,2,6,1),
(58,58,3,7,8),
(59,59,2,1,6),
(60,60,1,8,3),
(61,61,3,9,5),
(62,62,1,4,5),
(63,63,2,9,3),
(64,64,4,9,8),
(65,65,4,7,9),
(66,66,3,7,8),
(67,67,1,2,3),
(68,68,5,8,4),
(69,69,3,2,1),
(70,70,1,7,8),
(71,71,9,7,4),
(72,72,3,4,1),
(73,73,2,7,8),
(74,74,3,7,8),
(75,75,4,5,9),
(76,76,3,7,5),
(77,77,6,9,3),
(78,78,2,6,1),
(79,79,3,7,8),
(80,80,2,1,6)



/*Inserting data to Background Table */
INSERT INTO TextCaptcha.Background(bg_id, bg_image_path, opacity)
VALUES
(1,'../assets/images/bg1.png',0.1),
(2,'../assets/images/bg2.png',0.2),
(3,'../assets/images/bg3.png',0.3),
(4,'../assets/images/bg4.png',0.4),
(5,'../assets/images/bg5.png',0.5),
(6,'../assets/images/bg6.png',0.6),
(7,'../assets/images/bg7.png',0.7),
(8,'../assets/images/bg8.png',0.8),
(9,'../assets/images/bg9.png',0.9),
(10,'../assets/images/bg10.png',1.0),
(11,'../assets/images/bg11.png',0.1),
(12,'../assets/images/bg12.png',0.2),
(13,'../assets/images/bg13.png',0.3),
(14,'../assets/images/bg14.png',0.4),
(15,'../assets/images/bg15.png',0.5),
(16,'../assets/images/bg16.png',0.6),
(17,'../assets/images/bg17.png',0.7),
(18,'../assets/images/bg18.png',0.8),
(19,'../assets/images/bg19.png',0.9),
(20,'../assets/images/bg20.png',1.0)



/*Inserting data to Texts Table */
INSERT INTO TextCaptcha.Texts(text_id, word,  font_family, text_height, text_width, char_space, bg_id)
VALUES
(1,'abow2u','serif',1.1, 2.2,4, 1),
(2,'abc21jln','san-serif',2.2, 3.3,5, 2),
(3,'bnsde2','cursive',3.3, 4.4,6, 3),
(4,'1busa34','monospace',4.4, 5.5,7, 4),
(5,'wqks5f23l','fantasy',5.5, 6.6,1, 5),
(6,'amkug2u','serif',6.6, 7.7,2, 6),
(7,'jmcd34','serif',7.7, 8.8,3, 7),
(8, 'dhnjx4','monospace', 8.8, 9.9,3,8),
(9, 'kjsdg2ijub', 'georgia', 9.9, 9.9,4, 9),
(10,'aukisg2bs','times-roman',1.1, 2.2,6, 10),
(11,'lkoue5o7','san-serif',2.2, 3.3,7, 11),
(12,'sfdr19bx','cursive',3.3, 4.4,9, 12),
(13,'cxzsadr3','monospace',4.4, 5.5, 0,13),
(14,'lkouse6','fantasy',5.5, 6.6,1, 14),
(15,'aol6g2u','serif',6.6, 7.7,2, 15),
(16,'jmcpoy4','serif',7.7, 8.8, 3,16),
(17, 'djx4','monospace', 8.8, 9.9,4,17),
(18, 'kj78iub', 'georgia', 9.9, 9.9,5, 18),
(19,'alkjh6u','serif',1.1, 2.2,6, 19),
(20,'a1jln','san-serif',2.2, 3.3,7, 20),
(21,'bokhse2','cursive',3.3, 4.4,1, 1),
(22,'1bplkja34','monospace',4.4, 5.5,3, 2),
(23,'w5fl','fantasy',5.5, 6.6, 5,3),
(24,'adkug2u','serif',6.6, 7.7,7, 4),
(25,'jmd84','serif',7.7, 8.8,5, 5),
(26, 'dhn9jx4','monospace', 8.8, 9.9,6,6),
(27, 'kjsd4g2ijub', 'georgia', 9.9, 9.9,5, 7),
(28,'aukisg882bs','times-roman',1.1, 2.2,5, 8),
(29,'lkoue51o7','san-serif',2.2, 3.3,6, 9),
(30,'sfdr119bx','cursive',3.3, 4.4,8, 10),
(31,'cxzsa33dr3','monospace',4.4, 5.5,3, 11),
(32,'lkou2se6','fantasy',5.5, 6.6,2, 12),
(33,'aol56g2u','serif',6.6, 7.7,1, 13),
(34,'jmc66poy4','serif',7.7, 8.8,4, 14),
(35, 'djx004','monospace', 8.8, 9.9,5,15),
(36, 'kj7855iub', 'georgia', 9.9, 9.9,2, 16),
(37, 'dhn77jx4','monospace', 8.8, 9.9,2,6),
(38, 'kjsd57jub', 'georgia', 9.9, 9.9, 1,7),
(39,'au3737bs','times-roman',1.1, 2.2,8, 8),
(40,'lko17e5o7','san-serif',2.2, 3.3,5, 9)



/*Inserting data to Texts_Color Table(Multivalue) */
INSERT INTO TextCaptcha.Texts_Color(tc_id, text_id,  color1, color2, color3, color4)
VALUES
(1,1,'red','blue','yellow','orange'),
(2,2,'green','blue','black','orange'),
(3,3,'white','pink','yellow','purple'),
(4,4,'darkblue','grey','yellow','red'),
(5,5,'lightpink','blue','mint','orange'),
(6,6,'brown','mint','yellow','blue'),
(7,7,'pink','brown','mint','black'),
(8,8,'red','turquoise','yellow','brown'),
(9,9,'green','grey','black','orange'),
(10,10,'red','lilac','yellow','moss'),
(11,11,'moss','brown','yellow','green'),
(12,12,'red','grey','black','orange'),
(13,13,'lilac','moss','mint','pumpkin'),
(14,14,'tan','white','yellow','mint'),
(15,15,'green','moss','red','coral'),
(16,16,'mint','blue','yellow','khaki'),
(17,17,'turqouise','lilac','yellow','mint'),
(18,18,'red','lilac','yellow','cream'),
(19,19,'mint','blue','brown','beige'),
(20,20,'pumpkin','blue','moss','black'),
(21,21,'cream','pink','purple','violet'),
(22,22,'white','blue','yellow','red'),
(23,23,'forest','blue','yellow','tan'),
(24,24,'yellow','marin','pumpkin','moss'),
(25,25,'lemonade','mint','yellow','gray'),
(26,26,'kelly','blue','green','gold'),
(27,27,'mint','blue','black','navy'),
(28,28,'forest','blue','mint','orange'),
(29,29,'lilac','blue','red','mint'),
(30,30,'pink','blue','grey','orange'),
(31,31,'tan','blue','green','silver'),
(32,32,'cream','blue','peach','beige'),
(33,33,'purple','blue','kelly','crimson'),
(34,34,'lemonade','blue','cream','coral'),
(35,35,'light blue','blue','marine','orange'),
(36,36,'red','green','black','orange'),
(37,37,'forest','blue','forest','orange'),
(38,38,'marin','blue','purple','cyan'),
(39,39,'tan','blue','mint','beige'),
(40,40,'red','blue','pink','navy')



/*Inserting data to Sound Table */
INSERT INTO SoundCaptcha.Sound(sound_id, sound_sec, sound_word, sound_type)
VALUES
(1,5,'hello','robotic'),
(2,6,'generous','alien'),
(3,7,'thanks','electricity'),
(4,8,'welcome','magic'),
(5,9,'sophistication','gun'),
(6,10,'undefined','cassette'),
(7,5,'investigation','ocean'),
(8,6,'examine','schratched'),
(9,7,'contribution','chord'),
(10,8,'approximately','helicopter'),
(11,9,'straightforward','pulse'),
(12,10,'energy','seeker'),
(13,5,'balance','collapse'),
(14,6,'intelligence','radio'),
(15,7,'difficult','hivemind'),
(16,8,'distribution','synth'),
(17,9,'encouragement','dispatch'),
(18,10,'material','industrial'),
(19,5,'enforce','redalert'),
(20,6,'download','workshop'),
(21,7,'inexhaustible','robotic'),
(22,8,'qualification','alien'),
(23,9,'playback','electricty'),
(24,10,'alternative','magic'),
(25,5,'obsession','cassette'),
(26,6,'purchase','gun'),
(27,7,'imagination','ocean'),
(28,8,'authorization','chord'),
(29,9,'verification','helicopter'),
(30,10,'accomplishment','pulse'),
(31,5,'sustainability','seeker'),
(32,6,'acknowledgement','radio'),
(33,7,'neighbourhood','gun'),
(34,8,'thoughtfulness','magic'),
(35,9,'simultaneously','chord'),
(36,10,'manifestation','robotic'),
(37,5,'comprehensive','hivemind'),
(38,6,'prediction','dispatch'),
(39,7,'priority','magic'),
(40,8,'announcement','industrial')



/*Inserting data to Sound_soundLanguage Table (Multivalue)*/
INSERT INTO SoundCaptcha.Sound_soundLanguage(ssl_id, sound_id, language1, language2, language3, language4)
VALUES
(1,1,'german','english','portuguese','turkish'),
(2,2,'italian','english','russian','turkish'),
(3,3,'german','italian','portuguese','turkish'),
(4,4,'russian','english','italian','turkish'),
(5,5,'german','english','portuguese','italian'),
(6,6,'arabic','english','mandarin','turkish'),
(7,7,'bulgarian','arabic','portuguese','turkish'),
(8,8,'mandarin','english','arabic','turkish'),
(9,9,'german','english','portuguese','arabic'),
(10,10,'spanish','english','russian','turkish'),
(11,11,'german','spanish','portuguese','french'),
(12,12,'italian','english','spanish','turkish'),
(13,13,'german','english','portuguese','spanish'),
(14,14,'greek','spanish','portuguese','turkish'),
(15,15,'german','greek','portuguese','turkish'),
(16,16,'german','english','greek','turkish'),
(17,17,'italian','spanish','portuguese','greek'),
(18,18,'bulgarian','english','portuguese','turkish'),
(19,19,'german','bulgarian','portuguese','turkish'),
(20,20,'german','spanish','bulgarian','turkish'),
(21,21,'german','english','portuguese','bulgarian'),
(22,22,'russian','english','portuguese','turkish'),
(23,23,'german','russian','portuguese','turkish'),
(24,24,'german','english','russian','turkish'),
(25,25,'german','english','portuguese','russian'),
(26,26,'french','english','portuguese','bulgarian'),
(27,27,'german','french','portuguese','turkish'),
(28,28,'german','english','french','turkish'),
(29,29,'german','english','portuguese','french'),
(30,30,'chinese','english','portuguese','turkish'),
(31,31,'german','chinese','portuguese','french'),
(32,32,'german','english','chinese','turkish'),
(33,33,'german','english','portuguese','chinese'),
(34,34,'hindi','english','portuguese','turkish'),
(35,35,'german','hindi','portuguese','turkish'),
(36,36,'german','english','hindi','french'),
(37,37,'german','english','portuguese','hindi'),
(38,38,'mandarin','english','portuguese','turkish'),
(39,39,'german','mandarin','portuguese','turkish'),
(40,40,'german','english','mandarin','french')



/*Inserting data to Users Table */
INSERT INTO Person.Users(user_id, name,  lastName, email, control_captcha, active)
VALUES
(1,'Muslum', 'Sivri', 'mslm.svr9@gmail.com', NULL, 1),
(2,'Belen', 'Ýrican', 'belenirican@gmail.com', NULL, 1),
(3,'Melike', 'Varol', 'melikevrl@gmail.com', NULL, 0),
(4,'Fidan', 'Karadeniz', 'fidankrdn@gmail.com', NULL, 0),
(5,'Cem', 'Petek', 'cempetek@gmail.com', NULL, 1),
(6,'Emre', 'Coltu', 'emreclt@gmail.com', NULL, 0),
(7,'Mert', 'Gunacti', 'mertgunac@gmail.com', NULL, 1),
(8,'Tulin', 'Nayir', 'tulinyr@gmail.com', NULL, 1),
(9,'Ali', 'Kanal', 'alikanal@gmail.com', NULL, 0),
(10,'Ceyda', 'Uluturk', 'ceydauluturk@gmail.com', NULL, 1),
(11,'Onur', 'Oran', 'onuroran@gmail.com', NULL, 0),
(12,'Koray', 'Keleþ', 'koraykeles@gmail.com', NULL, 1),
(13,'Umur', 'Koksal', 'umurkoksal@gmail.com', NULL, 0),
(14,'Zehra', 'Dogan', 'zehradogan@gmail.com', NULL, 1),
(15,'Berk', 'Atasoy', 'berkatasoy@gmail.com', NULL, 0),
(16,'Rabia', 'Çevik', 'rabiacevik@hotmail.com', NULL, 1),
(17,'Tarýk Yasin', 'Vardi', 'tarýkvardi@hotmail.com', NULL, 0),
(18,'Haluk', 'Ertekin', 'halukertkn@hotmail.com', NULL, 1),
(19,'Emrehan', 'Görgeç', 'emrhngrgc@hotmail.com', NULL, 0),
(20,'Arda', 'Karabulut', 'krbltarda@hotmail.com', NULL, 1)



/*Creating UserMath table*/
CREATE TABLE MathCaptcha.UserMath
(
	user_math_id INT NOT NULL,
	user_result INT NOT NULL,
	math_id INT ,
	user_id INT

)


/*user_math_id added as primary key*/
ALTER TABLE MathCaptcha.UserMath
ADD CONSTRAINT PK_UserMath_user_math_id
PRIMARY KEY (user_math_id);

/*math_id  added as foreign key*/
ALTER TABLE MathCaptcha.UserMath
ADD CONSTRAINT FK_UserMath_math_id
FOREIGN KEY (math_id) REFERENCES MathCaptcha.Math(math_id);

/*user_id  added as foreign key*/
ALTER TABLE MathCaptcha.UserMath
ADD CONSTRAINT FK_UserMath_user_id
FOREIGN KEY (user_id) REFERENCES Person.Users(user_id);


/*Creating MathRecod table*/
CREATE TABLE MathCaptcha.MathRecord
(
	math_record_id INT NOT NULL,
	trial_no INT ,
	refresh_times INT ,
	user_math_id INT
)


/*math_record_id added as primary key*/
ALTER TABLE MathCaptcha.MathRecord
ADD CONSTRAINT PK_MathRecord_math_record_id
PRIMARY KEY (math_record_id);

/*math_id  added as foreign key*/
ALTER TABLE MathCaptcha.MathRecord
ADD CONSTRAINT FK_MathRecord_user_math_id
FOREIGN KEY (user_math_id) REFERENCES MathCaptcha.UserMath(user_math_id);


/*Creating UserImage table*/
CREATE TABLE ImageCaptcha.UserImage
(
	user_image_id INT NOT NULL,
	image_id INT ,
	user_id INT,
)


/*user_image_id added as primary key*/
ALTER TABLE ImageCaptcha.UserImage
ADD CONSTRAINT PK_UserImage_user_image_id
PRIMARY KEY (user_image_id);

/*image_id  added as foreign key*/
ALTER TABLE ImageCaptcha.UserImage
ADD CONSTRAINT FK_UserImage_image_id
FOREIGN KEY (image_id) REFERENCES ImageCaptcha.Images(image_id);

/*user_id  added as foreign key*/
ALTER TABLE ImageCaptcha.UserImage
ADD CONSTRAINT FK_UserImage_user_id
FOREIGN KEY (user_id) REFERENCES Person.Users(user_id);


/*Creating UserImage_selectedImage_no table*/
CREATE TABLE ImageCaptcha.UserImage_selectedImage_no
(
	usn_id INT NOT NULL,
	user_image_id INT NOT NULL ,
	image_no1 INT NOT NULL,
	image_no2 INT NOT NULL,
	image_no3 INT NOT NULL
	

)

/*usn_id added as primary key*/
ALTER TABLE ImageCaptcha.UserImage_selectedImage_no
ADD CONSTRAINT PK_UserImage_selectedImage_no_usn_idANDuser_image_id
PRIMARY KEY (usn_id,user_image_id);


/*Creating ImageRecod table*/
CREATE TABLE ImageCaptcha.ImageRecord
(
	image_record_id INT NOT NULL,
	trial_no INT ,
	refresh_times INT ,
	user_image_id INT

)


/*image_record_id added as primary key*/
ALTER TABLE ImageCaptcha.ImageRecord
ADD CONSTRAINT PK_ImageRecord_image_record_id
PRIMARY KEY (image_record_id);

/*image_id  added as foreign key*/
ALTER TABLE ImageCaptcha.ImageRecord
ADD CONSTRAINT FK_ImageRecord_user_image_id
FOREIGN KEY (user_image_id) REFERENCES ImageCaptcha.UserImage(user_image_id);


/*Creating UserText table*/
CREATE TABLE TextCaptcha.UserText
(
	user_text_id INT NOT NULL,
	user_input VARCHAR(50) NOT NULL,
	text_id INT ,
	user_id INT
)


/*user_text_id added as primary key*/
ALTER TABLE TextCaptcha.UserText
ADD CONSTRAINT PK_UserText_user_text_id
PRIMARY KEY (user_text_id);

/*text_id  added as foreign key*/
ALTER TABLE TextCaptcha.UserText
ADD CONSTRAINT FK_UserText_text_id
FOREIGN KEY (text_id) REFERENCES TextCaptcha.Texts(text_id);

/*user_id  added as foreign key*/
ALTER TABLE TextCaptcha.UserText
ADD CONSTRAINT FK_UserText_user_id
FOREIGN KEY (user_id) REFERENCES Person.Users(user_id);


/*Creating TextRecod table*/
CREATE TABLE TextCaptcha.TextRecord
(
	text_record_id INT NOT NULL,
	trial_no INT ,
	refresh_times INT ,
	user_text_id INT

)


/*text_record_id added as primary key*/
ALTER TABLE TextCaptcha.TextRecord
ADD CONSTRAINT PK_TextRecord_text_record_id
PRIMARY KEY (text_record_id);

/*user_text_id  added as foreign key*/
ALTER TABLE TextCaptcha.TextRecord
ADD CONSTRAINT FK_TextRecord_user_text_id
FOREIGN KEY (user_text_id) REFERENCES TextCaptcha.UserText(user_text_id);



/*Creating UserSound table*/
CREATE TABLE SoundCaptcha.UserSound
(
	user_sound_id INT NOT NULL,
	user_language VARCHAR(50) NOT NULL,
	user_word VARCHAR(50) NOT NULL,
	sound_id INT,
	user_id INT
)

/*user_sound_id added as primary key*/
ALTER TABLE SoundCaptcha.UserSound
ADD CONSTRAINT PK_UserSound_user_sound_id
PRIMARY KEY (user_sound_id);

/*sound_id  added as foreign key*/
ALTER TABLE SoundCaptcha.UserSound
ADD CONSTRAINT FK_UserSound_sound_id
FOREIGN KEY (sound_id) REFERENCES SoundCaptcha.Sound(sound_id);

/*user_id  added as foreign key*/
ALTER TABLE SoundCaptcha.UserSound
ADD CONSTRAINT FK_UserSound_user_id
FOREIGN KEY (user_id) REFERENCES Person.Users(user_id);



/*Creating SoundRecod table*/
CREATE TABLE SoundCaptcha.SoundRecord
(
	sound_record_id INT NOT NULL,
	trial_no INT ,
	refresh_times INT ,
	user_sound_id INT

)


/*sound_record_id added as primary key*/
ALTER TABLE SoundCaptcha.SoundRecord
ADD CONSTRAINT PK_SoundRecord_sound_record_id
PRIMARY KEY (sound_record_id);

/*user_sound_id  added as foreign key*/
ALTER TABLE SoundCaptcha.SoundRecord
ADD CONSTRAINT FK_SoundRecord_user_sound_id
FOREIGN KEY (user_sound_id) REFERENCES SoundCaptcha.UserSound(user_sound_id);



/*** CREATING TRIGGERS FOR USERMATH,USERIMAGE,USERTEXT AND USERSOUND TABLE ***/

/*Creating trigger for checking user math result.*/
CREATE TRIGGER MathCaptcha.CheckUserMathResult
ON MathCaptcha.UserMath
FOR INSERT
AS
BEGIN

DECLARE @user_result INT,@user_math_id INT,@user_id INT,@operation VARCHAR(50),@first_operand INT,@second_operand INT,@result INT
SELECT @user_result=user_result ,@user_math_id=math_id,@user_id=user_id FROM inserted;
SELECT @operation = operation,@first_operand=first_operand,@second_operand=second_operand FROM MathCaptcha.Math WHERE Math.math_id = @user_math_id

IF @operation = 'addition'
	BEGIN
		SET @result = @first_operand + @second_operand
	END

ELSE IF @operation = 'subtraction'
	BEGIN
		SET @result = @first_operand - @second_operand
	END

ELSE IF @operation = 'multiplication'
	BEGIN
		SET @result = @first_operand * @second_operand
	END

ELSE IF @operation = 'division'
	BEGIN
		SET @result = @first_operand / @second_operand
	END

IF @user_result = @result
	BEGIN
		UPDATE Person.Users SET control_captcha = 1 WHERE user_id = @user_id

		INSERT INTO Person.Verification(code,user_id)
		VALUES(@operation + 'abc' +@operation +'xyz',@user_id)
	END
ELSE
	BEGIN
		UPDATE Person.Users SET control_captcha = 0 WHERE user_id = @user_id
	END
END



/*Creating trigger for image captcha to check UserImage result*/
CREATE TRIGGER ImageCaptcha.CheckUserImageResult
ON ImageCaptcha.UserImage_selectedImage_no
FOR INSERT
AS
BEGIN
DECLARE @user_name VARCHAR(50),@user_id INT,@user_image_no1 INT,@user_image_no2 INT,@user_image_no3 INT,@user_image_id INT,@image_id INT,@image_no1 INT,@image_no2 INT,@image_no3 INT
SELECT @user_image_no1 = image_no1 ,@user_image_no2=image_no2,@user_image_no3=image_no3,@user_image_id=user_image_id FROM inserted;
SELECT @image_id = image_id,@user_id=user_id FROM UserImage WHERE user_image_id = @user_image_id;
SELECT @image_no1 = image_no1,@image_no2 = image_no2,@image_no3 = image_no3 FROM Images_correctImage_no WHERE image_id = @image_id;
SELECT @user_name=name FROM Person.Users WHERE user_id = @user_id;

IF (@user_image_no1 = @image_no1 AND @user_image_no2 = @image_no2 AND @user_image_no3 = @image_no3)
	BEGIN
		UPDATE Person.Users SET control_captcha = 1 WHERE user_id = @user_id

		INSERT INTO Person.Verification(code,user_id)
		VALUES('yyy'+@user_name+'xxx',@user_id)
	END
ELSE
	BEGIN
		UPDATE Person.Users SET control_captcha = 0 WHERE user_id = @user_id
	END
END



/*Creating trigger for text captcha to check user result*/
CREATE TRIGGER TextCaptcha.CheckUserTextResult
ON TextCaptcha.UserText
FOR INSERT
AS
BEGIN

DECLARE @user_input VARCHAR(50),@text_id INT,@user_id INT,@word VARCHAR(50)
SELECT @user_input = user_input , @text_id = text_id , @user_id = user_id FROM inserted;
SELECT @word = word FROM Texts WHERE text_id = @text_id;

IF @user_input = @word
	BEGIN
		UPDATE Person.Users SET control_captcha = 1 WHERE user_id = @user_id

		INSERT INTO Person.Verification(code,user_id)
		VALUES('qwe' + @word+ 'cvb',@user_id)
	END
ELSE
	BEGIN
		UPDATE Person.Users SET control_captcha = 0 WHERE user_id = @user_id
	END
END




/*Creating trigger for sound captcha to check user sound result*/
CREATE TRIGGER SoundCaptcha.CheckUserSoundResult
ON SoundCaptcha.UserSound
FOR INSERT
AS
BEGIN

DECLARE @user_word VARCHAR(50),@sound_id INT,@user_id INT,@sound_word VARCHAR(50),@sound_type VARCHAR(50)
SELECT @user_word = user_word , @sound_id = sound_id , @user_id = user_id FROM inserted;
SELECT @sound_word = sound_word,@sound_type=sound_type FROM Sound WHERE sound_id = @sound_id;

IF @user_word = @sound_word
	BEGIN
		UPDATE Person.Users SET control_captcha = 1 WHERE user_id = @user_id

		INSERT INTO Person.Verification(code,user_id)
		VALUES('XXX' + @sound_word+@sound_type+'YYY',@user_id)
	END
ELSE
	BEGIN
		UPDATE Person.Users SET control_captcha = 0 WHERE user_id = @user_id
	END
END


/*INSERTING DATA FOR USERMATH (CASUE OF TRIGGER USAGE IT WILL BE EXECUTED ONE BY ONE)*/
INSERT INTO MathCaptcha.UserMath(user_math_id,user_result,math_id,user_id)
VALUES(1,23,1,1) /*CORRECT RESULT=33,USER RESULT=23 ADDITION 10+23 MUSLUM*/

INSERT INTO MathCaptcha.UserMath(user_math_id,user_result,math_id,user_id)
VALUES(2,10,11,2) /*CORRECT RESULT=10,USER RESULT = 10 SUBTRACTION 20-10 BELEN*/

INSERT INTO MathCaptcha.UserMath(user_math_id,user_result,math_id,user_id)
VALUES(3,560,21,3) /*CORRECT RESULT = 560,USER RESULT=560 MULTI 14*40 MELIKE*/

INSERT INTO MathCaptcha.UserMath(user_math_id,user_result,math_id,user_id)
VALUES(4,54,71,13) /*CORRECT RESULT = 24,USER RESULT=54 MULTI 48/2 UMUR*/

/*INSERTING DATA FOR MATHRECORD*/
INSERT INTO MathCaptcha.MathRecord(math_record_id,trial_no,refresh_times,user_math_id)
VALUES
(1,5,4,1), /* MUSLUM*/
(2,1,2,2), /* BELEN*/
(3,15,6,3) /* MELIKE*/

INSERT INTO MathCaptcha.MathRecord(math_record_id,trial_no,refresh_times,user_math_id)
VALUES(4,2,8,4)

/*INSERTING DATA FOR USERIMAGE*/

INSERT INTO ImageCaptcha.UserImage(user_image_id,image_id,user_id)
VALUES
(1,1,4), /*TRAFFIC LIGHT CAPTCAH - FIDAN KARADENIZ*/
(2,2,5), /*BRIDGE  -CEM OZAN PETEK*/
(3,3,6)	 /* TRUCK -EMRE COLTU*/

/*INSERTING DATA FOR Images_SelectedImage_no(CAUSE OF TRIGGER IT WILL BE EXECUTED SEPERATELY)*/
INSERT INTO ImageCaptcha.UserImage_selectedImage_no(usn_id,user_image_id,image_no1,image_no2,image_no3)
VALUES(1,1,1,3,5) /*TRAFFIC LIGHT CAPTCHA USER RESULT=(1,3,5), CORRECT RESULT=(1,3,5)  - FIDAN KARADENIZ*/

INSERT INTO ImageCaptcha.UserImage_selectedImage_no(usn_id,user_image_id,image_no1,image_no2,image_no3)
VALUES(2,2,2,4,6) /*BRIDGE CAPTCHA USER RESULT=(2,4,6), CORRECT RESULT=(2,4,6)  - CEM OZAN PETEK*/

INSERT INTO ImageCaptcha.UserImage_selectedImage_no(usn_id,user_image_id,image_no1,image_no2,image_no3)
VALUES(3,3,4,8,9) /*TRUCK CAPTCHA USER RESULT=(4,8,9), CORRECT RESULT=(4,9,5)  - EMRE COLTU*/

/*INSERTING DATA FOR ImageRecord*/
INSERT INTO ImageCaptcha.ImageRecord(image_record_id,trial_no,refresh_times,user_image_id)
VALUES
(1,2,7,1), /* FIDAN*/
(2,3,11,2), /* CEM*/
(3,8,5,3) /* EMRE*/

/*INSERTING DATA FOR USERTEXT(CAUSE OF TRIGGER IT WILL BE EXECUTED ONE BY ONE)*/
INSERT INTO TextCaptcha.UserText(user_text_id,user_input,text_id,user_id)
VALUES(1,'kkkzzz',1,7) /*CORRECT RESULT=abow2u,USER RESULT=kkkzzz  MERT*/

INSERT INTO TextCaptcha.UserText(user_text_id,user_input,text_id,user_id)
VALUES(2,'abc21jln',2,8) /*CORRECT RESULT=abow2u,USER RESULT=kkkzzz  TÜLÝN*/

INSERT INTO TextCaptcha.UserText(user_text_id,user_input,text_id,user_id)
VALUES(3,'bns345',3,9) /*CORRECT RESULT=bnsde2,USER RESULT=kkkzzz  ALÝ*/

/*INSERTING DATA FOR TEXTRECORD*/
INSERT INTO TextCaptcha.TextRecord(text_record_id,trial_no,refresh_times,user_text_id)
VALUES
(1,4,6,1), /* MERT*/
(2,3,1,2), /* TÜLÝN*/
(3,9,4,3) /* ALÝ*/


/*INSERTING DATA FOR USERSOUND(CAUSE OF TRIGGER IT WILL BE EXECUTED SEPERATELY)*/
INSERT INTO SoundCaptcha.UserSound(user_sound_id,user_language,user_word,sound_id,user_id)
VALUES(1,'portuguese','hello',1,10) /* USER RESULT=hello, CORRECT RESULT=hello  - CEYDA ULUTÜRK*/

INSERT INTO SoundCaptcha.UserSound(user_sound_id,user_language,user_word,sound_id,user_id)
VALUES(2,'russian','genrus',2,11) /* USER RESULT=genrus, CORRECT RESULT=generous  - ONUR ORAN*/

INSERT INTO SoundCaptcha.UserSound(user_sound_id,user_language,user_word,sound_id,user_id)
VALUES(3,'german','thanks',3,12) /* USER RESULT=thanks, CORRECT RESULT=thanks  - KORAY KELEÞ*/

/*INSERTING DATA FOR SOUNDRECORD*/
INSERT INTO SoundCaptcha.SoundRecord(sound_record_id,trial_no,refresh_times,user_sound_id)
VALUES
(1,2,2,1), /* CEYDA*/
(2,3,4,2), /* ONUR*/
(3,1,5,3) /* KORAY*/


/*INSERTING DATA FOR AUTHORIZATIONS*/
INSERT INTO Person.Authorizations(authorization_id,system_log_no,last_login_date,current_login_date,user_id)
VALUES
(1,3,'2022-11-01','2022-11-11',1),
(2,4,'2022-03-02','2022-03-12',2),
(3,2,'2022-04-03','2022-04-13',3),
(4,11,'2022-05-04','2022-05-14',4),
(5,5,'2022-06-05','2022-06-15',5),
(6,6,'2022-07-06','2022-07-16',6),
(7,8,'2022-08-07','2022-08-17',7),
(8,11,'2022-09-08','2022-09-18',8),
(9,4,'2022-10-09','2022-10-19',9),
(10,3,'2022-11-10','2022-11-20',10),
(11,21,'2022-01-11','2022-01-21',11),
(12,10,'2022-02-12','2022-02-22',12),
(13,2,'2022-03-13','2022-03-23',13),
(14,6,'2022-04-14','2022-04-24',14),
(15,14,'2022-05-15','2022-05-25',15),
(16,1,'2022-06-16','2022-06-26',16),
(17,9,'2022-07-17','2022-07-27',17),
(18,8,'2022-08-18','2022-08-28',18),
(19,4,'2022-09-19','2022-09-29',19),
(20,3,'2022-10-20','2022-10-30',20)




/*** CREATING VIEWS  ***/


/*VIEW--To learn how many active users in the system*/
CREATE VIEW Person.VNumberOfActiveUsers
AS
SELECT COUNT(user_id) AS ActiveUsers
FROM Person.Users 
WHERE active = 1;


/*VIEW--To learn how many gmail accounts in the system*/
CREATE VIEW Person.VNumberOfGmails
AS
SELECT COUNT(*) AS NumberOfGmails
FROM Person.Users 
WHERE email LIKE '%@gmail.com';


/*VIEW---To learn how many operations in our correct tables*/
CREATE VIEW MathCaptcha.VNumberOfOperations
AS
SELECT operation AS OperationName,COUNT(operation) AS OperationCount
FROM MathCaptcha.Math
GROUP BY operation;


/*VIEW--To learn distinct backgrounds and char space for each font family in the system*/
CREATE VIEW TextCaptcha.VNumberOf
AS
SELECT font_family AS Font_Family, COUNT(DISTINCT bg_id) AS Distinct_Backgrounds,COUNT(DISTINCT char_space) AS Distinct_Char_Spaces
FROM TextCaptcha.Texts
GROUP BY font_family ;


/*VIEW---To learn how many sound type in our Sound tables*/
CREATE VIEW SoundCaptcha.VNumberOfSoundType
AS
SELECT sound_type AS SoundTypeName ,COUNT(sound_type) AS NumberOfSoundType
FROM SoundCaptcha.Sound
GROUP BY(sound_type)


/*VIEW--To learn long words(>= 7 ) in the system*/
CREATE VIEW SoundCaptcha.VSoundWordLength
AS
SELECT * 
FROM SoundCaptcha.Sound 
WHERE LEN(sound_word) >= 7;





/***  CREATING PROCEDURES  ***/


/*Creating store procedure for finding verification code of user who has control_captcha=1 */
CREATE PROCEDURE Person.sp_CheckingControlCaptcha
(
	@user_id INT ,
	@verification_code VARCHAR(50) OUTPUT
)
AS
BEGIN
	DECLARE @control_captcha BIT
	SELECT @control_captcha = control_captcha FROM Person.Users WHERE @user_id=user_id;

	IF(@control_captcha = 1)
		BEGIN
			SELECT @verification_code = code FROM Person.Verification WHERE @user_id=user_id;
		END

	ELSE
		BEGIN
			SET @verification_code = 'CAN NOT SEND VERIFICATION CODE TO USER!';
		END

END

/*Execution of finding UserVerificationCode stored procedure*/
DECLARE @output_code VARCHAR(50);

EXEC Person.sp_CheckingControlCaptcha
	@user_id =2,
	@verification_code = @output_code OUTPUT;

SELECT @output_code AS 'Output Code';




/*Creating procedure for CheckingDateDifference*/
CREATE PROCEDURE Person.CheckingDateDifference
(
	@user_id INT ,
	@message VARCHAR(50) OUTPUT
)
AS
BEGIN

	DECLARE @last_login_date DATETIME,@current_login_date DATETIME,@number_of_days INT
	SELECT @last_login_date=last_login_date,@current_login_date=current_login_date 
	FROM Person.Authorizations
	WHERE @user_id=user_id;

	IF(DATEDIFF(Day,@last_login_date,@current_login_date) > 3)
		BEGIN
			SET @number_of_days = DATEDIFF(Day,@last_login_date,@current_login_date);
			SET @message = 'USER HAVENT ENTERED SYSTEM LAST '+CONVERT(VARCHAR(50),@number_of_days)+' DAYS.';

		END

	ELSE
		BEGIN
			SET @message = 'USER IS AUTHORIZED.';

		END

END

/*Execution of checking date difference from Authorization table */
DECLARE @output_message VARCHAR(50);

EXEC Person.CheckingDateDifference
	@user_id =1,
	@message = @output_message OUTPUT;

SELECT @output_message AS 'Output Message';



/*Creating procedure for finding user verification code*/
CREATE PROCEDURE Person.sp_FindingUsersVerificationCode
AS
BEGIN
	
	SELECT Person.Users.user_id AS 'ID',Person.Users.name AS 'NAME',Person.Users.lastName AS'LAST NAME',Person.Verification.code AS 'SENT CODE'
	FROM Person.Users
	INNER JOIN Person.Verification ON Person.Users.user_id = Person.Verification.user_id

END

EXEC Person.sp_FindingUsersVerificationCode




/*Creating procedure to check math refresh time */
CREATE PROCEDURE MathCaptcha.sp_MathRefreshTimesCheck
AS
BEGIN
	
	SELECT Person.Users.name AS 'NAME' ,Person.Users.lastName AS 'LAST NAME',MathCaptcha.MathRecord.refresh_times
	FROM Person.Users,MathCaptcha.MathRecord,MathCaptcha.UserMath
	WHERE Person.Users.user_id=MathCaptcha.UserMath.user_id AND
	MathCaptcha.UserMath.user_math_id = MathCaptcha.MathRecord.user_math_id AND
	Person.Users.user_id 
	IN
	(SELECT user_id 
	FROM MathCaptcha.UserMath WHERE user_math_id 
	IN
	(SELECT user_math_id
	FROM MathCaptcha.MathRecord
	))
	ORDER BY refresh_times ASC;

END


EXEC MathCaptcha.sp_MathRefreshTimesCheck



/*Creating procedure for comparing user math result and correct result*/
CREATE PROCEDURE MathCaptcha.MathComparisonUserResultAndCorrectResult
AS
BEGIN
	DECLARE @ INT

	SELECT Person.Users.name AS 'NAME',MathCaptcha.UserMath.user_result AS 'USER RESULT',MathCaptcha.Math.first_operand+MathCaptcha.Math.second_operand AS 'CORRECT RESULTS'
	FROM Person.Users,MathCaptcha.UserMath,MathCaptcha.Math
	WHERE Person.Users.user_id=MathCaptcha.UserMath.user_id AND 
	MathCaptcha.Math.math_id = MathCaptcha.UserMath.math_id AND
	Person.Users.control_captcha=0 AND
	MathCaptcha.Math.operation = 'addition'
	
	

	SELECT Person.Users.name AS 'NAME',MathCaptcha.UserMath.user_result AS 'USER RESULT',MathCaptcha.Math.first_operand-MathCaptcha.Math.second_operand AS 'CORRECT RESULTS'
	FROM Person.Users,MathCaptcha.UserMath,MathCaptcha.Math
	WHERE Person.Users.user_id=MathCaptcha.UserMath.user_id AND
	MathCaptcha.Math.math_id = MathCaptcha.UserMath.math_id  AND
	Person.Users.control_captcha=0 AND
	MathCaptcha.Math.operation = 'subtraction'

	SELECT Person.Users.name AS 'NAME',MathCaptcha.UserMath.user_result AS 'USER RESULT',MathCaptcha.Math.first_operand * MathCaptcha.Math.second_operand AS 'CORRECT RESULTS'
	FROM Person.Users,MathCaptcha.UserMath,MathCaptcha.Math
	WHERE Person.Users.user_id=MathCaptcha.UserMath.user_id AND
	MathCaptcha.Math.math_id = MathCaptcha.UserMath.math_id   AND
	Person.Users.control_captcha=0 AND
	MathCaptcha.Math.operation = 'multiplication'

	SELECT Person.Users.name AS 'NAME',MathCaptcha.UserMath.user_result AS 'USER RESULT',MathCaptcha.Math.first_operand / MathCaptcha.Math.second_operand AS 'CORRECT RESULTS'
	FROM Person.Users,MathCaptcha.UserMath,MathCaptcha.Math
	WHERE Person.Users.user_id=MathCaptcha.UserMath.user_id AND
	MathCaptcha.Math.math_id=MathCaptcha.UserMath.math_id  AND
	Person.Users.control_captcha=0 AND
	MathCaptcha.Math.operation = 'division'
END


EXEC MathCaptcha.MathComparisonUserResultAndCorrectResult



/*Creating CorrectImageNumbers*/
CREATE PROCEDURE ImageCaptcha.FindCorrectImageNumbers
(
	@image_id INT ,
	@image_no1 INT OUTPUT,
	@image_no2 INT OUTPUT,
	@image_no3 INT OUTPUT

)
AS
BEGIN

	SELECT @image_no1 =image_no1,@image_no2 =image_no2 ,@image_no3 =image_no3
	FROM ImageCaptcha.Images_correctImage_no 
	WHERE @image_id=image_id;

	

END

/*Execution of finding correct image numbers from Images_correctImage_no table */
DECLARE @output_image_no1 INT,@output_image_no2 INT,@output_image_no3 INT;

EXEC ImageCaptcha.FindCorrectImageNumbers
	@image_id =1,
	@image_no1 = @output_image_no1 OUTPUT,
	@image_no2 = @output_image_no2 OUTPUT,
	@image_no3 = @output_image_no3 OUTPUT;

SELECT @output_image_no1 AS 'Output Image No1',@output_image_no2 AS 'Output Image No2',@output_image_no3 AS 'Output Image No3';




/*Creating procedure for comparing user image result and correct result*/
CREATE PROCEDURE ImageCaptcha.ImageComparisonUserResultAndCorrectResult
AS
BEGIN

	SELECT Person.Users.name AS 'NAME', ImageCaptcha.UserImage_selectedImage_no.image_no1 AS 'USER IMAGE 1'   ,ImageCaptcha.UserImage_selectedImage_no.image_no2 AS 'USER IMAGE 2',ImageCaptcha.UserImage_selectedImage_no.image_no3 AS 'USER IMAGE 3'  ,ImageCaptcha.Images_correctImage_no.image_no1 AS 'CORRECT IMAGE NO 1',ImageCaptcha.Images_correctImage_no.image_no2 AS 'CORRECT IMAGE NO 2',ImageCaptcha.Images_correctImage_no.image_no3 AS 'CORRECT IMAGE NO 3'
	FROM Person.Users,ImageCaptcha.UserImage_selectedImage_no,ImageCaptcha.Images_correctImage_no,ImageCaptcha.UserImage,ImageCaptcha.Images
	WHERE Person.Users.user_id = ImageCaptcha.UserImage.user_id AND
	ImageCaptcha.UserImage_selectedImage_no.user_image_id = ImageCaptcha.UserImage.user_image_id AND
	ImageCaptcha.UserImage.image_id = ImageCaptcha.Images.image_id AND
	ImageCaptcha.Images_correctImage_no.image_id = ImageCaptcha.Images.image_id AND 
	Person.Users.control_captcha = 0;

END

EXEC ImageCaptcha.ImageComparisonUserResultAndCorrectResult





/*Creating procedure to check image refresh time */
CREATE PROCEDURE ImageCaptcha.sp_ImageRefreshTimesCheck
AS
BEGIN
	
	SELECT Person.Users.name AS 'NAME' ,Person.Users.lastName AS 'LAST NAME',ImageCaptcha.ImageRecord.refresh_times
	FROM Person.Users,ImageCaptcha.ImageRecord,ImageCaptcha.UserImage
	WHERE Person.Users.user_id=ImageCaptcha.UserImage.user_id AND
	ImageCaptcha.UserImage.user_image_id = ImageCaptcha.ImageRecord.user_image_id AND
	Person.Users.user_id 
	IN
	(SELECT user_id 
	FROM ImageCaptcha.UserImage WHERE user_image_id 
	IN
	(SELECT user_image_id
	FROM ImageCaptcha.ImageRecord
	))
	ORDER BY refresh_times ASC;

END

EXEC ImageCaptcha.sp_ImageRefreshTimesCheck




/*Creating procedure to check text refresh time */
CREATE PROCEDURE TextCaptcha.sp_TextRefreshTimesCheck
AS
BEGIN
	
	SELECT Person.Users.name AS 'NAME' ,Person.Users.lastName AS 'LAST NAME',TextCaptcha.TextRecord.refresh_times
	FROM Person.Users,TextCaptcha.TextRecord,TextCaptcha.UserText
	WHERE Person.Users.user_id=TextCaptcha.UserText.user_id AND
	TextCaptcha.UserText.user_text_id = TextCaptcha.TextRecord.user_text_id AND
	Person.Users.user_id 
	IN
	(SELECT user_id 
	FROM TextCaptcha.UserText WHERE user_text_id 
	IN
	(SELECT user_text_id
	FROM TextCaptcha.TextRecord
	))
	ORDER BY refresh_times ASC;
END

EXEC TextCaptcha.sp_TextRefreshTimesCheck





/*Creating procedure for comparing user text result and correct result*/
CREATE PROCEDURE TextCaptcha.TextComparisonUserResultAndCorrectResult
AS
BEGIN

	SELECT Person.Users.name AS 'NAME',TextCaptcha.UserText.user_input AS 'USER INPUT',TextCaptcha.Texts.word AS 'CORRECT WORD'
	FROM Person.Users,TextCaptcha.UserText,TextCaptcha.Texts
	WHERE Person.Users.user_id=TextCaptcha.UserText.user_id AND
	TextCaptcha.UserText.text_id = TextCaptcha.Texts.text_id AND
	Person.Users.control_captcha=0;

END


EXEC TextCaptcha.TextComparisonUserResultAndCorrectResult





/*Creating procedure for finding text area for each text_id*/
CREATE PROCEDURE TextCaptcha.sp_FindTextArea
AS
BEGIN
	
	SELECT text_id AS 'ID',word AS 'WORD',text_height*text_width AS 'AREA'  FROM TextCaptcha.Texts

END

EXEC TextCaptcha.sp_FindTextArea




/*Creating procedure for finding color and background information from text_id*/
CREATE PROCEDURE TextCaptcha.sp_ColorAndBackgroundInfo
(
	@text_id INT ,
	@color1 VARCHAR(50) OUTPUT,
	@color2 VARCHAR(50) OUTPUT,
	@color3 VARCHAR(50) OUTPUT,
	@color4 VARCHAR(50) OUTPUT,
	@opcity FLOAT OUTPUT
)
AS
BEGIN
	DECLARE @bg_id INT
	SELECT @bg_id = bg_id FROM TextCaptcha.Texts WHERE @text_id = text_id;
	SELECT @opcity=opacity FROM TextCaptcha.Background WHERE @bg_id = bg_id;
	SELECT @color1=color1,@color2=color2,@color3=color3,@color4=color4 FROM TextCaptcha.Texts_Color WHERE @text_id=text_id;


END

DECLARE @output_color1 VARCHAR(50),@output_color2 VARCHAR(50),@output_color3 VARCHAR(50),@output_color4 VARCHAR(50),@output_opacity FLOAT;
EXEC TextCaptcha.sp_ColorAndBackgroundInfo
	@text_id =13,
	@color1 = @output_color1 OUTPUT,
	@color2 = @output_color2 OUTPUT,
	@color3 = @output_color3 OUTPUT,
	@color4 = @output_color4 OUTPUT,
	@opcity = @output_opacity OUTPUT;
SELECT @output_color1 AS 'COLOR 1',@output_color2 AS 'COLOR 2',@output_color3 AS 'COLOR 3',@output_color4 AS 'COLOR 4',@output_opacity AS 'OPACITY';





/*Creating procedure for calculating average sound for each sound type*/
CREATE PROCEDURE SoundCaptcha.sp_AverageSoundSecondEachType
AS
BEGIN
	
	SELECT sound_type AS 'SOUND TYPE',AVG(sound_sec) AS 'SOUND SECOND'
	FROM SoundCaptcha.Sound
	GROUP BY(sound_type);

END
EXEC SoundCaptcha.sp_AverageSoundSecondEachType






/*Creating procedure for Sound Captcha for user language choices*/
CREATE PROCEDURE SoundCaptcha.sp_UserLanguageChoices
(
	@user_sound_id INT ,
	@name VARCHAR(50) OUTPUT,
	@lastName VARCHAR(50) OUTPUT,
	@language1 VARCHAR(50) OUTPUT,
	@language2 VARCHAR(50) OUTPUT,
	@language3 VARCHAR(50) OUTPUT,
	@language4 VARCHAR(50) OUTPUT
)
AS
BEGIN

	DECLARE @sound_id INT,@user_id INT
	SELECT @sound_id = sound_id,@user_id=user_id FROM SoundCaptcha.UserSound WHERE @user_sound_id = user_sound_id
	
	SELECT @name = name,@lastName=lastName FROM Person.Users WHERE @user_id =user_id;

	SELECT @language1 = language1,@language2 = language2,@language3 = language3,@language4 = language4 FROM SoundCaptcha.Sound_soundLanguage WHERE @sound_id = sound_id;

END




DECLARE @output_name VARCHAR(50),@output_lastName VARCHAR(50),@output_language1 VARCHAR(50),@output_language2 VARCHAR(50),@output_language3 VARCHAR(50),@output_language4 VARCHAR(50);

EXEC SoundCaptcha.sp_UserLanguageChoices
	@user_sound_id =2,
	@name = @output_name OUTPUT,
	@lastName = @output_lastName OUTPUT,
	@language1 = @output_language1 OUTPUT,
	@language2 = @output_language2 OUTPUT,
	@language3 = @output_language3 OUTPUT,
	@language4 = @output_language4 OUTPUT

SELECT @output_name AS 'NAME',@output_lastName AS 'LAST NAME',@output_language1 AS 'LANGUAGE 1',@output_language2 AS 'LANGUAGE 2',@output_language3 AS 'LANGUAGE 3',@output_language4 AS 'LANGUAGE 4';





/*Creating procedure for comparing user sound result and correct result*/
CREATE PROCEDURE SoundCaptcha.SoundComparisonUserResultAndCorrectResult
AS
BEGIN

	SELECT Person.Users.name AS 'NAME',SoundCaptcha.UserSound.user_word AS 'USER WORD',SoundCaptcha.Sound.sound_word AS 'CORRECT WORD'
	FROM Person.Users,SoundCaptcha.UserSound,SoundCaptcha.Sound
	WHERE Person.Users.user_id=SoundCaptcha.UserSound.user_id AND
	SoundCaptcha.UserSound.sound_id = SoundCaptcha.Sound.sound_id AND
	Person.Users.control_captcha=0;

END

EXEC SoundCaptcha.SoundComparisonUserResultAndCorrectResult





/*Creating procedure to check sound refresh time */
CREATE PROCEDURE SoundCaptcha.sp_SoundRefreshTimesCheck
AS
BEGIN
	
	SELECT Person.Users.name AS 'NAME' ,Person.Users.lastName AS 'LAST NAME',SoundCaptcha.SoundRecord.refresh_times
	FROM Person.Users,SoundCaptcha.SoundRecord,SoundCaptcha.UserSound
	WHERE Person.Users.user_id=SoundCaptcha.UserSound.user_id AND
	SoundCaptcha.UserSound.user_sound_id = SoundCaptcha.SoundRecord.user_sound_id AND
	Person.Users.user_id 
	IN
	(SELECT user_id 
	FROM SoundCaptcha.UserSound WHERE user_sound_id 
	IN
	(SELECT user_sound_id
	FROM SoundCaptcha.SoundRecord
	))
	ORDER BY refresh_times ASC;
END

EXEC SoundCaptcha.sp_SoundRefreshTimesCheck



/*** CREATING FUNCTIONS ***/


/*Creating function for calclating result of math operation*/

CREATE FUNCTION MathCaptcha.GetOperationResult
(
	@math_id INT
)
RETURNS INT
AS
BEGIN

	DECLARE @first_operand INT , @second_operand INT,@result INT,@operation VARCHAR(50)
	
	SELECT @first_operand = first_operand,@second_operand = second_operand,@operation=operation FROM MathCaptcha.Math
	WHERE MathCaptcha.Math.math_id = @math_id;
	
	IF(@operation = 'addition')
	BEGIN
		SET @result = @first_operand +@second_operand;
	END

	ELSE IF(@operation = 'subtraction')
	BEGIN
		SET @result = @first_operand -@second_operand;
	END

	ELSE IF(@operation = 'multiplication')
	BEGIN
		SET @result = @first_operand *@second_operand;
	END

	ELSE IF(@operation = 'division')
	BEGIN
		SET @result = @first_operand /@second_operand;
	END

	RETURN @result
END
GO

SELECT MathCaptcha.GetOperationResult(3) AS 'RESULT';
SELECT MathCaptcha.GetOperationResult(12) AS 'RESULT';
SELECT MathCaptcha.GetOperationResult(26) AS 'RESULT';
SELECT MathCaptcha.GetOperationResult(37) AS 'RESULT';