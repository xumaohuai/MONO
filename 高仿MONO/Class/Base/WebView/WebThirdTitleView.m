//
//  WebThirdTitleView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/31.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "WebThirdTitleView.h"
#import "RecommendModel.h"
@interface WebThirdTitleView()
{
    UILabel *_nameLable;
    UILabel *_contentLabel;
    UIImageView *_arrowsView;
    UILabel *_readStyleLable;
    UIView *_backgroudView;
    UIView *_lineView;
}

@end

@implementation WebThirdTitleView

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
    _backgroudView = [UIView new];
    _backgroudView.backgroundColor = [UIColor whiteColor];
    
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
 
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont fontWithName:@"ITCAvantGardeStd-XLtObl" size:14];
    _nameLable.textColor = [UIColor blackColor];
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont fontWithName:@"ITCAvantGardeStd-XLtObl" size:10];
    _contentLabel.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1];
    _contentLabel.text = @"推荐链接";
    
    _arrowsView = [UIImageView new];
    _arrowsView.image = [UIImage imageNamed:@"icon-arrow-right-black"];
    
    _readStyleLable = [UILabel new];
    _readStyleLable.font = [UIFont fontWithName:@"ITCAvantGardeStd-XLtObl" size:12];
    _readStyleLable.text = @"阅读模式";
    _readStyleLable.textColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
    
    _readSwith = [[MBSwitch alloc]initWithFrame:CGRectMake(200, 20, 34, 16)];
    [_readSwith setOnTintColor:[UIColor colorWithRed:0.08 green:0.6 blue:0.64 alpha:1]];
    [_readSwith setTintColor:[UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1]];
    [_readSwith setOffTintColor:[UIColor clearColor]];
//    _readSwith.backgroundColor = [UIColor blackColor];

    CGFloat topHeight = NaviH - 44;
    _backgroudView.frame = CGRectMake(-25, -topHeight, SCREEN_WIDTH , self.bounds.size.height);
    [self addSubview:_backgroudView];
    NSArray *views = @[_nameLable,_contentLabel,_arrowsView,_readSwith,_readStyleLable,_lineView];
    [_backgroudView sd_addSubviews:views];
    
    _nameLable.sd_layout.leftSpaceToView(_backgroudView, 15).topSpaceToView(_backgroudView, 8 + topHeight).heightIs(_nameLable.font.lineHeight);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    _arrowsView.sd_layout.leftSpaceToView(_nameLable, 2).topSpaceToView(_nameLable, -13.4).widthIs(6.5).heightIs(11);
    _contentLabel.sd_layout.leftEqualToView(_nameLable).topSpaceToView(_nameLable, 5).heightIs(_contentLabel.font.lineHeight);
    [_contentLabel setSingleLineAutoResizeWithMaxWidth:200];
    _readSwith.sd_layout.rightSpaceToView(_backgroudView, 10).centerYIs((self.height + topHeight) /2).widthIs(34).heightIs(16);
    _readStyleLable.sd_layout.rightSpaceToView(_readSwith, 5).topSpaceToView(_readSwith, -13).heightIs(_readStyleLable.font.lineHeight);
    [_readStyleLable setSingleLineAutoResizeWithMaxWidth:100];
    _lineView.sd_layout.leftEqualToView(_backgroudView).rightEqualToView(_backgroudView).bottomEqualToView(_backgroudView).heightIs(0.5);
}

-(void)setModel:(RecommendModel *)model
{
    _nameLable.text = model.user.name;
}
@end
