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
#import "FileManager.h"
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
    
    _anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _anim.fromValue = [NSNumber numberWithFloat:0.f];
    _anim.toValue = [NSNumber numberWithFloat: M_PI *2];
    _anim.duration = 10;
    _anim.autoreverses = NO;
    _anim.fillMode = kCAFillModeForwards;
    _anim.repeatCount = MAXFLOAT;
//    self.hidden = YES;
    self.alpha = 0;
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"stopMusic" object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        [self stopMusic];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"playMusic" object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
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

-(void)playMusic
{
//    [[FileManager manager].musicListArr insertObject:_model atIndex:0];
//    [[FileManager manager]cacheSelf];
    for (RecommendModel *model in [FileManager manager].musicListArr) {
        NSLog(@"%@",model.music_url);
    }
    if (self.alpha != 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        }];
    }
    [self.layer addAnimation:_anim forKey:@"rotaion"];
}

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
