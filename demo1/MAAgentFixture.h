//
//  MAAgentFixture.h
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 06/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAAgent.h"

@class MAAgentFixture;
@class MAAgentResponseFixture;

@interface MAAgentFixture : NSObject

@property (nonatomic, strong) MAAgent *agent;

/**
 * Inicialização de uma fixture
 */
- (instancetype)initWithAgent:(MAAgent*)agent;

/**
 * Envia uma mensagem em broadcast sem esperar em segundo plano por uma resposta
 */
- (void)sendBroadcastMessage:(NSString*)type withContext:(NSDictionary*)context;

/**
 * Envia uma mensagem em broadcast esperando em segundo plano por uma resposta
 */
- (void)sendBroadcastMessage:(NSString*)type withContext:(NSDictionary*)context returning:(void (^)(int code, NSDictionary* result))block;

/**
 * Trata uma mensagem retornando ou não no bloco do método
 */
- (MAAgentResponseFixture*)receiveBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context;

@end

@interface MAAgentResponseFixture : NSObject

- (MAAgentResponseFixture*)expectedResultContext:(NSString*)key withValue:(NSObject*)value;

@end