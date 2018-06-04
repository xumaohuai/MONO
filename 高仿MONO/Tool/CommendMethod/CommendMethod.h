//
//  CommendMethod.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/29.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommendMethod : NSObject
+(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;
+(NSString *)getMMSSFromSS:(unsigned)totalTime;
+(NSString *)getTime:(unsigned)totalTime;
@end
