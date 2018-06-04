//
//  NSObject+JK.m
//  Pods
//
//  Created by Jack on 17/3/28.
//
//

#import "NSObject+JK.h"

@implementation NSObject (JK)

+ (void)JKswizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector withClass:(Class)targetClass
{
    Method originalMethod = class_getInstanceMethod(targetClass, origSelector);
    Method swizzledMethod = class_getInstanceMethod(targetClass, newSelector);
    if (!originalMethod) { // exchange ClassMethod
        originalMethod = class_getClassMethod(targetClass, origSelector);
        swizzledMethod = class_getClassMethod(targetClass, newSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
        return;
    }
    BOOL didAddMethod = class_addMethod(targetClass,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(targetClass,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    NSUInteger i = 1;
    for (id object in objects) {
        id tempObject = object;
        [invocation setArgument:&tempObject atIndex:++i];
    }
    [invocation invoke];
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}

+ (id)performSelector:(SEL)aSelector withParameters:(void *)firstParameter, ... {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSUInteger length = [signature numberOfArguments];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    [invocation setArgument:&firstParameter atIndex:2];
    va_list arg_ptr;
    va_start(arg_ptr, firstParameter);
    for (NSUInteger i = 3; i < length; ++i) {
        void *parameter = va_arg(arg_ptr, void *);
        [invocation setArgument:&parameter atIndex:i];
    }
    va_end(arg_ptr);
    [invocation invoke];
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}

@end
