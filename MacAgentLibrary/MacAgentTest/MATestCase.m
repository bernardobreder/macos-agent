//
//  MATestCase.m
//  MacAgentLibrary
//
//  Created by Bernardo Breder on 13/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import "MacAgent.h"
#import "MacAgentTest.h"

@implementation MATestCase

- (void)setUp {
    [super setUp];
    _envFxt = [[MAEnvironmentFixture alloc] initWithEnvironment:[[MAEnvironment alloc] init]];
}

- (void)tearDown {
    [_envFxt close];
    _envFxt = nil;
    [super tearDown];
}

@end
