//
//  GGStartMovieHelper.m
//  MONO
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 Mr.Gao. All rights reserved.
//

#import "GGStartMovieHelper.h"
#import "GGStartMovieView.h"

@interface GGStartMovieHelper ()
@property (strong, nonatomic) GGStartMovieView *startMovieView;

@end

@implementation GGStartMovieHelper

static GGStartMovieHelper *shareInstance_ = nil;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance_ = [[GGStartMovieHelper alloc] init];
    });
    return shareInstance_;
}

+ (void)showStartMovieViewWithMovieURL:(NSString *)movieURL musicURL:(NSString *)musicURL{
    if (![GGStartMovieHelper shareInstance].startMovieView) {
        
        GGStartMovieView *startMovieView = [GGStartMovieView movieView];
        startMovieView.movieURL = movieURL;
        startMovieView.musicURL = musicURL;
        [GGStartMovieHelper shareInstance].startMovieView = startMovieView;
        
    }
    [[UIApplication sharedApplication].keyWindow addSubview:[GGStartMovieHelper shareInstance].startMovieView];
}

@end
