//
//  MBSwitch.h
//  MBSwitchDemo
//
//  Created by Mathieu Bolard on 22/06/13.
//  Copyright (c) 2013 Mathieu Bolard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBSwitch : UIControl

@property(nonatomic, retain) UIColor *tintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, retain) UIColor *onTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, assign) UIColor *offTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, assign) UIColor *thumbTintColor UI_APPEARANCE_SELECTOR;

@property(nonatomic,getter=isOn) BOOL on;

- (id)initWithFrame:(CGRect)frame;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

- (void)setOnImageNamed:(NSString*)imageName;
- (void)setOffImageNamed:(NSString*)imageName;

@end
