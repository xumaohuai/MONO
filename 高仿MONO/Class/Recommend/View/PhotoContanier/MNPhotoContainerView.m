//
//  MNPhotoContainerView.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/6/4.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNPhotoContainerView.h"
#import "RecommendModel.h"
#import "UIView+SDAutoLayout.h"
#import <YYWebImage.h>
#import "YBImageBrowser.h"
#import "PhotoProgressView.h"

@interface MNPhotoContainerView()<YBImageBrowserDataSource>
{
    NSInteger _currentIndex;
}
@property (nonatomic, strong) NSArray *imageViewsArray;
@property(nonatomic,strong) NSMutableArray *animateImageArr;

@end

@implementation MNPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        PhotoProgressView *photoView = [PhotoProgressView new];
        photoView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
        [self addSubview:photoView];
        photoView.userInteractionEnabled = YES;
        photoView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [photoView addGestureRecognizer:tap];
        [temp addObject:photoView];
    }
    
    self.imageViewsArray = [temp copy];
}


-(void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        PhotoProgressView *imageView = [self.imageViewsArray objectAtIndex:i];
        //        imageView.imageView.image = nil;
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
    if (_picPathStringsArray.count == 1) {
        Thumb *thumb = _picPathStringsArray.firstObject;
        itemH = thumb.height / thumb.width * itemW;
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 5;
    _animateImageArr = [NSMutableArray array];
    for (int i = 0; i < _picPathStringsArray.count; i++) {
        Thumb *thumb = _picPathStringsArray[i];
        [_animateImageArr addObject:[UIImage new]];
        long columnIndex = i % perRowItemCount;
        long rowIndex = i / perRowItemCount;
        PhotoProgressView *photoView = [_imageViewsArray objectAtIndex:i];
        photoView.hidden = NO;
        photoView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        [photoView setUpProgressView];
        NSInteger width = thumb.width;
        NSInteger height = thumb.height;
        CGFloat scale = ((CGFloat)height / width) / (photoView.height / photoView.width);
        if ( isnan(scale)) {
            photoView.imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
        }else if(scale < 0.99 ){// 宽图把左右两边裁掉
            photoView.imageView.layer.contentsRect = CGRectMake((1 -(float)height / width) / 2, 0, (float)height / width, 1);
        } else { // 高图把上下裁掉
            photoView.imageView.layer.contentsRect = CGRectMake(0, (1- (float)width / height) / 2, 1, (float)width / height);
        }
        photoView.imageUrl = thumb.raw;
    }
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;
    
    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
}

- (UIImage *)imageDataFromDiskCacheWithKey:(NSString *)key {
    
    YYImage *img = [YYImage imageWithData:[[YYImageCache sharedCache]getImageDataForKey:key]];
    return img;
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return SCREEN_WIDTH - 2 * KMarginRight;
    } else if (array.count == 4){
        CGFloat w = (SCREEN_WIDTH - 2 * (KMarginRight + 5) + 5) / 2;
        return w;
    } else {
        CGFloat w = (SCREEN_WIDTH - 2 * (KMarginRight + 5)) / 3;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}


#pragma mark - SDPhotoBrowserDelegate
#pragma mark - private actions
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSource = self;
    browser.currentIndex = imageView.tag;
    _currentIndex = imageView.tag;
    [browser show];
}
//YBImageBrowserDataSource 代理实现赋值数据
- (NSInteger)numberInYBImageBrowser:(YBImageBrowser *)imageBrowser {
    return self.picPathStringsArray.count;
}
- (YBImageBrowserModel *)yBImageBrowser:(YBImageBrowser *)imageBrowser modelForCellAtIndex:(NSInteger)index {
    YBImageBrowserModel *model = [YBImageBrowserModel new];
    Thumb *thumb = self.picPathStringsArray[index];
    model.url = [NSURL URLWithString:thumb.raw];
    PhotoProgressView *photoView = [_imageViewsArray objectAtIndex:index];
    model.image = photoView.imageView.image;
    model.sourceImageView = photoView.imageView;
    return model;
}
- (UIImageView *)imageViewOfTouchForImageBrowser:(YBImageBrowser *)imageBrowser {
    PhotoProgressView *photoView = [_imageViewsArray objectAtIndex:_currentIndex];
    return photoView.imageView;
}


@end
