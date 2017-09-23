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
        [self exportData:context[@"id"]];
        return block(nil);
    }
    return [super receiveMessage:selector withContext:context returning:block];
}

- (void)exportData:(NSNumber*)productId
{
    // Publica
}

@end
