//
//  UIViewController+JKRouter.h
//  
//
//  Created by jack on 17/1/20.
//  Copyright © 2017年 localadmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKRouterHeader.h"
@class RouterOptions;
@interface UIViewController (JKRouter)

//每个VC 所属的moduleID，默认为nil
@property (nonatomic,copy) NSString *moduleID;

/**
 初始化viewController对象，可以重写该方法的实现，进行viewController的初始化。默认返回不为空

 @return 初始化后的viewController对象
 */
+ (instancetype)jkRouterViewController;

/**
 初始化viewController对象，默认返回为空，可以重写该方法实现初始化。赋值操作可以通过YYModel，或者别的工具类在内部实现。该方法主要用于h5和native交互跳转时，需要传输大量参数赋值时调用，或者后台接口返回的数据实现页面跳转时使用。

 @param dic json对象。纯数据的，内部不含OC对象
 @return 初始化后，赋值完成的viewController对象
 */
+ (instancetype)jkRouterViewControllerWithJSON:(NSDictionary *)dic;

/**
 根据权限等级判断是否可以打开，具体通过category重载来实现
 
 @return 是否进行正常的跳转
 */
+ (BOOL)validateTheAccessToOpenWithOptions:(RouterOptions *)options;

/**
 处理没有权限去打开的情况
 */
+ (void)handleNoAccessToOpenWithOptions:(RouterOptions *)options;

/**
 用户自定义转场动画
 
 @param naVC 根部导航栏
 */
- (void)jkRouterSpecialTransformWithNaVC:(UINavigationController *)naVC;

/**
 自定义的转场方式

 @return 转场方式
 */
- (RouterTransformVCStyle)jkRouterTransformStyle;

/**
 刷新数据
 */
- (void)jkRouterRefresh;

/**
 是否是tabbarItem的对应的viewController
defalut is NO
 @return YES or NO
 */
+ (BOOL)jkIsTabBarItemVC;

/**
 tab的index值
 
 @return index值 default is 0
 */
+ (NSInteger)jkTabIndex;


@end
