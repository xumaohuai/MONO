//
//  NSDictionary+Additions.h
//  FamiliarStranger
//
//  Created by admin on 15/12/22.
//
//

#import <Foundation/Foundation.h>



/**
 *  字典辅助类
 */
@interface NSDictionary (Additions)

+(NSDictionary*)loadPlistFile:(NSString*)fileName;


#pragma mark -字典解析相关

-(id)parseForKey:(id)aKey;


-(BOOL)safeBoolForKey:(NSString*)aKey;
-(id)safeObjectForKey:(NSString*)aKey;
-(NSString*)safeStringForKey:(NSString*)aKey;
-(NSArray*)safeArrayForKey:(NSString*)aKey;
-(NSDictionary*)safeDictionaryForKey:(NSString*)aKey;
-(NSInteger)safeIntegerForKey:(NSString*)aKey;
-(long long)safeLonglongForKey:(NSString*)aKey;
-(float)safeFloatForKey:(NSString*)aKey;
-(double)safeDoubleForKey:(NSString*)aKey;

@end
