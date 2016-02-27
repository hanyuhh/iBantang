//
//  UIView+ViewRect.m
//  Sinotrans
//
//  Created by chenuex.lee on 15/11/24.
//  Copyright © 2015年 django. All rights reserved.
//

#import "UIView+ViewRect.h"

@implementation UIView (ViewRect)

/**
 *  直接返回UIView 的宽
 *
 *  @return
 */
- (CGFloat)o_width {
    
    return self.frame.size.width;
}

/**
 *  直接返回UIView 的高
 *
 *  @return
 */
- (CGFloat)o_height {
    
    return self.frame.size.height;
}

/**
 *  直接返回UIView 的x坐标
 *
 *  @return
 */
- (CGFloat)o_x {
    
    return self.frame.origin.x;
}

/**
 *  直接返回UIView 的y坐标
 *
 *  @return
 */
- (CGFloat)o_y {
    
    return self.frame.origin.y;
}

/**
 *  直接给UIView 的宽赋值
 *
 *  @return
 */
- (void)o_width:(CGFloat)width {
    
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

/**
 *  直接给UIView 的高赋值
 *
 *  @return
 */
- (void)o_height:(CGFloat)height {
    
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
/**
 *  直接给UIView 的x 赋值
 *
 *  @return
 */
- (void)o_x:(CGFloat)x {
    
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
/**
 *  直接给UIView 的y 赋值
 *
 *  @return
 */
- (void)o_y:(CGFloat)y {
    
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

/**
 *  直接给UIView 的origin 赋值
 *
 *  @return
 */
- (void)o_origin:(CGPoint)point {
    
    CGRect rect = self.frame;
    rect.origin = point;
    self.frame = rect;
}
/**
 *  直接给UIView 的size 赋值
 *
 *  @return
 */
- (void)o_size:(CGSize)size {
    
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}


@end
