//
//  BaseNetWork.h
//  iBantang
//
//  Created by cloudtopxm on 16/1/25.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParameter.h"
#import "AFNetworking.h"

@interface BaseNetWork : NSObject

/**
 *  返回数据字典
 */
@property (strong, nonatomic) NSDictionary *requestDict;
/**
 *  类方法: 初始化并通过Block初始化网络参数
 *
 *  @param block 参数初始化
 *
 *  @return instancetype
 */
+ (instancetype)onet_initSelfandRequestParameter:(void (^)(RequestParameter **requestmodel, BaseNetWork *net))block;
/**
 *  更新参数
 *
 *  @param block 参数初始化
 */
- (void)onet_updateRequestParameter:(void (^)(RequestParameter **requestmodel))block;
/**
 *  移除当前所有参数, 从新加入新的参数组
 *
 *  @param block 新参数初始化的Block
 */
- (void)onet_removeRequestParameter:(void (^)(RequestParameter **requestmodel))block;
/**
 *  执行网络请求
 *
 *  @param url           可选, 为空时为默认服务器地址, 不为空时为传入的URL地址
 *  @param completeBlock 请求的回调
 */
- (void)onet_executeNetRequestComplete:(void (^)(id response))completeBlock;
/**
 *  打印所有参数
 */
- (void)printParameterString;
/**
 *  打印返回数据
 */
- (void)printResponseString;
/**
 *  取消所有网络请求
 */
- (void)onet_cancelRequest;
@end
