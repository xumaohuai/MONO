//
//  User.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/23.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseModel.h"

@interface User : MNBaseModel
@property (nonatomic,copy) NSString *avatar_url;//头像地址
@property (nonatomic,copy) NSString *user_id;//作者id
@property (nonatomic,copy) NSString *name;//作者名称
@end
