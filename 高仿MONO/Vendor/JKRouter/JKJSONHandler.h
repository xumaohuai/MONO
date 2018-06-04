//
//  JKJSONHandler.h
//  Pods
//
//  Created by Jack on 17/3/17.
//
//

#import <Foundation/Foundation.h>
#import "JKRouterHeader.h"
@interface JKJSONHandler : NSObject
// 解析JSON文件 获取到所有的Modules
+ (NSArray *)getModulesFromJsonFile:(NSArray <NSString *>*)files;

/**
 根据读取到的json文件中的内容找到对应的路径

 @param moduleID 对应的module的主页路径
 @return 对应模块的home页面路径
 */
+ (NSString *)getHomePathWithModuleID:(NSString *)moduleID;


/**
 根据moduleID获取url要跳转的type

 @param moduleID 模块的id
 @return type
 */
+ (NSString *)getTypeWithModuleID:(NSString *)moduleID;
@end
