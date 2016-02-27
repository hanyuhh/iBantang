//
//  SquareRecommendViewCell.m
//  iBantang
//
//  Created by djangolee on 16/2/20.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "SquareRecommendViewCell.h"
#import "UIImageView+WebCache.h"
#import "SquareModel.h"

@interface SquareRecommendViewCell() {
    
}

@property (nonatomic, strong) NSMutableArray <UIView *> *buttons;

@end

@implementation SquareRecommendViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}


/* 初始化 */
- (void)initialization {
    
    __weak __typeof(self)weakSelf = self;
    
    _buttons = [NSMutableArray new];
    UIView *lastView;
    for (int index = 0; index < 8; index ++) {
        UIView *view = [UIView new];
        [self addSubview:view];
        [_buttons addObject:view];
        
        //创建约束
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastView) {
                make.top.left.equalTo(weakSelf);
            } else {
                make.width.equalTo(lastView);
                make.height.equalTo(lastView);
                
                if (index == 3 || index == 7) {
                    make.right.equalTo(weakSelf);
                }
                if (index == 4) {
                    make.left.equalTo(weakSelf);
                    make.top.equalTo(lastView.mas_bottom);
                } else {
                    make.left.equalTo(lastView.mas_right);
                    make.top.equalTo(lastView);
                }
                if (index > 3) {
                    make.bottom.equalTo(weakSelf);
                }
            }
        }];
        lastView = view;
        
        //创建子视图
        UIImageView *pic = [UIImageView new];
        pic.tag = 1001;
        [view addSubview:pic];
        UILabel *title = [UILabel new];
        title.tag = 1002;
        [view addSubview:title];
        UILabel *numberl = [UILabel new];
        numberl.tag = 1003;
        [view addSubview:numberl];
        
        pic.layer.masksToBounds = YES;
        pic.layer.cornerRadius = (KSCREEN_WIDTH / 4) / 4;
        [pic setBackgroundColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0]];
        [pic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(10);
            make.centerX.equalTo(view);
            make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH / 4 / 2, KSCREEN_WIDTH / 4 / 2));
        }];
        
        title.font = [UIFont systemFontOfSize:12.f];
        title.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pic.mas_bottom).offset(5);
            make.centerX.equalTo(view);
        }];
        
        numberl.font = [UIFont systemFontOfSize:11.f];
        numberl.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
        [numberl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(5);
            make.centerX.equalTo(view);
        }];
    }
    
    
}

- (void)setModel:(NSArray <SquareElements *> *)arr {
    
    for (UIView *view in _buttons) {
        NSUInteger index = [_buttons indexOfObject:view];
        
        UIImageView *pic = [view viewWithTag:1001];
        [pic sd_setImageWithURL:[NSURL URLWithString:[arr objectAtIndex:index].photo]];
        UILabel *title = [view viewWithTag:1002];
        title.text = [arr objectAtIndex:index].title;
        [title sizeToFit];
        UILabel *numberl = [view viewWithTag:1003];
        numberl.text = [arr objectAtIndex:index].sub_title;
        [numberl sizeToFit];
    }
}

@end
