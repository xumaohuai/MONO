//
//  RecommendNetWork.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/21.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNNetworkTool.h"
typedef void (^SuccessBlock)(id responseObj);
typedef void (^FailedBlock)(void);
@interface RecommendNetWork : MNNetworkTool
+(void)getRecommendDataWithRecommendType:(RecommendType)recommendType
                                WithPage:(NSInteger)page
                               loadCache:(BOOL)loadCache
                                 Success:(SuccessBlock)success
                                  Failed:(FailedBlock)failed;

@end
