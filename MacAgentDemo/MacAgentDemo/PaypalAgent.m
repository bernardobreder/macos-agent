//
//  PaypalAgent.m
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import "PaypalAgent.h"

@implementation PaypalAgent

- (void)receiveMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    return [super receiveMessage:selector withContext:context returning:block];
}

@end
