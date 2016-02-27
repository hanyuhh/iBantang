//
//  SquareModel.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/19.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "SquareModel.h"

@implementation SquareModel

/**
 *  通过网络数据获取序列号模型
 *
 *  @param successblock 成功回调的Block
 *  @param failblock    失败回调的Block
 */
+ (void)onet_initSelfandnetComplete:(void(^)(SquareModel *model))successblock andFail:(void(^)(BaseModel *model))failblock {
    
    [[BaseNetWork onet_initSelfandRequestParameter:^(RequestParameter **requestmodel, BaseNetWork *net) {
        (*requestmodel).method = NetWorkRequestPOST;
        (*requestmodel).model = [SquareModel class];
        (*requestmodel).function = @"community/post/communityHome";
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
                                     @"screensize" : @"1242",
                                     @"v" : @"10"
                                     };
    }] onet_executeNetRequestComplete:^(SquareModel *response) {
        if ([response isSuccess]) {
            successblock(response);
        } else {
            failblock(response);
        }
    }];
}

@end
@implementation SquareData

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"module_elements" : [Module_Elements class], @"rec_groups" : [Rec_Groups class]};
}
@end


@implementation Module_Elements

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"elements" : [SquareElements class]};
}
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation SquareElements
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation Rec_Groups
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation SquareDynamic
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


@implementation SquareAuthor
+ (NSDictionary *)modelCustomPropertyMapper { return @{ @"ID" : @[@"id"]}; }
@end


