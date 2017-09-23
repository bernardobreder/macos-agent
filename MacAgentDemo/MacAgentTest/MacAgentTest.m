//
//  MacAgentTest.m
//  MacAgentTest
//
//  Created by Bernardo Breder on 13/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "MacAgent.h"
#import "MacAgentTest.h"
#import "MyProtocol.h"
#import "BuyerAgent.h"
#import "VisaAgent.h"
#import "FacebookAgent.h"

@interface MacAgentTest : MATestCase

@end

@implementation MacAgentTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBuyerVisa {
    MAAgent *agent = [[MAAgent alloc] init];
    BuyerAgent *buyerAgent = [[BuyerAgent alloc] init];
    VisaAgent *visaAgent = [[VisaAgent alloc] init];
    MAAgentFixture *agentFxt = [self.envFxt startAgent:agent];
    MAAgentFixture *buyerAgentFxt = [self.envFxt startAgent:buyerAgent];
    MAAgentFixture *visaAgentFxt = [self.envFxt startAgent:visaAgent];
    [agentFxt sendBroadcastMessage:@selector(buyProduct:returning:) withContext:@{@"id": @55}];
    XCTAssertTrue([agentFxt findResultMessage:@{@"state": @true}]);
    XCTAssertEqual(0, [agentFxt numberOfResultMessage]);
    XCTAssertTrue([buyerAgentFxt findReceiveContext:@{@"id": @55}]);
    XCTAssertEqual(0, [buyerAgentFxt numberOfResultMessage]);
    XCTAssertTrue([visaAgentFxt findReceiveContext:@{@"id": @55}]);
    XCTAssertEqual(0, [visaAgentFxt numberOfResultMessage]);
}

- (void)testOneFacebook {
    MAAgent *agent = [[MAAgent alloc] init];
    FacebookAgent *facebook = [[FacebookAgent alloc] init];
    MAAgentFixture *agentFxt = [self.envFxt startAgent:agent];
    MAAgentFixture *facebookFxt = [self.envFxt startAgent:facebook];
    [agentFxt sendBroadcastMessage:@selector(exportData:) withContext:@{@"id": @55}];
    XCTAssertTrue([agentFxt findResultMessage:@{@"state": @true}]);
    XCTAssertEqual(0, [agentFxt numberOfResultMessage]);
    XCTAssertTrue([facebookFxt findReceiveContext:@{@"id": @55}]);
    XCTAssertEqual(0, [facebookFxt numberOfResultMessage]);
}

- (void)testTwoFacebook {
    MAAgent *agent = [[MAAgent alloc] init];
    FacebookAgent *facebook1 = [[FacebookAgent alloc] init];
    FacebookAgent *facebook2 = [[FacebookAgent alloc] init];
    MAAgentFixture *agentFxt = [self.envFxt startAgent:agent];
    MAAgentFixture *facebook1Fxt = [self.envFxt startAgent:facebook1];
    MAAgentFixture *facebook2Fxt = [self.envFxt startAgent:facebook2];
    [agentFxt sendBroadcastMessage:@selector(exportData:) withContext:@{@"id": @55}];
    XCTAssertTrue([agentFxt findResultMessage:@{@"state": @true}]);
    XCTAssertTrue([agentFxt findResultMessage:@{@"state": @true}]);
    XCTAssertEqual(0, [agentFxt numberOfResultMessage]);
    XCTAssertTrue([facebook1Fxt findReceiveContext:@{@"id": @55}]);
    XCTAssertEqual(0, [facebook1Fxt numberOfResultMessage]);
    XCTAssertTrue([facebook2Fxt findReceiveContext:@{@"id": @55}]);
    XCTAssertEqual(0, [facebook2Fxt numberOfResultMessage]);
}

- (void)testAllFacebook {
    MAAgent *agent = [[MAAgent alloc] init];
    BuyerAgent *buyerAgent = [[BuyerAgent alloc] init];
    VisaAgent *visaAgent = [[VisaAgent alloc] init];
    FacebookAgent *facebook = [[FacebookAgent alloc] init];
    MAAgentFixture *agentFxt = [self.envFxt startAgent:agent];
    [self.envFxt startAgent:buyerAgent];
    [self.envFxt startAgent:visaAgent];
    MAAgentFixture *facebookFxt = [self.envFxt startAgent:facebook];
    [agentFxt sendBroadcastMessage:@selector(buyProduct:returning:) withContext:@{@"id": @55}];
    XCTAssertTrue([facebookFxt findReceiveContext:@{@"id": @55}]);
    XCTAssertEqual(0, [facebookFxt numberOfResultMessage]);
}

@end
