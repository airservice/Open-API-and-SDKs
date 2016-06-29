//
//  AppDelegate.m
//  PresentDemo
//
//  Copyright © 2016 AirService Digital. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) MainViewController *mainViewController;

- (void)registerForPushNotifications;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.mainViewController = [[MainViewController alloc] init];
    
    NSDictionary* localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification)
    {
        [self.mainViewController.airServiceKitViewController notificationReceived:localNotification handler:nil local:YES];
    }
    
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification)
    {
        self.mainViewController.airServiceKitViewController.notification = remoteNotification;
    }
    
    [self registerForPushNotifications];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.mainViewController;
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
    [self.mainViewController.airServiceKitViewController addPushDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self.mainViewController.airServiceKitViewController notificationReceived:userInfo handler:nil local:NO];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self.mainViewController.airServiceKitViewController notificationReceived:userInfo handler:completionHandler local:NO];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (notification.userInfo)
    {
        [self.mainViewController.airServiceKitViewController notificationReceived:notification.userInfo handler:nil local:YES];
    }
}


@end
