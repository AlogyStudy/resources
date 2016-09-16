
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

查询三要素
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

**整型**    
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
	     

	     
**小数(浮点型/定点型)**

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


> 字符串型

char, varchar, text, blod

char(6) 定长字符串。
例如， 姓名 char(6)
查找行记录时，如果都是定长，完全可以通过行数与行的长度计算出来，文件指针的偏移量.
对于定长N，不论是否够不够指定长度，实际都占据N个长度。如果不够N个长度，用空格在末尾补至N个长度。
利用率中，char(),可能达到100%;
char型，如果不够M个字符，内部用空格补齐，取出时再把右侧空格删除掉。（注意：如果右侧本身有空格，将会丢失）


varchar(100) 变长类型。 能够存储0-100个字符。
每个字符都要读取前缀，就算是空字符串，都是需要存储空间。
varchar(N),不用空格补齐，但是列内容前，有1-2个字节来标志该列的内容长度。
利用率中，varchar() 不可能达到100%;


注意：char(M),varchar(M) 限制的是字符，不是字节。
即：char(2) charset utf-8; 能存储 2个utf8 的字符.
 
错误认识：既然是字符，6个utf8字符串，18个字节。 
并不是18个字节。能够存储6个字符，就是在utf8中能够存储6个字节


text 文本类型，可以存储比较大的文本段，搜索速度稍慢。
text 不用加默认值 (加了也没有用)

```mysql
create table test ( article text );
```


blod , 二进制类型，用来存储图像，音频等二进制信息。
意义：二进制， 0-255 每个字节都有可能出现。
blod类型，在于防止因为字符集的问题，导致信息丢失。 
比如：一张图片中有 0xFF 字节， 这个在ascii字符集中，在入库的时候被过滤了。 因为当再次取出的时候，被损坏了。
如果是二进制，那么给你什么东西，你就存储什么东西，并不需要考虑字符集问题。
 

> 日期/时间类型

date, time, datetime, year

date 日期， date 类型 能存储哪年到哪年 ? 
1000-01-01 ~ 9999-12-31

time 时间，time 时间类型 
专款专用，专列专用

datetime 日期时间， 占8个字节

year 年类型  只占1字节，最多能够存储256中变化。
范围：1901 - 2155 ，还有一种 是：0000

```mysql
create table test5 (thing varchar(20) not null default '', ya year  not null default '0000') engine myisam charset utf8;
```


# 网站建表及优化意识

** 社交平台 **

主键 id, 用户名, 性别, 体重KG, 生日, 收入, 上次登陆时间, 个人简介     

```mysql
create table user (
	u_id int unsinged PRI,
	user varchar(20) not null default '',
	sex char(1) not null default '',
	wieght tinyint unsinged not null,
	birth date not null default '00',
	salary decimal(8,2) not null default 0.00,
	lastlogin datetime not null default '0000-00-00 00:00:00 ',
	intro varchar(200) not null default ''
)
```


** 优化 **

分析：这张表除了username intro 列之外，每一列都是定长的。不妨让其所有列都定长，可以极大提高查询速度。

```mysql
create table user (
	u_id int unsinged PRI,
	username char(20) not null default '',
	sex char(1) not null default '',
	wieght tinyint unsinged not null,
	birth date not null default '00',
	salary decimal(8,2) not null default 0.00,
	lastlogin int unsigned not null default '0000-00-00 00:00:00 '
)

create table inrto (
	i_id int unsinged PRI,
	username char(20) not null default '',
	intro varchar(1500) not null default ''
);
``` 

username char(20) 是会造成存储空间的浪费，但是提高了速度，值得。
intro char(1500) 却浪费的太多了，另一方面，人的简介，一旦注册完，修改的频率也并不高。可以把intro列单独拿出来，另放一张表里。
修改完之后，主表全部都是定长，容易被人查看，修改，速度快。
lastlogin 定义成 datetime计算的时候麻烦，一般使用的是，时间戳。


总结：
时间与空间是一对矛盾体。

优化的方法：`时间换空间`, `空间换时间` .

