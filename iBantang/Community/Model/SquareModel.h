//
//  SquareModel.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/19.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "BaseModel.h"

@class SquareData,Module_Elements,SquareElements,Rec_Groups,SquareDynamic,SquareAuthor;
@interface SquareModel : BaseModel

@property (nonatomic, strong) SquareData *data;

/**
 *  通过网络数据获取序列号模型
 *
 *  @param successblock 成功回调的Block
 *  @param failblock    失败回调的Block
 */
+ (void)onet_initSelfandnetComplete:(void(^)(SquareModel *model))successblock andFail:(void(^)(BaseModel *model))failblock;

@end
@interface SquareData : NSObject

@property (nonatomic, strong) NSArray<Rec_Groups *> *rec_groups;

@property (nonatomic, strong) NSArray *attention_groups;

@property (nonatomic, strong) NSArray<Module_Elements *> *module_elements;

@property (nonatomic, assign) NSInteger attention_group_size;

@end

@interface Module_Elements : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<SquareElements *> *elements;

@end

@interface SquareElements : NSObject

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@end

@interface Rec_Groups : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger attention_type;

@property (nonatomic, copy) NSString *pic1;

@property (nonatomic, strong) SquareAuthor *author;

@property (nonatomic, strong) NSArray *attention_users;

@property (nonatomic, strong) SquareDynamic *dynamic;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *pic3;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *pic2;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *update_time;

@end

@interface SquareDynamic : NSObject

@property (nonatomic, assign) NSInteger views;

@property (nonatomic, assign) NSInteger attentions;

@property (nonatomic, assign) NSInteger posts;

@end

@interface SquareAuthor : NSObject

@end

