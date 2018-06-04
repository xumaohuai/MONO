//
//  NSMutableArray+JKDataHelper.m
//  Pods
//
//  Created by Jack on 17/3/28.
//
//

#import "NSMutableArray+JKDataHelper.h"
#import "NSObject+JK.h"

@implementation NSMutableArray (JKDataHelper)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class targetClass = NSClassFromString(@"__NSArrayM");
        [self JKswizzleMethod:@selector(objectAtIndex:) withMethod:@selector(JKsafeObjectAtIndex:) withClass:targetClass];
        [self JKswizzleMethod:@selector(addObject:) withMethod:@selector(JKsafeAddObject:) withClass:targetClass];
        [self JKswizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(JKsafeInsertObject:atIndex:) withClass:targetClass];
        [self JKswizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(JKsafeRemoveObjectAtIndex:) withClass:targetClass];
       [self JKswizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(JKsafeReplaceObjectAtIndex:withObject:) withClass:targetClass];
    });
}

- (id)JKsafeObjectAtIndex:(NSInteger)index{
    if (index >=0 && index < self.count) {
        return [self JKsafeObjectAtIndex:index];
    }else{
        JKDataHelperLog(@"[__NSArrayM objectAtIndex:]  index is greater than the mutableArray.count or the index is less than zero");
        return nil;
    }
}

- (void)JKsafeAddObject:(id)object{
    if (object) {
        [self JKsafeAddObject:object];
    }else{
        JKDataHelperLog(@"[__NSArrayM addObject:] object will be added can't be nil");
    }
}

- (void)JKsafeInsertObject:(id)anObject atIndex:(NSUInteger)index{
    if (index <= self.count) {
        if (anObject) {
            [self JKsafeInsertObject:anObject atIndex:index];
        }else{
            JKDataHelperLog(@"[__NSArrayM insertObject:atIndex:] object can't be nil");
        }
    }else{
    JKDataHelperLog(@"the  index is greater than the mutableArray.count or the index is less than zero");
    }
}

- (void)JKsafeRemoveObjectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        [self JKsafeRemoveObjectAtIndex:index];
    }else{
        JKDataHelperLog(@"the  index is greater than the mutableArray.count or the index is less than zero");
    }
}

- (void)JKsafeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (index < self.count) {
        if (anObject) {
            [self JKsafeReplaceObjectAtIndex:index withObject:anObject];
        }else{
            JKDataHelperLog(@"[__NSArrayM replaceObjectAtIndex:withObject:]: object cannot be nil'");
        }
    }else{
        JKDataHelperLog(@"the  index is greater than the mutableArray.count or the index is less than zero");
    }
}

@end
