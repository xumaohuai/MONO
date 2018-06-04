//
//  ZZCACircleProgress.m
//  ZZCircleProgressDemo
//
//  Created by 周兴 on 2017/7/24.
//  Copyright © 2017年 zhouxing. All rights reserved.
//

#import "ZZCACircleProgress.h"

#define ZZCircleDegreeToRadian(d) ((d)*M_PI)/180.0
#define ZZCircleRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ZZCircleSelfWidth self.frame.size.width
#define ZZCircleSelfHeight self.frame.size.height


@interface ZZCACircleProgress ()

@property (nonatomic, strong) CAShapeLayer *backLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, assign) CGFloat realWidth;//实际边长
@property (nonatomic, assign) CGFloat lastProgress;/**<上次进度 0-1 */

@end

@implementation ZZCACircleProgress

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
        _startAngle = ZZCircleDegreeToRadian(startAngle);
        _strokeWidth = strokeWidth;
        
    }
    return self;
}

//初始化数据
- (void)initialization {
    self.backgroundColor = [UIColor clearColor];
    _pathBackColor = ZZCircleRGB(204, 204, 204);
    _pathFillColor = ZZCircleRGB(219, 184, 102);
    
    _strokeWidth = 10;//线宽默认为10
    _startAngle = ZZCircleDegreeToRadian(0);//圆起点位置
    _reduceAngle = ZZCircleDegreeToRadian(0);//整个圆缺少的角度
    
    _duration = 1.5;//动画时长
    _showPoint = YES;//小圆点
    _showProgressText = YES;//文字
    
    _realWidth = ZZCircleSelfWidth>ZZCircleSelfHeight?ZZCircleSelfHeight:ZZCircleSelfWidth;
    
}

#pragma Get
- (CAShapeLayer *)backLayer {
    if (!_backLayer) {
        _backLayer = [CAShapeLayer layer];
        
        _backLayer.frame = CGRectMake((ZZCircleSelfWidth-_realWidth)/2.0, (ZZCircleSelfHeight-_realWidth)/2.0, _realWidth, _realWidth);
        
        _backLayer.fillColor = [UIColor clearColor].CGColor;//填充色
        _backLayer.lineWidth = _strokeWidth;
        _backLayer.strokeColor = _pathBackColor.CGColor;
        _backLayer.lineCap = @"round";
        
        UIBezierPath *backCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_realWidth/2.0, _realWidth/2.0) radius:_realWidth/2.0 startAngle:_startAngle endAngle:(2*M_PI-_reduceAngle+_startAngle) clockwise:YES];
        self.backLayer.path = backCirclePath.CGPath;
    }
    return _backLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = CGRectMake((ZZCircleSelfWidth-_realWidth)/2.0, (ZZCircleSelfHeight-_realWidth)/2.0, _realWidth, _realWidth);
        
        _progressLayer.fillColor = [UIColor clearColor].CGColor;//填充色
        _progressLayer.lineWidth = _strokeWidth;
        _progressLayer.strokeColor = _pathFillColor.CGColor;
        _progressLayer.lineCap = @"round";
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_realWidth/2.0, _realWidth/2.0) radius:_realWidth/2.0 startAngle:_startAngle endAngle:(2*M_PI-_reduceAngle+_startAngle) clockwise:YES];
        _progressLayer.path = circlePath.CGPath;
        _progressLayer.strokeEnd = 0.0;
    }
    return _progressLayer;
}

- (UIImageView *)pointImage {
    if (!_pointImage) {
        _pointImage = [[UIImageView alloc] init];
        
        NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
        NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"ZZCircleProgress" ofType:@"bundle"]];
        _pointImage.image = [UIImage imageNamed:@"circle_point1" inBundle:resourcesBundle compatibleWithTraitCollection:nil];
        
        CGFloat realWidth = ZZCircleSelfWidth>ZZCircleSelfHeight?ZZCircleSelfHeight:ZZCircleSelfWidth;
        _pointImage.frame = CGRectMake(0, 0, _strokeWidth, _strokeWidth);
        //定位起点位置
        CGPoint shouldPoint = CGPointMake(_realWidth/2.0+(realWidth/2.0)*cosf(_startAngle), _realWidth/2.0+(realWidth/2.0)*sinf(_startAngle));
        _pointImage.center = shouldPoint;
        
    }
    return _pointImage;
}

