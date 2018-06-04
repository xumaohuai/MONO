//
//  NSDictionary+JKDataHelper.h
//  Pods
//
//  Created by Jack on 17/3/28.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JKDataHelper)

- (BOOL)jk_hasKey:(NSString *)key;

- (NSString*)jk_stringForKey:(id)key;

- (NSNumber*)jk_numberForKey:(id)key;

- (NSDecimalNumber *)jk_decimalNumberForKey:(id)key;

- (NSArray*)jk_arrayForKey:(id)key;

- (NSDictionary*)jk_dictionaryForKey:(id)key;

- (NSInteger)jk_integerForKey:(id)key;

- (NSUInteger)jk_unsignedIntegerForKey:(id)key;

- (BOOL)jk_boolForKey:(id)key;

- (int16_t)jk_int16ForKey:(id)key;

- (int32_t)jk_int32ForKey:(id)key;

- (int64_t)jk_int64ForKey:(id)key;

- (char)jk_charForKey:(id)key;

- (short)jk_shortForKey:(id)key;

- (float)jk_floatForKey:(id)key;

- (double)jk_doubleForKey:(id)key;

- (long long)jk_longLongForKey:(id)key;

- (unsigned long long)jk_unsignedLongLongForKey:(id)key;

- (NSDate *)jk_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)jk_CGFloatForKey:(id)key;

- (CGPoint)jk_pointForKey:(id)key;

- (CGSize)jk_sizeForKey:(id)key;

- (CGRect)jk_rectForKey:(id)key;
@end
