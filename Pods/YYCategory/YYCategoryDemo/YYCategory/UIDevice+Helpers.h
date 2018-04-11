//
//  UIDevice+Helpers.h
//  
//
//  Created by Kai on 9/1/11.
//  Copyright 2011 Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDevice (Helpers)

- (BOOL)isRetinaDisplay;
- (BOOL)is4InchRetinaDisplay;
- (int)systemMainVersion;

- (NSString *)carrierName;
- (NSString *)mobileCountryCode;
- (NSString *)mobileNetworkCode;
- (NSString *)macAddress;

- (BOOL)canMakeCall;
- (BOOL)canSendText;

+ (NSString *)platform;
+ (NSString *)getReturnPlat:(NSString *)platform;
+ (NSString *)getStandardPlat;

- (BOOL)hasLedLight;
- (BOOL)isLedLightOn;
- (void)turnLedLightTo:(BOOL)on;

@end
