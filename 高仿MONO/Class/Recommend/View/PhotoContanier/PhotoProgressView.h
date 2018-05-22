//
//  PhotoProgressView.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/10.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYAnimatedImageView;
@interface PhotoProgressView : UIView
@property(nonatomic,strong) YYAnimatedImageView *imageView;
@property (nonatomic,copy) NSString *imageUrl;
-(void)setUpProgressView;
@end
