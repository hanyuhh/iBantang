//
//  UserManage.m
//  s
//
//  Created by chenuex.lee on 15/10/15.
//  Copyright © 2015年 cloudtopCompany. All rights reserved.
//

#import "UserManage.h"
#import "sys/sysctl.h"

@interface UserManage() {

}

@end

@implementation UserManage

static UserManage  *sharesingleton = nil;//必须声明为一个静态方法

#pragma mark Singleton Methods
+ (instancetype)sharedDefaultManager{
    
    @synchronized(self){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{

            sharesingleton = [[self alloc] init];
            [UserManage getLocalInfo:sharesingleton];
        });
        
        return sharesingleton;
    }
}

//限制方法，类只能初始化一次
//alloc的时候调用
+ (id) allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if(sharesingleton == nil){
            sharesingleton = [super allocWithZone:zone];
        }
    });
    return sharesingleton;
}

//拷贝方法
- (id)copyWithZone:(NSZone *)zone{
    return sharesingleton;
}

#pragma mark - 对沙盒数据进行存取
/**
 *  通过keyName（fileName），将数据从沙盒中取出
 *
 *  @param fileName key， 存储文件时候的名字
 *
 *  @return 取出的数据
 */
- (NSMutableArray *) dataSourceFromSandboxWithFilename:(NSString *)fileName {
    
    //Create 存储list的Array
    NSMutableArray *dataSource = nil;
    
    //Get plist file path
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; //bin
    NSString *plist = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];//userinfo.plist //file name
    
    //把plist文件中的数据读取到data中
    NSData *data = [[NSData alloc] initWithContentsOfFile:plist];
    //Create 解码器
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //调用解码方法,获得存储的对象
    dataSource = (NSMutableArray *)[unarchiver decodeObjectForKey:fileName];
    //finish 解码
    [unarchiver finishDecoding];
    
    return dataSource;
}

/**
 *  通过keyName（fileName），将数据存到沙盒中
 *
 *  @param dataSource 数据源，需要存储的数据
 *  @param fileName   通过key（fileName）存入沙盒中
 *
 *  @return YES -> success NO -> failure
 */
- (BOOL)dataSourceStoreSandboxWithFilename:(NSMutableArray *) dataSource withFilename:(NSString *)fileName {
    
    //Get plist file path
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    
    //Create 空的 Data
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    //Create 编码器
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //调用编码方法
    [archiver encodeObject:dataSource forKey:fileName];
    //Finish编码
    [archiver finishEncoding];
    //Write to plist file
    if ( [data writeToFile:plistPath atomically:YES]) {
        return YES;
    } else {
        return NO;
    }
}
/**
 *  设置Load默认的一些信息
 */
+ (void)getLocalInfo:(UserManage *)manage {

    //手机型号
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    
    //版本信息
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    manage.app_versions = [info objectForKey:@"CFBundleShortVersionString"];
    manage.app_bundleversions = [info objectForKey:@"CFBundleVersion"];
    manage.device_versions = platform;
    manage.device_UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    manage.os_versions = [[UIDevice currentDevice] systemVersion];
}


@end
