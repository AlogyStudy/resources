
# 框架搭建

* 路径信息的初始化
* 参数过滤：GET/POST
* 运行日志：运行中的错误信息，SQL信息记录下来
* 报错级别：开发状态一个级别，上下状态一个级别
* 数据库类
* 配置文件的读取 



# 知识点

数据库类 -- Y
报错级别 -- Y
参数过滤 -- N (递归)
运行日志 -- 要求把运行中的信息记录在文件上(文件操作) N
					日志按天形成目录存放 （目录创建）N
读取配置文件 -- 小项目，配置文件往往只放数据库信息，因此被数据库读取到，就行.
							现在配置文件信息，还要包括缓存信息，smarty的目录信息。
							要求：能被多个类的读取.
								

		