在开发中，会员的信息优化往往是，把频繁用到的信息，优先考虑效率，存储到一张表中。不常用的信息和比较占据空间的信息，优先考虑空间占用，存储到另外一张辅表中。 


```mysql
create table member (
	id int unsigned auto_increment primary key,
	username char(20) not null default '',
	gender char(1) not null default '',
	weight tinyint unsigned not null default 0,
	birth date not null default '0000-00-00',
	salary decimal(8.2) not null default 0.00,
	lastlogin int unsigned not null default 0
) engine myisam charset utf8;

create table inrto (
	i_id int unsinged auto_increment primary key,
	username char(20) not null default '',
	intro varchar(1500) not null default ''
);
```


# 修改表

一张表，创建完毕，有了N列。
之后还有可能要增加或删除或修改列

**新增列**

	alter table 表名 add 列名称 列类型 列参数; [增加在表的最后]
	alter table 表名 add 列名称 列类型 列参数 after; 某列[把新列指定增加到某列后面]

新建一个列在表的最前面，使用`first`
	
	alter table 表名 add 列名称 列类型 列参数 first;
	alter table m1 add pid int not null defalut '' first;

```mysql
alter table m1 add username char(20) not null default '';
alter table m1 add birth date not null default '0000-00-00';
```


**删除列**

alter table 表名 drop 列名;

```mysql
alter table m1 drop pid;
``` 

**修改列**

修改列类型

alter table 表名 modify 列名 新类型 新参数;

```mysql
alter table m1 modify gener char(4) not null default ''; 
```


修改列类型和列名
alter table 表名 change 旧列名 新列名 新类型 新参数

```mysql
alter table m1 change id uid not null auto_increment primary key; 
```
  
如果列类型改变了，导致数据存储不下了怎么处理?
比如：int 修改成 smallint 列. 如果不匹配，数据将会丢失，或者在mysql严格模式下 (strict mode) 下修改不成功.



# ecshop 商品表

``` mysql
# shop
# 分析商品表
# 建立类似的
# 小型表
# 
# 商品表
# 
# goods_id 商品主键
# cat_id 栏目id
# goods_sn 货号
# goods_name 商品名称
# click_count 点击量
# brand_id 品牌
# goods_number 库存量
# goods_weight 重量
# market_price 市场价格
# shop_price 本店价格
# promote_price 优惠价格
# warn_number 报警数量
# keywords 关键字
# goods_thumb 小图
# goods_img 中等图
# original_img 原始图
# is_real 真实商品，与：extension_code 有关，还有虚拟商品
# extension_code  
# is_on_sale 是否上架状态
# is_alone_sale  是否单独销售，赠品
# is_shipping 是否包邮
# integral 送的点数 
# add_time 添加的时间戳
# sort_order 排序的权重
# is_delete 是否删除
# is_best 是否精品
# is_new 是否新品
# is_hot 是否热卖
# is_promote 
# bounts_type_id 优惠券
# last_update 上次修改时间
# goods_type 商品类型
# seller_note 买家备注

# 商品表
# goods_id, cat_id, goods_sn, goods_name, click_count, 
# goods_number, market_price, shop_price, add_time, is_best, is_new, is_hot

# 查看其它 表创建
# show create table 表名 
# show create table ecs_goods; 

CREATE TABLE `goods` (
  `goods_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `goods_sn` varchar(60) NOT NULL DEFAULT '',
  `goods_name` varchar(120) NOT NULL DEFAULT '',
  `click_count` int(10) unsigned NOT NULL DEFAULT '0',
  `goods_number` smallint(5) unsigned NOT NULL DEFAULT '0',
  `market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `shop_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  `is_best` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8


# 导入其它表中的相同字段的数据
# insert into 导入表 select 导入字段 被导入表

insert into zf.goods select goods_id, cat_id, goods_sn, goods_name, click_count, goods_number, market_price, shop_price, add_time, is_best, is_new, is_hot from ec_goods;

