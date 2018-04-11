//
//  UIView+ViewController.h
//
//  Created by 吴 天 on 12-10-26.
//

#import <UIKit/UIKit.h>

/**
 source:http://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview-on-iphone
 "IMHO, this is a design flaw. The view should not need to be aware of the controller."
 But "one reason you need to allow the UIView to be aware of its UIViewController is when you have custom UIView subclasses that need to push a modal view/dialog."
 */

@interface UIView (ViewController)
- (UIViewController *)firstAvailableUIViewController;
- (id)traverseResponderChainForUIViewController;
@end
