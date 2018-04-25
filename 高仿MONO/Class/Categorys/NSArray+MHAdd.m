//
//  NSArray+MHAdd.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "NSArray+MHAdd.h"

@implementation NSArray (MHAdd)
- (id)safeObjectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}
@end
