//
//  RecommendTypeVC.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendTypeVC.h"
#import "MNNetworkTool.h"
#import "RecommendVM.h"
#import "MNRefreshFooter.h"
#import "MNRefreshBlackHeader.h"

@interface RecommendTypeVC ()
@property(nonatomic,strong) MNRefreshFooter *refreshFooter;
@property(nonatomic,strong) MNRefreshBlackHeader *refreshHeader;
@property(nonatomic,strong) RecommendVM *vm;

@end

@implementation RecommendTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRefreshView];
   [self showPageLoadingProgress];
   
    [self.refreshHeader beginRefreshing];
//    [self showPageLoadingFailedWithReloadTarget:self action:@selector(loadData)];
}
#pragma mark - 配置刷新控件
-(void)setRefreshView{
    _vm = [RecommendVM new];
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
    if(!self.vm.dataArray.count){
         [self showPageLoadingProgress];
    }
    @weakify(self)
    [[self.vm.recommendCommand execute:[NSNumber numberWithInteger:self.page]]subscribeNext:^(id x) {
        @strongify(self)
        [self endPageLoadingProgress];
        [self.refreshFooter endRefreshing];
        [self.refreshHeader endRefreshing];
    }error:^(NSError *error) {
        if(!self.vm.dataArray.count){
        [self showPageLoadingFailedWithReloadTarget:self action:@selector(loadData)];
        }
        [self.refreshFooter endRefreshing];
        [self.refreshHeader endRefreshing];
    }];
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
