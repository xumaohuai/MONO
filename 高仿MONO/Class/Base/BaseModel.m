//
//  BaseModel.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/6/1.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "BaseModel.h"
#import <objc/message.h>
@implementation BaseModel
- (void)encodeWithCoder:(NSCoder*)coder
{
    //利用runtime 来归档!!
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //拿出每一个Ivar
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * KEY = [NSString stringWithUTF8String:name];
        //归档
        [coder encodeObject:[self valueForKey:KEY] forKey:KEY];
    }
    //C语言里面!! 一旦遇到了copy creat new 需要释放
    free(ivars);
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * KEY = [NSString stringWithUTF8String:name];
            //解档
            id value = [aDecoder decodeObjectForKey:KEY];
            //通过KVC 设置
            [self setValue:value forKey:KEY];
        }
        free(ivars);
    }
    return self;
}

@end
