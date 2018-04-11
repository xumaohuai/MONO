//
//  NSString+ChineseLength.m
//  WoodpeckerDoctors
//
//  Created by Ariel on 15/10/27.
//  Copyright © 2015年 Ariel. All rights reserved.
//

#import "NSString+ChineseLength.h"

@implementation NSString (ChineseLength)
+ (BOOL)isChinesecharacter:(NSString *)string{
    if (string.length == 0) {
        return NO;
    }
    unichar c = [string characterAtIndex:0];
    if (c >=0x4E00 && c <=0x9FA5)     {
        return YES;//汉字
    }else {
        return NO;//英文
    }
}

+ (NSInteger)chineseCountOfString:(NSString *)string{
    int ChineseCount = 0;
    if (string.length == 0) {
        return 0;
    }
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
            ChineseCount++ ;//汉字
        }
    }
    return ChineseCount;
}

+ (NSInteger)characterCountOfString:(NSString *)string{
    int characterCount = 0;
    if (string.length == 0) {
        return 0;
    }
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
        }else {
            characterCount++;//英文
        }
    }
    return characterCount;
}

@end
