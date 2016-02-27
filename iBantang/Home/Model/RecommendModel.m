//
//  RecommendModel.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/26.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "RecommendModel.h"
#import "NetworkRequest.h"

@implementation RecommendModel

/**
 *  通过网络数据获取序列号模型
 *
 *  @param successblock 成功回调的Block
 *  @param failblock    失败回调的Block
 */
+ (void)onet_initSelfandnetComplete:(void(^)(RecommendModel *model))successblock andFail:(void(^)(BaseModel *model))failblock {
    
    [[BaseNetWork onet_initSelfandRequestParameter:^(RequestParameter **requestmodel, BaseNetWork *net) {
        (*requestmodel).method = NetWorkRequestPOST;
        (*requestmodel).model = [RecommendModel class];
        (*requestmodel).function = @"recommend/index";
        (*requestmodel).paradict = @{
                                     @"app_versions" :  [UserManage sharedDefaultManager].app_versions,
                                     @"track_device_info" :  [UserManage sharedDefaultManager].device_versions,
                                     @"track_deviceid" :  [UserManage sharedDefaultManager].device_UUID,
                                     @"os_versions" :  [UserManage sharedDefaultManager].os_versions,
                                     @"app_installtime" : [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000],
                                     @"channel_name" : @"appStore",
                                     @"client_id" : @"bt_app_ios",
                                     @"client_secret" : @"9c1e6634ce1c5098e056628cd66a17a5",
                                     @"oauth_token" : @"12b8de8816a3e7e2f9f10c6072384d55",
                                     @"page" : @"0",
                                     @"pagesize" : @"20",
                                     @"screensize" : @"1242",
                                     @"track_user_id" : @"1802503",
                                     @"v" : @"10",
                                     };
        
    }] onet_executeNetRequestComplete:^(RecommendModel *response) {
        if ([response isSuccess]) {
            successblock(response);
        } else {
            failblock(response);
        }
    }];
}

/**
 *  通过网络数据获取序列号模型
 *
 *  @param extend
 *  @param successblock 成功回调的Block
 *  @param failblock    失败回调的Block
 */
+ (void)onet_initSelfandnetWithExtend:(NSString *)extend
                             Complete:(void(^)(NSArray<Topic *> *topic))successblock
                              andFail:(void(^)(BaseModel *model))failblock {
    
    
    
    [[BaseNetWork onet_initSelfandRequestParameter:^(RequestParameter **requestmodel, BaseNetWork *net) {
        (*requestmodel).method = NetWorkRequestPOST;
        (*requestmodel).model = [RecommendModel class];
        (*requestmodel).function = @"topic/list";
        (*requestmodel).paradict = @{
                                     @"app_versions" :  [UserManage sharedDefaultManager].app_versions,
                                     @"track_device_info" :  [UserManage sharedDefaultManager].device_versions,
                                     @"track_deviceid" :  [UserManage sharedDefaultManager].device_UUID,
                                     @"os_versions" :  [UserManage sharedDefaultManager].os_versions,
                                     @"track_user_id" : @"1802503",
                                     @"app_installtime" : [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000],
                                     @"channel_name" : @"appStore",
                                     @"client_id" : @"bt_app_ios",
                                     @"client_secret" : @"9c1e6634ce1c5098e056628cd66a17a5",
                                     @"oauth_token" : @"12b8de8816a3e7e2f9f10c6072384d55",
                                     @"page" : @"0",
                                     @"pagesize" : @"20",
                                     @"screensize" : @"1242",
                                     @"v" : @"10",
                                     @"scene" : extend,
                                     };
        
    }] onet_executeNetRequestComplete:^(RecommendModel *response) {
        if ([response isSuccess]) {
            successblock(response.data.topic);
        } else {
            failblock(response);
        }
    }];
}


@end


@implementation Data

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"category_element" : [Category_Element class], @"firstpage_element" : [Firstpage_Element class], @"banner_bottom_element" : [Banner_Bottom_Element class], @"topic" : [Topic class], @"banner" : [Banner class]};
}

@end


@implementation Append_Extend
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation Category_Element
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation Firstpage_Element
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation Banner_Bottom_Element
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation Topic
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation Banner
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


