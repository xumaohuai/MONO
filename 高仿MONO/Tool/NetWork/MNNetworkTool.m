//
//  MNNetworkTool.m
//  
//
//  Created by 徐茂怀 on 2018/4/15.
//

#import "MNNetworkTool.h"
#import <AFNetworking.h>
#import <YYCache.h>

@implementation MNNetSet
-(instancetype)init
{
    return [self initWithRequstMothed:MNRequestMothedGET SaveCache:NO ReadCache:NO ShowSVP:NO];
}
-(instancetype)initWithRequstMothed:(MNRequestMothed)requestMothed SaveCache:(BOOL)saveCache ReadCache:(BOOL)readCache ShowSVP:(BOOL)showSVP
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.requestMothed = requestMothed;
    self.saveCache = saveCache;
    self.readCache = readCache;
    self.showSVP = showSVP;
    return self;
}

+(instancetype)readCache
{
    MNNetSet *set = [[MNNetSet alloc]initWithRequstMothed:MNRequestMothedGET SaveCache:NO ReadCache:YES ShowSVP:NO];
    return set;
}

+(instancetype)saveCache
{
    MNNetSet *set = [[MNNetSet alloc]initWithRequstMothed:MNRequestMothedGET SaveCache:YES ReadCache:NO ShowSVP:NO];
    return set;
}

+(instancetype)postMethod
{
    MNNetSet *set = [[MNNetSet alloc]initWithRequstMothed:MNRequestMothedPOST SaveCache:NO ReadCache:NO ShowSVP:NO];
    return set;
}

@end

@implementation MNNetworkTool

+(instancetype)shareService
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.requestSerializer.timeoutInterval = 10.f;//设置请求超时的时间
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
        [self.requestSerializer setValue:@"5480afd43c0111e8b6f8525400b827a7" forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
    }
    return self;
}

-(void)requstWithUrl:(NSString *)url Param:(NSDictionary *)param Success:(SuccessBlock)success Failed:(FailedBlock)failed
{
    [self requstWithUrl:url Param:param MNNetSet:nil Success:success Failed:failed];
}

-(void)requstWithUrl:(NSString *)url Param:(NSDictionary *)param MNNetSet:(MNNetSet *)mnnetSet Success:(SuccessBlock)success Failed:(FailedBlock)failed
{
    if (!mnnetSet) {
        mnnetSet = [[MNNetSet alloc]init];
    }
    if (mnnetSet.showSVP) {
        [MBProgressHUD showProgress];
    }
    YYCache *cache = [YYCache cacheWithName:@"ResponseCache"];
    if ([cache containsObjectForKey:url] && mnnetSet.readCache && success) {
        id response = [cache objectForKey:url];
        success(response);
    }else{
        if (mnnetSet.requestMothed == MNRequestMothedGET) {
            [[MNNetworkTool shareService] GET:[NSString stringWithFormat:@"%@%@",BaseUrl,url] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (mnnetSet.saveCache && ![responseObject safeBoolForKey:@"is_last_page"]) {
                    [cache setObject:responseObject forKey:url];
                }
                NSLog(@"%@",responseObject);
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failed();
            }];
        }else{
            [[MNNetworkTool shareService] POST:[NSString stringWithFormat:@"%@%@",BaseUrl,url]  parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (mnnetSet.saveCache) {
                    [cache setObject:responseObject forKey:url];
                }
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failed();
            }];
        }
    }
 
}
@end
