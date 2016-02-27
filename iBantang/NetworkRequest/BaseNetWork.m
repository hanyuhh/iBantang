//
//  BaseNetWork.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/25.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "BaseNetWork.h"
#import "BaseModel.h"

const static char SERVERURL[] = "http://open3.bantangapp.com";

@interface BaseNetWork() {
    
}

/**
 * AF网络请求主体
 */
@property (strong, nonatomic) AFHTTPSessionManager *session;
/**
 *  参数模型
 */
@property (strong, nonatomic) RequestParameter     *parameter;


@end

@implementation BaseNetWork

/**
 *  类方法: 初始化并通过Block初始化网络参数
 *
 *  @param block 参数初始化
 *
 *  @return instancetype
 */

+ (instancetype)onet_initSelfandRequestParameter:(void (^)(RequestParameter **requestmodel, BaseNetWork *net))block {
    
    BaseNetWork *netWork = [BaseNetWork new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    netWork.session = manager;
    manager.requestSerializer     = [AFHTTPRequestSerializer serializer]; //设置请求数据
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer]; //设置返回数据
    
    RequestParameter *para = [RequestParameter new];
    netWork.parameter = para;
    block(&para,netWork);
    return netWork;
}

/**
 *  更新参数
 *
 *  @param block 参数初始化
 */
- (void)onet_updateRequestParameter:(void (^)(RequestParameter **requestmodel))block {
    
    RequestParameter *para = [RequestParameter new];
    block(&para);
    
    //执行过+onet_initSelfandRequestParameter:
    if (self.parameter) {
        
        if (para.method != NetWorkRequest) {
            self.parameter.method = para.method;
        }
        if (para.model) {
            self.parameter.model = para.model;
        }
        if (para.function) {
            self.parameter.function = para.function;
        }
        if (para.paradict) {
            self.parameter.paradict = para.paradict;
        }
        if (para.URL) {
            self.parameter.URL = para.URL;
        }
    } else { //未执行过+onet_initSelfandRequestParameter:
        self.parameter = para;
    }
}

/**
 *  移除当前所有参数, 从新加入新的参数组
 *
 *  @param block 新参数初始化的Block
 */
- (void)onet_removeRequestParameter:(void (^)(RequestParameter **requestmodel))block {
    
    RequestParameter *para = [RequestParameter new];
    block(&para);
    
    self.parameter = para;
}

/**
 *  执行网络请求, 调用此方法请必须先调用 +onet_initSelfandRequestParameter: 对访问参数进行初始化
 *
 *  @param completeBlock 请求的回调
 */
- (void)onet_executeNetRequestComplete:(void (^)(id response))completeBlock {
    
    if (!self.parameter) {
        NSAssert(NO, [NSString stringWithFormat: @"必须对参数进行初始化"]);
    }
    if (!self.parameter.model) {
        NSAssert(NO, [NSString stringWithFormat: @"必须指定返回数据的模型类"]);
    }
    if (self.parameter.method == NetWorkRequest) {
        NSAssert(NO, [NSString stringWithFormat: @"必须指定请求方式: NetWorkRequestMethod"]);
    }
    
    NSString *temp = self.parameter.URL ? : [NSString stringWithCString:SERVERURL encoding:NSUTF8StringEncoding];
    NSString *URLString = [NSString stringWithFormat:@"%@/%@",temp, self.parameter.function];

    switch (self.parameter.method) {
        case NetWorkRequestGET: {
            [self.session GET:URLString parameters:self.parameter.paradict progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // 接口调用成功
                [self dataModelWithData:(NSData *)responseObject complete:completeBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                // 接口调用失败
                [self requestFailcomplete:completeBlock];
            }];
            break;
        }
        case NetWorkRequestPOST: {
            [self.session POST:URLString parameters:self.parameter.paradict progress:^(NSProgress * _Nonnull uploadProgress) {

                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // 接口调用成功
                [self dataModelWithData:(NSData *)responseObject complete:completeBlock];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                // 接口调用失败
                [self requestFailcomplete:completeBlock];
                
            }];
            
            break;
        }
        case NetWorkRequestPUT: {
            [self.session PUT:URLString parameters:self.parameter.paradict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // 接口调用成功
                [self dataModelWithData:(NSData *)responseObject complete:completeBlock];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                // 接口调用失败
                [self requestFailcomplete:completeBlock];
                
            }];
        
            break;
        }
        case NetWorkRequestDELETE: {
            [self.session DELETE:URLString parameters:self.parameter.paradict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // 接口调用成功
                [self dataModelWithData:(NSData *)responseObject complete:completeBlock];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                // 接口调用失败
                [self requestFailcomplete:completeBlock];
                
            }];
            
            break;
        }
        default:
            break;
    }
}
/**
 *  取消所有网络请求
 */
- (void)onet_cancelRequest {
    
}
/**
 *  将从server端请求回来的结果进行处理,分配
 *
 *  @param data          从server获取的二进制数据
 *  @param completeBlock 回调Block, 将反序列化的结果返回
 */
- (void)dataModelWithData:(NSData *)data complete:(void (^)(id response))completeBlock {
    
    NSError *error = nil;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    id model;
    if (dict && !error) { //成功
        self.requestDict = dict;
        model = [self.parameter.model new];
        [model yy_modelSetWithDictionary:dict];
    } else { //失败
        model = [BaseModel new];
        ((BaseModel *)model).status = 0;
        ((BaseModel *)model).msg = @"序列号失败!";
    }
#if DEBUG
    printf("start: %s \n", [[[self.parameter.model class] description] UTF8String]);
    printf("%s \n", [((BaseModel *)model).msg UTF8String]);
    [self printParameterString];
    [self printResponseString];
    printf("end: %s \n", [[[self.parameter.model class] description] UTF8String]);
#endif
    //回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        completeBlock(model);
    });
}

/**
 *  网络请求失败
 *
 *  @param completeBlock
 */
- (void)requestFailcomplete:(void (^)(id response))completeBlock {
    
    id model = [BaseModel new];
    ((BaseModel *)model).status = 0;
    ((BaseModel *)model).msg = @"网络请求失败!";
#if DEBUG
    printf("start: %s \n", [[[self.parameter.model class] description] UTF8String]);
    [self printParameterString];
    [self printResponseString];
    printf("%s \n", [((BaseModel *)model).msg UTF8String]);
    printf("end: %s \n", [[[self.parameter.model class] description] UTF8String]);
#endif
    //回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        completeBlock(model);
    });
}


/**
 *  打印所有参数
 */
- (void)printParameterString {
    NSMutableString * string = [[self.parameter description] mutableCopy];
    const char * ch = [string UTF8String];
    printf("参数:\n%sDefaultURL: %s\n\n",ch, SERVERURL);
}
/**
 *  打印返回数据
 */
- (void)printResponseString {
    if (self.requestDict) {
        NSString *string = [self.requestDict description];
        const char * ch = [string UTF8String];
        printf("Response:\n%s\n\n",ch);
    } else {
        printf("Response:\nnil\n\n");
    }
}

@end
