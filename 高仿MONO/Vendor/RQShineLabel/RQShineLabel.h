//
//  TSTextShineView.h
//  TextShine
//
//  Created by Genki on 5/7/14.
//  Copyright (c) 2014 Reteq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RQShineLabel: UILabel

/**
 *  Fade in text animation duration. Defaults to 2.5.
 */
@property (assign, nonatomic, readwrite) CFTimeInterval shineDuration;

/**
 *  Fade out duration. Defaults to 2.5.
 */
@property (assign, nonatomic, readwrite) CFTimeInterval fadeoutDuration;


/**
 *  Auto start the animation. Defaults to NO.
 */
@property (assign, nonatomic, readwrite, getter = isAutoStart) BOOL autoStart;

/**
 *  Check if the animation is finished
 */
@property (assign, nonatomic, readonly, getter = isShining) BOOL shining;

/**
 *  Check if visible
 */
@property (assign, nonatomic, readonly, getter = isVisible) BOOL visible;

@property (assign, nonatomic, getter = isFadedOut) BOOL fadedOut;

/**
 *  Start the animation
 */
- (void)shineWithHasShined:(BOOL)hasShine;
- (void)shine;
- (void)shineWithCompletion:(void (^)())completion;
- (void)fadeOut;
- (void)fadeOutWithCompletion:(void (^)())completion;

@end
