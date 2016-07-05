
-- 静默抬头看天空， 天空是安静的.


#create

	create table tableName (
		filed1 dataType,
		filed2 dataType,
	) engine myisam charset set 字符集  	
	

-- 创建create table 的两种方法
	-- 1, create table tableName1 like tableName2; 
	-- 2, create table tableName1 as select * from tableName2   #(as 可省略);
	-- 第一种 ,只创建表结构，  第二种创建表结构和数据。  后者会丢失主键信息.	
	
	-- 实际应用
		# 根据 某张表中的一部分的数据，来创建自己的表
		create table he_goods( goods_id int unsigined not null primary key auto_increment ) select  goods_sn,goods_name,shop_price from ecshop.ecs_goods;
			
	
	
	
#insert
	insert into tableName ( col1,clo2 ) values ( val1,val2 );
	insert into he_goods values( null,'123' );
	insert into he_goods( goods_sn,shop_price ) values( 'ecs123',100 );
	
	-- 应用 蠕虫复制
		insert init tableName select * from tableName;
	
	/**
	 * 注意：
	 		 插入的数据应与字段的数据类型相同。（有时候会自动隐式转换，主要是数值）
            数据的大小应在列的规定范围内，例如：不能将一个长度为80的字符串加入到长度为40的列中。
            在values中列出的数据位置必须与被加入的列的排列位置相对应。
            字符和日期型数据应包含在单引号中，尤其注意单引号没关闭的情况。   
	 */
	
	







