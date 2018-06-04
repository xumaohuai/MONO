//
//  DiscoverVM.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/30.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "DiscoverVM.h"
#import "DiscoverNetWork.h"
#import "DiscoverBannerHeaderView.h"
#import "DiscoverModel.h"
@interface DiscoverVM()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) DiscoverBannerHeaderView *bannerView;
@end

@implementation DiscoverVM
-(void)bindViewToViewModel:(UIView *)view
{
    self.tableView = (UITableView *)view;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self requestRecommendInfo];
    [self setupView];
}

-(void)setupView
{
    _bannerView = [[DiscoverBannerHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.tableView.tableHeaderView = _bannerView;
}
-(void)requestRecommendInfo{
    @weakify(self)
    _discoverCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        RACSignal *requstSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [DiscoverNetWork getDiscoverDataWithPage:1 loadCache:YES Success:^(id responseObj) {
                [subscriber sendNext:responseObj];
                [subscriber sendCompleted];
            } Failed:^{
                [subscriber sendError:nil];
                [subscriber sendCompleted];
            }];
            return nil;
             }];
        return [requstSignal map:^id(NSDictionary *value) {
            NSDictionary *bannerDic = value[@"top_banner"];
            DiscoverModel *model = [DiscoverModel yy_modelWithJSON:bannerDic];
            self.bannerView.model = model;
            NSArray *modelArr = [NSArray array];
            return modelArr;
        }];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
