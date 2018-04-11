//
//  UIImage+Stretch.h
//  
//
//  Created by Stephen Liu on 11/17/11.
//  Copyright (c) 2011 Stephen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Stretch)

- (UIImage *)stretchableImageByCenter;
- (UIImage *)stretchableImageByHeightCenter;
- (UIImage *)stretchableImageByWidthCenter;

/**
 The right horizontal end-cap size. (read-only)
 
 End caps specify the portion of an image that should not be resized when an image is stretched. This technique is used
 to implement buttons and other resizable image-based interface elements. When a button with end caps is resized, the
 resizing occurs only in the middle of the button, in the region between the end caps. The end caps themselves keep
 their original size and appearance.
 
 This property specifies the size of the left end cap. The middle (stretchable) portion is assumed to be `1` pixel wide.
 
 By default, this property is set to `0`, which indicates that the image does not use end caps and the entire image is
 subject to stretching. To create a new image with a nonzero value for this property, use the
 `stretchableImageWithLeftCapWidth:topCapHeight:` method.
 */
@property (nonatomic, readonly) NSInteger rightCapWidth;

/**
 The bottom vertical end-cap size. (read-only)
 
 End caps specify the portion of an image that should not be resized when an image is stretched. This technique is used
 to implement buttons and other resizable image-based interface elements. When a button with end caps is resized, the
 resizing occurs only in the middle of the button, in the region between the end caps. The end caps themselves keep
 their original size and appearance.
 
 This property specifies the size of the top end cap. The middle (stretchable) portion is assumed to be `1` pixel wide.
 
 By default, this property is set to `0`, which indicates that the image does not use end caps and the entire image is
 subject to stretching. To create a new image with a nonzero value for this property, use the
 `stretchableImageWithLeftCapWidth:topCapHeight:` method.
 */
@property (nonatomic, readonly) NSInteger bottomCapHeight;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color radiu:(CGFloat)radiu;
@end
