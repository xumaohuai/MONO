//
//  RecommendVM.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/20.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseModel.h"
@class RecommendModel;
@interface RecommendVM : MNBaseModel
@property (nonatomic,strong,readonly) RACCommand *recommendCommand;
- (void)bindViewToViewModel:(UIView *)view;
@property(nonatomic,strong) NSMutableArray<RecommendModel *> *dataArray;
@end
