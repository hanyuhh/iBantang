//
//  InventoryCoutoAnimated.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoutoAnimated;

typedef NS_ENUM (NSInteger, COUTOTYPE) {
    COUTOTYPEPUSH, // Push/Pop过场
    COUTOTYPEPRESENT // Present过场
};

@protocol CoutoAnimatedProtocol <NSObject>
/**
 *  goto转场动画 (下面两句话由自己决定加在哪里)
 *
 *  [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
 *  [transitionContext completeTransition:YES];
 *
 *  @param transitionContext  过场上下文信息
 *  @param fromViewController
 *  @param toViewController
 *  @param containerView
 *  @param duration
 */
- (void)coutoAnimatedGotoOtherTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                      fromViewController:(UIViewController *)fromViewController
                        toViewController:(UIViewController *)toViewController
                           containerView:(UIView *)containerView
                                duration:(NSTimeInterval)duration;
/**
 *  diss转场动画 (下面两句话由自己决定加在哪里)
 *
 *  [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
 *  [transitionContext completeTransition:YES];
 *
 *  @param transitionContext  过场上下文信息
 *  @param fromViewController
 *  @param toViewController
 *  @param containerView
 *  @param duration
 */
- (void)coutoAnimatedComebackTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                     fromViewController:(UIViewController *)fromViewController
                       toViewController:(UIViewController *) toViewController
                          containerView:(UIView *)containerView
                               duration:(NSTimeInterval)duration;
@end

@interface CoutoAnimated : NSObject <UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

- (instancetype)initWithDuration:(NSTimeInterval)duration coutoType:(COUTOTYPE)coutotype delegate:(id <CoutoAnimatedProtocol>)delegate;
/**
 *  是否是返回操作
 *
 *  @return YES -> back , NO -> Push/Pop or Present
 */
- (BOOL)isComeback;
@end
