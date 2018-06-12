//
//  GGStartMovieView.h
//  MONO
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGStartMovieView : UIView

+ (instancetype)movieView;

@property (nonatomic, strong) NSString *musicURL;

@property (nonatomic, strong) NSString *movieURL;

@end