```

# SQL查询表达式

**查询练习**

1. 查询商品主键是32的商品

	select goods_id, goods_name, shop_price from goods where goods_id = 32;
	
2. 不属于第三个栏目的所有商品  即cat_id 不等于 3 
	`!=` 等价于 `<>`

	select goods_id, goods_name, shop_price, cat_id from goods where cat_id != 3;
	select goods_id, goods_name, shop_price, cat_id from goods where cat_id <> 3;
	
3. 本店商品价格高于三千的商品	
	
	select goods_id, goods_name, goods_price from goods where goods_price > 3000;
	
4. 本店商品价格小于或等于100的商品
	
	select goods_id, goods_name, shop_price from goods where shop_price<=100;
	
5. 取出第4栏目和第11栏目的商品(不许用or)

	select goods_id, cat_id, goods_name from goods where cat_id in(4, 11);
	
6. 取出100<=价格<=500 的商品(不许用and)

	select goods_id, goods_name, shop_price from goods where shop_price between 100 and 500;

注意：in是 是散的满足。 between 范围的满足.	

7. 取出不在第3个栏目和不在第11个栏目的商品(and或not in 分别实现) 。 即栏目的id，是3的不要，是11的也不要。 
	// $cat_id !=3 && $cat_id != 11;

	select goods_id, goods_name, shop_price, cat_id from goods where cat_id not in(3, 11);
	select goods_id, goods_name, shop_price, cat_id from goods where cat_id != 3 and cat_id != 11;
	
8. 取出价格大于100且小于300，或者大于4000且小于5000的商品 
	在[100, 300] 之间，或者 是 [4000,5000]
			
	select goods_id, goods_name, shop_price, cat_id from goods where (shop_price>100 and shop_price<300) or (shop_price>4000 and shop_price<5000);
	  	 	
and 的优先级比 or 高

9. 取出第3个栏目下面价格 < 1000 或 > 3000, 并且点击量 >5 的系列商品
	
	select goods_id, goods_name, shop_price, cat_id, click_count from goods where cat_id = 3 and ( shop_price < 1000 or shop_price>3000 ) and click_count >= 5;	
	 	
怎么要求就怎么写

10. 取出1号栏目下的商品 (无限级分类) 大分类 --> 小分类 --> 小分类 。。。
	
	select goods_id, goods_name, cat_id from goods where cat_id = 1;
	
11. 取出名字以"诺基亚"开头的商品

	select goods_name, shop_price from goods where goos_name like '诺基亚%';
	
`%` 匹配任意字符.

12. 取出已名字"诺基亚N"后面固定的二位字符. 

	select goods_name, goods_id from goods where goods_name link '诺基亚N__';
	
`_` 匹配任意单一字符			


# SQL 查询模型

## select 字句

把列看成变量，把where看成PHP中 if ( exp ) 里的 exp 表达式
哪些行被取出，哪一行能够让表达式为true，那一行就能够取出来。

判断这一行取出什么?
```mysql
select goods_id, goods_name from goods where 1>2;
```
取出为空


把列看成变量。
既然变量，变量之间也是可以运算。

取出商品id，商品名，本店价格比市价价格省的钱
```mysql
select goods_id, goods_name, (market_price - shop_price) from goods;
select goods_id, goods_name, (market_price - shop_price) from goods where 1;
```
表中原本就没有(market_price - shop_price) 的列
这一列其实是一个运算结果，术语叫"广义投影". 理解成字段运算.

列的运算结果，可以当成列看，还可以起个列别名。 (伪列)

```mysql
select goods_id, goods_name, (market_price - shop_price) as discount from goods where cat_id!=3;
```
-----

查出本店价比市场省的钱，而且省200以上的商品.

```mysql
select goods_id, goods_name, (market_price - shop_price) as discount from goods where (market_price - shop_price) > 200;



select goods_id, goods_name, (market_price - shop_price) as discount from goods where discount > 200; # 报错
# where 后面不能使用别名。

# where 查询 --> 结果 (多行多列的二维结构)

# where 查询的结果是对 表 中的数据发挥作用， 查询出数据。
# discount 是在结果中数据算出. 
# where发挥作用时，表上并没有discount列。发挥完作用，形成的结果里才能discount。 
# 对于结果中的列，如果再想筛选需用使用having

