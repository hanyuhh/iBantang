//
//  RequestParameter.h
//  iBantang
//
//  Created by cloudtopxm on 16/1/26.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  请求方式
 */
typedef NS_ENUM(NSInteger, NetWorkRequestMethod) {
    /**
     *  无 : 0
     */
    NetWorkRequest = 0,
    /**
     *  GET : 1
     */
    NetWorkRequestGET,
    /**
     *  POST : 2
     */
    NetWorkRequestPOST,
    /**
     *  PUT : 3
     */
    NetWorkRequestPUT,
    /**
     *  DELETE : 4
     */
    NetWorkRequestDELETE,
};

@interface RequestParameter : NSObject
/**
 *  请求方式 : 必选
 */
@property (assign, nonatomic) NetWorkRequestMethod  method;
/**
 *  访问结果的序列号模型 : 必选
 */
@property (strong, nonatomic) id                    model;
/**
 *  调用的接口名(方法) : 可选
 */
@property (strong, nonatomic) NSString              *function;
/**
 *  访问的参数 : 可选
 */
@property (strong, nonatomic) NSDictionary          *paradict;
/**
 *  服务器地址 : 可选(在默认情况下为默认服务器地址)
 */
@property (strong, nonatomic) NSString              *URL;
/**
 *  打印所有参数
 */
- (void)printString;

@end
