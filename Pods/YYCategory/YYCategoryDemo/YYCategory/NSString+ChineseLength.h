//
//  NSString+ChineseLength.h
//  WoodpeckerDoctors
//
//  Created by Ariel on 15/10/27.
//  Copyright © 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ChineseLength)
/**
 *  判断是否为汉字
 *
 *  @param string
 *
 *  @return BoolValue
 */
+ (BOOL)isChinesecharacter:(NSString *)string;


/**
 *  计算汉字的个数
 *
 *  @param string
 *
 *  @return NSInteger
 */
+ (NSInteger)chineseCountOfString:(NSString *)string;


/**
 *  计算字母的个数
 *
 *  @param string
 *
 *  @return NSInteger
 */
+ (NSInteger)characterCountOfString:(NSString *)string;
@end
