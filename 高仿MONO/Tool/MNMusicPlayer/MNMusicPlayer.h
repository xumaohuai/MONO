//
//  MNMusicPlayer.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/14.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "FSAudioStream.h"
@class RecommendModel;
typedef NS_ENUM(NSInteger,MNLoopState){
    MNOnceLoop = 0,//列表顺序播放
    MNSingleLoop,//单曲循环
    MNRandomLoop//随机播放
};
@interface MNMusicPlayer : FSAudioStream

/**
 是否是暂停状态
 */
@property (nonatomic,assign) BOOL isPause;

//默认 列表顺序播放 MNOnceLoop
@property (nonatomic,assign) MNLoopState loopState;
/**
 *
 单例播放器
 *
 **/
+ (instancetype)defaultPlayer;

/**
 更新播放进度
 */
-(void)updateProgress;
@end
