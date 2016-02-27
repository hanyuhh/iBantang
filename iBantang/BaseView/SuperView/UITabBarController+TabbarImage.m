//
//  UITabBarController+TabbarImage.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/18.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "UITabBarController+TabbarImage.h"

@implementation UITabBarController (TabbarImage)

- (void)initTabBarItemWithBarDictionary:(NSDictionary *)dict {
    
    NSArray *barImages = [dict objectForKey:@"image"];
    NSArray *barCheckImages = [dict objectForKey:@"imageChecked"];
    
    if (barCheckImages.count != barImages.count || barImages.count <= 0 || barImages.count <= 0) {
        return;
    }
    
    //移除原有的Tabbar
    [self.tabBar removeFromSuperview];
    
    //添加新的Tabbar
    UIView *newTabbar = [[UIView alloc] init];
    newTabbar.tag = 10086;
    newTabbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newTabbar];
    
    //阴影
    [newTabbar.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [newTabbar.layer setShadowOffset:CGSizeMake(-.1f, -.1f)]; //设置偏移量
    [newTabbar.layer setShadowOpacity:0.6f];//阴影透明度
    
    [newTabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(self.view).offset(0);
        make.height.equalTo(@49);
    }];
    
    UIButton *lastButton;
    for (int index = 0 ; index < barImages.count; index ++) {
        UIButton *button = [UIButton new];
        button.tag = 100 + index;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [button setImage:[UIImage imageNamed:[barImages objectAtIndex:index]] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:[barCheckImages objectAtIndex:index]] forState:(UIControlStateSelected)];
        [newTabbar addSubview:button];
        
        if (lastButton) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(newTabbar.mas_centerY);
                make.left.equalTo(lastButton.mas_right);
                make.width.equalTo(lastButton);
            }];
        } else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(newTabbar.mas_centerY);
                make.left.equalTo(newTabbar);
            }];
        }
        if (index == barImages.count - 1) {
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.right.equalTo(newTabbar);
            }];
        }
        if (index == 0) {
            button.selected = YES;
        }
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(newTabbar).offset(3);
        }];
        lastButton = button;
    }
}
/**
 *  按钮点击
 *
 *  @param button 按钮
 */
- (void)buttonClick:(UIButton *)button {
    
    if (button.tag - 100 == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:OPENPHOTO object:nil userInfo:nil];
        return;
    }
    
    //已选中的直接返回
    if (button.selected) {
        return;
    }
    
    //遍历子视图中的所有Button
    UIView *superview = [button superview];
    int index = 0;
    while (true) {
        if ([superview viewWithTag:100 + index] && [[superview viewWithTag:100 + index] isKindOfClass:[UIButton class]]) {
            if ([superview viewWithTag:100 + index] != button) {
                ((UIButton *)[superview viewWithTag:100 + index]).selected = NO;
            }
        } else {
            break;
        }
        index ++;
    }
    
    button.selected = YES;
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = button.tag - 100;
}
/**
 *  返回Tabbar
 *
 *  @return
 */
- (UIView *)newTabbar {
    return [self.view viewWithTag:10086];
}

@end
