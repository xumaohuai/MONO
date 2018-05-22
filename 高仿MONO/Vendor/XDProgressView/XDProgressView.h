//
//  XDProgressView.h
//  XDProgressView
//
//  Created by xindong on 17/2/9.
//  Copyright © 2017年 xindong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDProgressView : UIView

/// 0.0 .. 1.0, default is 0.0. values outside are pinned.
@property (nonatomic, assign) float progress;

/// The color shown for the portion of the progress bar that is filled.
@property (nonatomic, strong, nullable) UIColor *progressTintColor;

/// The color shown for the portion of the progress bar that is not filled.
@property (nonatomic, strong, nullable) UIColor *trackTintColor;

/// An image to use for the portion of the progress bar that is filled. If you provide a custom image, the progressTintColor property is ignored.
@property (nonatomic, strong, nullable) UIImage *progressImage;

/// An image to use for the portion of the track that is not filled. If you provide a custom image, the trackTintColor property is ignored.
@property (nonatomic, strong, nullable) UIImage *trackImage;
@property (nonatomic, strong, nullable) NSString *text; // default is nil.
@property (nonatomic, strong, nullable) UIColor *textColor; // default is white color.
@property (nonatomic, strong, nullable) UIFont  *font; // default is system font 17.0.
@property (nonatomic, assign) NSTextAlignment textAlignment; // default is left.

/// Both XDProgressView and progress bar present rounded corner style.
@property (nonatomic, assign) BOOL roundedCorner;

/// The animation duration when call `setProgress:animated:` method and set animated parameter value to YES. Default value is 1/4s.
@property (nonatomic, assign) CFTimeInterval animationDuration;

/// Adjusts the current progress shown by the receiver, optionally animating the change.
- (void)setProgress:(float)progress animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
