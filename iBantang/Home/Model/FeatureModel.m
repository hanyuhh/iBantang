//
//  FeatureModel.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/15.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "FeatureModel.h"

@implementation FeatureModel


/**
 *  通过网络数据获取序列号模型
 *
 *  @param ID           详情ID
 *  @param successblock 成功回调的Block
 *  @param failblock    失败回调的Block
 */
+ (void)onet_initWithID:(NSString *)ID Complete:(void(^)(FeatureModel *model))successblock andFail:(void(^)(BaseModel *model))failblock {
    
    [[BaseNetWork onet_initSelfandRequestParameter:^(RequestParameter **requestmodel, BaseNetWork *net) {
        (*requestmodel).method = NetWorkRequestPOST;
        (*requestmodel).model = [FeatureModel class];
        (*requestmodel).function = @"topic/newInfo";
        (*requestmodel).paradict = @{
                                     @"id" : ID,
                                     @"statistics_uv" : @"0",
                                     @"app_versions" :  [UserManage sharedDefaultManager].app_versions,
                                     @"track_device_info" :  [UserManage sharedDefaultManager].device_versions,
                                     @"track_deviceid" :  [UserManage sharedDefaultManager].device_UUID,
                                     @"os_versions" :  [UserManage sharedDefaultManager].os_versions,
                                     @"app_installtime" : [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000],
                                     @"channel_name" : @"appStore",
                                     @"client_id" : @"bt_app_ios",
                                     @"client_secret" : @"9c1e6634ce1c5098e056628cd66a17a5",
                                     @"oauth_token" : @"12b8de8816a3e7e2f9f10c6072384d55",
                                     @"screensize" : @"1242",
                                     @"track_user_id" : @"1802503",
                                     @"v" : @"10"
                                     };
        
    }] onet_executeNetRequestComplete:^(FeatureModel *response) {
        if ([response isSuccess]) {
            successblock(response);
        } else {
            failblock(response);
        }
    }];
}

@end

@implementation FeatureData

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"product" : [FeatureProduct class]};
}

@end


@implementation Activity

@end


@implementation FeatureProduct

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"pic" : [Pic class], @"likes_list" : [Likes_List class]};
}

@end


@implementation Pic

@end


@implementation Likes_List

@end


