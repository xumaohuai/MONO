//
//  RecommendNetWork.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/21.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendNetWork.h"

@implementation RecommendNetWork
+(void)getGuessLikeWithPage:(NSInteger)page loadCache:(BOOL)loadCache Success:(SuccessBlock)success Failed:(FailedBlock)failed
{
    NSString *url = [NSString stringWithFormat:@"recommendation/?init=%ld",page];
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
