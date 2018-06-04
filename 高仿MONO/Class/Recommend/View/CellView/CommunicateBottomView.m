
//
//  RecommendCellBottomView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/25.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "CommunicateBottomView.h"
#import "RecommendModel.h"
#import "MNShareMoreView.h"
#import "ACActionSheet.h"
@interface CommunicateBottomView()<MNShareMoreViewDelegate>
{
    UIButton *_shareBtn;//分享按钮
    UIButton *_collectBtn;//收藏按钮
    UIButton *_praiseBtn;//点赞按钮
    UIButton *_communicateBtn;//交流按钮
    UIButton *_moreBtn;//更多
    UIButton *_backBtn;//返回按钮
    UIImageView *_likeImageView;//收藏动画图片
    UIImageView *_dislikeImageView;//取消收藏动画图片
    NSMutableArray *_likeAnmations;//收藏动画
    NSMutableArray *_dislikeAnmations;//取消收藏动画
    UIView *_bottomView;
    UIView *_lineView;
    UIColor *_textColor;
    UIImage *_shareImage;
    UIImage *_collectImage;
    UIImage *_priaiseImage;
    UIImage *_communicateImage;
    UIImage *_backImage;
    UIImage *_moreImage;
    UIImage *_priaiseSelectedImage;
}
@end
const NSInteger kButtonWidth = 48;
const NSInteger kButtonHeight = 50;
@implementation CommunicateBottomView

-(instancetype)initWithFrame:(CGRect)frame CommunicateType:(CommunicateBottomType)communicateType
{
    if(self = [super initWithFrame:frame]){
        [self setColorStyleWithCommunicateBottomType:communicateType];
        [self setupView];
        self.communicateBottomType = communicateType;
        [self clickButtonAction];
    }
    return self;
}
-(void)setCommunicateBottomType:(CommunicateBottomType)communicateBottomType
{
    switch (communicateBottomType) {
        case CommunicateBottomTypeCellGray:
            [self setViewByCommunicateBottomTypeCellGray];
            break;
        case CommunicateBottomTypeCellWhite:
            [self setViewByCommunicateBottomTypeCellWhite];
            break;
        case CommunicateBottomTypeDetailGray:
            [self setViewByCommunicateBottomTypeDetailGray];
            break;
        case CommunicateBottomTypeDetailWhite:
            [self setViewByCommunicateBottomTypeDetailWhite];
            break;
        default:
            break;
    }
}

-(void)setColorStyleWithCommunicateBottomType:(CommunicateBottomType)commicateBottomType;
{
    switch (commicateBottomType) {
        case CommunicateBottomTypeCellGray:
        case CommunicateBottomTypeDetailGray:
            _shareImage = [UIImage imageNamed:@"item-btn-share-black"];
            _collectImage = [UIImage imageNamed:@"item-btn-like-black"];
            _priaiseImage = [UIImage imageNamed:@"item-btn-thumb-black"];
            _communicateImage = [UIImage imageNamed:@"item-btn-comment-black"];
            _moreImage = [UIImage imageNamed:@"icon-more-grey"];
            _priaiseSelectedImage = [UIImage imageNamed:@"item-btn-thumb-black-on"];
            _backImage = [UIImage imageNamed:@"btn-topback-active"];
            break;
        case CommunicateBottomTypeCellWhite:
        case CommunicateBottomTypeDetailWhite:
            _shareImage = [UIImage imageNamed:@"item-btn-share-white"];
            _collectImage = [UIImage imageNamed:@"item-btn-like-white"];
            _priaiseImage = [UIImage imageNamed:@"item-btn-thumb-white"];
            _communicateImage = [UIImage imageNamed:@"item-btn-comment-white"];
            _moreImage = [UIImage imageNamed:@"icon-more-white"];
            _priaiseSelectedImage = [UIImage imageNamed:@"item-btn-thumb-white-on"];
            _backImage = [UIImage imageNamed:@"btn-top-backwhite"];
            break;
        default:
            break;
    }
}

