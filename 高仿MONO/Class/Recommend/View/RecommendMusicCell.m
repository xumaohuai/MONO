//
//  RecommendMusicCell.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/14.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendMusicCell.h"
#import "RecommendCellTitleView.h"
#import "CommunicateBottomView.h"
#import "RecommendModel.h"
#import "MusicCDView.h"
#import "MusicProgressView.h"
@interface RecommendMusicCell()
{
    RecommendCellTitleView *_titleView;
    CommunicateBottomView *_bottomView;
    YYAnimatedImageView *_picImageView;
    MusicCDView *_musicCDView;
    MusicProgressView *_progressView;
    UILabel *_titleLabel;
    UILabel *_descripLabel;
    UIView *_contentView;
}
@end
#define kIMAGEHEIGHT 200
#define kIMAGEWIDTH  SCREEN_WIDTH - 2 * KMarginRight
@implementation RecommendMusicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupView];
    }
    return self;
}

-(void)setupView{
    _titleView = [RecommendCellTitleView new];
    _bottomView = [[CommunicateBottomView alloc]initWithFrame:CGRectZero CommunicateType:CommunicateBottomTypeCellGray];
    _picImageView = [YYAnimatedImageView new];
    _picImageView.backgroundColor = [UIColor colorWithRed:0.46 green:0.46 blue:0.46 alpha:1];
    _picImageView.contentMode = UIViewContentModeCenter;
    _picImageView.image = [UIImage imageNamed:@"icon-image-placeholder"];
    _picImageView.userInteractionEnabled = YES;
    _picImageView.clipsToBounds = YES;

    _musicCDView = [MusicCDView new];
    _progressView = [MusicProgressView new];
    
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = REGULARFONT(19);
    _titleLabel.isAttributedContent = YES;
    _descripLabel = [UILabel new];
    _descripLabel.font = THINFONT(13);
    _descripLabel.textColor = [UIColor colorWithRed:0.37 green:0.37 blue:0.37 alpha:1];
    _descripLabel.isAttributedContent = YES;
    _descripLabel.numberOfLines = 2;
    _contentView = self.contentView;
    NSArray *views = @[_titleView,_bottomView,_picImageView,_titleLabel,_descripLabel];
    [_picImageView addSubview:_musicCDView];
    [_picImageView addSubview:_progressView];
    [_contentView sd_addSubviews:views];
    _titleView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topEqualToView(_contentView).heightIs(60);
    _picImageView.sd_layout.leftSpaceToView(_contentView, KMarginLeft).rightSpaceToView(_contentView, KMarginRight).topSpaceToView(_titleView, 0).heightIs(kIMAGEHEIGHT);
    _titleLabel.sd_layout.topSpaceToView(_picImageView, 15).leftEqualToView(_picImageView).rightEqualToView(_picImageView).autoHeightRatio(0);
    _descripLabel.sd_layout.topSpaceToView(_titleLabel, 15).leftEqualToView(_picImageView).rightEqualToView(_picImageView).maxHeightIs(_descripLabel.font.lineHeight * 5 + 20).autoHeightRatio(0);
    _bottomView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topSpaceToView(_descripLabel, 20).heightIs(61);
    _musicCDView.sd_layout.leftSpaceToView(_picImageView, 30).rightSpaceToView(_picImageView, 30).heightIs(SCREEN_WIDTH - 84).topSpaceToView(_picImageView, 45);
    _progressView.sd_layout.leftEqualToView(_picImageView).rightEqualToView(_picImageView).bottomEqualToView(_picImageView).heightIs(40);
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self)
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self)
        [[MNMusicPlayer defaultPlayer]playFromURL:[NSURL URLWithString:self->_recommendModel.music_url]];
    }];
     [_picImageView addGestureRecognizer:tap];
}

-(void)setRecommendModel:(RecommendModel *)recommendModel
{
    _musicCDView.model = recommendModel;
    if ([[MNMusicPlayer defaultPlayer].url.absoluteString isEqualToString:recommendModel.music_url] && [MNMusicPlayer defaultPlayer].isPlaying) {
        [_musicCDView playMusic];
    }else{
        [_musicCDView stopMusic];
    }
    _picImageView.contentMode = UIViewContentModeCenter;
    _progressView.model = recommendModel;
    _recommendModel = recommendModel;
    _titleView.titleModel = recommendModel;
    _bottomView.bottomModel = recommendModel;
    @weakify(self)
    [_picImageView yy_setImageWithURL:[NSURL URLWithString:recommendModel.thumb.raw] placeholder:[UIImage imageNamed:@"icon-image-placeholder"] options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if(image){
            @strongify(self)
            self->_picImageView.contentMode = UIViewContentModeScaleToFill;
            NSInteger width = recommendModel.thumb.width;
            NSInteger height = recommendModel.thumb.height;
            CGFloat scale = ((CGFloat)height / width) / ((CGFloat)kIMAGEHEIGHT / (kIMAGEWIDTH));
            if (scale < 0.99) { // 宽图把左右两边裁掉
                self->_picImageView.layer.contentsRect = CGRectMake(0, 0, scale, 1);
            } else if(scale >= 1){ // 高图只保留顶部
                self->_picImageView.layer.contentsRect = CGRectMake(0, 0, 1,1 / scale);
            }else{
                self->_picImageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
            }
                self->_picImageView.image = image;
        }else{
                self->_picImageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
        }
    }];
    if (recommendModel.title.length) {
        _titleLabel.attributedText = [CommendMethod getAttributedStringWithString:recommendModel.title lineSpace:5];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }else{
        _titleLabel.attributedText = [[NSMutableAttributedString alloc]initWithString:@""];
    }
    if (recommendModel.descrip.length) {
        _descripLabel.attributedText = [CommendMethod getAttributedStringWithString:recommendModel.descrip lineSpace:5];
        _descripLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }else{
        _descripLabel.attributedText = [[NSMutableAttributedString alloc]initWithString:@""];
    }
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
}



@end
