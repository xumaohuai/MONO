//
//  DiscoverBannerHeaderView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/30.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "DiscoverBannerHeaderView.h"
#import <SDCycleScrollView.h>
@interface DiscoverBannerHeaderView()<SDCycleScrollViewDelegate>
@property(nonatomic,strong) SDCycleScrollView *cycleView;
@end

@implementation DiscoverBannerHeaderView

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
    _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
    [self addSubview:_cycleView];
}
-(void)setModel:(DiscoverModel *)model
{
    NSMutableArray *picArr = [NSMutableArray array];
    for (BannerModel *bannerModel in model.entity_list) {
        [picArr addObject:bannerModel.banner_img_url];
    }
    _cycleView.imageURLStringsGroup = picArr;
}

@end
