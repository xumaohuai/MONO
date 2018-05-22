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
#import "RecommendImagesCell.h"
#import "RecommendImageBgCell.h"
#import "RecommendMusicCell.h"
#import "RecommendVideoCell.h"
#import "RecommendPicturesCell.h"
#import "RecommendTeaCell.h"
@interface RecommendVM()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _bgCellY;//将要加载时的RecommendImageBgCell的Y值
    RecommendImageBgCell *_bgCell;//将要加载的RecommendImageBgCell
}
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL hasLoad;

@end

@implementation RecommendVM

-(void)bindViewToViewModel:(UIView *)view
{
    
    self.tableView = (UITableView *)view;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[RecommendImageBgCell class] forCellReuseIdentifier:NSStringFromClass([RecommendImageBgCell class])];
     [self.tableView registerClass:[RecommendReadCell class] forCellReuseIdentifier:NSStringFromClass([RecommendReadCell class])];
     [self.tableView registerClass:[RecommendImagesCell class] forCellReuseIdentifier:NSStringFromClass([RecommendImagesCell class])];
    [self.tableView registerClass:[RecommendMusicCell class] forCellReuseIdentifier:NSStringFromClass([RecommendMusicCell class])];
     [self.tableView registerClass:[RecommendVideoCell class] forCellReuseIdentifier:NSStringFromClass([RecommendVideoCell class])];
    [self.tableView registerClass:[RecommendPicturesCell class] forCellReuseIdentifier:NSStringFromClass([RecommendPicturesCell class])];
    [self.tableView registerClass:[RecommendTeaCell class] forCellReuseIdentifier:NSStringFromClass([RecommendTeaCell class])];
    _dataArray = [NSMutableArray array];
    [self requestRecommendInfo];
}

-(void)requestRecommendInfo{
    @weakify(self)
    _recommendCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        RACSignal *requstSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [RecommendNetWork getRecommendDataWithRecommendType:self.recommendType WithPage:[input integerValue] loadCache:!self.hasLoad Success:^(id responseObj) {
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
            NSArray *modelArr = [NSArray array];
            if (self.recommendType == RecommendTypeTea) {
                NSDictionary *morningDic = value[@"morning_tea"];
                NSArray *data = morningDic[@"entity_list"];
                modelArr = [[data.rac_sequence map:^id(id value) {
                    return [RecommendModel yy_modelWithJSON:[value objectForKey:@"meow"]];
                }]array];
            }else{
            NSArray *data = value[@"entity_list"];
                modelArr = [[data.rac_sequence map:^id(id value) {
                return [RecommendModel yy_modelWithJSON:[value objectForKey:@"meow"]];
            }]array];
            }
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
    RecommendModel *model = _dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"recommendModel" cellClass:NSClassFromString(model.cellIdentifier) contentViewWidth:SCREEN_WIDTH];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendModel *model = _dataArray[indexPath.row];
    MNBaseTableViewCell *cell;
    NSString *cellIdentifier;
    cellIdentifier = model.cellIdentifier;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setValue:_dataArray[indexPath.row] forKey:@"recommendModel"];
//    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[RecommendImageBgCell class]]) {
        RecommendImageBgCell *bgCell = (RecommendImageBgCell *)cell;
        _bgCell = bgCell;
        if (tableView.contentOffset.y <= 0 && bgCell.y <= 0) {
            //当第一个cell为RecommendImageBgCell时
            [_bgCell shineText];
            return;
        }
        _bgCellY = bgCell.y;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ((_bgCellY - scrollView.contentOffset.y <= (SCREEN_HEIGHT / 4 + KTabBarHeight)) && _bgCellY > 0) {
        [_bgCell shineText];
        _bgCellY = -10;
    }
}

@end
