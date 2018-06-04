//
//
//  Created by jack on 2016/12/2.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "JKDataHelper.h"

@implementation JKDataHelper

+ (NSArray *)safeArray:(id)array {
    if ([array isKindOfClass:[NSArray class]]) {
        return array;
    }
    return nil;
}

+ (NSMutableArray *)safeMutableArray:(id)mutableArray {
    if ([mutableArray isKindOfClass:[NSMutableArray class]]) {
        return mutableArray;
    }
    return nil;
}

+ (NSDictionary *)safeDictionary:(id)dict {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        return dict;
    }
    return nil;
}

+ (NSMutableDictionary *)safeMutableDictionary:(id)dict {
    if ([dict isKindOfClass:[NSMutableDictionary class]]) {
        return dict;
    }
    return nil;
}

+ (NSString *)safeStr:(id)str {
    if ([str isKindOfClass:[NSString class]]) {
        return str;
    }
    return nil;
}

+ (NSString *)safeStr:(id)str defaultStr:(NSString *)defaultStr {
    NSString *temp = [self safeStr:str];
    return temp ?: defaultStr;
}

+ (id)safeObj:(id)obj {
    if ([obj isKindOfClass:[NSObject class]]) {
        return obj;
    }
    return nil;
}

@end
