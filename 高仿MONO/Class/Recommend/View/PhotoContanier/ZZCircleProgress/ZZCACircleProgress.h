//
//  ZZCACircleProgress.h
//  ZZCircleProgressDemo
//
//  Created by 周兴 on 2017/7/24.
//  Copyright © 2017年 zhouxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZCountingLabel.h"

@interface ZZCACircleProgress : UIView

//图形定制
@property (nonatomic, strong) UIColor *pathBackColor;/**<线条背景色*/
@property (nonatomic, strong) UIColor *pathFillColor;/**<线条填充色*/
@property (nonatomic, strong) UIImageView *pointImage;/**<小圆点图片*/
@property (nonatomic, strong) ZZCountingLabel *progressLabel;

//角度相关
@property (nonatomic, assign) CGFloat startAngle;/**<起点角度。角度从水平右侧开始为0，顺时针为增加角度。直接传度数 如-90 */
@property (nonatomic, assign) CGFloat reduceAngle;/**<减少的角度 直接传度数 如30*/
@property (nonatomic, assign) CGFloat strokeWidth;/**<线宽*/

@property (nonatomic, assign) CGFloat duration;/**<动画时长*/

@property (nonatomic, assign) BOOL showPoint;/**<是否显示小圆点*/
@property (nonatomic, assign) BOOL showProgressText;/**<是否显示文字*/
@property (nonatomic, assign) BOOL increaseFromLast;/**<是否从上次数值开始动画，默认为NO*/

@property (nonatomic, assign) BOOL prepareToShow;/**<是否准备好显示, 如果创建好就显示必须在设置完其他属性后最后设置此属性为YES*/

//进度
@property (nonatomic, assign) CGFloat progress;/**<进度 0-1 */

//初始化
- (instancetype)initWithFrame:(CGRect)frame
                pathBackColor:(UIColor *)pathBackColor
                pathFillColor:(UIColor *)pathFillColor
                   startAngle:(CGFloat)startAngle
                  strokeWidth:(CGFloat)strokeWidth;

@end
