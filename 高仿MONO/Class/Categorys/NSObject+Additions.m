//
//  NSObject+Additions.m
//  FamiliarStranger
//
//  Created by admin on 15/12/22.
//
//

#import "NSObject+Additions.h"

@implementation NSObject (Additions)

-(BOOL)isNull
{
    if (!self) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    return NO;
}

-(id)expectedObject
{
    if (!self) {
        return nil;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return self;
}

-(id)expectedString {
    if ([self isKindOfClass:[NSString class]]) {
        return self;
    }
    
    return @"";
}

-(id)expectedArray
{
    
    if ([self isKindOfClass:[NSArray class]]) {
        return self;
    }

    return @[];
}

-(id)expectedDictionary
{
    if ([self isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    
    return @{};
}

-(int)expectedInt
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)self intValue];
    }
    return 0;
}

-(NSInteger)expectedInteger
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)self integerValue];
    }
    return 0;
}

-(long long)expectedLonglong
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)self longLongValue];
    }
    return 0;
}


-(BOOL)expectedBool
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)self boolValue];
    }
    return NO;
}

-(float)expectedFloat
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)self floatValue];
    }
    return 0.0;
}

-(double)expectedDouble
{
    if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)self doubleValue];
    }
    return 0.0;
}

@end
