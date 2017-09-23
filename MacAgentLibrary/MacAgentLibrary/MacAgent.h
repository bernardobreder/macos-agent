//
//  MacAgent.h
//  MacAgent
//
//  Created by Bernardo Breder on 13/05/15.
//  Copyright (c) 2015 MacAgent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectorArray.h"

@class MAEnvironment;
@class MAAgent;

@interface MAEnvironment : NSObject

- (void)startAgent:(MAAgent*)agent;

/**
 * Envia uma mensagem em broadcast esperando em segundo plano por uma resposta
 */
- (void)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block;

- (void)close;

@end

@interface MAAgent : NSObject

@property (nonatomic, strong) MAEnvironment *environment;

/**
 * Envia uma mensagem em broadcast esperando em segundo plano por uma resposta
 */
- (void)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block;

/**
 * Envia uma mensagem em broadcast esperando em segundo plano por uma resposta
 */
- (void)sendPrivateMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block;

/**
 * Trata uma mensagem retornando ou não no bloco do método
 */
- (void)receiveMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block;

- (SelectorArray*)agentSelectorArray;

- (void)addReceiveMessageListener:(void (^)(NSDictionary* context))block;

- (void)fireReceiveMessageListener:(NSDictionary*)context;

@end

@interface MAProtocol : NSObject

- (instancetype)initWithProtocol:(Protocol*)protocol;

@end