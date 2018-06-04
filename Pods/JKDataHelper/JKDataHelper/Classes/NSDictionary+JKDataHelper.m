//
//  NSDictionary+JKDataHelper.m
//  Pods
//
//  Created by Jack on 17/3/28.
//
//

#import "NSDictionary+JKDataHelper.h"
#import "NSObject+JK.h"
#import <objc/message.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wobjc-protocol-method-implementation"

@interface NSDictionary()

+ (instancetype)JKsafedictionaryWithObjectsAndKeys:(id)firstObject, ...;

@end

@implementation NSDictionary (JKDataHelper)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class targetClass = NSClassFromString(@"__NSDictionaryI");
        [self JKswizzleMethod:@selector(dictionaryWithObject:forKey:) withMethod:@selector(JKsafeDictionaryWithObject:forKey:) withClass:targetClass];
        [self JKswizzleMethod:@selector(dictionaryWithObjectsAndKeys:) withMethod:@selector(JKsafedictionaryWithObjectsAndKeys:) withClass:targetClass];
        [self JKswizzleMethod:@selector(dictionaryWithObjects:forKeys:) withMethod:@selector(JKsafeDictionaryWithObjects:forKeys:) withClass:targetClass];
        [self JKswizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(JKsafeinitWithObjects:forKeys:count:) withClass:NSClassFromString(@"__NSPlaceholderDictionary")];
    });
}


- (BOOL)jk_hasKey:(NSString *)key
{
    return [self objectForKey:key] != nil;
}

- (NSString*)jk_stringForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([[value description] isEqualToString:@"(null)"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}

- (NSNumber*)jk_numberForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)jk_decimalNumberForKey:(id)key {
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}


- (NSArray*)jk_arrayForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}

- (NSDictionary*)jk_dictionaryForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)jk_integerForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)jk_unsignedIntegerForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)jk_boolForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)jk_int16ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)jk_int32ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)jk_int64ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}
- (char)jk_charForKey:(id)key{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}
- (short)jk_shortForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)jk_floatForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)jk_doubleForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}
- (long long)jk_longLongForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)jk_unsignedLongLongForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

- (NSDate *)jk_dateForKey:(id)key dateFormat:(NSString *)dateFormat{
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}


//CG
- (CGFloat)jk_CGFloatForKey:(id)key
{
    CGFloat f = [self[key] doubleValue];
    return f;
}

- (CGPoint)jk_pointForKey:(id)key
{
    CGPoint point = CGPointFromString(self[key]);
    return point;
}
- (CGSize)jk_sizeForKey:(id)key
{
    CGSize size = CGSizeFromString(self[key]);
    return size;
}
- (CGRect)jk_rectForKey:(id)key
{
    CGRect rect = CGRectFromString(self[key]);
    return rect;
}


+ (instancetype)JKsafeDictionaryWithObject:(id)object forKey:(id <NSCopying>)key{
    if (object) {
        if (key) {
            return [self JKsafeDictionaryWithObject:object forKey:key];
        }else{
            JKDataHelperLog(@"[__NSDictionaryI dictionaryWithObject:forKey:] key can't be nil");
            return nil;
        }
    }else{
        JKDataHelperLog(@"[__NSDictionaryI dictionaryWithObject:forKey:] object can't be nil");
        return nil;
    }
}

+ (instancetype)JKsafedictionaryWithObjectsAndKeys:(id)firstObject, ...{
    NSMutableArray *objects =[NSMutableArray new];
    va_list list;
    va_start(list, firstObject);
    [objects addObject:firstObject];
    id arg = nil;
    while ((arg = va_arg(list, id))) {
        [objects addObject:arg];
    }
    va_end(list);
    if (objects.count%2 != 0) {
        JKDataHelperLog(@"[__NSDictionaryI dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil");
        return nil;
    }    
    id value = nil;
    id key = nil;
    NSMutableArray *values = [NSMutableArray new];
    NSMutableArray *keys = [NSMutableArray new];
    for (NSInteger i =0; i<objects.count; i++) {
        if (i%2==0) {
            value =objects[i];
            [values addObject:value];
        }else{
            key =objects[i];
            [keys addObject:key];
        }
    }
        return [self dictionaryWithObjects:[values copy] forKeys:[keys copy]];
}

+ (instancetype)JKsafeDictionaryWithObjects:(NSArray<id> *)objects forKeys:(NSArray<id <NSCopying>> *)keys{
    if ((objects && [objects isKindOfClass:[NSArray class]]) && (keys &&[keys isKindOfClass:[NSArray class]]) &&(objects.count ==keys.count)) {
        return [self JKsafeDictionaryWithObjects:objects forKeys:keys];
    }else{
        JKDataHelperLog(@"[__NSdictionaryI dictionaryWithObjects:forKeys:] please check you objects and keys");
        return nil;
    }
}

- (instancetype)JKsafeinitWithObjects:(int **)objects forKeys:(int **)keys count:(NSInteger)count{
    for (int i =0; i<count; i++) {
        if (!objects[i] || !keys[i]) {
            JKDataHelperLog(@"%@", [NSString stringWithFormat:@"[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil to objects[%d]",i]);
            return nil;
        }
    }
    return [self JKsafeinitWithObjects:objects forKeys:keys count:count];
}

@end

#pragma clang diagnostic pop
