//
//  MNRefreshFooter.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNRefreshFooter.h"

@implementation MNRefreshFooter

-(void)prepare
{
    [super prepare];
     [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"上拉加载更多" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"上拉加载更多" forState:MJRefreshStatePulling];
     [self setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
}

@end
