//
//  InventoryViewController.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "HomeBaseViewController.h"

@interface InventoryViewController : HomeBaseViewController

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIView *bottomView;

- (instancetype)initWithImage:(UIImageView *)imageView ID:(NSString *)ID;

/* 初始化Model */
- (void)initModel;

@end
