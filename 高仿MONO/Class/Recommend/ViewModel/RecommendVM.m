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
                if (data.count == 3) {
                    data = data.firstObject;
                }
                modelArr = [[data.rac_sequence map:^id(id modelValue) {
                return [RecommendModel yy_modelWithJSON:[modelValue objectForKey:@"meow"]];
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
    RecommendModel *model = _dataArray[indexPath.row];//获取model
    //MNBaseTableViewCell为所有cell的父类
    MNBaseTableViewCell *cell;
    NSString *cellIdentifier;
    //后台会根据内容的不同给出不同的object_type,根据这个来设置不同cell的identifier.
    cellIdentifier = model.cellIdentifier;
    //因为给每个cell注册过了,所以这里拿到identifier就可以找到具体的cell
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    //这里用kvc给cell赋值
    [cell setValue:_dataArray[indexPath.row] forKey:@"recommendModel"];
    return cell;
}
//cell将要被加载
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //判断是否是需要闪烁文字的cell
    if ([cell isKindOfClass:[RecommendImageBgCell class]]) {
        RecommendImageBgCell *bgCell = (RecommendImageBgCell *)cell;
        _bgCell = bgCell;
        //如果tableview刚刷新出来,这个cell就在界面上的话就执行闪烁方法
        if (tableView.contentOffset.y <= 0 && bgCell.y <= 0) {
            [_bgCell shineText];
            return;
        }
        //给一个全局变量来监视cell滑动情况
        _bgCellY = bgCell.y;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当cell滑动到一定位置的时候就闪烁
    if ((_bgCellY - scrollView.contentOffset.y <= (SCREEN_HEIGHT / 4 + KTabBarHeight)) && _bgCellY > 0) {
        [_bgCell shineText];
        _bgCellY = -10;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendModel *model = self.dataArray[indexPath.row];
    NSDictionary *params = @{@"recommendModel":model};
    RouterOptions *options = [RouterOptions optionsWithDefaultParams:params];
     [JKRouter open:@"MNWebViewController" options:options];
}

@end
