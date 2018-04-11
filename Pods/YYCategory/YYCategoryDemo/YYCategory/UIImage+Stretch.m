//
//  UIImage+Stretch.m
//  
//
//  Created by Stephen Liu on 11/17/11.
//  Copyright (c) 2011 Stephen. All rights reserved.
//

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)

- (UIImage *)stretchableImageByCenter
{
	CGFloat leftCapWidth = floorf(self.size.width / 2);
	if (leftCapWidth == self.size.width / 2)
	{
		leftCapWidth--;
	}
	
	CGFloat topCapHeight = floorf(self.size.height / 2);
	if (topCapHeight == self.size.height / 2)
	{
		topCapHeight--;
	}
	
	return [self stretchableImageWithLeftCapWidth:leftCapWidth 
									 topCapHeight:topCapHeight];
}

- (UIImage *)stretchableImageByHeightCenter
{
	CGFloat topCapHeight = floorf(self.size.height / 2);
	if (topCapHeight == self.size.height / 2)
	{
		topCapHeight--;
	}
	
	return [self stretchableImageWithLeftCapWidth:0
									 topCapHeight:topCapHeight];
}

- (UIImage *)stretchableImageByWidthCenter
{
	CGFloat leftCapWidth = floorf(self.size.width / 2);
	if (leftCapWidth == self.size.width / 2)
	{
		leftCapWidth--;
	}
	
	return [self stretchableImageWithLeftCapWidth:leftCapWidth 
									 topCapHeight:0];
}

- (NSInteger)rightCapWidth
{
	return (NSInteger)self.size.width - (self.leftCapWidth + 1);
}


- (NSInteger)bottomCapHeight
{
	return (NSInteger)self.size.height - (self.topCapHeight + 1);
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = [UIGraphicsGetImageFromCurrentImageContext() stretchableImageByCenter];
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color radiu:(CGFloat)radiu
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f + radiu*2, 1.0f + radiu*2);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radiu].CGPath);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *theImage = [UIGraphicsGetImageFromCurrentImageContext() stretchableImageByCenter];
    UIGraphicsEndImageContext();
    return theImage;
}
@end
