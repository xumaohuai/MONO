//
//  RecommendCellBottomView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/25.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendCellBottomView.h"
#import "RecommendModel.h"
#import "MNShareMoreView.h"
@interface RecommendCellBottomView()<MNShareMoreViewDelegate>
{
    UIButton *_shareBtn;
    UIButton *_collectBtn;
    UIButton *_praiseBtn;
    UIButton *_communicateBtn;
    UIButton *_moreBtn;
    UIImageView *_likeImageView;
    UIImageView *_dislikeImageView;
    NSMutableArray *_likeAnmations;
    NSMutableArray *_dislikeAnmations;
}
@end
const NSInteger kButtonWidth = 48;
const NSInteger kButtonHeight = 50;
@implementation RecommendCellBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

-(void)setupView{
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor colorWithRed:0.86 green:0.89 blue:0.91 alpha:1];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setImage:[UIImage imageNamed:@"item-btn-share-black"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(showMNShareMoreView) forControlEvents:UIControlEventTouchUpInside];
    
    _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectBtn setImage:[UIImage imageNamed:@"item-btn-like-black"] forState:UIControlStateNormal];
    [_collectBtn addTarget:self action:@selector(clickCollectBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _likeAnmations = @[].mutableCopy;
    _dislikeAnmations = @[].mutableCopy;
    for (NSUInteger i = 1; i < 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"liked_%zd", i]];
        [_likeAnmations addObject:image];
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
    [_praiseBtn setImage:[UIImage imageNamed:@"item-btn-thumb-black"] forState:UIControlStateNormal];
    _praiseBtn.titleLabel.font = REGULARFONT(12);
    [_praiseBtn setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1] forState:UIControlStateNormal];
    _communicateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_communicateBtn setImage:[UIImage imageNamed:@"item-btn-comment-black"] forState:UIControlStateNormal];
     [_communicateBtn setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1] forState:UIControlStateNormal];
    _communicateBtn.titleLabel.font = REGULARFONT(12);
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBtn setImage:[UIImage imageNamed:@"icon-more-grey"] forState:UIControlStateNormal];
    
    NSArray *views = @[lineView,_shareBtn,_collectBtn,_praiseBtn,_communicateBtn,_moreBtn,bottomView,_dislikeImageView,_likeImageView];
    [self sd_addSubviews:views];
    
    lineView.sd_layout.topEqualToView(self).leftSpaceToView(self, KMarginLeft).rightSpaceToView(self, KMarginRight).heightIs(0.5);
    _shareBtn.sd_layout.leftEqualToView(self).topSpaceToView(lineView, 0).widthIs(kButtonWidth).heightIs(kButtonHeight);
    _collectBtn.sd_layout.leftSpaceToView(_shareBtn, 0).topEqualToView(_shareBtn).widthIs(kButtonWidth).heightIs(kButtonHeight);
    _praiseBtn.sd_layout.leftSpaceToView(_collectBtn, 0).topEqualToView(_collectBtn).widthIs(kButtonWidth).heightIs(kButtonHeight);
    [_praiseBtn setupAutoSizeWithHorizontalPadding:4 buttonHeight:kButtonHeight];
    _communicateBtn.sd_layout.leftSpaceToView(_praiseBtn, 0).topEqualToView(_praiseBtn).widthIs(kButtonWidth).heightIs(kButtonHeight);
    [_communicateBtn setupAutoSizeWithHorizontalPadding:4 buttonHeight:kButtonHeight];
    _moreBtn.sd_layout.rightEqualToView(lineView).centerYEqualToView(_shareBtn).widthIs(16).heightIs(3);
    bottomView.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(_shareBtn, 0).heightIs(10);
     _likeImageView.sd_layout.bottomEqualToView(_shareBtn).leftEqualToView(_collectBtn).widthIs(45).heightIs(90);
    //55 54
_dislikeImageView.sd_layout.bottomEqualToView(_shareBtn).leftEqualToView(_collectBtn).widthIs(55).heightIs(54);
}

-(void)setBottomModel:(RecommendModel *)bottomModel
{
    _bottomModel = bottomModel;
    [_praiseBtn setTitle:[NSString stringWithFormat:@"%zd",bottomModel.bang_count] forState:UIControlStateNormal];
     [_communicateBtn setTitle:[NSString stringWithFormat:@"%zd",bottomModel.comment_count] forState:UIControlStateNormal];
}

-(void)showMNShareMoreView
{
    MNShareMoreView *moreView = [[MNShareMoreView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    moreView.delegate = self;
    [moreView appear];
}

-(void)clickCollectBtn
{
    _bottomModel.is_folded = !_bottomModel.is_folded;
    if(_bottomModel.is_folded){
        [_likeImageView startAnimating];
        [_collectBtn setImage:[UIImage imageNamed:@"item-btn-like-on"] forState:UIControlStateNormal];
    }else{
        [_dislikeImageView startAnimating];
        [_collectBtn setImage:[UIImage imageNamed:@"item-btn-like-black"] forState:UIControlStateNormal];
    }
}

#pragma mark - MNShareMoreViewDelegate
-(void)MNShareMoreViewSelectedItem:(NSInteger)item
{
    NSLog(@"点击了第%zd个按钮",item);
}
@end
