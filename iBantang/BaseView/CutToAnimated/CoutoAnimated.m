//
//  InventoryCoutoAnimated.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "CoutoAnimated.h"

@interface CoutoAnimated()

@property (nonatomic, weak  ) UIViewController           *fromViewController;
@property (nonatomic, weak  ) UIViewController           *toViewController;
@property (nonatomic, weak  ) UIView                     *containerView;
@property (nonatomic, assign) NSTimeInterval             duration;
@property (nonatomic, weak  ) id <CoutoAnimatedProtocol> delegate;
@property (nonatomic, assign) COUTOTYPE                  coutotype;

@end

@implementation CoutoAnimated

- (instancetype)initWithDuration:(NSTimeInterval)duration coutoType:(COUTOTYPE)coutotype delegate:(id <CoutoAnimatedProtocol>)delegate {
    if (self = [super init]) {
        self.duration = duration;
        self.coutotype = coutotype;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark UINavigationControllerDelegate methods
// Push/Pop时自定义过场的代理
// 参数：
//      navigationController：导航
//      operation：导航的操作：Push/Pop/None，可以用来控制在哪种导航的操作下使用自定义过场
//      fromVC：执行Push操作的UIViewController
//      toVC：被Push的UIViewController
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    
    return self; //返回self表示代理由类本身实现
}

// Present时自定义过场的代理
// 参数：
//      presented：被Present的UIViewController
//      presenting：正在执行Present的UIViewController
//      source：发起Present的UIViewController（PS：正在执行Present和发起Present的UIViewController是有区别的，
//      如果source是某个UINavigationController下的一个UIViewController，
//      那么presenting就是这个UINavigationController，如果source不是在类似UINavigationController或者
//      UITabbarController这样的控件内，那么presenting就是source本身）
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    return self;
}

// Dismiss时自定义过场的代理
// 参数：
//      dismissed：被Dismiss掉的UIViewController
-(id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}


#pragma mark - UIViewControllerContextTransitioning

// 实现具体自定义过场动画效果的代理，这个代理也是实现动画效果的核心
// 参数：
//      transitionContext：过场时的上下文信息
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    _fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _containerView = [transitionContext containerView];
    _duration = [self transitionDuration:transitionContext];
    
    if ([self isComeback]) {
        if ([_delegate conformsToProtocol:@protocol(CoutoAnimatedProtocol)] &&
            [_delegate respondsToSelector:@selector(coutoAnimatedGotoOtherTransition:fromViewController:toViewController:containerView:duration:)]) {
            [_delegate coutoAnimatedGotoOtherTransition:transitionContext
                                     fromViewController:_fromViewController
                                       toViewController:_toViewController
                                          containerView:_containerView
                                               duration:_duration];
        }
    } else {
        if ([_delegate conformsToProtocol:@protocol(CoutoAnimatedProtocol)] &&
            [_delegate respondsToSelector:@selector(coutoAnimatedComebackTransition:fromViewController:toViewController:containerView:duration:)]) {
            [_delegate coutoAnimatedComebackTransition:transitionContext
                                    fromViewController:_fromViewController
                                      toViewController:_toViewController
                                         containerView:_containerView
                                              duration:_duration];
        }
    }
}

// 过场动画时间的代理
// 参数：
//      transitionContext：过场时的上下文信息
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}

/**
 *  是否是返回操作
 *
 *  @return YES -> back , NO -> Push/Pop or Present
 */
- (BOOL)isComeback {
    return (self.fromViewController == (UIViewController *)self.delegate) ? YES : NO;
}
@end
