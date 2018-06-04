//
//  WebNavTitleView.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/29.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendModel;
typedef NS_ENUM(NSInteger,WebNavTitleStyle){
    WebNavTitleStyleWhite,//白色主题
    WebNavTitleStyleBlack//黑色主题
};
@interface WebNavTitleView : UIView
-(instancetype)initWithFrame:(CGRect)frame WebNavStyle:(WebNavTitleStyle)style;
@property(nonatomic,strong) RecommendModel *model;
@end
