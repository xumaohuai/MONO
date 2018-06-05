//
//  MusicCDView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/14.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MusicCDView.h"
#import <YYWebImage.h>
#import "RecommendModel.h"
@interface MusicCDView()
{
    UIView *_blackHoleView;
    UIImageView *_cdImageView;
    UIImageView *_coverImageView;
    CABasicAnimation *_anim;
}
@end

@implementation MusicCDView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    _blackHoleView = [UIView new];
    _blackHoleView.backgroundColor = [UIColor blackColor];
    _blackHoleView.layer.cornerRadius = 5;
    _cdImageView = [UIImageView new];
    _cdImageView.image = [UIImage imageNamed:@"icon-disc"];
    _coverImageView = [UIImageView new];
    _coverImageView.layer.masksToBounds = YES;
    _coverImageView.layer.cornerRadius = (SCREEN_WIDTH - 84) / 6;
    
    [self addSubview:_cdImageView];
    [self addSubview:_coverImageView];
    [self addSubview:_blackHoleView];
    _cdImageView.sd_layout.topEqualToView(self).leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self);
    _coverImageView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthIs((SCREEN_WIDTH - 84) / 3).heightIs((SCREEN_WIDTH - 84) / 3);
    _blackHoleView.sd_layout.centerYEqualToView(self).centerXEqualToView(self).widthIs(10).heightIs(10);
    
    //创建一个全局的动画
    _anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _anim.fromValue = [NSNumber numberWithFloat:0.f];
    _anim.toValue = [NSNumber numberWithFloat: M_PI *2];
    _anim.duration = 10;
    _anim.autoreverses = NO;
    _anim.fillMode = kCAFillModeForwards;
    _anim.repeatCount = MAXFLOAT;
    
    self.alpha = 0;
    //当收到通知时执行的操作
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"stopMusic" object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        [self stopMusic];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"playMusic" object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        //播放音乐的URL和此URL地址相同时才播放
        if ([notification.object isEqualToString:self.model.music_url]) {
            [self playMusic];
        }
    }];
    
}

-(void)setModel:(RecommendModel *)model
{
    _model = model;
    _coverImageView.yy_imageURL = [NSURL URLWithString:model.album_cover.raw];
}

-(void)setCoverUrl:(NSString *)coverUrl
{
    _coverImageView.yy_imageURL = [NSURL URLWithString:coverUrl];
}

//播放音乐
-(void)playMusic
{
    if (self.alpha != 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        }];
    }
    [self.layer addAnimation:_anim forKey:@"rotaion"];
}
//暂停音乐
-(void)stopMusic
{
    if (self.alpha != 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        }];
    }
    [self.layer removeAnimationForKey:@"rotaion"];
}
@end
