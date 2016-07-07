//
//  AppDelegate.m
//  SupportingPayPalPayments
//
//  Copyright © 2016 AirService Digital. All rights reserved.
//

#import "AppDelegate.h"

#import <AirServiceKit/AirServiceKit.h>
#import <ASPayPalPayments/ASPayPalPayments.h>

@interface AppDelegate () <AirServiceKitDelegate>

@property (nonatomic, strong) AirServiceKitViewController *viewController;
- (void)registerForPushNotifications;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.viewController = [[AirServiceKitViewController alloc] initWithClientID:@"22c7d3fc" clientSecret:@"aada245b93feb5d8e84dfeb49296da8b" collection:@"airservice-qa-sdk" delegate:self];
    self.viewController.appName = @"AirServiceKit Basic Demo";
    self.viewController.appEnvironment = ASAppEnvironmentQA; //QA Environment. Remove for production
    
    self.viewController.acceptPayPalPayments = YES;
    self.viewController.payPalPaymentsClient = [[ASPayPalPayments alloc] init];
    
    NSDictionary* localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification)
    {
        [self.viewController notificationReceived:localNotification handler:nil local:YES];
    }
    
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification)
    {
        self.viewController.notification = remoteNotification;
    }
    
    [self registerForPushNotifications];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Push Notifications

- (void)registerForPushNotifications
{
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self.viewController addPushDeviceToken:deviceToken];
}

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

#pragma mark - URL scheme handling

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

#pragma mark - AirServiceKitDelegate Methods

- (void)AirServiceKitDidUpdateCustomer:(NSDictionary *)customer
{
    NSLog(@"AirServiceKitDidUpdateCustomer: %@", customer);
}

- (void)AirServiceKitDidTriggerHostAction
{
    NSLog(@"AirServiceKitDidTriggerHostAction");
}

@end