

#update  更新

	update tableName set shop_price=shop_price+100;
	update tableName set colName=value where shop_price>2000;
	update tableName set shop_sn='110',shop_price=999 where shop_id=10;
	

	#update TableName set 字段=值  
	update mm_stu set age=25;	
	
	/*
	 *  UPDATE语法可以用新值更新原有表行中的各列。
  	  SET子句指示要修改哪些列和要给予哪些值。
	    WHERE子句指定应更新哪些行。如没有WHERE子句，则更新所有的行。
            更新成功一般要两个条件，语句OK，并且有受影响行数，删除也是如此。
      UPDATE结合INSERT的一种特殊用法。
            
            没有where的updata语句开发中不允许.
	 */
	
-- update 和 insert 结合
	insert into he_goods values(19,'aaa','bbb',100) 
		on duplicate key update goods_sn='aaa',goods_name='bbb',shop_price=100;
	
	
	
#delete
	#delete from tableName where 条件
/*
	如果不使用WHERE子句，将删除表中所有数据。
	DELETE语句是以行为单位的，不能删除某一列的值。
	使用DELETE语句仅删除记录，不删除表本身。如要删除表，使用DROP TABLE语句。
	删除表中数据也可使用TRUNCATE TABLE 语句，注意二者之间的差异。
								truncate table 
	从一个表中删除记录将引起其它表的参照完整性问题，insert和update一样在修改数据库数据时，头脑中应该始终不要忘记这个潜在的问题。
*/	

	/**
	 * 实际上，truncate 的操作，先删除表，再创建表。
    delete 在数据量大的时候，远远低于truncate.
    #truncate table    
    truncate he_goods; 
	 */
			
		
			
