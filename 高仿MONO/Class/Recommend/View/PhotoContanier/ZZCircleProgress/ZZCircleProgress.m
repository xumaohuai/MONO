//
//  ZZCircleProgress.m
//  ZZCircleProgressDemo
//
//  Created by iMac on 2016/12/23.
//  Copyright © 2016年 zhouxing. All rights reserved.
//

#import "ZZCircleProgress.h"
#import "NSTimer+timerBlock.h"

//角度转换为弧度
#define CircleDegreeToRadian(d) ((d)*M_PI)/180.0
//255进制颜色转换
#define CircleRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//宽高定义
#define CircleSelfWidth self.frame.size.width
#define CircleSelfHeight self.frame.size.height


@implementation ZZCircleProgress
{
    CGFloat fakeProgress;
    NSTimer *timer;//定时器用作动画
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame
                pathBackColor:(UIColor *)pathBackColor
                pathFillColor:(UIColor *)pathFillColor
                   startAngle:(CGFloat)startAngle
                  strokeWidth:(CGFloat)strokeWidth {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        if (pathBackColor) {
            _pathBackColor = pathBackColor;
        }
        if (pathFillColor) {
            _pathFillColor = pathFillColor;
        }
        _startAngle = CircleDegreeToRadian(startAngle);
        _strokeWidth = strokeWidth;
    }
    return self;
}

//初始化数据
- (void)initialization {
    self.backgroundColor = [UIColor clearColor];
    _pathBackColor = CircleRGB(204, 204, 204);
    _pathFillColor = CircleRGB(219, 184, 102);
    _strokeWidth = 10;//线宽默认为10
    _startAngle = -CircleDegreeToRadian(90);//圆起点位置
    _reduceAngle = CircleDegreeToRadian(0);//整个圆缺少的角度
    _animationModel = CircleIncreaseByProgress;//根据进度来
    _showPoint = YES;//小圆点
    _showProgressText = YES;//文字
    _forceRefresh = NO;//一直刷新动画
    
    fakeProgress = 0.0;//用来逐渐增加直到等于progress的值
    //获取图片资源
    NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"ZZCircleProgress" ofType:@"bundle"]];
    _pointImage = [UIImage imageNamed:@"circle_point1" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
}

#pragma Set
- (void)setStartAngle:(CGFloat)startAngle {
    if (_startAngle != CircleDegreeToRadian(startAngle)) {
        _startAngle = CircleDegreeToRadian(startAngle);
        [self setNeedsDisplay];
    }
}

- (void)setReduceAngle:(CGFloat)reduceAngle {
    if (_reduceAngle != CircleDegreeToRadian(reduceAngle)) {
        if (reduceAngle>=360) {
            return;
        }
        _reduceAngle = CircleDegreeToRadian(reduceAngle);
        [self setNeedsDisplay];
    }
}

- (void)setStrokeWidth:(CGFloat)strokeWidth {
    if (_strokeWidth != strokeWidth) {
        _strokeWidth = strokeWidth;
        [self setNeedsDisplay];
    }
}

- (void)setPathBackColor:(UIColor *)pathBackColor {
    if (_pathBackColor != pathBackColor) {
        _pathBackColor = pathBackColor;
        [self setNeedsDisplay];
    }
}

- (void)setPathFillColor:(UIColor *)pathFillColor {
    if (_pathFillColor != pathFillColor) {
        _pathFillColor = pathFillColor;
        [self setNeedsDisplay];
    }
}

- (void)setShowPoint:(BOOL)showPoint {
    if (_showPoint != showPoint) {
        _showPoint = showPoint;
        [self setNeedsDisplay];
    }
}

-(void)setShowProgressText:(BOOL)showProgressText {
    if (_showProgressText != showProgressText) {
        _showProgressText = showProgressText;
        [self setNeedsDisplay];
    }
}


//画背景线、填充线、小圆点、文字
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置中心点 半径 起点及终点
    CGFloat maxWidth = self.frame.size.width<self.frame.size.height?self.frame.size.width:self.frame.size.height;
    CGPoint center = CGPointMake(maxWidth/2.0, maxWidth/2.0);
    CGFloat radius = maxWidth/2.0-_strokeWidth/2.0-1;//留出一像素，防止与边界相切的地方被切平
    CGFloat endA = _startAngle + (CircleDegreeToRadian(360) - _reduceAngle);//圆终点位置
    CGFloat valueEndA = _startAngle + (CircleDegreeToRadian(360)-_reduceAngle)*fakeProgress;  //数值终点位置
    
    //背景线
    UIBezierPath *basePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:endA clockwise:YES];
    //线条宽度
    CGContextSetLineWidth(ctx, _strokeWidth);
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //线条颜色
    [_pathBackColor setStroke];
    //把路径添加到上下文
    CGContextAddPath(ctx, basePath.CGPath);
    //渲染背景线
    CGContextStrokePath(ctx);
    
    //路径线
    UIBezierPath *valuePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:valueEndA clockwise:YES];
    //设置线条顶端
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //线条颜色
    [_pathFillColor setStroke];
    //把路径添加到上下文
    CGContextAddPath(ctx, valuePath.CGPath);
    //渲染数值线
    CGContextStrokePath(ctx);
    
    //画小圆点
    if (_showPoint) {
        CGContextDrawImage(ctx, CGRectMake(CircleSelfWidth/2 + ((CGRectGetWidth(self.bounds)-_strokeWidth)/2.f-1)*cosf(valueEndA)-_strokeWidth/2.0, CircleSelfWidth/2 + ((CGRectGetWidth(self.bounds)-_strokeWidth)/2.f-1)*sinf(valueEndA)-_strokeWidth/2.0, _strokeWidth, _strokeWidth), _pointImage.CGImage);
    }
    
    if (_showProgressText) {
        //画文字
        NSString *currentText = [NSString stringWithFormat:@"%.2f%%",fakeProgress*100];
        //段落格式
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle.alignment = NSTextAlignmentCenter;//水平居中
        //字体
        UIFont *font = [UIFont systemFontOfSize:0.15*CircleSelfWidth];
        //构建属性集合
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
        //获得size
        CGSize stringSize = [currentText sizeWithAttributes:attributes];
        //垂直居中
        CGRect r = CGRectMake((CircleSelfWidth-stringSize.width)/2.0, (CircleSelfHeight - stringSize.height)/2.0,stringSize.width, stringSize.height);
        [currentText drawInRect:r withAttributes:attributes];
    }
    
}

//设置进度
- (void)setProgress:(CGFloat)progress {

    //赋真实值
    _progress = progress;
    fakeProgress = _progress;
    [self setNeedsDisplay];

}

//最后一次动画所做的处理
- (void)dealWithLast {
    //最后一次赋准确值
    fakeProgress = _progress;
    [self setNeedsDisplay];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

@end
