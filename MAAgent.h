//
//  MAAgent.h
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 05/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define MESSAGE_CODE_SUCCESS 200
//#define MESSAGE_CODE_AUTH 303
//#define MESSAGE_CODE_ERROR -1

@interface MAAgent : NSObject

/**
 * Envia uma mensagem em broadcast sem esperar em segundo plano por uma resposta
 */
- (void)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context;

/**
 * Envia uma mensagem em broadcast esperando em segundo plano por uma resposta
 */
- (void)sendBroadcastMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block;

/**
 * Envia uma mensagem em broadcast sem esperar em segundo plano por uma resposta
 */
- (void)sendPrivateMessage:(SEL)selector withContext:(NSDictionary*)context;

/**
 * Envia uma mensagem em broadcast esperando em segundo plano por uma resposta
 */
- (void)sendPrivateMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block;

/**
 * Trata uma mensagem retornando ou não no bloco do método
 */
- (void)receiveMessage:(SEL)selector withContext:(NSDictionary*)context returning:(void (^)(NSDictionary* result))block;

/**
 * Inicializa um Agente
 */
- (instancetype)start;

/**
 * Finaliza um Agente
 */
- (instancetype)stop;

@end
