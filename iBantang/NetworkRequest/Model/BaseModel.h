//
//  BaseModel.h
//  iBantang
//
//  Created by cloudtopxm on 16/1/25.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "BaseNetWork.h"

@interface BaseModel : NSObject

@property (nonatomic, assign) NSInteger   status;

@property (nonatomic, assign) NSInteger   ts;

@property (nonatomic, copy  ) NSString    *msg;

@property (nonatomic, strong) BaseNetWork *net;

/**
 *  判断是否访问成功
 *
 *  @return 
 */
- (BOOL)isSuccess;

@end