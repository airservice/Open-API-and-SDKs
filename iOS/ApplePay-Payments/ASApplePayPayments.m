//
//  ASApplePayPayments.m
//  AirServiceKit
//
//  Copyright © 2017 AirService Digital. All rights reserved.
//

#import "ASApplePayPayments.h"

@import Braintree.BraintreeApplePay;

typedef void(^ASApplePayCompletionBlock)(BOOL success, NSString *nonce, NSError *error);

@interface ASApplePayPayments () <PKPaymentAuthorizationViewControllerDelegate>

@property (nonatomic, copy) ASApplePayCompletionBlock authorizedCompletionBlock;
@property (nonatomic, assign) BOOL authorizationStatusReceived;

- (BOOL)supportsPaymentsWithNetworks:(NSArray<PKPaymentNetwork> *)networks;

@end

@implementation ASApplePayPayments

- (instancetype)initWithClientToken:(NSString *)clientToken
{
    if ((self = [super init]))
    {
        _clientToken = clientToken;
    }
    
    return self;
}

- (BOOL)deviceSupportsPayments
{
    return [PKPaymentAuthorizationViewController canMakePayments];
}

- (BOOL)deviceSupportsPaymentsWithAcceptedNetworks
{
    return [self supportsPaymentsWithNetworks:[self acceptedNetworks]];
}

- (NSArray<PKPaymentNetwork> *)acceptedNetworks
{
    return @[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex];
}

- (void)authorizePaymentRequest:(PKPaymentRequest *)paymentRequest applePayHostViewController:(UIViewController *)hostViewController completion:(ASApplePayCompletionBlock)completionBlock
{
    NSAssert(self.clientToken && self.clientToken.length, @"ASApplePayPayments requires clientToken to be set");
    NSAssert(paymentRequest, @"ASApplePayPayments authorizePaymentRequest:applePayHostViewController:completion: missing paymentRequest value");
    NSAssert(hostViewController, @"ASApplePayPayments authorizePaymentRequest:applePayHostViewController:completion: missing hostViewController value");
    
    self.authorizedCompletionBlock = [completionBlock copy];
    self.authorizationStatusReceived = NO;
    
    PKPaymentAuthorizationViewController *viewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:paymentRequest];
    viewController.delegate = self;
    
    [hostViewController presentViewController:viewController animated:YES completion:nil];
}

- (void)presentApplePaySetup
{
    PKPassLibrary *passLibrary = [[PKPassLibrary alloc] init];
    [passLibrary openPaymentSetup];
}

#pragma mark - Private

- (BOOL)supportsPaymentsWithNetworks:(NSArray<PKPaymentNetwork> *)networks
{
    return [PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:networks];
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
    __weak typeof(self)weakSelf = self;
    
    BTAPIClient *braintreeClient = [[BTAPIClient alloc] initWithAuthorization:self.clientToken];
    BTApplePayClient *applePayClient = [[BTApplePayClient alloc] initWithAPIClient:braintreeClient];
    
    [applePayClient tokenizeApplePayPayment:payment completion:^(BTApplePayCardNonce * _Nullable tokenizedApplePayPayment, NSError * _Nullable error) {
        
        weakSelf.authorizationStatusReceived = YES;
        
        if (error)
        {
            if (weakSelf.authorizedCompletionBlock)
            {
                weakSelf.authorizedCompletionBlock(NO, nil, error);
            }
            
            completion(PKPaymentAuthorizationStatusFailure);
        }
        else
        {
            if (weakSelf.authorizedCompletionBlock)
            {
                weakSelf.authorizedCompletionBlock(YES, tokenizedApplePayPayment.nonce, nil);
            }
            
            completion(PKPaymentAuthorizationStatusSuccess);
        }
    }];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    __weak typeof(self)weakSelf = self;
    
    [controller dismissViewControllerAnimated:YES completion:^{
        
        if (weakSelf.authorizedCompletionBlock && !weakSelf.authorizationStatusReceived) //user must be cancelling ApplePay
        {
            weakSelf.authorizedCompletionBlock(NO, nil, nil);
        }
    }];
}

@end
