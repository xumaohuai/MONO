//
//  MBProgressHUD+Message.h
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/24.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Message)
+(void)showMessage:(NSString *)message;
+(void)showProgress;
+(void)hideProgress;
@end
