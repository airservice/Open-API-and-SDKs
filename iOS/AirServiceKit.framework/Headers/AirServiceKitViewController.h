//
//  AirServiceKitViewController.h
//  AirServiceKit
//
//  Copyright © 2016 AirService Digital. All rights reserved.
//  http://www.airservice.com
//

#import <UIKit/UIKit.h>

/**
 ASAppEnvironment is an enumeration describing which environment of AirService to run.
 */
typedef NS_ENUM(NSInteger, ASAppEnvironment)
{
    /** QA: To be used during development and testing. */
    ASAppEnvironmentQA = 0,
    
    /** Production: Live environment, real money, real people, real food.. */
    ASAppEnvironmentProduction
};

/**
 ASHostActionType is an enumeration describing the supported types of return/exit buttons
 that will be shown when AirService is presented or pushed from the host view controller.
 */
typedef NS_ENUM(NSInteger, ASHostActionType)
{
    /** None: No button will be shown */
    ASHostActionTypeNone = 0,
    /** Close: Button typically used when the `AirServiceKitViewController` is presented */
    ASHostActionTypeClose,
    /** Back: Button typically used when the `AirServiceKitViewController` is pushed */
    ASHostActionTypeBack,
    /** Home: House shaped button */
    ASHostActionTypeHome,
    /** Menu: Hamburger menu button */
    ASHostActionTypeMenu
};


@protocol AirServiceKitDelegate;


/** Private protocol used with ASPayPalPayments */
@protocol ASPayPalPaymentsConnector;


/**
 AirServiceKitViewController
 
 Include the AirService ordering platform right within your own application.
        AirServiceKitViewController can be used directly, or subclassed, and is simple to integrate 
        anywhere you would typically use a View Controller.
 
 @see https://github.com/airservice/Open-API-and-SDKs for more information.
 */
@interface AirServiceKitViewController : UIViewController

/**
 Your application code as provided by AirService
 */
@property (nonatomic, strong) IBInspectable NSString* appCode;

/** 
 Your client identifier for the AirService API
 */
@property (nonatomic, strong) IBInspectable NSString* clientID;


/**
 Your client secret for the AirService API
 */
@property (nonatomic, strong) IBInspectable NSString* clientSecret;


/**
 Your collection name as provided by AirService
 */
@property (nonatomic, strong) IBInspectable NSString* collection;


/**
 Implement any desired optional methods and set your object as the delegate.
 
 ```objc
 @interface AppDelegate () <AirServiceKitDelegate>
 ...
 self.viewController = [[AirServiceKitViewController alloc] initWithClientID:@"XX" clientSecret:@"XX" collection:@"XX" delegate:self];
 
 or
 
 self.viewController.delegate = self;
 ```
 
 @see `AirServiceKitDelegate`
 */
@property (nonatomic, weak) id<AirServiceKitDelegate> delegate;


/**
 Your sector name as provided by AirService
 
 Depending on your setup by AirService this value may not be required.
 */
@property (nonatomic, strong) IBInspectable NSString* sector;


/**
 Determines the return/exit button that will be shown when AirService is presented or pushed
 
 A button is displayed in the root view of AirService enabling your users to return
 to your View Controller. The value of hostAction determines what icon is shown on the button.
 
 @note Defaults to `ASHostActionTypeNone`
 @see `AirServiceKitDelegate` method `-AirServiceKitDidTriggerHostAction:`
 @see `ASHostActionType` enum for details
 */
@property (nonatomic, assign) ASHostActionType hostAction;


/**
 Determines which envionment of AirService to run.
 
 **QA:** To be used during development and testing.
 
 **Production:** Live environment, real money, real people, real food..
 
 @note Defaults to `ASAppEnvironmentProduction`
 @see `ASAppEnvironment` enum for details
 */
@property (nonatomic, assign) ASAppEnvironment appEnvironment;


/**
 Set this flag to indicate your application will support PayPal payments
 
 Supporting PayPal payments inside AirServiceKit also requires the [ASPayPalPayments library](https://github.com/airservice/Open-API-and-SDKs).
 
 ```objc
 self.viewController.acceptPayPalPayments = YES;
 self.viewController.payPalPaymentsClient = [[ASPayPalPayments alloc] init];
 ```
 
 @note Defaults to NO
 @see `payPalPaymentsClient` and https://github.com/airservice/Open-API-and-SDKs for more information.
 */
