//
//  FeatureModel.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/15.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "BaseModel.h"

/**
 *  半塘推荐
 */
@class FeatureData,Activity,FeatureProduct,Pic,Likes_List;

@interface FeatureModel : BaseModel

@property (nonatomic, strong) FeatureData *data;

/**
 *  通过网络数据获取序列号模型
 *
 *  @param ID           详情ID
 *  @param successblock 成功回调的Block
 *  @param failblock    失败回调的Block
 */
+ (void)onet_initWithID:(NSString *)ID Complete:(void(^)(FeatureModel *model))successblock andFail:(void(^)(BaseModel *model))failblock;

@end
@interface FeatureData : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger category;

@property (nonatomic, strong) NSArray<FeatureProduct *> *product;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *tag_ids;

@property (nonatomic, copy) NSString *share_pic;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *user_avatr_host;

@property (nonatomic, strong) Activity *activity;

@property (nonatomic, assign) BOOL islike;

@property (nonatomic, copy) NSString *product_pic_host;

@end

@interface Activity : NSObject

@end

@interface FeatureProduct : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger category;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, assign) BOOL iscomments;

@property (nonatomic, copy) NSString *topic_id;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *item_id;

@property (nonatomic, copy) NSString *platform;

@property (nonatomic, strong) NSArray<Pic *> *pic;

@property (nonatomic, strong) NSArray<Likes_List *> *likes_list;

@property (nonatomic, assign) BOOL islike;

@end

@interface Pic : NSObject

@property (nonatomic, copy) NSString *p;

@property (nonatomic, assign) NSInteger w;

@property (nonatomic, assign) NSInteger h;

@end

@interface Likes_List : NSObject

@property (nonatomic, assign) NSInteger u;

@property (nonatomic, copy) NSString *a;

@end

