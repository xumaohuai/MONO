//
//  NSObject+AssociatedObject.m
//  
//
//  Created by Stephen Liu on 12-11-26.
//  Copyright (c) 2012年 Stephen. All rights reserved.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)
- (id)objectWithAssociatedKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

- (void)setObject:(id)object forAssociatedKey:(void *)key retained:(BOOL)retain
{
    objc_setAssociatedObject(self, key, object, retain?OBJC_ASSOCIATION_RETAIN_NONATOMIC:OBJC_ASSOCIATION_ASSIGN);
}
@end
