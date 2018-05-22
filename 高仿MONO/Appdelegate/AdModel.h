//
//  AdModel.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/29.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseModel.h"

@interface AdModel : MNBaseModel
@property (nonatomic,assign) NSInteger modified_time;//修改时间
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger duration;//停留时间
@property (nonatomic,assign) NSInteger Id;
@property (nonatomic,assign) BOOL skip_enabled;//是否可以点击跳转
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) BOOL hide_mono_logo;//是否隐藏底部logo
@property (nonatomic,copy) NSString *external_link_url;//跳转网页链接
@property (nonatomic,copy) NSString *image_url;//图片url地址

@end
