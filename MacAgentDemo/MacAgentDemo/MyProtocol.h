//
//  MyProtocol.h
//  MacAgentTestModel
//
//  Created by Bernardo Breder on 06/05/15.
//  Copyright (c) 2015 Bernardo Breder. All rights reserved.
//

@protocol BuyerAgentDelegate <NSObject>

- (void)buyProduct:(NSNumber*)productId returning:(void(^)(NSDictionary* context))block;

- (void)buyProduct:(NSNumber*)productId withPayment:(NSString*)paymentName returning:(void(^)(NSDictionary* context))block;

@end

@protocol PaymentDelegate <NSObject>

- (void)payment:(NSDictionary*)context returning:(void(^)(NSDictionary* context))block;

@end

@protocol ExportDelegate <NSObject>

- (BOOL)exportData:(NSNumber*)productId;

@end