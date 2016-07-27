//
//  ASPayPalPayments.h
//  AirServiceKit
//
//  Copyright © 2016 AirService Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "ASPayPalPaymentsConnector.h"

@interface ASPayPalPayments : NSObject <ASPayPalPaymentsConnector>

@property (nonatomic, strong) NSString *clientToken;
@property (nonatomic, strong) UIViewController *payPalHostViewController;

- (instancetype)initWithClientToken:(NSString *)clientToken payPalHostViewController:(UIViewController *)viewController;
- (void)authorizeVaultFlow:(void (^)(BOOL success, NSString *nonce, NSError *error))completionBlock;
- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

+ (void)registerURLScheme;

@end
