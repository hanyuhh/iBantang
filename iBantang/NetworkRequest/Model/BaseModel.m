//
//  BaseModel.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/25.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (BOOL)isSuccess {
    return self.status == 0 ? NO : YES;
}

@end


