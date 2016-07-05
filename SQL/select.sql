

#select 
/*
SELECT *|{column1, column2. column3..}
	FROM tablename
	[WHERE where_definition]   ;
	
	where 后面表达式，要么为真，要么为假
		where 1  , where 0
	通常使用主键 来比较 	
		  
	select * from goods where goods_id between 10 and 20; #区间
	select * from goods where goods_id in(12,6,3);  #in	  
		  
	link  模拟查询  和 精确查询
	
	select * from he_goods where goods_id link '诺基亚%';     # %代表通配符
	select * from he_goods where goods_id link '诺基亚N__';   # __代表字符
		  
	is null 和 is not null
	
	注意：
	select  查询， 可以理解为 输出
	
	select 指定查询那些列的数据
	
	column 指定列名.
	* 号 代表查询所有列，不要总是使用 * ;
	
	from 指定查询那张表
	
	where 指定筛选的条件， 如果没有 where， 则查询 所有记录.
	 	
		  
*/