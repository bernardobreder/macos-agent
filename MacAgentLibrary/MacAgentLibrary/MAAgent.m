//
//  MAAgent.m
//  MacAgentLibrary
//
//  Created by Bernardo Breder on 13/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import "MacAgent.h"

@interface MAAgent ()

@property (nonatomic, strong) NSMutableArray *listeners;

@end

@implementation MAAgent

- (instancetype)init
{
    if (!(self = [super init])) return nil;
    return self;
}

- (void)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    [_environment sendBroadcastMessage:selector withContext:context returning:block];
}

- (void)sendPrivateMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    // Criptografa
    [self sendBroadcastMessage:selector withContext:context returning:block];
}

- (void)receiveMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    return block(nil);
}

- (SelectorArray*)agentSelectorArray
{
    return [[SelectorArray alloc] init];
}

- (void)addReceiveMessageListener:(void (^)(NSDictionary* context))block
{
    if (!_listeners) _listeners = [[NSMutableArray alloc] init];
    [_listeners addObject:block];
}

- (void)fireReceiveMessageListener:(NSDictionary*)context
{
    if (!_listeners) return;
    for (void (^block)(NSDictionary* context) in _listeners) {
        block(context);
    }
}

@end
