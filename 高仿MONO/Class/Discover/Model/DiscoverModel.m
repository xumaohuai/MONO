//
//  DiscoverModel.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/5/30.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "DiscoverModel.h"

@implementation BannerMeow
@end
@implementation BannerModel
@end

@implementation DiscoverModel
+(NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"meow":[BannerMeow class],@"category":[Sort class],@"thumb":[Thumb class],@"pics":[Thumb class],@"album_cover":[Thumb class],@"logo_url_thumb":[Thumb class],@"images":[Thumb class],@"group":[Group class],@"BannerModel":[BannerModel class],@"entity_list":[BannerModel class]};
}
@end
