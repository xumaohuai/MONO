//
//  PushAnimationView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/6/12.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "PushAnimationView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PushAnimationView()
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIButton *_besidesBtn;
    UILabel *_bottomLabel;
}
@property(nonatomic,strong) AVPlayer *player;
@property (nonatomic, weak) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVAudioPlayer *musicPlayer;//音乐播放
@end

@implementation PushAnimationView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupView
{

    AVPlayer *player = [[AVPlayer alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"PushAnimation.mp4" withExtension:nil]];
    player.volume = 0;
    player.volume = 3.0f;
    self.player = player;

    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    playerLayer.frame = CGRectMake(0, SCREEN_HEIGHT - 90 - SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_WIDTH);
    [self.layer addSublayer:playerLayer];
    self.playerLayer = playerLayer;

    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"pushsound.aiff" withExtension:nil] error:nil];
    self.musicPlayer.numberOfLoops = 1;
    [self.musicPlayer setVolume:1.0];
    [self.musicPlayer prepareToPlay];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"开启推送,不错过感兴趣的好内容";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightHeavy];
    
    _contentLabel = [UILabel new];
    
    _contentLabel.text = @"MONO为你提供了主题站更新推送功能，在主题站更新时会第一时间告诉你。";
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:19 weight:UIFontWeightLight];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    
    _besidesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _besidesBtn.titleLabel.font = REGULARFONT(14);
    [_besidesBtn setTitle:@"以后再说" forState:UIControlStateNormal];
    [_besidesBtn setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1] forState:UIControlStateNormal];
 
    
    _bottomLabel = [UILabel new];
    _bottomLabel.font = LIGHTFONT(12);
    _bottomLabel.text = @"反正以后我们也会时常提醒您的O(∩_∩)O";
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    
    NSArray *views = @[_titleLabel,_contentLabel,_besidesBtn,_bottomLabel];
    [self sd_addSubviews:views];
    _bottomLabel.sd_layout.centerXEqualToView(self).bottomSpaceToView(self, 20).heightIs(_bottomLabel.font.lineHeight);
    [_bottomLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _besidesBtn.sd_layout.centerXEqualToView(_bottomLabel).bottomSpaceToView(_bottomLabel, 10).heightIs(_besidesBtn.titleLabel.font.lineHeight).widthIs(200);
    
    
    _titleLabel.sd_layout.centerXEqualToView(self).topSpaceToView(self, 60).autoHeightRatio(0);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 40];
    
    _contentLabel.sd_layout.centerXEqualToView(_titleLabel).topSpaceToView(_titleLabel, 30).autoHeightRatio(0);
    [_contentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 20];
    
     [_besidesBtn addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.player play];
    [self.musicPlayer play];
}

- (void)enterMainAction:(UIButton *)button{
    [self.player pause];
    [self.musicPlayer pause];
    self.musicPlayer = nil;
    self.player = nil;
    self.playerLayer = nil;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];        
    }];
    
}

@end
