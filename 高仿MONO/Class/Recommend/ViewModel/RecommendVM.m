//
//  RecommendVM.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/20.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendVM.h"
#import "RecommendNetWork.h"
#import "RecommendModel.h"
#import "RecommendReadCell.h"
@interface RecommendVM()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL hasLoad;

@end

@implementation RecommendVM

-(void)bindViewToViewModel:(UIView *)view
{
    self.tableView = (UITableView *)view;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _dataArray = [NSMutableArray array];
    [self requestRecommendInfo];
}

-(void)requestRecommendInfo{
    @weakify(self)
    _recommendCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        RACSignal *requstSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [RecommendNetWork getGuessLikeWithPage:[input integerValue] loadCache:!self.hasLoad Success:^(id responseObj) {
                self.hasLoad = YES;
                [subscriber sendNext:responseObj];
                [subscriber sendCompleted];
            } Failed:^{
                self.hasLoad = YES;
                [subscriber sendError:nil];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        return [requstSignal map:^id(NSDictionary *value) {
            NSArray *data = value[@"entity_list"];
            NSArray *modelArr = [[data.rac_sequence map:^id(id value) {
                return [RecommendModel yy_modelWithJSON:[value objectForKey:@"meow"]];
            }]array];
            if([input integerValue] == 1){
                [self.dataArray insertObjects:modelArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, modelArr.count)]];
            }else{
            [self.dataArray addObjectsFromArray:modelArr];
            }
            [self.tableView reloadData];
            return modelArr;
        }];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 121;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendReadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[RecommendReadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.recommendModel = _dataArray[indexPath.row];
    return cell;
}

@end
