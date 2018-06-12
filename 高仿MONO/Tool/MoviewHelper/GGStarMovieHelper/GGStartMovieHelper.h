//
//  GGStartMovieHelper.h
//  MONO
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 Mr.Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGStartMovieHelper : NSObject

+ (instancetype)shareInstance;

+ (void)showStartMovieViewWithMovieURL:(NSString *)movieURL musicURL:(NSString *)musicURL; 

@end
