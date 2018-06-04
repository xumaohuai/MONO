//
//  CommendMethod.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/29.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "CommendMethod.h"
#import "MNNetworkTool.h"
#import <YYCache.h>
#import <AFNetworking.h>
@implementation CommendMethod
+(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    if (!string.length) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}



+(NSString *)getMMSSFromSS:(unsigned int)totalTime
{
    NSString *str_minute = [NSString stringWithFormat:@"%02u",(totalTime%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02u",totalTime%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    return format_time;
}

+(NSString *)getTime:(unsigned)totalTime
{
//    NSTimeInterval _interval = [timeStamp doubleValue];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:totalTime];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy.MM.dd"];
    return [objDateformat stringFromDate: date];
}
@end
