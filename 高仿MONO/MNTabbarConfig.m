//
//  MNTabbarController.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNTabbarConfig.h"
#import "RecommendVC.h"
#import "DiscoverVC.h"
#import "CommunityVC.h"
#import "MineVC.h"
#import "MNNavigationController.h"
#import <CYLTabBarController.h>
#define CYL_DEPRECATED(explain) __attribute__((deprecated(explain)))
#define CYL_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define CYL_IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)
#define CYL_IS_IPHONE_X (CYL_IS_IOS_11 && CYL_IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 812))
@interface MNTabbarConfig ()

@end

@implementation MNTabbarConfig


-(CYLTabBarController *)tabbarController{
    if (!_tabbarController) {
    RecommendVC *firstViewController = [[RecommendVC alloc] init];
    UIViewController *firstNavigationController = [[MNNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    DiscoverVC *secondViewController = [[DiscoverVC alloc] init];
    UIViewController *secondNavigationController = [[MNNavigationController alloc]
                                                   initWithRootViewController:secondViewController];
    CommunityVC *thirdViewController = [[CommunityVC alloc] init];
    UIViewController *thirdNavigationController = [[MNNavigationController alloc]
                                                    initWithRootViewController:thirdViewController];
    MineVC *fourthViewController = [[MineVC alloc] init];
    UIViewController *fourthNavigationController = [[MNNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    NSArray *controllers = @[firstNavigationController,secondNavigationController,thirdNavigationController,fourthNavigationController];
        CYLTabBarController *tabbarController = [[CYLTabBarController alloc]initWithViewControllers:controllers tabBarItemsAttributes:[self customizeTabBarForController] imageInsets:UIEdgeInsetsMake(0, 0, -10, 0) titlePositionAdjustment:UIOffsetMake(0, MAXFLOAT)];
    [self customizeTabBarAppearance:tabbarController];
        _tabbarController = tabbarController;
    }
    return _tabbarController;
}

- (NSArray *)customizeTabBarForController {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"",
                            CYLTabBarItemImage : @"tab-recommend",
                            CYLTabBarItemSelectedImage : @"tab-recommend-active",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"",
                            CYLTabBarItemImage : @"tab-explore",
                            CYLTabBarItemSelectedImage : @"tab-explore-active",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"",
                            CYLTabBarItemImage : @"tab-social",
                            CYLTabBarItemSelectedImage : @"tab-social-active",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"",
                            CYLTabBarItemImage : @"tab-mine",
                            CYLTabBarItemSelectedImage : @"tab-mine-active",
                            };
    
    return  @[ dict1, dict2,dict3,dict4 ];
    
}
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 83 : 49;
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setShadowImage:[UIImage new]];
    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tab_bg"]];
    [tabBarController hideTabBadgeBackgroundSeparator];
}




@end
