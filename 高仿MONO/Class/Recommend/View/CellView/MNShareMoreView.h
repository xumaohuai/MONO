//
//  MNShareMoreView.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/25.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MNShareMoreView;
@protocol MNShareMoreViewDelegate <NSObject>
/** 点击每一个item的事件*/
- (void)MNShareMoreViewSelectedItem:(NSInteger)item;
@end
@interface MNShareMoreView : UIView
@property (nonatomic,weak)id <MNShareMoreViewDelegate>delegate;

- (void)appear;
- (void)disAppear;
@end

@interface MNShareItem : UIView

/** 初始化
 *  image  顶部的image
 *  title  下面的文字
 *  action 点击的方法
 */
- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title target:(id)target action:(SEL)action;

@end
