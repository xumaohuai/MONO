//
//  RecommendImageBgCell.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/29.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendImageBgCell.h"
#import "RecommendCellTitleView.h"
#import "CommunicateBottomView.h"
#import "RecommendModel.h"
#import <YYWebImage.h>
#import "RQShineLabel.h"
@interface RecommendImageBgCell()
{
    RecommendCellTitleView *_titleView;
    CommunicateBottomView *_bottomView;
    YYAnimatedImageView *_picImageView;
    RQShineLabel *_textLabel;
    RQShineLabel *_authLabel;
    UIView *_contentView;
    
}
@end

@implementation RecommendImageBgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupView];
    }
    return self;
}
-(void)setupView{
    _titleView = [RecommendCellTitleView new];
    _bottomView = [[CommunicateBottomView alloc]initWithFrame:CGRectZero CommunicateType:CommunicateBottomTypeCellWhite];
    _picImageView = [YYAnimatedImageView new];
    _picImageView.contentMode = UIViewContentModeCenter;
    _picImageView.backgroundColor = [UIColor colorWithRed:0.46 green:0.46 blue:0.46 alpha:1];
    _picImageView.image = [UIImage imageNamed:@"icon-image-placeholder"];
   
    _textLabel = [RQShineLabel new];
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont fontWithName:@"ITCAvantGardeStd-Bk" size:18];
    _textLabel.isAttributedContent = YES;
    
    _authLabel = [RQShineLabel new];
    _authLabel.textColor = [UIColor whiteColor];
    _authLabel.font = REGULARFONT(14);
    _authLabel.isAttributedContent = YES;

    _contentView = self.contentView;
    NSArray *views = @[_titleView,_picImageView,_textLabel,_authLabel,_bottomView];
    [_contentView sd_addSubviews:views];
    _titleView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topEqualToView(_contentView).heightIs(60);
    _picImageView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topSpaceToView(_titleView, 0).heightIs(SCREEN_WIDTH);
    _textLabel.sd_layout.leftSpaceToView(_contentView, 30).rightSpaceToView(_contentView, 30).centerYEqualToView(_picImageView).autoHeightRatio(0);
    _authLabel.sd_layout.rightSpaceToView(_contentView, 30).topSpaceToView(_textLabel, 10).autoHeightRatio(0);
    [_authLabel setSingleLineAutoResizeWithMaxWidth:300];
    _bottomView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topSpaceToView(_picImageView, -51).heightIs(61);
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
}

-(void)setRecommendModel:(RecommendModel *)recommendModel
{
    _picImageView.contentMode = UIViewContentModeScaleToFill;
    _recommendModel = recommendModel;
    _titleView.titleModel = recommendModel;
    _bottomView.bottomModel = recommendModel;
    [_picImageView yy_setImageWithURL:[NSURL URLWithString:recommendModel.thumb.raw] placeholder:[UIImage imageNamed:@"icon-image-placeholder"]];
    if (!_recommendModel.hasShine) {
        _textLabel.hidden = YES;
        _authLabel.hidden = YES;
    }else{
        _textLabel.attributedText = [self getAttributeStringWithString:_recommendModel.text];
        if (_recommendModel.author.length) {
            _authLabel.attributedText = [self getAttributeStringWithString:[NSString stringWithFormat:@"---%@",_recommendModel.author]];
        }else{
            _authLabel.attributedText = nil;
        }
        _textLabel.sd_resetLayout.leftSpaceToView(_contentView, 30).rightSpaceToView(_contentView, 30).centerYEqualToView(_picImageView).autoHeightRatio(0);
        _authLabel.sd_resetLayout.rightSpaceToView(_contentView, 30).topSpaceToView(_textLabel, 10).autoHeightRatio(0);
    }
}

-(void)shineText
{
    if (!_recommendModel.hasShine) {
        _authLabel.hidden = NO;
        _textLabel.hidden = NO;
        if (_recommendModel.author.length) {
            _authLabel.text = [NSString stringWithFormat:@"---%@",_recommendModel.author];
        }else{
            _authLabel.text = @"";
        }
        _textLabel.text = _recommendModel.text;
        _textLabel.sd_resetLayout.leftSpaceToView(_contentView, 30).rightSpaceToView(_contentView, 30).centerYEqualToView(_picImageView).autoHeightRatio(0);
        _authLabel.sd_resetLayout.rightSpaceToView(_contentView, 30).topSpaceToView(_textLabel, 10).autoHeightRatio(0);
        _recommendModel.hasShine = YES;
        [_textLabel shine];
        [_authLabel shine];
    }
}

-(NSMutableAttributedString *)getAttributeStringWithString:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5; // 调整行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}


@end
