//
//  BuyerAgent.m
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import "BuyerAgent.h"

@implementation BuyerAgent

- (void)receiveMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    if (selector == @selector(buyProduct:returning:)) {
        return [self buyProduct:context[@"id"] returning:block];
    } else if (selector == @selector(buyProduct:withPayment:returning:)) {
        
    }
    return [super receiveMessage:selector withContext:context returning:block];
}

- (void)buyProduct:(NSNumber*)productId returning:(void(^)(NSDictionary* context))block
{
    [self sendBroadcastMessage:@selector(buyProduct:withPayment:returning:) withContext:@{@"id": @55} returning:^(NSDictionary* result) {
        block(@{@"state": @true});
    }];
}

- (void)buyProduct:(NSNumber*)productId withPayment:(NSString*)paymentName returning:(void(^)(NSDictionary* context))block
{
    [self sendBroadcastMessage:@selector(buyProduct:withPayment:returning:) withContext:@{@"id": @55} returning:^(NSDictionary* result) {
        block(@{@"state": @true});
    }];
}

@end
