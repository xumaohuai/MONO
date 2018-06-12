//
//  GGStartMovieView.m
//  MONO
//
//  Created by Mac on 2018/6/11.
//  Copyright © 20888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888 8iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii18年 Mr.Gao. All rights reserved.
//

#import "GGStartMovieView.h"
#import "UIImage+LaunchImage.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PushAnimationView.h"

@interface AnimationDelegate : NSObject  <CAAnimationDelegate>

@property (nonatomic, strong) AVPlayer *animationDelegatePlayer;

@end

@implementation AnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.animationDelegatePlayer play];
}

@end

@interface GGStartMovieView ()

@property (nonatomic, weak) UIButton * endButton;

@property (nonatomic, weak) AVPlayer *player;//视频播放

@property (nonatomic, weak) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) CABasicAnimation *scaleAnimation;//这东西只能强引用

@property (nonatomic, strong) AVAudioPlayer *musicPlayer;//音乐播放

@end

@implementation GGStartMovieView

+ (instancetype)movieView{
    GGStartMovieView *movieView = [[GGStartMovieView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    movieView.backgroundColor = [UIColor whiteColor];
    return movieView;
}

- (void)setMovieURL:(NSString *)movieURL{
    
    _movieURL = movieURL;
    
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = [UIScreen mainScreen].bounds;
    //这句代码有一些问题，可能会导致前后台切换，画面又出现启动页，
    backLayer.contents = (__bridge id _Nullable)[UIImage getLaunchImage].CGImage;
    [self.layer addSublayer:backLayer];
    
    AVPlayer *player = [[AVPlayer alloc] initWithURL:[[NSBundle mainBundle] URLForResource:movieURL withExtension:nil]];
    player.volume = 0;
    player.volume = 3.0f;
    self.player = player;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    playerLayer.frame = [UIScreen mainScreen].bounds;
    [self.layer addSublayer:playerLayer];
    self.playerLayer = playerLayer;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome_video_info"]];
    imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 193/2, [UIScreen mainScreen].bounds.size.height-220, 193, 99);
    [self addSubview:imageView];
    
    UIButton *endButton = [[UIButton alloc] init];
    endButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-25, [UIScreen mainScreen].bounds.size.height-100, 50, 50);
    [endButton setBackgroundImage:[UIImage imageNamed:@"welcome_video_start"] forState:UIControlStateNormal];
    endButton.alpha = 0.0;
    [endButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:endButton];
    self.endButton = endButton;
    
    //监听视频播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    // app启动或者app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive1) name:UIApplicationDidBecomeActiveNotification object:nil];
    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive2) name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

- (void)applicationBecomeActive1{
    [self.player play];
    [self.musicPlayer play];
}

- (void)applicationBecomeActive2{
    [self.player pause];
    [self.musicPlayer pause];
}


- (void)setMusicURL:(NSString *)musicURL{
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:musicURL withExtension:nil] error:nil];
    self.musicPlayer.numberOfLoops = -1;
    [self.musicPlayer setVolume:1.0];
    [self.musicPlayer prepareToPlay];
    [self.musicPlayer play];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];//设定动画的开始帧
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];//设定动画的完成帧
    scaleAnimation.duration = 1.0f;//动画时长
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设定动画的速度变化
    self.scaleAnimation = scaleAnimation;
    
    AnimationDelegate *animationDelegate = [AnimationDelegate new];
    animationDelegate.animationDelegatePlayer = self.player;
    scaleAnimation.delegate = animationDelegate;
    [self.playerLayer addAnimation:scaleAnimation forKey:nil];
    [UIView animateWithDuration:2.0 animations:^{
        self.endButton.alpha = 1.0;
    }];
}

- (void)playbackFinished:(NSNotification *)notifation {
    if (self.player.currentItem == notifation.object) {
        // 回到视频的播放起点
        [self.player seekToTime:kCMTimeZero];
        [self.player play];
    }else if (self.musicPlayer == notifation.object){
        [self.musicPlayer prepareToPlay];
        [self.musicPlayer play];
    }
}

- (void)removeFromSuperview{
    [self.player pause];
    [self.musicPlayer pause];
    self.musicPlayer = nil;
    self.player = nil;
    self.playerLayer = nil;
    self.scaleAnimation.delegate = nil;
    self.scaleAnimation = nil;
    self.endButton = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super removeFromSuperview];
}

- (void)enterMainAction:(UIButton *)button{

        PushAnimationView *pushView = [[PushAnimationView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:pushView];
        [self removeFromSuperview];
    
}



@end
