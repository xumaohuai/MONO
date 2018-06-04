//
//  DiscoverModel.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/30.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseModel.h"
#import "RecommendModel.h"
@interface BannerMeow : NSObject
@property (nonatomic,assign) NSInteger bang_count;//点赞数(没用)
@property (nonatomic,copy) NSString *banner_img_url;//图片地址
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) NSInteger object_type;
@property(nonatomic,strong) Group *group;
@end

@interface BannerModel : NSObject
@property (nonatomic,copy) NSString *banner_img_url;//图片地址
@property (nonatomic,assign) NSInteger object_type;
@property(nonatomic,strong) BannerMeow *meow;
@property(nonatomic,strong) BannerMeow *collection;
@end

@interface DiscoverModel : MNBaseModel
@property(nonatomic,strong) NSArray<BannerModel *> *entity_list;
@property (nonatomic,assign) BOOL is_last_page;

@end
