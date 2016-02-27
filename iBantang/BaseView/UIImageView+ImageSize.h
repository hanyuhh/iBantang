//
//  UIImageView+ImageSize.h
//  Sinotrans
//
//  Created by chenuex.lee on 15/11/24.
//  Copyright © 2015年 django. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ImageSize)

/**
 *  获取UIImageView 中 image 的真实宽度
 *
 *  @return
 */
- (CGFloat)o_imageWidth;
/**
 *  获取UIImageView 中 image 的真实高度
 *
 *  @return
 */
- (CGFloat)o_imageHeight;


@end
