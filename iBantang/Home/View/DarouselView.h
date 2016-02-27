//
//  DarouselView.h
//  DarouselDemo
//
//  Created by cloudtopxm on 16/1/19.
//  Copyright © 2016年 orange. All rights reserved.
//
/**
 *  轮播图 : //只需要设置宽度, 高度会自动适应
 *
 *  @param assign 几秒后切换
 *
 */
#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface DarouselView : UIView
/**
 *  几秒后切换
 */
@property (assign, atomic) NSInteger maxSecond;
@property (nonatomic, strong) void (^heightBlock) (CGFloat height);

/**
 *  设置数据源
 *
 *  @param dataArr    轮播图数据
 *  @param bottomArr  Bottom数据
 */
- (void)setArray:(NSArray <Banner *> *) dataArr andBottomarr:(NSArray <Banner_Bottom_Element *> *) bottomArr;
/**
 *  计算高度
 *
 *  @return height
 */
+ (CGFloat)selfHeight;

@end

//UIPageControl 重写
@interface PagePageSizeControl : UIPageControl

@end