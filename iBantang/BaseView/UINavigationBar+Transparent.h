//
//  UINavigationBar+Transparent.h
//  iBantang
//
//  Created by cloudtopxm on 16/1/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Transparent)

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;

@end
