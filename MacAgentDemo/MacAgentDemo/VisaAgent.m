//
//  VisaAgent.m
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import "VisaAgent.h"

@implementation VisaAgent

- (void)receiveMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    [self payment:context returning:block];
}

- (void)payment:(NSDictionary*)context returning:(void(^)(NSDictionary* context))block
{
    [self sendBroadcastMessage:@selector(exportData:) withContext:@{@"id": @55} returning:nil];
    block(@{@"state": @true});
}

- (SelectorArray*)agentSelectorArray
{
    SelectorArray *array = [[SelectorArray alloc] init];
    [array addSelector:@selector(payment:returning:)];
    return array;
}

@end
