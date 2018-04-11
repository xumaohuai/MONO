//
//  UIView+ViewController.m
//
//  Created by 吴 天 on 12-10-26.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)firstAvailableUIViewController
{
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id)traverseResponderChainForUIViewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        return nextResponder;
    }
    else if ([nextResponder isKindOfClass:[UIView class]])
    {
        return [nextResponder traverseResponderChainForUIViewController];
    }
    else
    {
        return nil;
    }
}
@end
