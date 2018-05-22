
//
//  XDProgressView.m
//  XDProgressView
//
//  Created by xindong on 17/2/9.
//  Copyright © 2017年 xindong. All rights reserved.
//  @See: https://github.com/Tbwas/XDProgressView

#import "XDProgressView.h"

#define kWidth  self.frame.size.width
#define kHeight self.frame.size.height

#pragma mark - XDProgressLayer

@interface XDProgressLayer : CALayer

@property (nonatomic, assign) float progress;
@property (nonatomic, strong, nullable) UIColor *progressTintColor;
@property (nonatomic, strong, nullable) UIImage *progressImage;
@property (nonatomic, strong, nullable) UIImage *trackImage;
@property (nonatomic, strong, nullable) NSString *text;
@property (nonatomic, strong, nullable) UIColor *textColor;
@property (nonatomic, strong, nullable) UIFont  *font;
@property (nonatomic, assign) NSTextAlignment textAlignment;

- (void)setProgressWithAnimated:(BOOL)animated;

@end

@implementation XDProgressLayer {
    CATextLayer *_textLayer;
    CALayer *_imageLayer;
    BOOL _isAnimated;
    BOOL _didLayout;
    BOOL _roundedCorner;
    CFTimeInterval _animationDuration;
}

- (instancetype)init {
    if (self = [super init]) {
        _animationDuration = 1 / 4.0;
    }
    return self;
}

- (void)setProgressWithAnimated:(BOOL)animated {
    _isAnimated = animated;
    if (animated) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:_animationDuration];
        self.imageLayer.frame = CGRectMake(0, 0, _progress * kWidth, kHeight);
        [CATransaction commit];
    } else {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.imageLayer.frame = CGRectMake(0, 0, _progress * kWidth, kHeight);
        [CATransaction commit];
    }
}

- (void)setTextFont:(UIFont *)font {
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.textLayer.font = fontRef;
    self.textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

#pragma mark - Overriden

- (void)display {
    [super display];
    // TODO:
}

- (void)drawInContext:(CGContextRef)ctx {
    CGRect rect = CGRectMake(0, 0, self.progress * kWidth, kHeight);
    if (self.trackImage) {   // trackImage
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -rect.size.height);
        CGContextDrawImage(ctx, CGRectMake(0, 0, kWidth, kHeight), self.trackImage.CGImage);
    }
}

- (void)layoutSublayers {
    if (_didLayout) return;
    if (!self.font) self.font = [UIFont systemFontOfSize:17.0];
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    self.textLayer.frame = (CGRect){0, (kHeight - size.height) / 2, kWidth, size.height};
    [self setProgressWithAnimated:NO]; // should call the method here when use autolayout.
    _didLayout = YES;
}

#pragma mark - Property

- (void)setTrackImage:(UIImage *)trackImage {
    _trackImage = trackImage;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLayer.string = text;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    self.imageLayer.backgroundColor = self.progressTintColor.CGColor;
}

- (void)setProgressImage:(UIImage *)progressImage {
    _progressImage = progressImage;
    self.imageLayer.contents = (__bridge id)(self.progressImage.CGImage);
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self setTextFont:font];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textLayer.foregroundColor = textColor.CGColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    switch (textAlignment) {
        case NSTextAlignmentLeft:
            self.textLayer.alignmentMode = kCAAlignmentLeft;
            break;
        case NSTextAlignmentCenter:
            self.textLayer.alignmentMode = kCAAlignmentCenter;
            break;
        case NSTextAlignmentRight:
            self.textLayer.alignmentMode = kCAAlignmentRight;
            break;
        case NSTextAlignmentJustified:
            self.textLayer.alignmentMode = kCAAlignmentJustified;
            break;
        case NSTextAlignmentNatural:
            self.textLayer.alignmentMode = kCAAlignmentNatural;
            break;
        default:
            break;
    }
}

- (void)setRoundedCorner:(NSNumber *)roundedCorner {
    _roundedCorner = [roundedCorner boolValue];
    if (!_roundedCorner) return;
    self.cornerRadius = kHeight / 2.0;
    self.imageLayer.cornerRadius = kHeight / 2.0;
    if (self.trackImage) self.masksToBounds = YES;
}

- (void)setAnimationDuration:(NSNumber *)animationDuration {
    CFTimeInterval duration = [animationDuration doubleValue];
    _animationDuration = duration < 0.0 ? 0.0 : duration;
}

#pragma mark - Lazy Loading

- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
        [self addSublayer:_textLayer];
    }
    return _textLayer;
}

- (CALayer *)imageLayer {
    if (!_imageLayer) {
        _imageLayer = [CALayer layer];
        _imageLayer.frame = CGRectMake(0, 0, self.progress * kWidth, kHeight);
        [self addSublayer:_imageLayer];
    }
    return _imageLayer;
}

@end

#pragma mark - XDProgressView

@implementation XDProgressView

+ (Class)layerClass {
    return [XDProgressLayer class];
}

#pragma mark - Public

- (void)setProgress:(float)progress animated:(BOOL)animated {
    if (_progress == progress) return;
    _progress = progress > 1.0 ? 1.0 : progress < 0.0 ? 0.0 : progress;
    XDProgressLayer *layer = (XDProgressLayer *)self.layer;
    layer.progress = _progress;
    [(XDProgressLayer *)self.layer setProgressWithAnimated:animated];
}

#pragma mark - Property

- (void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    if (_textAlignment == textAlignment) return;
    _textAlignment = textAlignment;
    XDProgressLayer *layer = (XDProgressLayer *)self.layer;
    layer.textAlignment = textAlignment;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
    if (_trackTintColor == trackTintColor) return;
    _trackTintColor = trackTintColor;
    self.backgroundColor = trackTintColor;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    if (_progressTintColor == progressTintColor) return;
    _progressTintColor = progressTintColor;
    [self.layer performSelector:_cmd withObject:progressTintColor];
}

- (void)setProgressImage:(UIImage *)progressImage {
    if (_progressImage == progressImage) return;
    _progressImage = progressImage;
    [self.layer performSelector:_cmd withObject:progressImage];
}

- (void)setTrackImage:(UIImage *)trackImage {
    if (_trackImage == trackImage) return;
    _trackImage = trackImage;
    [self.layer performSelector:_cmd withObject:trackImage];
}

- (void)setText:(NSString *)text {
    if (_text == text) return;
    _text = text;
    [self.layer performSelector:_cmd withObject:text];
}

- (void)setTextColor:(UIColor *)textColor {
    if (_textColor == textColor) return;
    _textColor = textColor;
    [self.layer performSelector:_cmd withObject:textColor];
}

- (void)setFont:(UIFont *)font {
    if (_font == font) return;
    _font = font;
    [self.layer performSelector:_cmd withObject:font];
}

- (void)setRoundedCorner:(BOOL)roundedCorner {
    if (_roundedCorner == roundedCorner) return;
    _roundedCorner = roundedCorner;
    [self.layer performSelector:_cmd withObject:@(roundedCorner)];
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    if (_animationDuration == animationDuration) return;
    _animationDuration = animationDuration;
    [self.layer performSelector:_cmd withObject:@(animationDuration)];
}

#pragma clang diagnostic pop

@end
