//
//  RecommendImageBgCell.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/29.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseTableViewCell.h"
@class RecommendModel;
@interface RecommendImageBgCell : MNBaseTableViewCell
@property(nonatomic,strong) RecommendModel *recommendModel;
-(void)shineText;
@end
