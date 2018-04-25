//
//  Thumb.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseModel.h"

@interface Thumb : MNBaseModel
@property (nonatomic,copy) NSString *raw;//大图地址(已被裁切好了,不用再裁切了,尼玛,人家的UI!!!!!!)
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,copy) NSString *format;//图片类型
@end
