//
//  ProductCellTableViewCell.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/15.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureModel.h"

@interface ProductCellTableViewCell : UITableViewCell

- (void)setModel:(FeatureProduct *)model index:(NSInteger)index;


+ (CGFloat)heightSelf:(FeatureProduct *)model label:(UILabel *)label;
@end
