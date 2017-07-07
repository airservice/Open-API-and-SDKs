//
//  ASApplePayPaymentsConnector.h
//  AirServiceKit
//
//  Copyright © 2017 AirService Digital. All rights reserved.
//

@import PassKit;

@protocol ASApplePayPaymentsConnector <NSObject>

@required @property (nonatomic, strong) NSString *clientToken;

@required - (BOOL)deviceSupportsPayments;
@required - (BOOL)deviceSupportsPaymentsWithAcceptedNetworks;
@required - (NSArray<PKPaymentNetwork> *)acceptedNetworks;

@required - (void)authorizePaymentRequest:(PKPaymentRequest *)paymentRequest applePayHostViewController:(UIViewController *)hostViewController completion:(void (^)(BOOL success, NSString *nonce, NSError *error))completionBlock;
@required - (void)presentApplePaySetup;

@end
