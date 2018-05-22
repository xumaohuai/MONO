//
//  RecommendModel.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/20.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MNBaseModel.h"
@class MNBaseTableViewCell;

@interface Sort : MNBaseModel
@property (nonatomic,assign) NSInteger Id;
@property (nonatomic,copy) NSString *name;//类型名称
@end

@interface Thumb : MNBaseModel
@property (nonatomic,copy) NSString *raw;//大图地址(已被裁切好了,不用再裁切了,尼玛,人家的UI!!!!!!)
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,copy) NSString *format;//图片类型
@property (nonatomic,assign) NSInteger error_code;

@end

@interface User : MNBaseModel
@property (nonatomic,copy) NSString *avatar_url;//头像地址
@property (nonatomic,copy) NSString *user_id;//作者id
@property (nonatomic,copy) NSString *name;//作者名称
@property (nonatomic,assign) BOOL is_anonymous;

@end

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
@property(nonatomic,strong) Thumb *thumb;
@property(nonatomic,strong) Thumb *logo_url_thumb;
@property(nonatomic,strong) Thumb *album_cover;
@property (nonatomic,assign) unsigned music_duration;//歌曲总长(秒)
@property (nonatomic,assign) unsigned video_duration;


@property (nonatomic,copy) NSString *song_name;//歌曲名
@property (nonatomic,copy) NSString *artist;//歌手名
@property (nonatomic,copy) NSString *music_url;//歌曲地址
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,copy) NSString *author;
@property(nonatomic,strong) NSArray<Thumb*> *pics;
@property(nonatomic,strong) NSArray<Thumb*> *images;
@property (assign, nonatomic, getter = isFadedOut) BOOL hasShine;
@property(nonatomic,strong) NSURL *videoUrl;

//获取cell的identifier
@property (nonatomic,copy) NSString *cellIdentifier;

@end



