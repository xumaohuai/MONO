//
//  NSObject+AssociatedObject.h
//  
//
//  Created by Stephen Liu on 12-11-26.
//  Copyright (c) 2012年 Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObject)
- (id)objectWithAssociatedKey:(void *)key;
- (void)setObject:(id)object forAssociatedKey:(void *)key retained:(BOOL)retain;
@end
