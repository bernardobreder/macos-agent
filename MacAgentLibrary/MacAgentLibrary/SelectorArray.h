//
//  SelectorArray.h
//  MacAgentDemo
//
//  Created by Bernardo Breder on 31/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectorArray : NSObject <NSFastEnumeration>

- (instancetype)init;

- (SelectorArray*)addSelector:(SEL)selector;

- (SEL)selectorAtIndex:(NSInteger)index;

- (void)removeSelector:(SEL)selector;

- (NSInteger)count;

@end
