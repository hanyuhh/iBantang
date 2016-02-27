//
//  RequestParameter.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/26.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "RequestParameter.h"

@implementation RequestParameter
/**
 *  打印所有参数
 */
- (void)printString {
    NSString *string = [self description];
    const char * ch = [string UTF8String];
    printf("参数:\n%s\n",ch);
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString new];
    if (self.paradict) {
        [string appendFormat:@"Paradict: %@\n",self.paradict];
    } else {
        [string appendFormat:@"Paradict: nil\n"];
    }
    if (self.function) {
        [string appendFormat:@"Function: %@\n",self.function];
    } else {
        [string appendFormat:@"Function: nil\n"];
    }
    switch (self.method) {
        case NetWorkRequestGET:
            [string appendFormat:@"NetWorkRequestMethod: NetWorkRequestGET\n"];
            break;
            
        case NetWorkRequestPOST:
            [string appendFormat:@"NetWorkRequestMethod: NetWorkRequestPOST\n"];
            break;
            
        case NetWorkRequestPUT:
            [string appendFormat:@"NetWorkRequestMethod: NetWorkRequestPUT\n"];
            break;
            
        case NetWorkRequestDELETE:
            [string appendFormat:@"NetWorkRequestMethod: NetWorkRequestDELETE\n"];
            break;
            
        default:
            [string appendFormat:@"NetWorkRequestMethod: NetWorkRequest\n"];
            break;
    }
    if (self.model) {
        [string appendFormat:@"RequestModel: %@\n",self.model];
    } else {
        [string appendFormat:@"RequestModel: nil\n"];
    }
    if (self.URL) {
        [string appendFormat:@"URL: %@\n",self.URL];
    } else {
        [string appendFormat:@"URL: nil\n"];
    }
    return string;
}

@end
