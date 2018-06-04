//
//  FileManager.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/6/1.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "FileManager.h"
#import <YYCache.h>
@implementation FileManager
+(instancetype)manager
{
    static dispatch_once_t once;
    static FileManager *instanceUser;
    dispatch_once(&once, ^ {
        YYCache *cache = [YYCache cacheWithName:@"mono_db"];
        BOOL contain = [cache containsObjectForKey:@"mn"];
        if (contain) {
            //            UCUser *cachedUser = [cache objectForKey:@"uc"];
            instanceUser = (FileManager *)[cache objectForKey:@"mn"];
            NSLog(@"%@",instanceUser);
        } else {
            instanceUser = [[FileManager alloc] init];
            [instanceUser clear];
            [cache setObject:instanceUser forKey:@"mn"];
        }
    });
    return instanceUser;
}
-(void)clear
{
    _musicListArr = [NSMutableArray array];
}

//缓存登录用户
-(void)cacheSelf
{
    if (self == [FileManager manager]) {
        YYCache *cache = [YYCache cacheWithName:@"mono_db"];
        [cache setObject:[FileManager manager] forKey:@"mn" withBlock:nil];
    }
}
@end
