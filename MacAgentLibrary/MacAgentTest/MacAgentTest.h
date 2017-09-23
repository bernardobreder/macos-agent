//
//  MacAgentTest.h
//  MacAgentTest
//
//  Created by Bernardo Breder on 13/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MacAgent.h"

@class MAEnvironmentFixture;
@class MAAgentFixture;
@class MAAgentResponseFixture;

@interface MAEnvironmentFixture : NSObject

@property (nonatomic, strong) MAEnvironment *target;

/**
 * Inicialização de uma fixture
 */
- (instancetype)initWithEnvironment:(MAEnvironment*)environment;

- (MAAgentFixture*)startAgent:(MAAgent*)agent;

- (void)close;

@end

@interface MAAgentFixture : NSObject

@property (nonatomic, strong) MAAgent *target;

/**
 * Inicialização de uma fixture
 */
- (instancetype)initWithAgent:(MAAgent*)agent;

- (MAAgentFixture*)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context;

//- (MAAgentFixture*)expectedResultContext:(NSDictionary*)context;
//
//- (MAAgentFixture*)expectedNoMessage;
//
//- (MAAgentFixture*)expectedReceiveContext:(NSDictionary*)context;
//
//- (MAAgentFixture*)expectedNoReceiveContext;

- (bool)findResultMessage:(NSDictionary*)context;

- (NSInteger)numberOfResultMessage;

- (bool)findReceiveContext:(NSDictionary*)context;

- (NSInteger)numberOfReceiveContext;

@end

@interface MATestCase : XCTestCase

@property (nonatomic, strong) MAEnvironmentFixture *envFxt;

- (void)setUp;

- (void)tearDown;

@end