- (ZZCountingLabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[ZZCountingLabel alloc] init];
        _progressLabel.textColor = [UIColor blackColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:22];
        _progressLabel.text = @"0%";
        _progressLabel.frame = CGRectMake(0, 0, ZZCircleSelfWidth, ZZCircleSelfHeight);
    }
    return _progressLabel;
}

#pragma Set
- (void)setStartAngle:(CGFloat)startAngle {
    if (_startAngle != ZZCircleDegreeToRadian(startAngle)) {
        _startAngle = ZZCircleDegreeToRadian(startAngle);
    }
}

- (void)setReduceAngle:(CGFloat)reduceAngle {
    if (_reduceAngle != ZZCircleDegreeToRadian(reduceAngle)) {
        if (reduceAngle>=360) {
            return;
        }
        _reduceAngle = ZZCircleDegreeToRadian(reduceAngle);
    }
}

- (void)setStrokeWidth:(CGFloat)strokeWidth {
    if (_strokeWidth != strokeWidth) {
        _strokeWidth = strokeWidth;
    }
}

- (void)setPathBackColor:(UIColor *)pathBackColor {
    if (_pathBackColor != pathBackColor) {
        _pathBackColor = pathBackColor;
        self.backLayer.strokeColor = _pathBackColor.CGColor;;
    }
}

- (void)setPathFillColor:(UIColor *)pathFillColor {
    if (_pathFillColor != pathFillColor) {
        _pathFillColor = pathFillColor;
        self.progressLayer.strokeColor = _pathFillColor.CGColor;
    }
}

- (void)setShowPoint:(BOOL)showPoint {
    if (_showPoint != showPoint) {
        _showPoint = showPoint;
        if (_showPoint) {
            self.pointImage.hidden = NO;
        } else {
            self.pointImage.hidden = YES;
        }
    }
}

-(void)setShowProgressText:(BOOL)showProgressText {
    if (_showProgressText != showProgressText) {
        _showProgressText = showProgressText;
        if (_showProgressText) {
            self.progressLabel.hidden = NO;
        } else {
            self.progressLabel.hidden = YES;
        }
    }
}

- (void)setPrepareToShow:(BOOL)prepareToShow {
    if (_prepareToShow != prepareToShow) {
        _prepareToShow = prepareToShow;
        if (_prepareToShow) {
            [self initSubviews];
        }
    }
}

- (void)setProgress:(CGFloat)progress {
    
    //准备好显示
    self.prepareToShow = YES;
    
    _progress = progress;
    if (_progress < 0) {
        _progress = 0;
    }
    if (_progress > 1) {
        _progress = 1;
    }
    
    [self startAnimation];
}

- (void)startAnimation {
    
    //线条动画
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.duration = _duration;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:_increaseFromLast==YES?_lastProgress:0];
    pathAnima.toValue = [NSNumber numberWithFloat:_progress];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.progressLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    if (_showPoint) {
        //小图片动画
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.calculationMode = @"paced";
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.duration = _duration;
        CGMutablePathRef curvedPath = CGPathCreateMutable();
        BOOL shouldNot = NO;
        if (_progress<_lastProgress && _increaseFromLast == YES) {
            shouldNot = YES;
        }
        CGPathAddArc(curvedPath, NULL, _realWidth/2.0, _realWidth/2.0, _realWidth/2.0, _increaseFromLast==YES?(2*M_PI-_reduceAngle)*_lastProgress+_startAngle:_startAngle, (2*M_PI-_reduceAngle)*_progress+_startAngle, shouldNot);
        pathAnimation.path = curvedPath;
        CGPathRelease(curvedPath);
        [self.pointImage.layer addAnimation:pathAnimation forKey:nil];
        if (!_increaseFromLast && _progress == 0.0) {
            [self.pointImage.layer removeAllAnimations];
        }
    }
    
    if (_showProgressText) {
        if (_increaseFromLast) {
            [self.progressLabel countingFrom:_lastProgress*100 to:_progress*100 duration:_duration];
        } else {
            [self.progressLabel countingFrom:0 to:_progress*100 duration:_duration];
        }
    }
    
    
    _lastProgress = _progress;
}

- (void)initSubviews {
    [self.layer addSublayer:self.backLayer];
    [self.layer addSublayer:self.progressLayer];
    
    [self addSubview:self.pointImage];
    [self addSubview:self.progressLabel];
    
}

@end
