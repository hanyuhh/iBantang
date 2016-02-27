//
//  FeatureUserModel.h
//  iBantang
//
//  Created by cloudtopxm on 16/2/15.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "BaseModel.h"
/**
 *  用户推荐
 */
@class FeatureUserData,List,Dynamic,Author,Pics,Tags,Product,Comments,c_Product,At_User;
@interface FeatureUserModel : BaseModel

@property (nonatomic, strong) FeatureUserData *data;

@end

@interface FeatureUserData : NSObject

@property (nonatomic, strong) NSArray<List *> *list;

@end


@interface List : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *relation_id;

@property (nonatomic, copy) NSString *is_recommend;

@property (nonatomic, strong) NSArray<Comments *> *comments;

@property (nonatomic, strong) Author *author;

@property (nonatomic, copy) NSString *datestr;

@property (nonatomic, strong) NSArray<Product *> *product;

@property (nonatomic, strong) NSArray<Tags *> *tags;

@property (nonatomic, strong) Dynamic *dynamic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *author_id;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *publish_time;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *i_tags;

@property (nonatomic, strong) NSArray<Pics *> *pics;

@property (nonatomic, copy) NSString *content;

@end

@interface Dynamic : NSObject

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, strong) NSArray *likes_users;

@property (nonatomic, assign) BOOL is_comment;

@property (nonatomic, copy) NSString *praises;

@property (nonatomic, copy) NSString *views;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, assign) BOOL is_collect;

@end

@interface Author : NSObject

@property (nonatomic, assign) NSInteger attention_type;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger is_official;

@property (nonatomic, copy) NSString *avatar;

@end

@interface Pics : NSObject

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

@interface Tags : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@end

@interface Product : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *platform;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *item_id;

@property (nonatomic, copy) NSString *url;

@end

@interface Comments : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger is_praise;

@property (nonatomic, assign) NSInteger is_official;

@property (nonatomic, copy) NSString *datestr;

@property (nonatomic, strong) c_Product *product;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, assign) NSInteger reply;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, assign) NSInteger dateline;

@property (nonatomic, copy) NSString *conent;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSInteger praise;

@property (nonatomic, strong) At_User *at_user;

@property (nonatomic, assign) NSInteger is_hot;

@end

@interface c_Product : NSObject

@end

@interface At_User : NSObject

@end

