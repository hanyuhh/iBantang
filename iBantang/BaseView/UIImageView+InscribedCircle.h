//
//  UITableView+InscribedCircle.h
//  GraphicsDemo
//
//  Created by cloudtopxm on 16/3/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  为UIImageView 设置圆形遮罩
 */
@interface UIImageView (InscribedCircle)

@property(nonatomic, strong)UIImageView *markView;
/**
 *  将图片设置成圆形
 *
 *  @param color 背景颜色
 */
- (void)jo_InscribedCircleWidthBackgroud:(UIColor *)color;
/**
 *  将图片设置成圆形
 *
 */
- (void)jo_InscribedCircle;

@end