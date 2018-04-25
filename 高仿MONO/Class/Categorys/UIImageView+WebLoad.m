//
//  UIImageView+WebLoad.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/24.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "UIImageView+WebLoad.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (WebLoad)
-(void)setAvatarWithUrlString:(NSString *)urlString
{
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"avatorCover_icon_normal"]];
}
@end
