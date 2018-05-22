//
//  RecommendModel.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/20.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "RecommendModel.h"
#import "RecommendReadCell.h"
#import "RecommendImageBgCell.h"
#import "RecommendImagesCell.h"
#import "RecommendMusicCell.h"
#import "RecommendVideoCell.h"
#import "RecommendPicturesCell.h"
#import "RecommendTeaCell.h"
@implementation Sort
@end

@implementation User
@end

@implementation Thumb
@end

@implementation RecommendModel
+(NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user":[User class],@"category":[Sort class],@"thumb":[Thumb class],@"pics":[Thumb class],@"album_cover":[Thumb class],@"logo_url_thumb":[Thumb class],@"images":[Thumb class]};
}
-(NSString *)cellIdentifier
{
    switch (self.meow_type) {
        case MeowTypeImageBg:
            return NSStringFromClass([RecommendImageBgCell class]);
            break;
        case MeowTypeImages:
            return NSStringFromClass([RecommendImagesCell class]);
            break;
        case MeowTypeMusic:
            return NSStringFromClass([RecommendMusicCell class]);
            break;
        case MeowTypeVideo:
            return NSStringFromClass([RecommendVideoCell class]);
            break;
        case MeowTypeRead:
            return NSStringFromClass([RecommendReadCell class]);
            break;
        case MeowTypeReadThird:
            return NSStringFromClass([RecommendReadCell class]);
            break;
        case MeowTypeTea:
            return NSStringFromClass([RecommendTeaCell class]);
            break;
        default:
            return NSStringFromClass([RecommendPicturesCell class]);
            break;
    }
}

@end
