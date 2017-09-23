//
//  FacebookAgent.m
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import "FacebookAgent.h"

@implementation FacebookAgent

- (void)receiveMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    if (selector == @selector(exportData:)) {
        return block(@{@"state": [NSNumber numberWithBool:[self exportData:context[@"id"]]]});
    }
    return [super receiveMessage:selector withContext:context returning:block];
}

- (BOOL)exportData:(NSNumber*)productId
{
    if (productId == nil) return false;
    return true;
}

- (SelectorArray*)agentSelectorArray
{
    SelectorArray *array = [[SelectorArray alloc] init];
    [array addSelector:@selector(exportData:)];
    return array;
}

@end
