//
//  MNBaseTabbarController.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseTabbarController.h"
#import "RecommendVC.h"
#import "DiscoverVC.h"
#import "CommunityVC.h"
#import "MineVC.h"
#import "MNNavigationController.h"
#import <UIView+Sizes.h>
#import "GGStartMovieHelper.h"

#define CYL_DEPRECATED(explain) __attribute__((deprecated(explain)))
#define CYL_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define CYL_IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)
#define CYL_IS_IPHONE_X (CYL_IS_IOS_11 && CYL_IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) == 812))
@interface MNBaseTabbarController ()

@end

@implementation MNBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RecommendVC *firstViewController = [[RecommendVC alloc] init];
    MNNavigationController *firstNavigationController = [[MNNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    firstNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.14 alpha:1];
    firstNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab-recommend"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-recommend-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    firstNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -10, 0);
    
    DiscoverVC *secondViewController = [[DiscoverVC alloc] init];
    MNNavigationController *secondNavigationController = [[MNNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    secondNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab-explore"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-explore-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    secondNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -10, 0);
    
    CommunityVC *thirdViewController = [[CommunityVC alloc] init];
    MNNavigationController *thirdNavigationController = [[MNNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    thirdNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab-social"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-social-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    thirdNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -10, 0);
    
    MineVC *fourthViewController = [[MineVC alloc] init];
    MNNavigationController *fourthNavigationController = [[MNNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    fourthNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab-mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-mine-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    fourthNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -10, 0);
    [self setTabbarApperence];
    [self setViewControllers:@[firstNavigationController,secondNavigationController,thirdNavigationController,fourthNavigationController]];
   
    
}
-(void)setTabbarApperence
{
//    self.tabBar.height = CYL_IS_IPHONE_X ? 83 : 49;
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setShadowImage:[UIImage new]];
    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tab_bg"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
