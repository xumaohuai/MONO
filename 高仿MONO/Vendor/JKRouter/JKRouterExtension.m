//
//  JKRouterExtension.m
//  JKRouter
//
//  Created by JackLee on 2017/12/16.
//

#import "JKRouterExtension.h"

@implementation JKRouterExtension

+ (BOOL)safeValidateURL:(NSString *)url{
    //默认都是通过安全性校验的
    return YES;
}

+ (NSString *)jkWebURLKey{
    
    return @"jkurl";
}

+ (NSString *)jkWebVCClassName{
    return @"";
}

+ (NSArray *)urlSchemes{
    return @[@"http",
             @"https",
             @"file",
             @"itms-apps"];
    
}

+ (NSString *)jkModuleTypeKey{
    return @"ViewController";
}

+ (NSString *)sandBoxBasePath{
    return NSHomeDirectory();
}

+ (NSString *)JKRouterModuleIDKey{
    return @"jkModuleID";
}

+ (NSString *)JKRouterHttpOpenStyleKey{
    return @"jkRouterAppOpen";
}

+ (void)otherActionsWithActionType:(NSString *)actionType URL:(NSURL *)url extra:(NSDictionary *)extra complete:(void(^)(id result,NSError *error))completeBlock{
}

+ (void)jkSwitchTabWithVC:(NSString *)vcClassName options:(RouterOptions *)options{
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSInteger index = [NSClassFromString(vcClassName) jkTabIndex];
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)rootVC;
        if ([tabBarVC.selectedViewController isKindOfClass:[UINavigationController class]]) {
            NSArray *vcArray = tabBarVC.viewControllers;
            UINavigationController *naVC = vcArray[index];
            [naVC popToRootViewControllerAnimated:YES];
            tabBarVC.selectedIndex = index;

        }else{
            tabBarVC.selectedIndex = index;
        }
    }
}

@end
