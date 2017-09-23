//
//  BuyerAgent.m
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import "BuyerAgent.h"
#import "SelectorArray.h"

@implementation BuyerAgent

- (void)buyProduct:(NSNumber*)productId returning:(void(^)(NSDictionary* context))block
{
    [self sendBroadcastMessage:@selector(payment:returning:) withContext:@{@"id": @55} returning:^(NSDictionary* result) {
        block(result);
    }];
}

- (void)buyProduct:(NSNumber*)productId withPayment:(NSString*)paymentName returning:(void(^)(NSDictionary* context))block
{
    [self sendBroadcastMessage:@selector(payment:returning:) withContext:@{@"id": @55} returning:^(NSDictionary* result) {
        block(result);
    }];
}

- (void)receiveMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    if (selector == @selector(buyProduct:returning:)) {
        return [self buyProduct:context[@"id"] returning:block];
    } else if (selector == @selector(buyProduct:withPayment:returning:)) {
        return [self buyProduct:context[@"id"] withPayment:context[@"payment"] returning:block];
    }
    return [super receiveMessage:selector withContext:context returning:block];
}

- (SelectorArray*)agentSelectorArray
{
    SelectorArray *array = [[SelectorArray alloc] init];
    [array addSelector:@selector(buyProduct:returning:)];
    [array addSelector:@selector(buyProduct:withPayment:returning:)];
    return array;
}

@end
