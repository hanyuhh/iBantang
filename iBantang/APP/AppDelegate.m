//
//  AppDelegate.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/18.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "CommunityViewController.h"
#import "MessageViewController.h"
#import "UserViewController.h"
#import "PublishViewController.h"
#import "UITabBarController+TabbarImage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initWindows];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Other
/**
 *  构建主界面基本Windows元素
 */
- (void)initWindows {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //首页
    HomeViewController *home = [HomeViewController new];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    [homeNav.navigationBar setBarTintColor:OCTHEMECOLOR];
    // 社区
    CommunityViewController *community = [CommunityViewController new];
    UINavigationController *communityNav = [[UINavigationController alloc] initWithRootViewController:community];
    [communityNav.navigationBar setBarTintColor:OCTHEMECOLOR];
    //发布
    UIViewController *publish = [UIViewController new];
    UINavigationController *publishNav = [[UINavigationController alloc] initWithRootViewController:publish];
    [publishNav.navigationBar setBarTintColor:OCTHEMECOLOR];
    //消息
    MessageViewController *message = [MessageViewController new];
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:message];
    [messageNav.navigationBar setBarTintColor:OCTHEMECOLOR];
    //用户
    UserViewController *user = [UserViewController new];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:user];
    [userNav.navigationBar setBarTintColor:OCTHEMECOLOR];
    
    //添加到Tabbar中
    UITabBarController *tabbar = [UITabBarController new];
    [tabbar setViewControllers:@[homeNav, communityNav, publishNav, messageNav, userNav] animated:YES];
    NSArray *icimage = @[@"ic_main_tab_home",
                         @"ic_main_tab_community",
                         @"ic_main_tab_publish",
                         @"ic_main_tab_msg",
                         @"ic_main_tab_personal"];
    NSArray *icimagechecked = @[@"ic_main_tab_home_checked",
                                @"ic_main_tab_community_checked",
                                @"ic_main_tab_publish_pressed",
                                @"ic_main_tab_msg_checked",
                                @"ic_main_tab_personal_checked"];
    NSDictionary *icimageDict = @{@"image" : icimage,
                                  @"imageChecked" : icimagechecked
                                  };
    
    [tabbar initTabBarItemWithBarDictionary:icimageDict];
    //重定义Tabbar样式
    
    self.window.rootViewController = tabbar;
    
    //监听照片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openAboutPhoto) name:OPENPHOTO object:nil];
}

- (void)openAboutPhoto {
    [self.window.rootViewController presentViewController:[PublishViewController new] animated:YES completion:nil];
}

@end
