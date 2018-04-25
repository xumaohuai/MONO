//
//  RecommendCellTitleView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendCellTitleView.h"
#import "RecommendModel.h"
@interface RecommendCellTitleView()
{
    UIImageView *_avatarImageView;
    UILabel *_userNameLabel;
    UIButton *_typeBtn;
}
@end

@implementation RecommendCellTitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    [super layoutSubviews];
    _avatarImageView = [UIImageView new];
    _avatarImageView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    _userNameLabel = [UILabel new];
    _userNameLabel.font = LIGHTFONT(14);
    _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _typeBtn.titleLabel.font = LIGHTFONT(13);
    
    NSArray *views = @[_avatarImageView,_userNameLabel,_typeBtn];
    [self sd_addSubviews:views];
    
    _avatarImageView.sd_layout.leftSpaceToView(self, KMarginLeft).centerYEqualToView(self).widthIs(32).heightIs(32);
    _userNameLabel.sd_layout.leftSpaceToView(_avatarImageView, 6).centerYEqualToView(_avatarImageView).heightIs(_userNameLabel.font.lineHeight);
    [_userNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    _typeBtn.sd_layout.rightSpaceToView(self, KMarginRight).centerYEqualToView(_avatarImageView).heightIs(100).widthIs(40);
}

-(void)setTitleModel:(RecommendModel *)titleModel
{
    _titleModel = titleModel;
    [_avatarImageView setAvatarWithUrlString:titleModel.user.avatar_url];
    _userNameLabel.text = titleModel.user.name;
    [_typeBtn setTitle:titleModel.category.name forState:UIControlStateNormal];
}

@end
