//
//  SDWeiXinPhotoContainerView.m
//  SDAutoLayout 测试 Demo
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年 gsd. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 362419100(2群) 459274049（1群已满）
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import "SDWeiXinPhotoContainerView.h"
#import "RecommendModel.h"
#import "UIView+SDAutoLayout.h"
#import <YYWebImage.h>
#import "YBImageBrowser.h"
#import "PhotoProgressView.h"
//#import "LKImageKit.h"

@interface SDWeiXinPhotoContainerView () <YBImageBrowserDataSource>
{
    NSInteger _currentIndex;
}
@property (nonatomic, strong) NSArray *imageViewsArray;
@property(nonatomic,strong) NSMutableArray *animateImageArr;

@end

@implementation SDWeiXinPhotoContainerView

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
