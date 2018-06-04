//
//  NSObject+JK.h
//  Pods
//
//  Created by Jack on 17/3/28.
//
//

#ifdef DEBUG

#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define JKDataHelperLog(...) printf("%s: %s 第%d行: %s\n\n",[[NSString stringWithFormat:@"%@",[NSDate date]] UTF8String], [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else

#define JKDataHelperLog(...)

#endif

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (JK)

+ (void)JKswizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector withClass:(Class)targetClass;

/**
 *   用来处理带有多个参数的函数的分发
 *
 *  @param aSelector 被分发的方法
 *  @param objects   传入的参数数组，数组里面的元素不能为空，数组中元素必须是对象
 *
 *  @return 返回所分发的函数的返回值
 */
+ (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

/**
 *  用来处理可变参数函数的分发
 *
 *  @param aSelector      被分发的方法
 *  @param firstParameter 传入的可变参数的第一个参数
 *
 *  @return 返回所分发的函数的返回值
 */
+ (id)performSelector:(SEL)aSelector withParameters:(void *)firstParameter, ...;


@end
