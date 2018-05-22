//
//  MusicCDView.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/14.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendModel;
@interface MusicCDView : UIView
//@property (nonatomic,copy) NSString *coverUrl;
@property(nonatomic,strong) RecommendModel *model;
-(void)playMusic;
-(void)stopMusic;
@end
