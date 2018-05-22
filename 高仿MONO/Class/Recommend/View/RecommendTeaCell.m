//
//  RecommendTeaCell.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/22.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendTeaCell.h"
#import "RecommendCellTitleView.h"
#import "CommunicateBottomView.h"
#import "RecommendModel.h"

@interface RecommendTeaCell()
{
    RecommendCellTitleView *_titleView;
    CommunicateBottomView *_bottomView;
    YYAnimatedImageView *_picImageView;
    UIView *_contentView;
}
@end

@implementation RecommendTeaCell

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
    _picImageView.image = [UIImage imageNamed:@"icon-image-placeholder"];
    
    _contentView = self.contentView;
    NSArray *views = @[_titleView,_bottomView,_picImageView];
    [_contentView sd_addSubviews:views];
    _titleView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topEqualToView(_contentView).heightIs(60);
    _picImageView.sd_layout.leftSpaceToView(_contentView, 0).rightSpaceToView(_contentView, 0).topSpaceToView(_titleView, 0).heightIs(SCREEN_WIDTH / 64 * 67);
    _bottomView.sd_layout.leftEqualToView(_contentView).rightEqualToView(_contentView).topSpaceToView(_picImageView, 5).heightIs(61);
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
}

-(void)setRecommendModel:(RecommendModel *)recommendModel
{
    _titleView.titleModel = recommendModel;
    _bottomView.bottomModel = recommendModel;
    _picImageView.yy_imageURL = [NSURL URLWithString:recommendModel.thumb.raw];
}
@end
