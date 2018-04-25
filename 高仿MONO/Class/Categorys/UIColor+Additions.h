//
//  UIColor+Additions.h
//  QMQZ_Rebuild
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)


+ (UIColor *)getColorWithHexString:(NSString*)hexColor;

+ (UIColor *)getColorWithHexString:(NSString*)hexColor alpha:(CGFloat)alpha;


+ (UIColor *)getColorWithR:(int)r g:(int)g b:(int)b;

+ (UIColor *)getColorWithR:(int)r g:(int)g b:(int)b alpha:(CGFloat)alpha;

+ (UIColor *)getColor:(NSString*)hexColor;

@end
