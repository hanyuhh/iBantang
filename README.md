# iBantang
Imitation iBantang App
精仿半塘
已知缺陷:  首页 各个标签对应的数据是一次性加载, 数据没有做缓存, 
         清单 界面点赞用户的头像圆形处理只是通过layer.cornerRadius masksToBounds设置, 减低了性能

2016年03月03日22:28:06
优化了 圆角逻辑, 使用CG框架生成PNG镂空矩形内切圆PNG图片来方式来实现圆角, 舍去layer.cornerRadius masksToBounds的圆角逻辑 
