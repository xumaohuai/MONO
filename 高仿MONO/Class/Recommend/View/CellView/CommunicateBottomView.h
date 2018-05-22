//
//  RecommendCellBottomView.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/25.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CommunicateBottomType){
    CommunicateBottomTypeCellGray,   //cell上面白底灰字
    CommunicateBottomTypeCellWhite,  //只有一张大图时透明背景白字
    CommunicateBottomTypeDetailGray, //详情里面白底灰字
    CommunicateBottomTypeDetailWhite, //详情里面的黑底白字
    CommunicateBottomTypeComment    //评论区的样式
};

@class RecommendModel;
@interface CommunicateBottomView : UIView
@property(nonatomic,strong) RecommendModel *bottomModel;
-(instancetype)initWithFrame:(CGRect)frame CommunicateType:(CommunicateBottomType)communicateType;
@property(nonatomic,assign) CommunicateBottomType communicateBottomType;
@end
