//
//  WebThirdTitleView.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/31.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSwitch.h"
@class RecommendModel;
@interface WebThirdTitleView : UIView
@property(nonatomic,strong) RecommendModel *model;
@property(nonatomic,strong) MBSwitch *readSwith;
@end
