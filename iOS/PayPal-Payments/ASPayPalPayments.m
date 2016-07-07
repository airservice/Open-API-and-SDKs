//
//  ASPayPalPayments.m
//  AirServiceKit
//
//  Copyright © 2016 AirService Digital. All rights reserved.
//

#import "ASPayPalPayments.h"

#import <Braintree/BraintreeCore.h>
#import <Braintree/BraintreePayPal.h>

@interface ASPayPalPayments () <BTViewControllerPresentingDelegate>

+ (NSString *)urlScheme;

@end

@implementation ASPayPalPayments

- (instancetype)initWithClientToken:(NSString *)clientToken hostViewController:(UIViewController *)viewController
{
    if ((self = [self init]))
    {
        _clientToken = clientToken;
        _hostViewController = viewController;
    }
    
    return self;
}

- (instancetype)init
{
    if ((self = [super init]))
    {
        [[self class] registerURLScheme];
    }
    
    return self;
}

- (void)authorizeVaultFlow:(void (^)(BOOL, NSString *, NSError *))completionBlock
{
    if (self.clientToken != nil && self.hostViewController != nil)
    {
        BTAPIClient *braintreeClient = [[BTAPIClient alloc] initWithAuthorization:self.clientToken];
        BTPayPalDriver *payPalDriver = [[BTPayPalDriver alloc] initWithAPIClient:braintreeClient];
        payPalDriver.viewControllerPresentingDelegate = self;
        
        [payPalDriver authorizeAccountWithCompletion:^(BTPayPalAccountNonce *tokenizedPayPalAccount, NSError *error) {
            
            if (error)
            {
                if (completionBlock)
                {
                    completionBlock(NO, nil, error);
                }
            }
            else
            {
                if (completionBlock)
                {
                    completionBlock(YES, tokenizedPayPalAccount.nonce, nil);
                }
            }
        }];
    }
}

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
{
    if ([url.scheme localizedCaseInsensitiveCompare:[[self class] urlScheme]] == NSOrderedSame) {
        return [BTAppSwitch handleOpenURL:url sourceApplication:sourceApplication];
    }
    
    return NO;
}

+ (void)registerURLScheme
{
    [BTAppSwitch setReturnURLScheme:[self urlScheme]];
}

+ (NSString *)urlScheme
{
    return [NSString stringWithFormat:@"%@.payments", [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"]];
}

#pragma mark - BTViewControllerPresentingDelegate

- (void)paymentDriver:(id)driver requestsPresentationOfViewController:(UIViewController *)viewController
{
    [self.hostViewController presentViewController:viewController animated:YES completion:nil];
}

- (void)paymentDriver:(id)driver requestsDismissalOfViewController:(UIViewController *)viewController
{
    [self.hostViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
