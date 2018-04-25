//
//  RecommendReadCell.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendReadCell.h"
#import "RecommendCellTitleView.h"
#import "RecommendCellBottomView.h"
@interface RecommendReadCell()
{
    RecommendCellTitleView *_titleView;
    RecommendCellBottomView *_bottomView;
}
@end

@implementation RecommendReadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupView];
    }
    return self;
}

-(void)setupView{
    _titleView = [RecommendCellTitleView new];
    _bottomView = [RecommendCellBottomView new];
    
    UIView *contentView = self.contentView;
    NSArray *views = @[_titleView,_bottomView];
    [contentView sd_addSubviews:views];
    _titleView.sd_layout.leftEqualToView(contentView).rightEqualToView(contentView).topEqualToView(contentView).heightIs(60);
    _bottomView.sd_layout.leftEqualToView(contentView).rightEqualToView(contentView).topSpaceToView(_titleView, 0).heightIs(61);
}

-(void)setRecommendModel:(RecommendModel *)recommendModel
{
    _recommendModel = recommendModel;
    _titleView.titleModel = recommendModel;
    _bottomView.bottomModel = recommendModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
