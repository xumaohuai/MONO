//
//  JKRouterHeader.h
//  JKRouter
//
//  Created by JackLee on 2017/12/11.
//

#ifndef JKRouterHeader_h
#define JKRouterHeader_h

typedef NS_ENUM(NSInteger,RouterTransformVCStyle){
    RouterTransformVCStyleDefault =-1, ///< 不指定转场方式，使用自带的转场方式
    RouterTransformVCStylePush,        ///< push方式转场
    RouterTransformVCStylePresent,     ///< present方式转场
    RouterTransformVCStyleOther        ///< 用户自定义方式转场
};///< ViewController的转场方式

typedef NS_ENUM(NSInteger,RouterCreateStyle) {
    RouterCreateStyleNew,               ///< 默认创建方式，创建一个新的ViewController对象
    RouterCreateStyleReplace,           ///< 创建一个新的ViewController对象，然后替换navigationController当前的viewController
    RouterCreateStyleRefresh           ///<  当前的viewController就是目标viewController就不创建，而是执行相关的刷新操作。如果当前的viewController不是目标viewController就执行创建操作
};///< ViewController的创建方式

typedef NS_ENUM(NSInteger, RouterWindowRootVCStyle) {
 RouterWindowRootVCStyleDefault,         ///< 默认的window的rootVC的初始化方式具体如（1）
 RouterWindowRootVCStyleCustom           ///< 常见的window的rootVC的初始化方式具体方式如(2)
};

/*
 
 (1):window的rootViewController的初始化方式：
 self.rootTabBarController = [[RootTabbarViewController alloc] init];
 
 UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController: self.rootTabBarController];
 self.window.rootViewController = naVC;
 
 或者：
 UIViewController *vc = [UIViewController new];
 UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
 self.window.rootViewController = naVC;

 ****************************************************
 (2):window的rootViewController的初始化方式：
 UIViewController *vc1 = [UIViewController new];
 UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc1];
 UIViewController *vc2 = [UIViewController new];
 UINavigationController *naVC1 = [[UINavigationController alloc] initWithRootViewController:vc2];
 UIViewController *vc3 = [UIViewController new];
 UINavigationController *naVC2 = [[UINavigationController alloc] initWithRootViewController:vc3];
 UITabBarController *tabBarVC3 = [UITabBarController new];
 tabBarVC.viewControllers = @[naVC1,naVC2,naVC3];
 self.window.rootViewController = tabBarVC.viewControllers;
 
 */

#import"UIViewController+JKRouter.h"
#import"JKRouter.h"
#import"JKJSONHandler.h"
#import"JKRouterExtension.h"

#endif /* JKRouterHeader_h */
