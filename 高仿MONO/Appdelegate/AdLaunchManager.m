//
//  AdLaunchManager.m
//  高仿MONO
//
//  Created by 徐茂怀 on 2018/4/29.
//  Copyright © 2018年 徐茂怀. All rights reserved.
//

#import "AdLaunchManager.h"
#import "MNNetworkTool.h"
#import <XHLaunchAd.h>
#import "AdModel.h"
#define imageURL @"http://yun.it7090.com/image/XHLaunchAd/pic01.jpg"
@interface AdLaunchManager()<XHLaunchAdDelegate>
@end
@implementation AdLaunchManager
+(void)load{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"FirstLoad"]) {
        return;
    }
    [self shareManager];
}

+(AdLaunchManager *)shareManager{
    static AdLaunchManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[AdLaunchManager alloc] init];
    });
    return instance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
            [self setupXHLaunchAd];
        }];
    }
    return self;
}

-(void)setupXHLaunchAd{
    [XHLaunchAd setWaitDataDuration:5];
    NSString *imageUrl = [NSString stringWithFormat:@"new_ads/recent/?height=%.f&width=%.f",SCREEN_HEIGHT,SCREEN_WIDTH];
    [[MNNetworkTool shareService]requstWithUrl:imageUrl Param:nil Success:^(id responseObj) {
        NSArray *arr = [responseObj safeArrayForKey:@"splash_image_ad"];
        if (!arr.count) {
            [XHLaunchAd removeAndAnimated:YES];
            return ;
        }
        NSArray *result = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [[NSNumber numberWithInteger:[obj2 safeIntegerForKey:@"modified_time"]] compare:[NSNumber numberWithInteger:[obj1 safeIntegerForKey:@"modified_time"]]];
        }];
        AdModel *model = [AdModel yy_modelWithJSON:result[0]];
        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
        //广告停留时间
        imageAdconfiguration.duration = model.duration;
        //广告frame
        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
        imageAdconfiguration.imageNameOrURLString = model.image_url;
        //设置GIF动图是否只循环播放一次(仅对动图设置有效)
        imageAdconfiguration.GIFImageCycleOnce = NO;
        //缓存机制(仅对网络图片有效)
        //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
        //图片填充模式
        imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
        imageAdconfiguration.openModel = model.external_link_url;
        //广告显示完成动画
        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
        imageAdconfiguration.duration = model.duration;
        
        if (!model.hide_mono_logo) {
            CGFloat adHeight = (CGFloat)model.height / model.width * SCREEN_WIDTH;
            imageAdconfiguration.frame = CGRectMake(0, 0, SCREEN_WIDTH, adHeight);
            UIImageView *adBottomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, adHeight, SCREEN_WIDTH, SCREEN_HEIGHT - adHeight)];
            adBottomImageView.image = [UIImage imageNamed:@"mono-splash-logo-2018"];
            adBottomImageView.backgroundColor = [UIColor whiteColor];
            adBottomImageView.contentMode = UIViewContentModeCenter;
            imageAdconfiguration.subViews = @[adBottomImageView];
        }
        //显示开屏广告
        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        
    } Failed:^{
        
    }];
}

-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint
{
    NSLog(@"%@",openModel);
}
@end
