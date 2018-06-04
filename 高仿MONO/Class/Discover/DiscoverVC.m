//
//  DiscoverVC.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "DiscoverVC.h"
#import "MNRefreshFooter.h"
#import "MNRefreshBlackHeader.h"
#import "DiscoverVM.h"
@interface DiscoverVC ()
@property(nonatomic,strong) MNRefreshFooter *refreshFooter;
@property(nonatomic,strong) MNRefreshBlackHeader *refreshHeader;
@property(nonatomic,strong) DiscoverVM *vm;
@end

@implementation DiscoverVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.14 alpha:1];
    [self setRefreshView];
    [self showPageLoadingProgress];
    
    [self.refreshHeader beginRefreshing];
}
#pragma mark - 配置刷新控件
-(void)setRefreshView{
    _vm = [DiscoverVM new];
//    _vm.recommendType = _recommendType;
    [_vm bindViewToViewModel:self.tableView];
    WEAKSELF
    _refreshHeader = [MNRefreshBlackHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadData];
    }];
    self.tableView.mj_header = _refreshHeader;
    _refreshFooter = [MNRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = _refreshFooter;
}
-(void)loadData
{
//    if(!self.vm.dataArray.count){
//        [self showPageLoadingProgress];
//    }
    @weakify(self)
    [[self.vm.discoverCommand execute:[NSNumber numberWithInteger:self.page]]subscribeNext:^(id x) {
        @strongify(self)
        [self endPageLoadingProgress];
        [self.refreshFooter endRefreshing];
        [self.refreshHeader endRefreshing];
    }error:^(NSError *error) {
//        if(!self.vm.dataArray.count){
//            [self showPageLoadingFailedWithReloadTarget:self action:@selector(loadData)];
//        }
        [self.refreshFooter endRefreshing];
        [self.refreshHeader endRefreshing];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