# where 字句就没有discount列，所以报错.
```

where 条件是表达式，在哪一行表达式为真，哪一行就取出来。


题目：
把num的值处于[20, 29]之间的，改为20
num值处于[30, 39] 之间的，改为30

```mysql
create table number ( num smallint not null default 0 ) engine myisam charset utf8;

inset into number values (3), (12), (23), (25), (29), (32), (34), (38);

update number set num = floor(num / 10) * 10 where num>=20 and num<=30;
# 字段看成变量，可以运算，可以使用函数，可以做成表达式.
   
```

## group 子句

**统计函数**

max: 求最大。min: 求最小。sum: 求总和。avg: 求平均。count: 求总行数。

1. 查出最贵的商品的价格

```mysql
select max(shop_price) from goods;  
```

2. 查处最便宜的商品的价格

```mysql
select min(shop_price) from goods;
```

3. 查询出发布最早的商品。即goods_id 最小的值.

```mysql
select min(goods_id) from goods;
``` 
 
4. goods_number 是指库存量，统计一下，本店一共库存多少件商品

```mysql
select sum(goods_number) from goods;
``` 

5. 查看一个店中的所有商品的平均价格.

```mysql
select avg(shop_price) from goods;
```

6. 统计一下本店中有多少的商品。(不是多少个)
 
count 计算 多少条记录.
如果使用字段，来count()计算总共，null并不会计算在其中.

```mysql
select count(*) from goods; # 查询的就是绝对的行数，哪怕某一行所有字段全为null，也计算在内。
select count(goods_id) from goods; # 字段如果是 null，并不会计算在其中。
```

用 count(*)，count(1)，谁更好呢?
对于myisam引擎的表，没有区别的。因为，这中引擎内部，有一个计数器在维护着行数。
innodb的表，用count(*)直接读取行数，效率低下，因为innodb真的去数一边。


5个统计函数，单独使用，意义不大，要和分组配合起来使用，威力更大。


计算，第3个栏目下所有商品的库存量之和  sum(goods_num);

```mysql
select sum(goods_number)  from goods where cat_id = 3;  
```

计算，第4个栏目下所有商品的库存量之和 
```mysql
select sum(goods_number) from goods where cat_id = 4;
```


**group 子句**

计算，一次计算完，每个栏目下的库存量之和
按照规则，分组，然后 组内解决总和。

分组之后再统计，结合起来使用。

```mysql
select sum(goods_number) from goods group by cat_id;
```

-----

是否正确：
```mysql
select goods_id, sum(goods_number) from goods;
```
这条语句执行了，把 goods_id，第一次出现的值 取出来。
对于SQL标准来说，这个语句是错误的，不能执行的。但是在MySQL中可以这么做。(MySQL特征)
这是MySQL的一个特点，出于可移植性和规范性，不推荐这样写。
严格的讲，select 的a, b 列必须在 group by  a, b, c的列出现。


按cat_id分组，计算每个栏目下的商品的平均价格
```mysql
select goods_id, cat_id, avg(shop_price) from goods group by cat_id;
```
	

## having 子句
	
**having筛选**

having 发挥的时间，是where对硬盘上的表文件进行查询之后，内存形成一张结果的虚拟表(伪列存在于此表中)， having在此时生效。

1. 查询本店价比市场价省的钱，并且要求省钱200元以上的取出来。

```mysql
select goods_id, market_price, shop_price, (market_price - shop_price) as discount from goods having discount > 200;
# where 没有写出，表示where 1;
```
2. 查询每种商品所积压的贷款(提示: 库存 +单价)
goods_number + shop_price

```mysql
select goods_id, goods_number, shop_price , (goods_number * shop_price) as hk from goods ;
```

3. 查询该店积压的总货款。
	即，每个商品积压的贷款之和。考虑：sum那个列?

```mysql
select sum(shop_price * goods_number) as zhk from goods;
```			

4. 查询每个栏目下，积压的货款。

```mysql
select cat_id, shop_price, goods_number, sum(shop_price * goods_number) as hk from goods group by cat_id;
```

5. 查询积压货款超过2w元的栏目，以及该栏目积压的贷款。

```mysql
select cat_id, shop_price, goods_number, sum(shop_price * goods_number) as hk from goods group by cat_id having hk > 20000;
```

6. 查询本店价比市场价省的钱，且筛选出省钱200以上的商品. (用where 和 having 分别来实现)

```mysql
#where
select goods_id, market_price, shop_price from goods where (market_price - shop_price) > 200;

