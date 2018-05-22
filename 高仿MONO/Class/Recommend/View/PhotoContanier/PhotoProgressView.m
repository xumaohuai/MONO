//
//  PhotoProgressView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "PhotoProgressView.h"
#import <YYWebImage.h>
#import "ZZCircleProgress.h"
#define CircleWidth  44
@interface PhotoProgressView()
@property (nonatomic, strong) ZZCircleProgress *progressView;
@property (nonatomic, strong) UIBezierPath *path;
@end

@implementation PhotoProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.imageView                   = [YYAnimatedImageView new];
        [self addSubview:self.imageView];
        self.imageView.sd_layout.leftEqualToView(self).topEqualToView(self).bottomEqualToView(self).rightEqualToView(self);
    }
    return self;
}
-(void)setImageUrl:(NSString *)imageUrl
{
    if([[YYImageCache sharedCache]containsImageForKey:imageUrl]){
        [self.imageView setImage:[[YYImageCache sharedCache]getImageForKey:imageUrl]];
        [self.progressView removeFromSuperview];
    }else{
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:nil options:YYWebImageOptionProgressive | YYWebImageOptionProgressiveBlur | YYWebImageOptionUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.progress = ((CGFloat)receivedSize / expectedSize);
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (image) {
            self.imageView.image = image;
            [self.progressView removeFromSuperview];
        }
    }];
    }
}

-(void)setUpProgressView
{
    if (!_progressView) {
        self.progressView = [[ZZCircleProgress alloc]initWithFrame:CGRectMake(0, 0, CircleWidth, CircleWidth) pathBackColor:[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1] pathFillColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1] startAngle:0 strokeWidth:3];
         self.progressView.progress = 0;
        self.progressView.showPoint = NO;
        self.progressView.showProgressText = NO;
        [self addSubview:self.progressView];
        self.progressView.sd_resetLayout.widthIs(CircleWidth).heightIs(CircleWidth).centerXIs(self.width / 2).centerYIs(self.height / 2);
        self.progressView.backgroundColor = [UIColor clearColor];
    }
}

@end
