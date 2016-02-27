//
//  UserManage.h
//  s
//
//  Created by chenuex.lee on 15/10/15.
//  Copyright © 2015年 cloudtopCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManage : NSObject <NSCopying>
/**
 *  应用版本
 */
@property(nonatomic, strong) NSString *app_versions;
/**
 *  短版本号
 */
@property(nonatomic, strong) NSString *app_bundleversions;
/**
 *  手机型号
 */
@property(nonatomic, strong) NSString *device_versions;
/**
 *  UUID
 */
@property(nonatomic, strong) NSString *device_UUID;
/**
 *  系统版本
 */
@property(nonatomic, strong) NSString *os_versions;

+ (instancetype)sharedDefaultManager;

@end
