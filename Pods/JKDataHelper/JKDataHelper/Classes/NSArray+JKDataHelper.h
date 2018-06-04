//
//  NSArray+JKDataHelper.h
//  Pods
//
//  Created by Jack on 17/3/28.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (JKDataHelper)

-(id)jk_objectWithIndex:(NSUInteger)index;

- (NSString*)jk_stringWithIndex:(NSUInteger)index;

- (NSNumber*)jk_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)jk_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)jk_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)jk_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)jk_integerWithIndex:(NSUInteger)index;

- (NSUInteger)jk_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)jk_boolWithIndex:(NSUInteger)index;

- (int16_t)jk_int16WithIndex:(NSUInteger)index;

- (int32_t)jk_int32WithIndex:(NSUInteger)index;

- (int64_t)jk_int64WithIndex:(NSUInteger)index;

- (char)jk_charWithIndex:(NSUInteger)index;

- (short)jk_shortWithIndex:(NSUInteger)index;

- (float)jk_floatWithIndex:(NSUInteger)index;

- (double)jk_doubleWithIndex:(NSUInteger)index;

- (NSDate *)jk_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)jk_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)jk_pointWithIndex:(NSUInteger)index;

- (CGSize)jk_sizeWithIndex:(NSUInteger)index;

- (CGRect)jk_rectWithIndex:(NSUInteger)index;

@end
