//
//  HomeBaseViewController.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "UITabBarController+TabbarImage.h"
#import "HomeBaseViewController.h"
#import "AppDelegate.h"

@interface HomeBaseViewController ()

@end

@implementation HomeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    [self.navigationController.navigationBar lt_setBackgroundColor:OCTHEMECOLOR];
    [self cleanNavBarLine]; // 去除底部黑线
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if ([self.navigationController.viewControllers objectAtIndex:0] != self) {
        [self o_setBackBarButtom:nil];
    }
    
}

/**
 *  设置左边按钮
 *
 *  @param image
 */
- (void)o_setLeftBarButtom:(UIImage*)image {
    _navBarLeft = [UIButton new];
    [_navBarLeft addTarget:self action:@selector(o_leftAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_navBarLeft setImage:image forState:(UIControlStateNormal)];
    [_navBarLeft o_size:image.size];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:_navBarLeft];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    self.navigationItem.leftBarButtonItems = @[fixed, button];
}
- (void)o_leftAction:(UIButton *)button {
    
}
/**
 *  设置返回按钮
 *
 *  @param image
 */
- (void)o_setBackBarButtom:(UIImage *)image {
    self.navigationItem.hidesBackButton = YES;
    if (!image) {
        image = [[UIImage imageNamed:@"ic_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    _navBarBack = [UIButton new];
    [_navBarBack addTarget:self action:@selector(o_backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_navBarBack setImage:image forState:(UIControlStateNormal)];
    [_navBarBack o_size:image.size];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:_navBarBack];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -25;
    self.navigationItem.leftBarButtonItems = @[fixed, button];
}
- (void)o_backAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  设置右边按钮
 *
 *  @param image
 */
- (void)o_setRightBarButtom:(UIImage*)image  {
    _navBarRight = [UIButton new];
    [_navBarRight addTarget:self action:@selector(o_rightAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_navBarRight setImage:image forState:(UIControlStateNormal)];
    [_navBarRight o_size:image.size];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:_navBarRight];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width -= 15;
    self.navigationItem.rightBarButtonItems = @[fixed,button];
}
- (void)o_rightAction:(UIButton *)button {
    
}
/**
 *  设置标题
 *
 *  @param text
 */
- (void)o_setTitle:(NSString *)text {
    _navBarTitle = [UILabel new];
    if ([self.navigationController.viewControllers objectAtIndex:0] != self) {
        _navBarTitle.font = [UIFont systemFontOfSize:18];
    } else {
        _navBarTitle.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:19];
    }
    _navBarTitle.textColor = [UIColor whiteColor];
    _navBarTitle.text = text;
    [_navBarTitle sizeToFit];
    self.navigationItem.titleView = _navBarTitle;
}

- (void)o_settabBarHidden:(BOOL)flag {
    UITabBarController *tabBarController = self.tabBarController;
    [UIView animateWithDuration:0.25 animations:^{
        [tabBarController newTabbar].hidden = flag;
    }];
}
@end
