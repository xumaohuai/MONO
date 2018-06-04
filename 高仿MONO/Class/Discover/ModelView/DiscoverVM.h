//
//  DiscoverVM.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/30.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class RecommendModel;
@interface DiscoverVM : NSObject
- (void)bindViewToViewModel:(UIView *)view;
//@property(nonatomic,strong) NSMutableArray<RecommendModel *> *dataArray;
//@property (nonatomic,assign) RecommendType recommendType;
@property (nonatomic,strong,readonly) RACCommand *discoverCommand;
@end
