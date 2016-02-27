//
//  RecommendModel.h
//  iBantang
//
//  Created by cloudtopxm on 16/1/26.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "BaseModel.h"

@class Data,Append_Extend,Category_Element,Firstpage_Element,Banner_Bottom_Element,Topic,Banner;

@interface RecommendModel : BaseModel

@property (nonatomic, strong) Data *data;

/**
 *  通过网络数据获取序列号模型
 *
 *  @param successblock 成功回调的Block
 *  @param failblock    失败回调的Block
 */
+ (void)onet_initSelfandnetComplete:(void(^)(RecommendModel *model))successblock andFail:(void(^)(BaseModel *model))failblock;


/**
 *  通过网络数据获取序列号模型
 *
 *  @param extend
 *  @param successblock 成功回调的Block
 *  @param failblock    失败回调的Block
 */
+ (void)onet_initSelfandnetWithExtend:(NSString *)extend Complete:(void(^)(NSArray<Topic *> *topic))successblock andFail:(void(^)(BaseModel *model))failblock;

@end

@interface Data : NSObject

@property (nonatomic, strong) NSArray<Banner *> *banner;

@property (nonatomic, strong) NSArray<Banner_Bottom_Element *> *banner_bottom_element;

@property (nonatomic, strong) NSArray *entry_list;

@property (nonatomic, strong) NSArray<Firstpage_Element *> *firstpage_element;

@property (nonatomic, strong) NSArray<Topic *> *topic;

@property (nonatomic, strong) NSArray<Category_Element *> *category_element;

@property (nonatomic, strong) Append_Extend *append_extend;

@end

@interface Append_Extend : NSObject

@property (nonatomic, assign) NSInteger entry_list_index;

@end

@interface Category_Element : NSObject

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@end

@interface Firstpage_Element : NSObject

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@end

@interface Banner_Bottom_Element : NSObject

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@end

@interface Topic : NSObject

@property (nonatomic, assign) BOOL islike;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *tags;

@end

@interface Banner : NSObject

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@end

