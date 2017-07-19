//
//  ASApplePayPayments.h
//  AirServiceKit
//
//  Copyright © 2017 AirService Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASApplePayPaymentsConnector.h"

@import PassKit;

@interface ASApplePayPayments : NSObject <ASApplePayPaymentsConnector>

@property (nonatomic, strong) NSString *clientToken;

- (instancetype)initWithClientToken:(NSString *)clientToken;

- (BOOL)deviceSupportsPayments;
- (BOOL)deviceSupportsPaymentsWithAcceptedNetworks;
- (NSArray<PKPaymentNetwork> *)acceptedNetworks;

- (void)authorizePaymentRequest:(PKPaymentRequest *)paymentRequest applePayHostViewController:(UIViewController *)hostViewController completion:(void (^)(BOOL success, NSString *nonce, NSError *error))completionBlock;
- (void)presentApplePaySetup;

@end
