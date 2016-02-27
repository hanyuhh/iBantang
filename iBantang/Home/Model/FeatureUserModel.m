//
//  FeatureUserModel.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/15.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "FeatureUserModel.h"

@implementation FeatureUserModel

@end@implementation FeatureUserData

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"list" : [List class]};
}

@end


@implementation List

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"pics" : [Pics class], @"tags" : [Tags class], @"product" : [Product class], @"comments" : [Comments class]};
}

@end


@implementation Dynamic

@end


@implementation Author

@end


@implementation Pics

@end


@implementation Tags

@end


@implementation Product

@end


@implementation Comments

@end


@implementation c_Product

@end


@implementation At_User

@end


