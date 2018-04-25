//
//  RecommendModel.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/20.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel
+(NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user":[User class],@"category":[Sort class]};
}

@end
