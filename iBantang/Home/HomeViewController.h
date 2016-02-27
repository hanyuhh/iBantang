//
//  HomeViewController.h
//  iBantang
//
//  Created by cloudtopxm on 16/1/18.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "HomeBaseViewController.h"
#import "RecommendModel.h"      // 首页数据模型

@interface HomeViewController : HomeBaseViewController

@property (nonatomic, strong) RecommendModel   *dataModel;
@property (atomic, strong) NSMutableDictionary *dataSouce;
/**
 *  转到第几个标签
 *
 *  @param index
 */
- (void)gotoViewWithindex:(NSInteger)index;

@end
