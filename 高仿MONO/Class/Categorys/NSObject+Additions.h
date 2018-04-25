//
//  NSObject+Additions.h
//  FamiliarStranger
//
//  Created by admin on 15/12/22.
//
//

#import <Foundation/Foundation.h>

/**
 *  app 内所有对象辅助类
 */
@interface NSObject (Additions)

-(BOOL)isNull;

/**
 *  期望是 NSObject 类型,如果不是,则返回 nil
 *
 */
-(id)expectedObject;

/**
 *  期望是 NSString 类型,如果不是,则返回 @""
 *
 */
-(id)expectedString;

/**
 *  期望是 NSArray 类型,如果不是,则返回 @[]
 *
 */
-(id)expectedArray;

/**
 *  期望是 NSDictionary 类型,如果不是,则返回  @{}
 *
 */
-(id)expectedDictionary;

/**
 *  期望是 int 类型,如果不是,则返回  0
 *
 */
-(int)expectedInt;

/**
 *  期望是 NSInteger 类型,如果不是,则返回  0
 *
 */
-(NSInteger)expectedInteger;

/**
 *  期望是 long long 类型,如果不是,则返回  0
 *
 */
-(long long)expectedLonglong;

/**
 *  期望是 BOOL 类型,如果不是,则返回  NO
 *
 */
-(BOOL)expectedBool;

/**
 *  期望是 float 类型,如果不是,则返回  0.0
 *
 */
-(float)expectedFloat;

/**
 *  期望是 double 类型,如果不是,则返回  0.0
 *
 */
-(double)expectedDouble;

@end
