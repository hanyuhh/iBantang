//
//  HomeContentTable.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/1.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"      // 首页数据模型

@class HomeContentTable;

@protocol TableViewOtherProtocol<NSObject>
/**
 *  滚动过程中调用
 *
 *  @param tableView
 *  @param point
 */
- (void)tableView:(UITableView *)tableView scrollViewDidScroll:(CGPoint )point;
/**
 *  点击某个cell时调用
 *
 *  @param tableView
 *  @param cell      点击的cell
 */
- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell;

@end
/**
 *  本控件的所有有关UITableView代理均为自己
 */
@interface HomeContentTable : UITableView

@property(nonatomic, assign)CGFloat numOneCellheight;
@property(nonatomic, strong)RecommendModel *dataModel;
/**
 *  设置最新资讯的数据模型
 *
 *  @param topic
 */
- (void)setTopic:(NSArray<Topic *> *)topic;
/**
 *  设置其他的编号
 *
 *  @param scene 编号 作为key
 *  @param dict  存放的容器
 */
- (void)setTopicWithScene:(NSString *)scene SaveDict:(NSDictionary *)dict;
/**
 *  滚动代理
 */
@property(nonatomic, weak)id <TableViewOtherProtocol> scrollProtocl;
- (void)setHeaderBoxMaxY:(CGFloat)headerBoxMaxY;

@end
