//
//  RecommendNetWork.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/21.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendNetWork.h"

@implementation RecommendNetWork

+(void)getRecommendDataWithRecommendType:(RecommendType)recommendType WithPage:(NSInteger)page loadCache:(BOOL)loadCache Success:(SuccessBlock)success Failed:(FailedBlock)failed
{
    NSString *url = @"";
    switch (recommendType) {
        case RecommendTypeTea:
            url = [NSString stringWithFormat:@"tea/2019-01-13/full/"];
            break;
        case RecommendTypeAttention:
            url = [NSString stringWithFormat:@"recommendation/?start=%ld",page];
            break;
        case RecommendTypeLike:
            url = [NSString stringWithFormat:@"recommendation/?start=%ld",page];
            break;
        case RecommendTypeVideo:
            url = [NSString stringWithFormat:@"tab/?start=%zd%%2C10&tab_id=7&tab_type=3",page];
            break;
        case RecommendTypeMusic:
            url = [NSString stringWithFormat:@"tab/?start=%zd%%2C10&tab_id=8&tab_type=3",page];
            break;
        case RecommendTypePicture:
            url = [NSString stringWithFormat:@"tab/?start=%zd%%2C10&tab_id=9&tab_type=3",page];
            break;
        default:
            break;
    }
    MNNetSet *set = [[MNNetSet alloc]init];
    set.readCache = loadCache;
    if(page == 1) {set.saveCache = YES;};
    [[MNNetworkTool shareService]requstWithUrl:url Param:nil MNNetSet:set Success:^(id responseObj) {
        success(responseObj);
    } Failed:^{
        failed();
    }];
}
@end
