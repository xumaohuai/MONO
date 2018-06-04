//
//  WebNavTitleView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/29.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "WebNavTitleView.h"
#import "RecommendModel.h"
#import <YYWebImage.h>
@interface WebNavTitleView()
{
    WebNavTitleStyle _style;
    UIImageView *_avatorView;
    UILabel *_nameLable;
    UILabel *_descripLabel;
    UIButton *_attentionBtn;
    UIView *_backgroudView;
}
@end

@implementation WebNavTitleView

-(instancetype)initWithFrame:(CGRect)frame WebNavStyle:(WebNavTitleStyle)style
{
    _style = style;
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    _backgroudView = [UIView new];
    _backgroudView.backgroundColor = [UIColor whiteColor];
    if (_style == WebNavTitleStyleBlack) {
        _backgroudView.backgroundColor = [UIColor blackColor];
    }
    _avatorView = [UIImageView new];
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:12];
    _nameLable.textColor = [UIColor colorWithRed:0.2 green:0.53 blue:0.53 alpha:1];
    _descripLabel = [UILabel new];
    _descripLabel.font = [UIFont systemFontOfSize:9];
    _descripLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
    _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentionBtn setImage:[UIImage imageNamed:@"icon-join-group"] forState:UIControlStateNormal];
    CGFloat topHeight = NaviH - 44;
    _backgroudView.frame = CGRectMake(-25, -topHeight, SCREEN_WIDTH , self.bounds.size.height);
    [self addSubview:_backgroudView];
    NSArray *views = @[_avatorView,_nameLable,_descripLabel,_attentionBtn];
    [_backgroudView sd_addSubviews:views];
    _avatorView.sd_layout.leftSpaceToView(_backgroudView, 10).centerYIs((self.height + topHeight) / 2).widthIs(30).heightIs(30);
    _nameLable.sd_layout.leftSpaceToView(_avatorView, 8).topSpaceToView(_backgroudView,  topHeight + 8).heightIs(_nameLable.font.lineHeight);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    _descripLabel.sd_layout.leftEqualToView(_nameLable).topSpaceToView(_nameLable, 4).heightIs(_descripLabel.font.lineHeight);
    [_descripLabel setSingleLineAutoResizeWithMaxWidth:200];
    _attentionBtn.sd_layout.rightSpaceToView(_backgroudView, 10).centerYEqualToView(_avatorView).widthIs(75).heightIs(30);
}

-(void)setModel:(RecommendModel *)model
{
    _avatorView.yy_imageURL = [NSURL URLWithString:model.group.logo_url];
    _nameLable.text = model.user.name;
    _descripLabel.text = [NSString stringWithFormat:@"%@,%ld成员",[CommendMethod getTime:model.create_time],model.group.member_num];
}
//- (void)setFrame:(CGRect)frame {
//    [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
//}

-(CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
}

@end
