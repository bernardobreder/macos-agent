//
//  MAEnvironmentFixture.m
//  MacAgentDemo
//
//  Created by Bernardo Breder on 13/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import "MacAgent.h"
#import "MacAgentTest.h"

@implementation MAEnvironmentFixture

- (instancetype)initWithEnvironment:(MAEnvironment*)environment
{
    if (!(self = [super init])) return nil;
    _target = environment;
    return self;
}

- (MAAgentFixture*)startAgent:(MAAgent*)agent
{
    MAAgentFixture *agentFxt = [[MAAgentFixture alloc] initWithAgent:agent];
    agent.environment = _target;
    [_target startAgent:agent];
    return agentFxt;
}

- (void)close
{
    [_target close];
}

@end