@property (nonatomic, assign) BOOL acceptPayPalPayments;


/**
 Your initialised ASPayPalPayments instance.
 
 Supporting PayPal payments inside AirServiceKit also requires the [ASPayPalPayments library](https://github.com/airservice/Open-API-and-SDKs).
 Provide an initialised instance of ASPayPalPayments as well as setting acceptPayPalPayments to true
 
 ```objc
 self.viewController.acceptPayPalPayments = YES;
 self.viewController.payPalPaymentsClient = [[ASPayPalPayments alloc] init];
 ```
 
 @see `acceptPayPalPayments` and https://github.com/airservice/Open-API-and-SDKs for more information.
 */
@property (nonatomic, strong) id<ASPayPalPaymentsConnector> payPalPaymentsClient;


/**
 Override your application display name.
 
 @note This is optional and will otherwise be taken from your app bundle automatically to match what is shown on the iOS homescreen.
 */
@property (nonatomic, strong) NSString *appName;


/**
 If your application launched as a result of a user interacting with a push notification, pass this notification to `AirServiceKitViewController` during initialisation.
 
 ```objc
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
 {
    ...
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification)
    {
        self.viewController.notification = remoteNotification;
    }
    ...
 }
 ```
 */
@property (nonatomic, strong) NSDictionary *notification;


/**
 Apple AppStore identifier.
 
 @note Advanced property, not required for standard implementation.
 */
@property (nonatomic, strong) NSString *appStoreID;


/**
 AirService specific app type identifier.
 
 @note Advanced property, not required for standard implementation.
 */
@property (nonatomic, strong) NSString *appIdentifier;


/**
 Overrides the default AirService App URL.
 
 @note Advanced property, not required for standard implementation.
 */
@property (nonatomic, strong) NSString *overrideBaseAppURL;


/**
 Overrides the default AirService API URL.
 
 @note Advanced property, not required for standard implementation.
 */
@property (nonatomic, strong) NSString *overrideBaseApiURL;


/**
 Provide additional custom parameters to `AirServiceKit`.
 
 @note Advanced property, not required for standard implementation.
 */
@property (nonatomic, strong) NSMutableArray *customParameters;


/**
 Override the default colour with your brand colour.
 
 @note This is optional, not required for standard implementation.
 */
@property (nonatomic, strong) UIColor *brandColour;


/**
 Enables `AirServiceKit` logging to the console. This is useful for debugging during development but should be disabled in production applications.
 
 @note Defaults to NO
 @note Advanced property, not required for standard implementation.
 */
@property (nonatomic, assign) BOOL loggingEnabled;


/**
 Convenience initializer to create an AirServiceKitViewController instance.
 Its parameters are required in order to authenticate with AirService.
 
 @param appCode Your application code as provided by AirService
 @param clientID Your client identifier for the AirService API
 @param clientSecret Your client secret for the AirService API
 @param collection Your collection name as provided by AirService
 @param delegate A delegate object adopting `AirServiceKitDelegate` that wishes to receive messages
 @return An `AirServiceKitViewController` instance
 */
- (instancetype)initWithAppCode:(NSString *)appCode clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret collection:(NSString *)collection delegate:(id<AirServiceKitDelegate>)delegate;


/**
 When your application successfully registers for remote notifications you must pass the device token 
 through to your `AirServiceKitViewController` instance. This is so that AirService can use Apple Push Notifications
 to communicate order related messages to customers.
 
 ```objc
 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
 {
    [self.viewController addPushDeviceToken:deviceToken];
 }
 ```
 
 @param token A device token object
 */
- (void)addPushDeviceToken:(NSData *)token;


/**
 A string representation of the saved device token, if any, that `AirServiceKit` currently holds.
 
 @see `-addPushDeviceToken:`
 @return A device token string
 */
+ (NSString *)pushDeviceToken;


