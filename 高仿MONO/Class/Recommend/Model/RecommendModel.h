//
//  RecommendModel.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/20.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseModel.h"
#import "Sort.h"
#import "User.h"
#import "Thumb.h"
typedef NS_ENUM(NSInteger,MeowType){
        MeowTypeMusic  = 8,//音乐
        MeowTypeRead = 4,//阅读
        MeowTypeReadThird = 5,//阅读(来自第三方)
        MeowTypeTileAndImage = 3,//图片与标题
        MeowTypeOneImage = 2//一张大图
};


@interface RecommendModel : MNBaseModel
@property(nonatomic,strong) NSString *Id;
@property (nonatomic,assign) NSInteger bang_count;//点赞数
@property (nonatomic,assign) NSInteger comment_count;//评论数
@property (nonatomic,assign) BOOL is_folded;
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *descrip;//内容描述
@property (nonatomic,assign) NSInteger object_type;
@property (nonatomic,assign) NSInteger meow_type;
@property (nonatomic,copy) NSString *text;
@property(nonatomic,strong) User *user;
@property(nonatomic,strong) Sort *category;
@property (nonatomic,copy) NSString *song_name;//歌曲名
@property (nonatomic,copy) NSString *artist;//歌手名
@property (nonatomic,copy) NSString *music_url;//歌曲地址

@end


