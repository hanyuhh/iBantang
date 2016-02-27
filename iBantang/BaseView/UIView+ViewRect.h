//
//  UIView+ViewRect.h
//  Sinotrans
//
//  Created by chenuex.lee on 15/11/24.
//  Copyright © 2015年 django. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewRect)


/**
 *  直接返回UIView 的宽
 *
 *  @return
 */
- (CGFloat)o_width;
/**
 *  直接返回UIView 的高
 *
 *  @return
 */
- (CGFloat)o_height;
/**
 *  直接返回UIView 的x坐标
 *
 *  @return
 */
- (CGFloat)o_x;
/**
 *  直接返回UIView 的y坐标
 *
 *  @return
 */
- (CGFloat)o_y;
/**
 *  直接给UIView 的宽赋值
 *
 *  @return
 */
- (void)o_width:(CGFloat)width;
/**
 *  直接给UIView 的高赋值
 *
 *  @return
 */
- (void)o_height:(CGFloat)height;
/**
 *  直接给UIView 的x 赋值
 *
 *  @return
 */
- (void)o_x:(CGFloat)x;
/**
 *  直接给UIView 的y 赋值
 *
 *  @return
 */
- (void)o_y:(CGFloat)y;
/**
 *  直接给UIView 的origin 赋值
 *
 *  @return
 */
- (void)o_origin:(CGPoint)point;
/**
 *  直接给UIView 的size 赋值
 *
 *  @return
 */
- (void)o_size:(CGSize)size;
@end
