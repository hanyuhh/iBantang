//
//  HomeContentTableCellTableViewCell.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/2.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface HomeContentTableCellTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titlePic;
@property (nonatomic, strong) Topic       *topic;
/**
 *  返回自己的高度
 *
 *  @return
 */
+ (CGFloat)selfHeight;
/**
 *  最新专题
 *
 *  @param topic 数据模型
 */
- (void)setTopic:(Topic *)topic;
@end
