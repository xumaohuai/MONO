//
//  NSString+Utilities.m
//  GHLibrary
//
//  Created by Stephen Liu on 13-10-17.
//  Copyright (c) 2013年 Stephen Liu. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)
+ (NSString *)UUIDString
{
	CFUUIDRef u = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef s = CFUUIDCreateString(kCFAllocatorDefault, u);
	CFRelease(u);
	return (NSString *)CFBridgingRelease(s);
}

- (NSComparisonResult)versionCompare:(NSString *)string
{
    if (!string) {
        return NSOrderedDescending;
    }
    __block NSComparisonResult result = NSOrderedSame;
    NSArray *selfComponents = [self componentsSeparatedByString:@"."];
    NSArray *stringComponents = [string componentsSeparatedByString:@"."];
    [selfComponents enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        NSString *local = @"";
        if (stringComponents.count > idx) {
            local = [stringComponents objectAtIndex:idx];
        }
        if (obj.integerValue < local.integerValue) {
            result = NSOrderedAscending;
            *stop = YES;
        } else if(obj.integerValue > local.integerValue) {
            result = NSOrderedDescending;
            *stop = YES;
        }
    }];
    return result;
}

- (NSString *)urlEncodeString
{
	NSString *result = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	return result;
}

- (NSString *)urlDecodeString
{
	NSString *result = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (__bridge CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
	return result;
}
@end
