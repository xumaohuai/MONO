//
//  RecommendVideoCell.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/21.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendVideoCell.h"
#import "RecommendCellTitleView.h"
#import "CommunicateBottomView.h"
#import "RecommendModel.h"
#import <ZFPlayer.h>
#import <ZFPlayerModel.h>
#import "MNNetworkTool.h"
@interface RecommendVideoCell()
{
    RecommendCellTitleView *_titleView;
    CommunicateBottomView *_bottomView;
    YYAnimatedImageView *_picImageView;
    UIImageView *_playImageView;
    UIButton *_timeBtn;
    UILabel *_titleLabel;
    UILabel *_descripLabel;
    UIView *_contentView;
    NSString *_videoUrl;
}
@property(nonatomic,strong) ZFPlayerView *playerView;
@end
#define kIMAGEHEIGHT 200
#define kIMAGEWIDTH  SCREEN_WIDTH - 2 * KMarginRight
@implementation RecommendVideoCell
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
    _picImageView.userInteractionEnabled = YES;
    _picImageView.image = [UIImage imageNamed:@"icon-image-placeholder"];
    
    _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [_timeBtn setImage:[UIImage imageNamed:@"icon-video-new"] forState:UIControlStateNormal];
    _timeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _playImageView = [UIImageView new];
    _playImageView.image = [UIImage imageNamed:@"item-btn-video-play"];
    
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = REGULARFONT(19);
    _titleLabel.isAttributedContent = YES;
    _descripLabel = [UILabel new];
    _descripLabel.font = THINFONT(13);
    _descripLabel.textColor = [UIColor colorWithRed:0.37 green:0.37 blue:0.37 alpha:1];
    _descripLabel.isAttributedContent = YES;
    _descripLabel.numberOfLines = 2;
    //    ITCAvantGardeStd-Md
    _contentView = self.contentView;
    NSArray *views = @[_titleView,_bottomView,_picImageView,_titleLabel,_descripLabel,_playImageView,_timeBtn];
    [_contentView sd_addSubviews:views];
    _titleView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topEqualToView(_contentView).heightIs(60);
    _picImageView.sd_layout.leftSpaceToView(_contentView, KMarginLeft).rightSpaceToView(_contentView, KMarginRight).topSpaceToView(_titleView, 0).heightIs(kIMAGEHEIGHT);
    _playImageView.sd_layout.centerXEqualToView(_picImageView).centerYEqualToView(_picImageView).widthIs(71).heightIs(71);
    _timeBtn.sd_layout.centerXEqualToView(_picImageView).topSpaceToView(_playImageView, 15).widthIs(50);
     [_timeBtn setupAutoSizeWitImagehHorizontalPadding:0 buttonHeight:16];
    _titleLabel.sd_layout.topSpaceToView(_picImageView, 15).leftEqualToView(_picImageView).rightEqualToView(_picImageView).autoHeightRatio(0);
    _descripLabel.sd_layout.topSpaceToView(_titleLabel, 15).leftEqualToView(_picImageView).rightEqualToView(_picImageView).maxHeightIs(_descripLabel.font.lineHeight * 5 + 20).autoHeightRatio(0);
    _bottomView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topSpaceToView(_descripLabel, 20).heightIs(61);
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
}

-(void)setRecommendModel:(RecommendModel *)recommendModel
{
    if (recommendModel.videoUrl == nil) {
        [[MNNetworkTool shareService]getVideoUrlWithId:recommendModel.Id Success:^(NSString *url) {
            recommendModel.videoUrl = [NSURL URLWithString:url];
        }];
    }
    
    [_timeBtn setTitle:[CommendMethod getMMSSFromSS:recommendModel.video_duration] forState:UIControlStateNormal];
    _picImageView.contentMode = UIViewContentModeCenter;
    _picImageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    _recommendModel = recommendModel;
    _titleView.titleModel = recommendModel;
    _bottomView.bottomModel = recommendModel;
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
    @weakify(self)
    [_picImageView yy_setImageWithURL:[NSURL URLWithString:recommendModel.thumb.raw] placeholder:[UIImage imageNamed:@"icon-image-placeholder"] options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if(image){
            @strongify(self)
            self->_picImageView.contentMode = UIViewContentModeScaleToFill;
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