#having
select goods_id, market_price, shop_price from goods having (market_price - shop_price) > 200;
select goods_id, market_price, shop_price, (market_price - shop_price) as discount from goods having discount > 200;
```

-----

查询出2门及2门以上的不及格者的平均成绩

```mysql		
CREATE TABLE `reslute` (
  `name` varchar(20) DEFAULT NULL,
  `subject` varchar(20) DEFAULT NULL,
  `score` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8

insert into reslute values ('zhangsan', 'math', 90), ('zhangsan', 'ch', 50), ('zhangsan', 'dili', 40), ('lisi', 'ch', 55), ('lisi', 'zhengzhi', 45), ('wangwu', 'zhengzhi', 30);
```

错误
```mysql
select name, avg(score), count(score < 60) as sc from reslute group by name having sc >= 2;
```

正确查询
```mysql
# 1: 查询所有的平均分
select name, avg(score) from reslute group by name;

# 2: 想办法计算出每个人挂科的情况
select name, subject, score, score<60 as g from reslute;

# 3: 挂科数目，就是g 列的 sum() 结果.
# 总和下
select name, avg(score), sum(score < 60) as sc from reslute group by name having sc >= 2;
```

![](./_image/2016-09-15-15-44-05.jpg)

## order by 与 limit 
**order by**
语法: `order by 列名 desc/asc`. (列名，结果集中的列名)    
例如:  `order by add_time asc` . 按发布时间升序排列.

1. 取出第4个栏目下的商品，并按价格由高到低排序。
```mysql
select goods_id, goods_name, shop_price from goods where cat_id = 4 order by shop_price desc;
```

2. 按栏目升序排列，同一个栏目下的商品，再按商品的价格降序排列
```mysql
select goods_id,cat_id, goods_name, shop_price from goods order by cat_id asc, shop_price desc;
# 多个字段排序，通过`,` 逗号隔开。
```
**limit**
限制条目
`limit 数量` 限制条数
`limit [offset] N` 
offset 偏移量 (可选参数),跳过几行。 N 取出条数。
offset 如果不写则相当于 `limit  0 N`； offset 是跳过的个数，N是实际取的个数。

1. 本店商品价格最高的商品。
```mysql
select goods_id, goods_name, shop_price from goods order by shop_price limit 3;
```
2. 本店最高的第三名到第五名 商品。
```mysql
select goods_id, goods_name, shop_price from goods order by shop_price desc limit 2,3;
# 取第3到第5，即意味着跳过， 第1，第2, 因此偏移量offset是2.
# 取第3,4,5条。即取3条，因此N=3；
```

3. 取出价格最高的那条商品
```mysql
select goods_id, goods_name, shop_price from goods order by shop_price desc limit 1;
```

4. 查询出每个栏目下id号最大(最新)的一条商品.

```
# 错误语句分析
第一种错误：group by cat_id;
group by cat_id 从语义上来分析，select 的列，只能是cat_id, max/min/avg/sum/count .
这个 goods_id, goods_name 从语义上分析就不对，也不符合sql标准。
只是MySQL允许这种语法。
取出 栏目中 第一次 出现的记录。

第二种错误：name 匹配第一次出现的
select max(goods_id) as max_cat_id, goods_id, goods_name from goods group by cat_id;

第三种错误：先 order by 再 group by. 语法错误。
select goods_id, cat_id, goods_name from goods order by cat_id asc, goods_id desc;
在此基础上，再分组。
select goods_id, cat_id, goods_name from goods order by cat_id asc, goods_id desc group by cat_id;

需要使用到 子查询.
```

![](./_image/2016-09-16-00-33-40.jpg)


# 子查询

## where 型子查询
把内层查询的结果，作为外层查询的比较条件
典型的：查询最大商品，最贵商品。

如果 where 列 = (内层 sql)。 则内层sql返回的必然是单行单列.
如果 where 列 in (内层 sql)。 则内层sql返回单列， 可以多行。

1. 查询出本店最新的(goods_id最大) 的一条商品。

```mysql
# 思路，按照goods_id desc 排序，再去 第一行.
select goods_id, goods_name from goods order by goods_id desc limit 1;
```

2.  查询出本店最新的(goods_id最大) 的一条商品。要求不要使用排序.

```mysql
# 思路，求出最大的id， 然后在where判断
select goods_id, goods_name from goods where goods_id = (select max(goods_id) from goods);
```

查询出每个栏目下id号最大(最新)的一条商品.
```
# 第一步：查询出每个栏目下goods_id 最大的。
select max(goods_id) from goods group by cat_id;
# 只需要再把goods_id = 第一步值.
select goods_name, goods_id from goods where goods_id in (select max(goods_id) from goods group by cat_id);
```

## from 型子查询
内层sql的查询结果，当成一张临时表，供外层sql再次查询.

查询模型：查询结果集 ---> 在结构上可以当成表看.


查询出每个栏目下id号最大(最新)的一条商品.

```mysql
select * from (select goods_id, cat_id, goods_name from goods
order by cat_id asc, goods_id desc) as tmp group by cat_id;
```

## exists型子查询

把外层sql的结果，拿到内层sql去测试。
如果内层的sql成立，则该行取出。

查询有商品的栏目.取 栏目标，且只取下面有商品的栏目
思考：什么样的表，叫做 下面栏目有商品?
设某栏目cat_id 为N,则 select * from goods where cat_id = N;
能取出数据，则说明该栏目有商品 

```mysql
select cat_id, cat_name from category where exists (select * from goods where goods.cat_id = category.cat_id);
# 从外层SQL取出内层SQL需要的字段值，然后再通过内层SQL来判断.
```

## 奇怪的NULL

建表时，列后面 not null defalut ''/default 0; 这是什么意思
就是让这个列值不为NULL， 如果某个列确实没填，也有默认值，值不为NULL 

为什么列的值不为NULL。


```mysql
create table test5 ( sname varchar(20) ) engine myisam charset utf8;

insert into test5 values ('tianjilaoren'), ('lixunhuan'), ('afei'), NULL;

# 查询出用户名不为null的行

select * from test5 where sname != null;

# tianjilaoren lixunhuan afei 没有查询出来?

#查询 sname 为null 的行

select * from test5 whre sname = null;

#也是空

select 'afei' = null; # 查询结果： NULL

# NULL为家， list=null 是假

select null = null; #查询结果： NULL

# null = null , 还是 null， 还是假

select null != null; #查询结果：NULL

# null是空

# null 的比较需要用特殊的运算符 is null 和 is not null

select * from test5 where sname is not null;

# 取出值为null

select * from test5 where sname is null;
```


null 是一种类型，比较时，只能用专门的is null 和 is not null 来比较 碰到运算符， 一律返回 null.
效率不高，不利于提高索引效率。

因此，往往在建表的时候声明 `not null default ''/defalut 0`


# 新手1+N模式

新手1+N模式查询

```php
$conn = mysql_connect('localhost', 'root', '');

$sql = 'use zf';

mysql_query($sql, $conn);

$sql = 'set names utf8';

mysql_query($sql, $conn);

$sql = 'select goods_name, cat_id, goods_number, shop_price from goods';

$rs = mysql_query($sql, $conn);

$list = array();
while ( $row = mysql_fetch_assoc($rs) ) {

	/**
	 * 根据$row 中的cat_id 在此查询category表
	 * 每循环一次，又要查询另一张表
	 * 因此，查询 1+N 次.
	 */
	$sql = 'select cat_name from category where cat_id = ' . $row['cat_id'];
	
	$rs2 = mysql_query($sql, $conn);
	
	$cat = mysql_fetch_assoc($rs2);
	
	$row['cat_name'] = $cat['cat_name'];
	
	$list[] = $row;
	
}
```
