//
//  NSTimer+timerBlock.m
//  ZZCircleViewDemo
//
//  Created by iMac on 2016/12/22.
//  Copyright © 2016年 zhouxing. All rights reserved.
//

#import "NSTimer+timerBlock.h"

@implementation NSTimer (timerBlock)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)blockInvoke:(NSTimer *)timer {
    void (^ block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
