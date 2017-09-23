//
//  SelectorArray.m
//  MacAgentDemo
//
//  Created by Bernardo Breder on 31/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import "SelectorArray.h"

@interface SelectorArray ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation SelectorArray

- (instancetype)init
{
    if (!(self = [super init])) return nil;
    _array = [[NSMutableArray alloc] init];
    return self;
}

- (SelectorArray*)addSelector:(SEL)selector
{
    [_array addObject:[NSValue valueWithPointer:selector]];
    return self;
}

- (SEL)selectorAtIndex:(NSInteger)index
{
    NSValue *value = _array[index];
    return value.pointerValue;
}

- (void)removeSelector:(SEL)selector
{
    [_array removeObject:[NSValue valueWithPointer:selector]];
}

- (NSInteger)count
{
    return _array.count;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [_array countByEnumeratingWithState:state objects:buffer count:len];
}

@end
