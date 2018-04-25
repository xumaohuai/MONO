//
//  MNRefreshHeader.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNRefreshBlackHeader.h"

@interface MNRefreshBlackHeader()
@property(nonatomic,strong) UIImageView *refreshImageView;
@end

@implementation MNRefreshBlackHeader

- (void)prepare
{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    NSMutableArray *idleImages = [NSMutableArray array];
    UIImage *image = [UIImage imageNamed:@"mono-black-20"];
    [idleImages addObject:image];
    
    [self setImages:idleImages forState:MJRefreshStateIdle];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i < 21; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"mono-black-%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages duration:1 forState:MJRefreshStatePulling];
}

@end
