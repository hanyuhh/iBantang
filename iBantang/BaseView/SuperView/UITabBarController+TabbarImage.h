//
//  UITabBarController+TabbarImage.h
//  iBantang
//
//  Created by cloudtopxm on 16/1/18.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OPENPHOTO @"OpenPhotoNotification"

@interface UITabBarController (TabbarImage)
/**
 *  重写Tabbar的底部按钮
 *
 *  @param dict 图片字典
 */
- (void)initTabBarItemWithBarDictionary:(NSDictionary *)dict;
/**
 *  返回Tabbar
 *
 *  @return
 */
- (UIView *)newTabbar;
@end
