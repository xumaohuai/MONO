//
//  RecommendImagesCell.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/30.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendImagesCell.h"
#import "RecommendCellTitleView.h"
#import "CommunicateBottomView.h"
#import "RecommendModel.h"
#import "SDWeiXinPhotoContainerView.h"
@interface RecommendImagesCell()
{
    RecommendCellTitleView *_titleView;
    CommunicateBottomView *_bottomView;
    SDWeiXinPhotoContainerView *_picContainerView;
    UIView *_lineView;
    UILabel *_titleLabel;
    UILabel *_descripLabel;
    UIView *_contentView;
}
@end

@implementation RecommendImagesCell

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
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = REGULARFONT(19);
    _titleLabel.isAttributedContent = YES;
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    _descripLabel = [UILabel new];
    _descripLabel.font = THINFONT(15);
    _descripLabel.textColor = [UIColor blackColor];
    _descripLabel.isAttributedContent = YES;
    _descripLabel.numberOfLines = 2;
    _picContainerView = [SDWeiXinPhotoContainerView new];
    _contentView = self.contentView;
    NSArray *views = @[_titleView,_bottomView,_lineView,_picContainerView,_titleLabel,_descripLabel];
    [_contentView sd_addSubviews:views];
    _titleView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topEqualToView(_contentView).heightIs(60);
    _lineView.sd_layout.leftSpaceToView(_contentView, KMarginLeft).rightSpaceToView(_contentView, KMarginRight).topSpaceToView(_titleView, 0).heightIs(0.5);
    _titleLabel.sd_layout.leftEqualToView(_lineView).rightEqualToView(_lineView).topSpaceToView(_lineView, 10).autoHeightRatio(0);
    _descripLabel.sd_layout.topSpaceToView(_titleLabel, 15).leftEqualToView(_lineView).rightEqualToView(_lineView).maxHeightIs(_descripLabel.font.lineHeight * 5 +20).autoHeightRatio(0);
    _picContainerView.sd_layout.leftEqualToView(_lineView).topSpaceToView(_descripLabel, 10);
    _bottomView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topSpaceToView(_picContainerView, 20).heightIs(61);
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
}
-(void)setRecommendModel:(RecommendModel *)recommendModel
{
    _recommendModel = recommendModel;
    _titleView.titleModel = recommendModel;
    _picContainerView.picPathStringsArray = recommendModel.pics;
    _bottomView.bottomModel = recommendModel;
    if (recommendModel.title.length) {
        _titleLabel.attributedText = [CommendMethod getAttributedStringWithString:recommendModel.title lineSpace:5];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }else{
        _titleLabel.attributedText = [[NSMutableAttributedString alloc]initWithString:@""];
    }
    if (recommendModel.text.length) {
        _descripLabel.attributedText = [CommendMethod getAttributedStringWithString:recommendModel.text lineSpace:5];
        _descripLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }else{
        _descripLabel.attributedText = [[NSMutableAttributedString alloc]initWithString:@""];
    }
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
}


@end
