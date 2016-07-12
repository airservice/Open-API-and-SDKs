//
//  AirServiceKitViewController.h
//  AirServiceKit
//
//  Copyright © 2016 AirService Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ASAppEnvironment)
{
    ASAppEnvironmentQA = 0,
    ASAppEnvironmentProduction
};

typedef NS_ENUM(NSInteger, ASHostActionType)
{
    ASHostActionTypeNone = 0,
    ASHostActionTypeClose,
    ASHostActionTypeBack,
    ASHostActionTypeHome,
    ASHostActionTypeMenu
};

@protocol AirServiceKitDelegate;
@protocol ASPayPalPaymentsConnector;

@interface AirServiceKitViewController : UIViewController

@property (nonatomic, strong) IBInspectable NSString* clientID;
@property (nonatomic, strong) IBInspectable NSString* clientSecret;
@property (nonatomic, strong) IBInspectable NSString* collection;
@property (nonatomic, strong) IBInspectable NSString* filenameIcon;
@property (nonatomic, assign) ASHostActionType hostAction;
@property (nonatomic, strong) IBInspectable NSString* sector;

@property (nonatomic, assign) ASAppEnvironment appEnvironment;
@property (nonatomic, assign) BOOL acceptPayPalPayments;
@property (nonatomic, strong) id<ASPayPalPaymentsConnector> payPalPaymentsClient;
@property (nonatomic, strong) NSMutableArray *customParameters;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appStoreID;
@property (nonatomic, strong) NSString *appIdentifier;
@property (nonatomic, strong) NSString *overrideBaseAppURL;
@property (nonatomic, strong) NSString *overrideBaseApiURL;
@property (nonatomic, strong) NSDictionary *notification;
@property (nonatomic, weak) id<AirServiceKitDelegate> delegate;

- (instancetype)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret collection:(NSString *)collection delegate:(id<AirServiceKitDelegate>)delegate;

- (void)addPushDeviceToken:(NSData *)token;
- (void)notificationReceived:(NSDictionary*)payload handler:(void (^)(UIBackgroundFetchResult))handler local:(BOOL)local;
- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

@end

@protocol AirServiceKitDelegate <NSObject>
    @optional - (void)AirServiceKitDidUpdateCustomer:(NSDictionary*)customer;
    @optional - (void)AirServiceKitDidTriggerHostAction;
@end