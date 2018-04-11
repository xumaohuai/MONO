//
//  NSString+Utilities.h
//  GHLibrary
//
//  Created by Stephen Liu on 13-10-17.
//  Copyright (c) 2013年 Stephen Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilities)
+ (NSString *)UUIDString;
- (NSComparisonResult)versionCompare:(NSString *)string;
- (NSString *)urlEncodeString;
- (NSString *)urlDecodeString;
@end
