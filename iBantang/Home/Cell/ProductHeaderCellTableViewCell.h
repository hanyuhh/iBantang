//
//  ProductHeaderCellTableViewCell.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/16.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureModel.h"

@interface ProductHeaderCellTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *picView;

- (void)setPlaceholderImage:(UIImageView *)image model:(FeatureModel *)model;

+ (CGFloat)heightSelf:(FeatureModel *)model;

@end
