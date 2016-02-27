//
//  UILabel+LayoutTextRect.m
//  Sinotrans
//
//  Created by chenuex.lee on 15/11/26.
//  Copyright © 2015年 django. All rights reserved.
//

#import "UILabel+LayoutTextRect.h"

@implementation UILabel (LayoutTextRect)

/**
 *  根据给定的大小， 算出实际大小
 *
 *  @param size 自定的大小
 *
 *  @return 实际占用的大小
 */
- (CGSize)boundingRectWithSize:(CGSize)size {
    
    NSDictionary *attribute = @{NSFontAttributeName: self.font};

    CGSize retSize          = [self.text boundingRectWithSize:size
                                             options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;

    return retSize;
}
/**
 *  覆盖自带sizeThatFits: 重写, 使其有直接为View赋值size的特性
 *
 *  @param size 最大的空间
 *
 *  @return 实际占用的大小
 */
- (CGSize)o_sizeThatFits:(CGSize)size {
    
    CGSize temp = [self sizeThatFits:size];
    [self o_size:temp];
    
    return temp;
}

@end
