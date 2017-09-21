//
//  MAAgent.m
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import "MAAgent.h"

@implementation MAAgent

- (void)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context
{
    // Envia a mensagem em broadcast
}

- (void)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block
{
    // Envia a mensagem em broadcast
    // Quando vier a resposta asincrona, retorna no bloco
}

- (void)sendPrivateMessage:(SEL)selector withContext:(NSDictionary*)context
{
    // Criptografa
    [self sendBroadcastMessage:selector withContext:context];
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

- (instancetype)start
{
    return self;
}

- (instancetype)stop
{
    return self;
}

@end
