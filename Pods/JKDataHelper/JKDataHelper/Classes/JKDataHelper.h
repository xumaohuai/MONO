//
//
//
//  Created by jack on 2016/12/2.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+JKDataHelper.h"
#import "NSMutableArray+JKDataHelper.h"
#import "NSDictionary+JKDataHelper.h"




#define JKSafeArray(array)   [JKDataHelper safeArray:array]

#define JKSafeMutableArray(mutableArray)   [JKDataHelper safeMutableArray:mutableArray]

#define JKSafeDic(dict)   [JKDataHelper safeDictionary:dict]


#define JKSafeMutableDic(mutableDict)   [JKDataHelper safeMutableDictionary:mutableDict]

#define JKSafeStr(str)   [JKDataHelper safeStr:str]

#define JKSafeStr1(str, defaultStr)   [JKDataHelper safeStr:str defaultStr:defaultStr]

#define JKSafeObj(obj)   [JKDataHelper safeObj:obj]


@interface JKDataHelper : NSObject

/**
 judge the paramter is a kind of class NSArray , if yes return the array,if not return nil

 @param array the array need to judge
 @return the safeData
 */
+ (NSArray *)safeArray:(id)array;

/**
 return a mutableArray ,if the params is not a kind of NSMutableArray return nil

 @param mutableArray the parameter need to judge
 @return the safeData
 */
+ (NSMutableArray *)safeMutableArray:(id)mutableArray;


/**
 return a NSDictionary ,if the params is not a kind of NSDictionary return nil
 
 @param dict the parameter need to judge
 @return the safeData
 */
+ (NSDictionary *)safeDictionary:(id)dict;

/**
 return a NSMutableDictionary ,if the params is not a kind of NSMutableDictionary return nil

 @param dict the parameter need to judge
 @return the safeData
 */
+ (NSMutableDictionary *)safeMutableDictionary:(id)dict;

/**
 return a NSString ,if the params is not a kind of NSString return nil
 
 @param str the parameter need to judge
 @return the safeData
 */
+ (NSString *)safeStr:(id)str;

/**
 return a NSString ,if the params is not a kind of NSString return nil
 
 @param str the parameter need to judge
 @param defaultStr the defaultStr need to specified
 @return the safeData
 */
+ (NSString *)safeStr:(id)str defaultStr:(NSString *)defaultStr;


/**
 return a NSObject ,if the params is not a kind of NSObject return nil
 
 @param obj the parameter need to judge
 @return the safeData
 */
+ (id)safeObj:(id)obj;

@end
