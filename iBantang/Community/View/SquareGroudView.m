//
//  SquareGroudView.m
//  iBantang
//
//  Created by djangolee on 16/2/21.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "SquareGroudView.h"
#import "UIImageView+WebCache.h"
#import "SquareModel.h"

@interface SquareGroudView() {
    
}

@property (nonatomic, strong) NSMutableArray <UIImageView *> *boxs;

@end

@implementation SquareGroudView

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}


/* 初始化 */
- (void)initialization {
    
    __weak __typeof (self) weakSelf = self;
    
    UIView *headleftLine = [UIView new];
    [headleftLine setBackgroundColor:OCLINE];
    [self addSubview:headleftLine];
    UIView *headrightLine = [UIView new];
    [headrightLine setBackgroundColor:OCLINE];
    [self addSubview:headrightLine];
    UILabel *headTitle = [UILabel new];
    headTitle.font = [UIFont systemFontOfSize:13.f];
    headTitle.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    headTitle.text = @"种草小分队";
    [headTitle sizeToFit];
    [self addSubview:headTitle];
    
    [headleftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(headTitle.mas_left).offset(-10);
        make.centerY.equalTo(headTitle);
        make.height.equalTo(@0.5);
    }];
    [headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
    }];
    [headrightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10);
        make.left.equalTo(headTitle.mas_right).offset(10);
        make.centerY.equalTo(headTitle);
        make.height.equalTo(@0.5);
    }];

    _boxs = [NSMutableArray new];
    UIImageView *lastView;
    
    for (int index = 0; index < 5; index ++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        [_boxs addObject:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH - 20, (KSCREEN_WIDTH - 20) * 340 / 900));
            if (!lastView) {
                make.top.equalTo(headTitle.mas_bottom);
            } else {
                make.top.equalTo(lastView.mas_bottom).offset(5);
            }
        }];
        lastView = imageView;
        
        // 图片描述
        UIView *box = [UIView new];
        box.tag = 1000;
        [imageView addSubview:box];
        [box mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(imageView);
            make.width.equalTo(imageView);
        }];
        
        UIImageView *titleView = [UIImageView new];
        titleView.tag = 1001;
        [box addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(box);
            make.size.mas_equalTo(CGSizeMake(480.f / 2.5, 100.f / 2.5));
            make.centerX.equalTo(box);
        }];
        UILabel *number = [UILabel new];
        number.tag = 1002;
        number.textColor = [UIColor whiteColor];
        number.font = [UIFont systemFontOfSize:10.f];
        [box addSubview:number];
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleView.mas_bottom).offset(5);
            make.centerX.equalTo(box);
            make.bottom.equalTo(box);
        }];
        
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
}

- (void)setModel:(NSArray <Rec_Groups *> *)arr {
    for (UIImageView *imageView in _boxs) {
        [imageView sd_setImageWithURL:([NSURL URLWithString:[arr objectAtIndex:[_boxs indexOfObject:imageView]].pic2])];
        UIImageView *titleView = [[imageView viewWithTag:1000] viewWithTag:1001];
        [titleView sd_setImageWithURL:([NSURL URLWithString:[arr objectAtIndex:[_boxs indexOfObject:imageView]].pic3])];
        SquareDynamic *dynamic = [arr objectAtIndex:[_boxs indexOfObject:imageView]].dynamic;
        UILabel *number = [[imageView viewWithTag:1000] viewWithTag:1002];
        number.text = [NSString stringWithFormat:@"%ld浏览    %ld帖子", (long)dynamic.views, (long)dynamic.posts];
        [number sizeToFit];
    }
}

@end
