//
//  HomeBaseViewController.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBaseViewController : UIViewController

@property (nonatomic, strong) UIButton         *navBarLeft; //左
@property (nonatomic, strong) UIButton         *navBarBack; //左
@property (nonatomic, strong) UIButton         *navBarRight; //右
@property (nonatomic, strong) UILabel          *navBarTitle; //标题

/**
 *  设置左边按钮
 *
 *  @param image
 */
- (void)o_setLeftBarButtom:(UIImage *)image;
- (void)o_leftAction:(UIButton *)button;
/**
 *  设置返回按钮
 *
 *  @param image
 */
- (void)o_setBackBarButtom:(UIImage *)image;
- (void)o_backAction:(UIButton *)button;
/**
 *  设置右边按钮
 *
 *  @param image
 */
- (void)o_setRightBarButtom:(UIImage *)image;
- (void)o_rightAction:(UIButton *)button;
/**
 *  设置标题
 *
 *  @param text
 */
- (void)o_setTitle:(NSString *)text;
- (void)o_settabBarHidden:(BOOL)flag;

@end
