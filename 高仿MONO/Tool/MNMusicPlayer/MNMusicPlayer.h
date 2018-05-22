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
 *
 播放列表
 *
 **/
@property (nonatomic,strong) NSMutableArray *musicListArray;
/**
 当前播放歌曲的歌词
 */
@property (nonatomic,strong) NSMutableArray *musicLRCArray;
/**
 *
 当前播放
 *
 **/
@property (nonatomic,assign,readonly) NSUInteger currentIndex;
/**
 *
 当前播放的音乐的标题
 *
 **/
@property (nonatomic,strong) NSString *currentTitle;
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
 播放队列中的指定的文件

 */
//- (void)playMusicWithUrl:(NSString *)urlString;
/**
 播放前一首
 */
- (void)playFont;
/**
 播放下一首
 */
- (void)playNext;

/**
 更新播放进度
 */
-(void)updateProgress;
@end
