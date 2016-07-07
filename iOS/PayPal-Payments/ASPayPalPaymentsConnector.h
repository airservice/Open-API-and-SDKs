//
//  ASPayPalPaymentConnectors.h
//  AirServiceKit
//
//  Copyright © 2016 AirService Digital. All rights reserved.
//

@protocol ASPayPalPaymentsConnector <NSObject>

@required @property (nonatomic, strong) NSString *clientToken;
@required @property (nonatomic, strong) UIViewController *hostViewController;

@required - (void)authorizeVaultFlow:(void (^)(BOOL success, NSString *nonce, NSError *error))completionBlock;
@required - (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

@end
