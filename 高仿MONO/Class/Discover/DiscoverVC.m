//
//  DiscoverVC.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "DiscoverVC.h"

@interface DiscoverVC ()

@end

@implementation DiscoverVC


- (void)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self scrollViewDidScroll:_tableview];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
