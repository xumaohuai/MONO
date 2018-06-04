//
//  MBProgressHUD+Message.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/24.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MBProgressHUD+Message.h"

@implementation MBProgressHUD (Message)
+(void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.userInteractionEnabled = NO;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = message;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    [hud hideAnimated:YES afterDelay:2];
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    hud.bezelView.layer.cornerRadius = 12;
}
+(void)showProgress
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
//    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor redColor];
//    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:[MBProgressHUD class], nil].color = [UIColor redColor];
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    hud.bezelView.layer.cornerRadius = 6;
    [hud showAnimated:YES];
}

+(void)hideProgress
{
    [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
}
@end
