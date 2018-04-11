//
//  UIDevice+Helpers.m
//  
//
//  Created by Kai on 9/1/11.
//  Copyright 2011 Stephen. All rights reserved.
//

#import "UIDevice+Helpers.h"
#import <MessageUI/MessageUI.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AVFoundation/AVFoundation.h>

#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>


@implementation UIDevice (Helpers)

- (BOOL)isRetinaDisplay
{
    if ([[UIScreen mainScreen] scale] > 1.0)
    {
        return YES;
    }
	
	return NO;
}

- (BOOL)is4InchRetinaDisplay
{
    if ([[UIScreen mainScreen] applicationFrame].size.height > 480)
    {
        return YES;
    }
    
    return NO;
}

static int systemMainVersion = 0;
- (int)systemMainVersion
{
	if (systemMainVersion > 0) {
		return systemMainVersion;
	}
	systemMainVersion = [self systemVersion].intValue;
	return systemMainVersion;
}

- (NSString *)carrierName
{
    // Carrier name.
    CTTelephonyNetworkInfo *telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
	NSString *carrierName = [[telephonyNetworkInfo subscriberCellularProvider] carrierName];
    return carrierName;
}

- (NSString *)mobileCountryCode
{
    CTTelephonyNetworkInfo *telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
	return [[telephonyNetworkInfo subscriberCellularProvider] mobileCountryCode];
}
- (NSString *)mobileNetworkCode
{
    CTTelephonyNetworkInfo *telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
	return [[telephonyNetworkInfo subscriberCellularProvider] mobileNetworkCode];
}

- (BOOL)canMakeCall
{
    static BOOL checked = NO;
    static BOOL result = NO;
    
    if (checked == NO)
    {
        result = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
        checked = YES;
    }
    
    return result;
}

- (BOOL)canSendText
{
    static BOOL checked = NO;
    static BOOL result = NO;
    
    if (checked == NO)
    {
        result = [MFMessageComposeViewController canSendText];
        checked = YES;
    }
    
    return result;
}


+ (NSString *) platform
{
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
	free(machine);
	return platform;
}

+ (NSString *)getReturnPlat:(NSString *)platform
{
	if ([platform isEqualToString:@"iPod1,1"]) {
		return @"ipodtouch1";
	}
	if ([platform isEqualToString:@"iPod2,1"]) {
		return @"ipodtouch2";
	}
	if ([platform isEqualToString:@"iPod3,1"]) {
		return @"ipodtouch3";
	}
	if ([platform isEqualToString:@"iPod4,1"]) {
		return @"ipodtouch4";
	}
	if ([platform isEqualToString:@"iPhone1,1"]) {
		return @"iphone1";
	}
	if ([platform isEqualToString:@"iPhone1,2"]) {
		return @"iphone3g";
	}
	if ([platform isEqualToString:@"iPhone2,1"]) {
		return @"iphone3gs";
	}
	if ([platform isEqualToString:@"iPhone3,1"]) {
		return @"iphone4";
	}
	if ([platform isEqualToString:@"iPad1,1"]) {
		return @"ipad1";
	}
	if ([platform isEqualToString:@"iPad2,1"]) {
		return @"ipad2";
	} else {
		return @"iphone";
	}
}

+ (NSString *) getStandardPlat
{
//	return [self getReturnPlat:[self platform]];
	return [self platform];
}


// 
// source: http://mobiledevelopertips.com/device/determine-mac-address.html
// 
- (NSString *)macAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        //NSLog(@"Error: %@", errorFlag);
        free(msgBuffer);
        return nil;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    //NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

- (BOOL)hasLedLight
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return [device hasTorch];
}
- (BOOL)isLedLightOn
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        return [device torchMode] == AVCaptureTorchModeOn;
    }
    return NO;
}
- (void)turnLedLightTo:(BOOL)on
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:on?AVCaptureTorchModeOn:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}
@end
