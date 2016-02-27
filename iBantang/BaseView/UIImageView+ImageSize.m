//
//  UIImageView+ImageSize.m
//  Sinotrans
//
//  Created by chenuex.lee on 15/11/24.
//  Copyright © 2015年 django. All rights reserved.
//

#import "UIImageView+ImageSize.h"

@implementation UIImageView (ImageSize)

/**
 *  获取UIImageView 中 image 的真实宽度
 *
 *  @return
 */
- (CGFloat)o_imageWidth {
    
    return self.image != nil ? self.image.size.width : 0.f;
}
/**
 *  获取UIImageView 中 image 的真实高度
 *
 *  @return
 */
- (CGFloat)o_imageHeight {
    
    return self.image != nil ? self.image.size.height : 0.f;
}


@end
