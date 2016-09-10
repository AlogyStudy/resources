# 数据库概念
一台服务器下有多个库，一个库下有1到多张表，表有多行多列的数据。
postgresql也是一个开源数据库，而且sql标准执行方面，比mysql要严格。

表格  --> 档案袋 --> 人管理(MySql)

# MySql 安装
MySql5.1 & MySql5.5 稳定版

# 基本入门语句
1. 链接数据库
        mysql -uusername -ppassworld
        链接上服务器之后面对的是库。 库有一个或多个.
2. 查看所有数据库
        show databases
        选择库之后，面对的是表。 表有一个表或多个表
3. 创建库
        create database zf [charset utf8]
4. 删除库 
        drop database zf;
        Mysql 表/列可以修改名字，库名字不可以修改.
5. 选择数据库
        use 库名   
            use test 
6. 查看表
        show tables; // 查看库底下有几张表
7. 创建表
        create table stu ( snum int,  sname  varchar(10)  )engine  myisam charset utf8;
8. 删除表
        drop table stu;
9. 改表名
        rename table oldTable to newTable;
10. 清空表
        truncate stu;
        truncate 与 delete 区别:
        truncate 相当于删除表再重建一张同样结构的表，操作之后得到一张全新的表.
        delete 是从删除数据行的层面来操作的，如果有自增的影响还在.
11. 插入数据
        insert into stu values ( 1, 'zhangsan' ), ( 2, 'wangwu' );
12. 查询简单数据
         select * from stu;


# insert增数据详解
查看表结构 desc tablename；

## 增 
insert into 
1. 往哪张表，添加信息(行)。
2. 给哪几列添加值。
3. 分别是什么值。

```mysql
# 创建表
create table class (
	id int primary key auto_increment,
	sname varchar(10) not null default '',
	gender char(1) not null default '',
	company varchar(20) not null default '',
	salary decimal(6,2) not null default 0.00,
	fanbu smallint not null default 0
) engine myisam charset utf8;
```
```mysql
# 插入数据
insert into class (id, sanme, gender, company, salary, fanbu) values (1, '天机老人', '男', 'zf', 9000.00, 200);
```
> 插入所有列
 
如果插入所有的列，则可以不声明待插入的列。
不声明插入的列，则理解为依次插入"所有"列 。
```mysql
insert into class (2, '李寻欢', '男', 'jh', 7000, 130);
```

注意:
id是自增型，插入时不必为其赋值。是错误的，需要对应，添加该值或者null。
列与值必须按一一对应

> 增加多行

```mysql
insert into class (sname, company, salary) values ('刘备', '皇室成员', 15.23), ('孙策', '江东集团', 56.32), ('曹操', '宦官后裔', 88.43)
```
纵横 结合定位， 增加数据。

## 改
update 
修改的是字段，并不是记录。
需要添加的where表达式.
1. 修改那张表
2. 需要改哪几列的值
3. 分别改为什么值
4. 在那些行生效

 where expression , 表达式。
只要where 表达式为真，则该条记录发挥作用。

```mysql
update class set commpany = 'qd' where sname = '刘备' and salary > 5000;
```   
每条记录都有 字段 来约束。 

##  删
删除，就是删除每条记录，不存在删除一条记录中的某几个字段.

1. 要删哪张表的数据
2. 要删除那几条数据 (while + 表达式)

```mysql
delete form class where salary>7000;
```
```mysql
#表中的所有数据删除
delete form class;
```

## 查
select基础查询

查询三要锁
1. 查询那张表的数据
2. 查询那些记录
3. 查询那些字段

```mysql
select sname, company, salary from class where id = 2;
```

```mysql
# 暴力查找，所有记录，所有字段 
# * 表示所有记录，表名后不加where条件，则选所有记录，认为 是true。
# 效率低下
select * from class;
```

怎么理解where ?
where 后面的是表达式，表达式为true，则此行被取出

- - - - -

如何建表
如何修改表(增加或减少列)
多表联查
子查询
解决触发器
事务
存储过程
备份恢复


# 建表

**列类型意义**
建表就是一个画表头的过程。从术语上说，建表的过程，是 `定义/声明` 字段的`属性/过程`。

建表和列类型又什么关系 ？
分析: 例如一张A4纸，画一个学生报名表。 A4纸是数据的存储空间，而A4的大小是有限的。
准备预留学号留多宽，给姓名预留多宽，给自我介绍预留多宽。
自然的，姓名如果留的过宽，比如20个字能够存下，但是一般人的姓名，就三四个字 就浪费了。如果预留过窄，导致存不下，更有问题。

建立列的时候，自然是:能够容纳放置的内容，但是又不浪费。

建表的意义: **存储同样的数据，不同的类型，所占用的空间和效率是不一样的**
重点 : 列类型的存储范围与占据的字节关系。

## MySQL三大类型

> 数值型

    整型
  	tinyint
    smallint
    mediuint
    int
    bigint 
    
分析 tinyint
	占据字节： 1一个字节
	存储范围：-128 -- 127 (无符号)， 0-255     

```
tinyint 1字节

1个字节 8个位


# 模拟  -- 每个位，只能存储0,1
[][][][][][][][]


0000 0000 ---> 0
1111 1111 ---> 2^8-1=255


计算机为了表述一个数是负数，会把最高位(左侧)的 0/1,当成符号位来看。 如为0， 则是正数，如为1,则是负数

0 0000000
0 1111111 ---> 0-->127(2^7-1)


1 0000000 ---> -128
1 1111111 ---> -127

-127 -- 127


二进制补码的问题

+0，-0 则重复了，浪费了一种存储的可能性。
因此计算机中的负数，不是照着 "后面的绝对值直接乘以-1得到的"，而是补码规则换算的。

 
负数 = 绝对值位 - 128;

1111 1111 ---> -1
1000 0000 ---> -128


因此最终的结果： -128 --> 127

```

1个字节 8个位 0~2^8-1 0~255 /  -2^7 --> +2^7-1

分析： 
2个字节， 16位   0~2^16-1 = 65535
						-2^15 ~ +2^15-1  -- -32768 ~ 32767 
						
对于int型，占字节越多，存储的范围也越大

**int系列的声明时的参数**

tinyint 的参数并验证字节与范围的关系
(M) unsigned zerofill

int系列，不需要特殊说明，默认是有符号。
加 unsigned 表示无符号， 可以影响存储的范围

M 参数 

zerofill：zero零， fill是填充。代表：0填充
M必须是和zerofill 配合使用  
场景： 学号，00001 。 这种是需要补0.

```mysql
alter table class add snum smallint(5) zerofill not null default 0;
insert into class (sname, snum) values ('吕布', 1);
```	

学号会显示成： 00001
为什么会补5位， 因为M为 5.
总结：M表示补0宽度， 和zerofill配合使用才有意义.
如果设置，zerofill ，同时必须是 unsigned参数. 0填充，自动unsigned
	     

	     
> 小数(浮点型/定点型)

	float(D, M)
	decimal(D, M)
	
	M --> 标度。 表示小数的'总位数'
	D --> 精度。 代表小数位(小数点右边的尾数)

float(6, 2) 表示 -9999.99 ~ 9999.99
	
也可以添加 unsinged ，zerofill 参数。	


浮点数占多大的空间呢?
float 能存储 10^38 。小数点右边可以精确到： 10^38分之一
如果：M<=24 占4个字节存储，否则占用8个字节存储。 

浮点和定点区别：
定点(decimal)是把整数部分和小数部分，分开存储的。比 float精确. 
float 有时候会损失精度


