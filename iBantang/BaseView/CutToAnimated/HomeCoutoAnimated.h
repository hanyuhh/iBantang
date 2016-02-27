//
//  HomeCoutoAnimated.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/4.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "CoutoAnimated.h"

@interface HomeCoutoAnimated : CoutoAnimated

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGRect      toframe;

- (void)setHeaderImageView:(UIImageView *)imageView toWindowsFrame:(CGRect)rect;

@end