-(void)setupView{
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor colorWithRed:0.86 green:0.89 blue:0.91 alpha:1];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setImage:_shareImage forState:UIControlStateNormal];
    _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectBtn setImage:_collectImage forState:UIControlStateNormal];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:_backImage forState:UIControlStateNormal];
    
    _likeAnmations = @[].mutableCopy;
    _dislikeAnmations = @[].mutableCopy;
    for (NSUInteger i = 1; i < 15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"liked_%zd", i]];
        [_likeAnmations addObject:image];
    }
    for (NSUInteger i = 1; i < 9; i++) {
        UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"dislike_%zd", i]];
        [_dislikeAnmations addObject:image1];
    }
    _likeImageView = [UIImageView new];
    _likeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _likeImageView.image = nil;
    _likeImageView.userInteractionEnabled = NO;
    _likeImageView.animationImages = _likeAnmations;
    _likeImageView.animationDuration = 0.3;//设置动画时间
    _likeImageView.animationRepeatCount = 1;
   
    _dislikeImageView = [UIImageView new];
    _dislikeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _dislikeImageView.image = nil;
    _dislikeImageView.userInteractionEnabled = NO;
    _dislikeImageView.animationImages = _dislikeAnmations;
    _dislikeImageView.animationDuration = 0.3;//设置动画时间
    _dislikeImageView.animationRepeatCount = 1;
 
    _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_praiseBtn setImage:_priaiseImage forState:UIControlStateNormal];
    _praiseBtn.titleLabel.font = REGULARFONT(12);
    
    _communicateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_communicateBtn setImage:_communicateImage forState:UIControlStateNormal];
    _communicateBtn.titleLabel.font = REGULARFONT(12);
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBtn setImage:_moreImage forState:UIControlStateNormal];
    
    NSArray *views = @[_lineView,_shareBtn,_collectBtn,_praiseBtn,_communicateBtn,_moreBtn,_bottomView,_dislikeImageView,_likeImageView,_backBtn];
    [self sd_addSubviews:views];
}
//cell灰色
-(void)setViewByCommunicateBottomTypeCellGray
{
    _lineView.hidden = NO;
    self.backgroundColor = [UIColor whiteColor];
    [_praiseBtn setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1] forState:UIControlStateNormal];
     [_communicateBtn setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1] forState:UIControlStateNormal];
    _lineView.sd_layout.topEqualToView(self).leftSpaceToView(self, KMarginLeft).rightSpaceToView(self, KMarginRight).heightIs(0.5);
    _shareBtn.sd_layout.leftEqualToView(self).topSpaceToView(_lineView, 0).widthIs(kButtonWidth).heightIs(kButtonHeight);
    _collectBtn.sd_layout.leftSpaceToView(_shareBtn, 0).topEqualToView(_shareBtn).widthIs(kButtonWidth).heightIs(kButtonHeight);
    _praiseBtn.sd_layout.leftSpaceToView(_collectBtn, 0).topEqualToView(_collectBtn).widthIs(kButtonWidth).heightIs(kButtonHeight);
    [_praiseBtn setupAutoSizeWitImagehHorizontalPadding:4 buttonHeight:kButtonHeight];
    _communicateBtn.sd_layout.leftSpaceToView(_praiseBtn, 0).topEqualToView(_praiseBtn).widthIs(kButtonWidth).heightIs(kButtonHeight);
    [_communicateBtn setupAutoSizeWitImagehHorizontalPadding:4 buttonHeight:kButtonHeight];
    _moreBtn.sd_layout.rightEqualToView(self).centerYEqualToView(_shareBtn).widthIs(4 * KMarginRight).heightIs(kButtonHeight);
    _bottomView.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(_shareBtn, 0).heightIs(10);
    _likeImageView.sd_layout.bottomEqualToView(_shareBtn).leftEqualToView(_collectBtn).widthIs(45).heightIs(90);
    //55 54
   _dislikeImageView.sd_layout.bottomEqualToView(_shareBtn).leftEqualToView(_collectBtn).widthIs(55).heightIs(54);
}
//cell白色
-(void)setViewByCommunicateBottomTypeCellWhite
{
    [self setViewByCommunicateBottomTypeCellGray];
    _lineView.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
    [_praiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_communicateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//详情灰色
-(void)setViewByCommunicateBottomTypeDetailGray
{
    _lineView.hidden = NO;
    self.backgroundColor = [UIColor whiteColor];
    [_praiseBtn setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1] forState:UIControlStateNormal];
    [_communicateBtn setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1] forState:UIControlStateNormal];
    
    _lineView.sd_layout.topEqualToView(self).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(0.5);
    _backBtn.sd_layout.leftSpaceToView(self, 0).topEqualToView(_lineView).widthIs(kButtonHeight).heightIs(kButtonHeight);
    _moreBtn.sd_layout.rightEqualToView(self).topSpaceToView(_lineView, 0).widthIs(4 * KMarginRight).heightIs(kButtonHeight);
    _communicateBtn.sd_layout.rightSpaceToView(_moreBtn, 0).topSpaceToView(_lineView, 0).widthIs(kButtonWidth).heightIs(kButtonHeight);
    [_communicateBtn setupAutoSizeWitImagehHorizontalPadding:4 buttonHeight:kButtonHeight];
    _praiseBtn.sd_layout.rightSpaceToView(_communicateBtn, 0).topSpaceToView(_lineView, 0).widthIs(kButtonWidth).heightIs(kButtonHeight);
    [_praiseBtn setupAutoSizeWitImagehHorizontalPadding:4 buttonHeight:kButtonHeight];
    _collectBtn.sd_layout.rightSpaceToView(_praiseBtn, 0).topSpaceToView(_lineView, 0).widthIs(kButtonWidth).heightIs(kButtonHeight);
    _shareBtn.sd_layout.rightSpaceToView(_collectBtn,0).topSpaceToView(_lineView, 0).widthIs(kButtonWidth).heightIs(kButtonHeight);
    
    _likeImageView.sd_layout.bottomEqualToView(_shareBtn).leftEqualToView(_collectBtn).widthIs(45).heightIs(90);
    //55 54
    _dislikeImageView.sd_layout.bottomEqualToView(_shareBtn).leftEqualToView(_collectBtn).widthIs(55).heightIs(54);
}
-(void)setViewByCommunicateBottomTypeDetailWhite
{
    [self setViewByCommunicateBottomTypeDetailGray];
    _lineView.hidden = YES;
    self.backgroundColor = [UIColor blackColor];
    [_praiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_communicateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)clickButtonAction
{
    [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        MNShareMoreView *moreView = [[MNShareMoreView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        moreView.delegate = self;
        [moreView appear];
    }];
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [JKRouter pop:YES];
    }];
    @weakify(self)
    [[_collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        self.bottomModel.is_folded = !self.bottomModel.is_folded;
        if(self.bottomModel.is_folded){
            [self->_likeImageView startAnimating];
            [self->_collectBtn setImage:[UIImage imageNamed:@"item-btn-like-on"] forState:UIControlStateNormal];
        }else{
            [self->_dislikeImageView startAnimating];
            [self->_collectBtn setImage:self->_collectImage forState:UIControlStateNormal];
        }
    }];
    [[_praiseBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        self.bottomModel.is_folded = !self.bottomModel.is_folded;
        if(self.bottomModel.is_folded){
            [self->_praiseBtn setImage:self->_priaiseSelectedImage forState:UIControlStateNormal];
        }else{
            [self->_praiseBtn setImage:self->_priaiseImage forState:UIControlStateNormal];
        }
    }];
    [[_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       ACActionSheet *actionSheet = [[ACActionSheet alloc]initWithTitle:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"不喜欢",@"举报"] actionSheetBlock:^(NSInteger buttonIndex) {
            NSLog(@"ACActionSheet block - %ld",buttonIndex);
        }];
        [actionSheet show];
    }];
}

-(void)setBottomModel:(RecommendModel *)bottomModel
{
    _bottomModel = bottomModel;
    [_praiseBtn setTitle:[NSString stringWithFormat:@"%zd",bottomModel.bang_count] forState:UIControlStateNormal];
    [_communicateBtn setTitle:[NSString stringWithFormat:@"%zd",bottomModel.comment_count] forState:UIControlStateNormal];
}


#pragma mark - MNShareMoreViewDelegate
-(void)MNShareMoreViewSelectedItem:(NSInteger)item
{
    NSLog(@"点击了第%zd个按钮",item);
}
@end
