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
@interface MNBaseTabbarController ()

@end

@implementation MNBaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    RecommendVC *firstViewController = [[RecommendVC alloc] init];
    MNNavigationController *firstNavigationController = [[MNNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    firstViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab-recommend"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-recommend-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    DiscoverVC *secondViewController = [[DiscoverVC alloc] init];
    MNNavigationController *secondNavigationController = [[MNNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    secondNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab-explore"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-explore-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    CommunityVC *thirdViewController = [[CommunityVC alloc] init];
    MNNavigationController *thirdNavigationController = [[MNNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    thirdNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab-social"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-social-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    MineVC *fourthViewController = [[MineVC alloc] init];
    MNNavigationController *fourthNavigationController = [[MNNavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    fourthNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab-mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-mine-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    [self setViewControllers:@[firstNavigationController,secondNavigationController,thirdNavigationController,fourthNavigationController]];
    
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