/**
 When your application receives a notification via one of `UIApplication's` several delegate methods you must pass this 
 notification through to your `AirServiceKitViewController` instance so that AirServiceKit can handle it.
 
 ```objc
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
 {
    [self.viewController notificationReceived:userInfo handler:nil local:NO];
 }
 
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
 {
    [self.viewController notificationReceived:userInfo handler:completionHandler local:NO];
 }
 
 - (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
 {
    if (notification.userInfo)
    {
        [self.viewController notificationReceived:notification.userInfo handler:nil local:YES];
    }
 }

 ```
 
 @param payload The complete Apple Push Notification payload
 @param handler The existing `UIBackgroundFetchResult` completion handler or `nil`
 @param local Specify whether the notification you are passing is a local or remote notification
 @note If your application also makes use of push notifications you can check the notification payload 
 for the key/value pair `"source":"airservice"` and only pass the AirService specific notifications through to `AirServiceKit`.
 */
- (void)notificationReceived:(NSDictionary*)payload handler:(void (^)(UIBackgroundFetchResult))handler local:(BOOL)local;


/**
 AirServiceKit makes use of resource URLs, URL schemes and services such as PayPal Payments. If your application receives a request to handle a URL 
 pass this through to your `AirServiceKitViewController` instance so that AirServiceKit can determine whether to handle it.
 
 ```objc
 //iOS 8
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
     return [self.viewController handleOpenURL:url sourceApplication:sourceApplication];
 }
 
 //iOS 9
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
 {
     return [self.viewController handleOpenURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
 }
 ```
 
 @param url The URL provided from the `UIApplication` delegate
 @param sourceApplication The NSString sourceApplication provided from the `UIApplication` delegate
 @return A BOOL indicating whether `AirServiceKit` has handled the URL or your application should manage it.
 @note `AirServiceKit` only handles its specific URLs it recognises and is interested in, if your application also makes 
 use of URL schemes you can check the return value from this method.
 */
- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

@end


/**
 `AirServiceKitDelegate` exposes optional methods that you can implement in your application to receive events from AirServiceKit.
 AirServiceKit uses these methods to communicate with your application. For an instance of your class to function as the delegate 
 of AirServiceKit, it must do the following:
 
 - Set your object as the delegate (by assigning it to `AirServiceKitViewController's` delegate property).
 - Declare that your class adopts the protocol in the class definition. For example:
 
 ```objc
 @interface MyClass () <AirServiceKitDelegate>
 ```
 
 - Implement any optional methods that you want to participate in.
 */
@protocol AirServiceKitDelegate <NSObject>

    @optional

    /**
     An optional `AirServiceKitDelegate` method that can provide your application with information about the authenticated AirService customer.
     
     @param customer An `NSDictionary` containing information such as `name`, `email`, `birth_date`, `mobile` and `id`.
     @note This information is provided directly by a customer, as such the presence of all information nor its accuracy is not guaranteed.
     */
    - (void)AirServiceKitDidUpdateCustomer:(NSDictionary*)customer;


    /** 
     An optional `AirServiceKitDelegate` method used to inform your application that the user has requested to exit the `AirServiceKitViewController` 
     and return to your application.
     
     Depending on how your application implemented the launch of `AirServiceKitViewController` you should use this delegate method to reverse that process. 
     
     - **Example 1** If you modally presented the `AirServiceKitViewController`, you should dismiss it to return.
     
     ```objc
     - (IBAction)presentAirService
     {
         [self presentViewController:self.airServiceKitViewController animated:YES completion:nil];
     }
     
     - (void)AirServiceKitDidTriggerHostAction
     {
         [self dismissViewControllerAnimated:YES completion:nil];
     }
     ```
     
     - **Example 2** If you pushed the `AirServiceKitViewController` from within a `UINavigationController`, you should pop it to return.
     
     ```objc
     - (IBAction)pushAirService
     {
         [self.navigationController pushViewController:self.airServiceKitViewController animated:YES];
         [self.navigationController setNavigationBarHidden:YES animated:YES];
     }
     
     - (void)AirServiceKitDidTriggerHostAction
     {
         [self.navigationController popViewControllerAnimated:YES];
         [self.navigationController setNavigationBarHidden:NO animated:YES];
     }
     ```
     
     @see `ASHostActionType` for supported types of return/exit buttons that will be shown
     */
    - (void)AirServiceKitDidTriggerHostAction;
@end
