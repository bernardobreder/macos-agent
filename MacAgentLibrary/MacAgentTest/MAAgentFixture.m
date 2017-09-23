//
//  MAAgentFixture.m
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 06/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MacAgent.h"
#import "MacAgentTest.h"

@interface MAAgentFixture ()

@property (nonatomic, strong) NSMutableArray *returnMessageArray;

@property (nonatomic, strong) NSMutableArray *receiveMessageArray;

@end

@implementation MAAgentFixture

- (instancetype)initWithAgent:(MAAgent*)agent
{
    if (!(self = [super init])) return nil;
    _target = agent;
    _returnMessageArray = [[NSMutableArray alloc] init];
    _receiveMessageArray = [[NSMutableArray alloc] init];
    [agent addReceiveMessageListener:^(NSDictionary *context) {
        @synchronized(_receiveMessageArray) {
            [_receiveMessageArray addObject:context];
        }
    }];
    return self;
}

- (MAAgentFixture*)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context
{
    [_target.environment sendBroadcastMessage:selector withContext:context returning:^(NSDictionary* context) {
        [_returnMessageArray addObject:context];
    }];
    return self;
}

- (bool)findResultMessage:(NSDictionary*)context
{
    for (NSInteger n = 0 ; n < 5 * 100 ; n++) {
        @synchronized(_returnMessageArray) {
            for (NSInteger n = 0 ; n < _returnMessageArray.count ; n++) {
                if ([_returnMessageArray[n] isEqualToDictionary:context]) {
                    [_returnMessageArray removeObjectAtIndex:n];
                    return true;
                }
            }
        }
        [NSThread sleepForTimeInterval:0.01];
    }
    return false;
}

- (NSInteger)numberOfResultMessage
{
    @synchronized(_returnMessageArray) {
        return _returnMessageArray.count;
    }
}

- (bool)findReceiveContext:(NSDictionary*)context
{
    for (NSInteger n = 0 ; n < 5 * 100 ; n++) {
        @synchronized(_receiveMessageArray) {
            for (NSInteger n = 0 ; n < _receiveMessageArray.count ; n++) {
                if ([_receiveMessageArray[n] isEqualToDictionary:context]) {
                    [_receiveMessageArray removeObjectAtIndex:n];
                    return true;
                }
            }
        }
        [NSThread sleepForTimeInterval:0.01];
    }
    return false;
}

- (NSInteger)numberOfReceiveContext
{
    @synchronized(_receiveMessageArray) {
        return _receiveMessageArray.count;
    }
}

@end