//
//  UIView+Additions.m
//  QMQZ_Rebuild
//
//  Created by chengdengjian on 15/8/20.
//  Copyright (c) 2015年 CL. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
//x属性的get,set
-(void)setX:(CGFloat)x
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}
//centerX属性的get,set
-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}
-(CGFloat)centerX
{
    return self.center.x;
}
//centerY属性的get,set
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}
-(CGFloat)centerY
{
    return self.center.y;
}
//y属性的get,set
-(void)setY:(CGFloat)y
{
    
    
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
    
    
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
//width属性的get,set
-(void)setWidth:(CGFloat)width
{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
//height属性的get,set
-(void)setHeight:(CGFloat)height
{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
//size属性的get,set
-(void)setSize:(CGSize)size
{
    CGRect frame=self.frame;
    frame.size.width=size.width;
    frame.size.height=size.height;
    self.frame=frame;
}
-(CGSize)size
{
    return self.frame.size;
}
//origin属性的get,set,用于设置坐标
-(void)setOrigin:(CGPoint)origin
{
    CGRect frame=self.frame;
    frame.origin.x=origin.x;
    frame.origin.y=origin.y;
    self.frame=frame;
}
-(CGPoint)origin
{
    return self.frame.origin;
}

-(CGFloat)rightX
{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setRightX:(CGFloat)rightX
{
    CGRect frame=self.frame;
    frame.origin.x=rightX - frame.size.width;
    self.frame=frame;
}

-(CGFloat)bottomY
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}
- (void)layerBordeColor:(UIColor *)color
            borderWidth:(CGFloat)borderWidth
      roundedCornerWith:(CGFloat)cornerRadius {
    
    [self roundedCornerWith:cornerRadius];
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [color CGColor];
    
}
- (void)roundedCornerWith:(CGFloat)cornerRadius
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (UITableViewCell *)findSupercell {
    UITableViewCell *cell = nil;
    
    UIView *view = self.superview;
    while (view != nil) {
        if ([view isKindOfClass:UITableViewCell.class]) {
            cell = (UITableViewCell *)view;
            break;
        }
        view = view.superview;
    }
    
    return cell;
}
- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}


@end
