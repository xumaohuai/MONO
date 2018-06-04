//
//  JKRouterExtension.h
//  JKRouter
//
//  Created by JackLee on 2017/12/16.
//

#import <Foundation/Foundation.h>
#import "UIViewController+JKRouter.h"

@class RouterOptions;
@interface JKRouterExtension : NSObject

/**
 对传入的URL进行安全性校验，防止恶意攻击
 
 @param url 传入的url字符串
 @return 通过验证与否的状态
 */
+ (BOOL)safeValidateURL:(NSString *)url;

/**
 配置web容器从外部获取url的property的字段名
 
 @return property的字段名
 */
+ (NSString *)jkWebURLKey;

/**
 配置webVC的className，使用的时候可以通过category重写方法配置

 @return webVC的className
 */
+ (NSString *)jkWebVCClassName;

/**
 app支持的url协议组成的数组

 @return 协议的数组
 */
+ (NSArray *)urlSchemes;

/**
 模块的类型名字的可以，用来解析模块的类型

 @return key
 */
+ (NSString *)jkModuleTypeKey;

/**
 沙盒基础路径，该目录下用于保存后台下发的路由配置信息，以及h5模块文件

 @return 基础路径
 */
+ (NSString *)sandBoxBasePath;


/**
 用来解析moduleID的key

 @return key default is @"jkModuleID"
 */
+ (NSString *)JKRouterModuleIDKey;


/**
 在url参数后设置 JKRouterHttpOpenStyleKey=1 时通过appweb容器打开网页，其余情况通过safari打开网页

 @return key default is @"jkRouterAppOpen"
 */
+ (NSString *)JKRouterHttpOpenStyleKey;

/**
 除了路由跳转以外的操作
 @param actionType 操作的类型
 @param url url
 @param extra 额外传入的参数
 @param completeBlock 操作成功后的回调
 
 */
+ (void)otherActionsWithActionType:(NSString *)actionType URL:(NSURL *)url extra:(NSDictionary *)extra complete:(void(^)(id result,NSError *error))completeBlock;

/**
 进行tab切换，如果用户使用了自定义的tabBar，可以考虑重写该方法
 
 @param vcClassName VC的类名
 @param options 打开页面的各种配置

 */
+ (void)jkSwitchTabWithVC:(NSString *)vcClassName options:(RouterOptions *)options;

@end
