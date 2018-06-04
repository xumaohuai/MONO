//
//  JKJSONHandler.m
//  Pods
//
//  Created by Jack on 17/3/17.
//
//

#import "JKJSONHandler.h"

@implementation JKJSONHandler
// 解析JSON文件 获取到所有的Modules
+ (NSArray *)getModulesFromJsonFile:(NSArray <NSString *>*)files {
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (NSString *fileName in files) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *modules = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [mutableArray addObjectsFromArray:modules];
    }
    return [mutableArray copy];
}

+ (NSString *)getHomePathWithModuleID:(NSString *)moduleID{
    return @"";
}

+ (NSString *)getTypeWithModuleID:(NSString *)moduleID{
    return @"";
}

@end
