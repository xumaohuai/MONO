//
//  MNNetworkTool.m
//  
//
//  Created by 徐茂怀 on 2018/4/15.
//

#import "MNNetworkTool.h"
#import <AFNetworking.h>
#import <YYCache.h>
#import<CommonCrypto/CommonDigest.h>
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
        //sha1加密f708a631250c9714ab668e2fe1a495eed330316e
        //http://mmmono.com/api/accountsv2/welcome/sha1加密/
       YYCache *cache = [YYCache cacheWithName:@"ResponseCache"];
        if ([cache containsObjectForKey:@"token"]) {
             [self.requestSerializer setValue:(NSString *)[cache objectForKey:@"token"] forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
        }
        [self.requestSerializer setValue:@"api-client/1.0 com.mmmono.mono/3.6.8 iOS/11.3 iPhone8,1" forHTTPHeaderField:@"MONO-USER-AGENT"];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        self.requestSerializer.timeoutInterval = 10.f;//设置请求超时的时间

    }
    return self;
}

-(void)requstWithUrl:(NSString *)url Param:(NSDictionary *)param Success:(SuccessBlock)success Failed:(FailedBlock)failed
{
    [self requstWithUrl:url Param:param MNNetSet:nil Success:success Failed:failed];
}

-(void)requstWithUrl:(NSString *)url Param:(NSDictionary *)param MNNetSet:(MNNetSet *)mnnetSet Success:(SuccessBlock)success Failed:(FailedBlock)failed
{
    YYCache *cache = [YYCache cacheWithName:@"ResponseCache"];
    if (!mnnetSet) {
        mnnetSet = [[MNNetSet alloc]init];
    }
    if (mnnetSet.showSVP) {
        [MBProgressHUD showProgress];
    }
    if ([cache containsObjectForKey:url] && mnnetSet.readCache && success) {
        id response = [cache objectForKey:url];
        success(response);
    }else{
        NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
        if ([url hasPrefix:@"http:"]) {
            urlString = url;
        }
        if (mnnetSet.requestMothed == MNRequestMothedGET) {
            [[MNNetworkTool shareService] GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *jsonString = [[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if ([jsonString hasPrefix:@"{"]) {
                    NSError *err;
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:&err];
                    if (mnnetSet.saveCache && ![dic safeBoolForKey:@"is_last_page"]) {
                        [cache setObject:dic forKey:url];
                    }
                    success(dic);
                }else{
                    success(jsonString);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failed();
                if (![cache containsObjectForKey:@"token"]) {
                    [self getTokenSuccess:^{
                        [[MNNetworkTool shareService]requstWithUrl:url Param:param MNNetSet:mnnetSet Success:^(id responseObj) {
                            success(responseObj);
                        } Failed:^{
                            failed();
                        }];
                    }];
                }
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

-(void)getTokenSuccess:(void (^)(void))success
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mmmono.com/api/v3/accountsv2/welcome/%@/",[self sha1:(__bridge NSString *)(uuidStr)]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *json = @{@"ts":@"TjbnMo4kZeh8o883e5kR9iPQiHt8CCpjCQZtqTaDkvL2Jr2WGqq36JA5Ozm3OlxDpoyu7CeWni9dUuebIp0iFvy7egYVLlNY3viTE6eBTEC2s+WJ1Mjldsh+rROrDzQ"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
    
    NSError *error;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            YYCache *cache = [YYCache cacheWithName:@"ResponseCache"];
            [cache setObject:[dic safeStringForKey:@"access_token"] forKey:@"token"];
            [[MNNetworkTool shareService].requestSerializer setValue:[dic safeStringForKey:@"access_token"] forHTTPHeaderField:@"HTTP-AUTHORIZATION"];
            success();
        }
    }];
    [dataTask resume];
}

- (NSString *) sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

-(void)getVideoUrlWithId:(NSString *)Id Success:(void (^)(NSString *))success
{
    //视频链接
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mmmono.com/g/meow/%@/get_video/",Id]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString *string =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSRange startRange = [string rangeOfString:@"url:\""];
            NSRange endRange = [string rangeOfString:@"urlFrom:"];
            NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
            NSString *result = [string substringWithRange:range];
            result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
            result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            result = [result substringToIndex:result.length - 2];
            if (success) {
                NSLog(@"%@",result);
                success(result);
            }
        }
    }];
    [dataTask resume];
}
@end
