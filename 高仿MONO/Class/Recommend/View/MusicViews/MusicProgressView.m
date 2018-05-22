//
//  MusicProgressView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/15.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MusicProgressView.h"
#import "RecommendModel.h"
#import "XDProgressView.h"
@interface MusicProgressView()
{
    XDProgressView *_pView;
    UIButton *_playBtn;
    UILabel *_musicTitleLabel;
    UILabel *_timeLabel;
    UIImageView *_musicImageView;
}
@end

@implementation MusicProgressView

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
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _pView = [XDProgressView new];
    _pView.progressTintColor = [UIColor colorWithRed:0.1 green:0.67 blue:0.96 alpha:0.5];
    _pView.trackTintColor = [UIColor clearColor];
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn setImage:[UIImage imageNamed:@"icon-player-play-white"] forState:UIControlStateNormal];
    //icon-player-play-white
    @weakify(self)
    [[_playBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
    @strongify(self)
    [[MNMusicPlayer defaultPlayer]playFromURL:[NSURL URLWithString:self->_model.music_url]];
    }];
    
    _musicTitleLabel = [UILabel new];
    _musicTitleLabel.font = LIGHTFONT(12);
    _musicTitleLabel.textColor = [UIColor whiteColor];
    _timeLabel = [UILabel new];
    _timeLabel.font = LIGHTFONT(12);
    _timeLabel.textColor = [UIColor whiteColor];
    _musicImageView = [UIImageView new];
    [_musicImageView setImage:[UIImage imageNamed:@"icon-player-logo-blue"]];
    
    NSArray *views = @[_pView,_playBtn,_timeLabel,_musicTitleLabel,_musicImageView];
    [self sd_addSubviews:views];
    _playBtn.sd_layout.leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(14).heightIs(16);
    _musicImageView.sd_layout.rightSpaceToView(self, 15).centerYEqualToView(self).widthIs(13).heightIs(13);
    _timeLabel.sd_layout.rightSpaceToView(_musicImageView, 10).centerYEqualToView(self).heightIs(15).widthIs(40);
    _musicTitleLabel.sd_layout.leftSpaceToView(_playBtn, 20).rightSpaceToView(_timeLabel, 10).centerYEqualToView(self).heightIs(20);
    _pView.sd_layout.leftSpaceToView(_playBtn, 15).rightEqualToView(_timeLabel).topEqualToView(self).heightIs(40);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"playingMusic" object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        if ([[MNMusicPlayer defaultPlayer].url.absoluteString isEqualToString:self->_model.music_url] && [MNMusicPlayer defaultPlayer].isPlaying) {
            self->_timeLabel.text = [notification.object safeStringForKey:@"currentTime"];
            self->_pView.progress = [[notification.object objectForKey:@"progress"]floatValue];
            [self->_playBtn setImage:[UIImage imageNamed:@"icon-player-pause-white"] forState:UIControlStateNormal];
        }else{
            self->_timeLabel.text = [CommendMethod getMMSSFromSS:self->_model.music_duration];
            self->_pView.progress = 0.0;
            [self->_playBtn setImage:[UIImage imageNamed:@"icon-player-play-white"] forState:UIControlStateNormal];
        }
      
    }];
}

-(void)setModel:(RecommendModel *)model
{
    _model = model;
    _pView.progress = 0.0;
    _musicTitleLabel.text = [NSString stringWithFormat:@"%@ - %@",model.song_name,model.artist];
    _timeLabel.text = [CommendMethod getMMSSFromSS:model.music_duration];
}
@end
