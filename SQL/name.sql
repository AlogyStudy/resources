
#库-->表-->数据

#创建数据库
	#carate database dbName;  指定字符集
	carate database mm; charset utf-8;


	#创建数据库的时候需要做判断： if not exists 或者 if exists
	#如果存在不创建该数据库
		create database if not exists mm; charset utf-8;




#删除数据库
	drop database dbName
	drop database if exists dbName;
	drop database if exists mm;			


	
	
#修改数据库
	

#查询数据库
	show databases;  #查询所有数据库
	show create database dbName;	
		show craete database mm;
		





#--------------------------------------------------------------------------------------------------------------------------				
	

#表相关操作

	#选择库
		#use LibName;
			use mm;
	
#创建表
	#create table TableName(列声明1,列声明2,列声明3) engine=存储引擎 charset=字符集;
		#列声明: 列名  列类型 列属性
	create table mm_stu( name varchar(30), class varchar(30), age int , tel varchar(15) ) engine=MyISAM charset=utf8 comment 'test';
	
	

#删除表
	#删除表
	#drop table TableName
		drop table mm_stu;
		
	#删除记录
	#delete from TableName where 条件
	 delete from mm_stu where id>4;


#修改表 
 
	#插入数据
	#insert into TableName(字段列表) values(值列表);  #字段列表 要和 值列表 一一对应
		insert into mm_stu(id,name,class,age,tel) values(null,'01',23,'13164889430');
	#更新记录
	#update TableName set 字段=值  where 条件; 
		update mm_stu set age=25 where id>4;		


#查询表

	#查看表 有多少张表
		show tables;
		
	#查看表结构  
		#desc TableName
		desc mm_stu;	
	#查看表数据
		#select 列1,列2,列3 from TableName;
			select `name`,`age`,`tel` from mm_stu;
		#select * from TableName;
			select * from mm_stu;
				
	#查看表的创建语句
	show create table TableName;
		
			









#---------------------------------------------------------------------------------------------------------------------------
#列类型

	#mysql中只能存储简单的数据(标量类型)
		#数值
		#字符串
		#日期时间


		
	#数值   #原则： 能选择小 就不选择大的.
		int      #--> (0,4294967295)
		tinyint  #--> (0,255);
		create table t1(id smallit(5) unsigned zerofill) engine=myisam;  /*  */


		
	#小数
		#近似值：flaot,double 
		#精确值：decimal
		#定义方式：float(M,D); 其中M表示总共有多少位，而D则表示小数的位数，注意，小数点不包括在内 ，符号位也不包括.
		#小数的范围， 由 M 和 D 共同决定，有正负之分， 默认是有符号的，如果申明为无符号，则使用 unsigned. 此时，负数被去掉，正数部分不变.
		
		crate table t2(f flaot(10,2), d decimal(10,2)) engine=myisam;


		
	#字符串
		#char (0<=M<=255),varchar(0<=M<=66535),text
			#char 定长， varchar 不定长
		#凡事使用textarea 都是用 text 存储
			
/*		设计的时候：
			name: varchar(20)
			身份ID: char(18);
			sex: char(1)
			password: md5()  char(32);

			图片使用 varchar(50) 保存的是路径.
			ip 使用 varcahr(15) 
*/



	#enum 和 set
	/* 尺码，性别，星期，选择题， 取值固定值 */
	#enum: 枚举 ，单选题  
	#set: 集合 ， 多选题
	#enmu('true','fasle');  tinyint 1 0;  那种定义更好， tinyint
	
	craete table e (size enmu('S','M','L',"XL",'XLL'));

	#date
	-- time(失去的时间),datatime,timestamp,year
	#实际开发中使用 int 来存储 日期	 
			
			
			
	
#列属性
	-- 有无符号
	-- 无符号	 声明 unsigned

	-- default  默认值
	create table t4 ( id int not null default 0, name vahchar(30) not null default '' );

	-- 主键 primary key
		-- 1；方式1
		create table t5( id int not null primary key, name varchar(30) not null default '' ); 
		-- 2: 方式2	
		create table t6( id int not null,name varchar(30) not null default '', primary key(id) );	

	-- 自动增长
		# auto_increment
/*
	CRUD  (增删改查)
		C: create  insert
		R: read retrieve   select desc
		U: update
		D: delete
*/



-- 我可以选择放弃，但是我不能选择放弃
-- 不怕失去就不会失去



