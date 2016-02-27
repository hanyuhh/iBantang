//
//  PhotoGroudView.h
//  iBantang
//
//  Created by djangolee on 16/2/22.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol PhotoGroudViewDelegate <NSObject>

- (void)view:(UIView *)view backButton:(UIButton *)button;

- (void)view:(UIView *)view didSelectRow:(NSInteger)index groupAtArray:(NSMutableArray <ALAsset *> *)arr;

@end

@interface PhotoGroudView : UIView

@property (nonatomic, copy) NSMutableArray <NSDictionary <NSString *, NSMutableArray <ALAsset *> *> *> *groupArray;
@property (nonatomic, weak) id <PhotoGroudViewDelegate> delegate;

@end
