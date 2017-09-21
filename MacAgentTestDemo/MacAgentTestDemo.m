//
//  MacAgentTestDemo.m
//  MacAgentTestDemo
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "MAAgent.h"
#import "MAAgentFixture.h"
#import "BuyerAgent.h"
#import "VisaAgent.h"
#import "PaypalAgent.h"
#import "FacebookAgent.h"
#import "TwitterAgent.h"
#import "PrintAgent.h"
#import "EmailAgent.h"

@interface MacAgentTestDemo : XCTestCase

@end

@implementation MacAgentTestDemo

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    MAAgentFixture *fixture = [[MAAgentFixture alloc] initWithAgent:[[BuyerAgent alloc] init]];
    [[[fixture receiveBroadcastMessage:@selector(buyProduct:returning:) withContext:@{@"id":@55}] expectedResultContext:@"id" withValue:@55] expectedResultContext:@"Success" withValue:@true];
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
