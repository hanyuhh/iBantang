//
//  HeadingView.h
//  iBantang
//
//  Created by cloudtopxm on 16/1/27.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface HeadingView : UICollectionView
/**
 *  联动的容器
 */
@property (nonatomic, strong)UICollectionView *collectionViewView;

- (void)setDataSourceArr:(NSArray <Category_Element *> *) dataSource;
/**
 *  转到第几个标签
 *
 *  @param index
 */
- (void)gotoViewWithindex:(NSInteger)index;

@end
