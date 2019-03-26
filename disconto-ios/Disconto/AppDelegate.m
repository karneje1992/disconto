
//
//  AppDelegate.m
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "Flurry.h"
#import "DSingleOfferViewModel.h"
#import "DSingleOfferViewController.h"
#import "DCuponViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end
#endif

#ifndef NSFoundationVersionNumber_iOS_9_x_Max
#define NSFoundationVersionNumber_iOS_9_x_Max 1299
#endif

@interface AppDelegate ()


@end

@implementation AppDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";

+ (void)initialize
{
    if ([self class] == [AppDelegate class]) {
      //  [YMMYandexMetrica activateWithApiKey:@"1f9289e7-f447-40d9-8564-975c1aabe8e7"];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Fabric with:@[[Crashlytics class]]];
    
    [DSocialViewController initSocialsPlatformWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
    gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release
    [GMSServices provideAPIKey:@"AIzaSyDAAaisVcwIqWebIT-vOvSM_U6kiWAL2_c"];
    [Flurry startSession:@"Q9795HXHGK2Z9W7S4J6B"];
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = @"RMkJvt6dxSCKtdmdAtqPdS";
    [AppsFlyerTracker sharedTracker].appleAppID = @"id1003256356";
    //
    //  self.forcecube = [DForceCubeSubClass installForscubeWithAppDeveloperKey:devKey appDeveloperSecret:appDeveloperSecret externalId:externalId];
    
//    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    if (locationNotification) {
//        // Set icon badge number to zero
//        application.applicationIconBadgeNumber = 0;
//    }
    //within applicationDidFinishLaunchingWithOptions
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        if ([UIApplication instancesRespondToSelector: @selector(registerUserNotificationSettings:)]) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
 
                
                [application registerUserNotificationSettings:[UIUserNotificationSettings
                                                               settingsForTypes:UIUserNotificationTypeAlert| UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
            });
        }
    }
    
    #if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        UNUserNotificationCenter *notifiCenter = [UNUserNotificationCenter currentNotificationCenter];
        notifiCenter.delegate = self;
        [notifiCenter requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
        }];
#endif
    
  //  [self fmIniWithApplication:application];
    
    return YES;
}

- (void)fmIniWithApplication:(UIApplication *)application{
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        // iOS 7.1 or earlier. Disable the deprecation warnings.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType allNotificationTypes =
        (UIRemoteNotificationTypeSound |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeBadge);
        [application registerForRemoteNotificationTypes:allNotificationTypes];
#pragma clang diagnostic pop
    } else {
        // iOS 8 or later
        // [START register_for_notifications]
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
            UIUserNotificationType allNotificationTypes =
            (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
            UIUserNotificationSettings *settings =
            [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        } else {
            // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
            // For iOS 10 display notification (sent via APNS)
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            UNAuthorizationOptions authOptions =
            UNAuthorizationOptionAlert
            | UNAuthorizationOptionSound
            | UNAuthorizationOptionBadge;
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
            }];
            
            // For iOS 10 data message (sent via FCM)
     //       [FIRMessaging messaging].remoteMessageDelegate = self;
#endif
        }
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
  //  [FIRApp configure];
    // [END configure_firebase]
    // [START add_token_refresh_observer]
    // Add observer for InstanceID token refresh callback.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:)
//                                                 name:kFIRInstanceIDTokenRefreshNotification object:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    if (application.keyWindow.rootViewController)
        if([application.keyWindow.rootViewController isKindOfClass:[UINavigationController class]])
            if ([[[[(UINavigationController *)application.keyWindow.rootViewController visibleViewController].childViewControllers lastObject].childViewControllers lastObject].childViewControllers.lastObject isKindOfClass:[MPMoviePlayerViewController class]]){
                
                self.moviePlayerViewController = (id)[[[(UINavigationController *)application.keyWindow.rootViewController visibleViewController].childViewControllers lastObject].childViewControllers lastObject].childViewControllers.lastObject ;
                [self.moviePlayerViewController.moviePlayer stop];
            }
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if (application.keyWindow.rootViewController)
        if([application.keyWindow.rootViewController isKindOfClass:[UINavigationController class]])
            if ([[[[(UINavigationController *)application.keyWindow.rootViewController visibleViewController].childViewControllers lastObject].childViewControllers lastObject].childViewControllers.lastObject isKindOfClass:[MPMoviePlayerViewController class]]){
                
                self.moviePlayerViewController = (id)[[[(UINavigationController *)application.keyWindow.rootViewController visibleViewController].childViewControllers lastObject].childViewControllers lastObject].childViewControllers.lastObject ;
                [self.moviePlayerViewController.moviePlayer stop];
            }
    
  //  [[FIRMessaging messaging] disconnect];
  //  NSLog(@"Disconnected from FCM");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (application.keyWindow.rootViewController)
        if([application.keyWindow.rootViewController isKindOfClass:[UINavigationController class]])
            if ([[[[(UINavigationController *)application.keyWindow.rootViewController visibleViewController].childViewControllers lastObject].childViewControllers lastObject].childViewControllers.lastObject isKindOfClass:[MPMoviePlayerViewController class]]){
                
                [self.moviePlayerViewController.moviePlayer play];
            }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if (application.keyWindow.rootViewController)
        if([application.keyWindow.rootViewController isKindOfClass:[UINavigationController class]])
            if ([[[[(UINavigationController *)application.keyWindow.rootViewController visibleViewController].childViewControllers lastObject].childViewControllers lastObject].childViewControllers.lastObject isKindOfClass:[MPMoviePlayerViewController class]]){
                
                [self.moviePlayerViewController.moviePlayer play];
            }
    [FBSDKAppEvents activateApp];
    // [[AppsFlyerTracker sharedTracker] trackAppLaunch];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; // set badge number on icon
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  //  [self connectToFcm];
    [FBSDKAppEvents activateApp];
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    
    
    if (application.keyWindow.rootViewController) {
        if([application.keyWindow.rootViewController isKindOfClass:[UINavigationController class]])
            if ([[[[[[(UINavigationController *)application.keyWindow.rootViewController visibleViewController].childViewControllers lastObject].childViewControllers lastObject] childViewControllers] lastObject] isKindOfClass:[MPMoviePlayerViewController class]]){
                
                return UIInterfaceOrientationMaskAllButUpsideDown;
            }
    }
    
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    [DSocialViewController application:application openURL:url sourceApplication:sourceApplication annotation:annotation andSocTypeString:kFB];
    [DSocialViewController application:application openURL:url sourceApplication:sourceApplication annotation:annotation andSocTypeString:kVK];
    [DSocialViewController application:application openURL:url sourceApplication:sourceApplication annotation:annotation andSocTypeString:kOK];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    //const unsigned *tokenBytes = [devToken bytes];
    NSString *deviceTokenString = devToken.description;
    deviceTokenString = [deviceTokenString stringByReplacingOccurrencesOfString:@"[< >]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, deviceTokenString.length)];
  //  NSLog(@"%@", deviceTokenString.description);
    SET_PUSH_TOKEN(deviceTokenString);
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
        
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    if (err) {
        UIRemoteNotificationType enabledTypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
}
//**************************************************************************************************
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSString *string = userInfo[@"aps"][@"alert"];
    if ([string rangeOfString:@"logout"].location == NSNotFound) {
        NSLog(@"string does not contain bla");
    } else {
        [DSuperViewController logOut];
    }
    
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
       // NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
  //  NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_00
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    // Print message ID.
    NSDictionary *userInfo = notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
      //  NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    //NSLog(@"%@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
      //  NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    //NSLog(@"%@", userInfo);
    
    completionHandler();
}
#endif

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// Receive data message on iOS 10 devices while app is in the foreground.
//- (void)applicationReceivedRemoteMessage:(FIRMessagingRemoteMessage *)remoteMessage {
//    // Print full message
//    NSLog(@"%@", remoteMessage.appData);
//}
#endif

- (void)tokenRefreshNotification:(NSNotification *)notification {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
 //   NSString *refreshedToken = [[FIRInstanceID instanceID] token];
  //  NSLog(@"InstanceID token: %@", refreshedToken);
    
    // Connect to FCM since connection may have failed when attempted before having a token.
   // [self connectToFcm];
    
    // TODO: If necessary send token to application server.
}
// [END refresh_token]

// [START connect_to_fcm]
//- (void)connectToFcm {
//    // Won't connect since there is no token
//    if (![[FIRInstanceID instanceID] token]) {
//        return;
//    }
//    
//    // Disconnect previous FCM connection if it exists.
//    [[FIRMessaging messaging] disconnect];
//    
//    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
//        if (error != nil) {
//            NSLog(@"Unable to connect to FCM. %@", error);
//        } else {
//            NSLog(@"Connected to FCM.");
//        }
//    }];
//}

//**************************************************************************************************222


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    UIApplicationState state = [application applicationState];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    if (state == UIApplicationStateActive) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:notification.alertTitle
                                      message:notification.alertBody
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self notificationActionWithString:notification.alertBody application:application];
                             }];
        
        [alert addAction:ok];
        
        
        [application.keyWindow.rootViewController.childViewControllers.firstObject.presentedViewController presentViewController:alert animated:YES completion:nil];
        
    }else{
        
        [self notificationActionWithString:notification.alertBody application:application];
        
    }
}

- (void)notificationActionWithString:(NSString *)string application:(UIApplication *)application{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"alarmDate"]) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        [dateFormatter setLocale:usLocale];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:s"];
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"alarmDate"];
        
        if ([[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]] timeIntervalSinceDate:[dateFormatter dateFromString:str]] > couponTimeOut) {
            ;
            [self notificationActionWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"alarmID"]];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"alarmDate"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"alarmID"];
        }
    } else
        if ([string rangeOfString:@"Доступен "].location != NSNotFound){
            
            //                            [[[(UINavigationController *)application.keyWindow.rootViewController visibleViewController].childViewControllers lastObject] pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:[[DOfferModel alloc]initWithOffer:[[[[DForceCubeSubClass activeForceCube] campaignManager] unopenedOffers] firstObject]]]] animated:NO];
            
        }
    
}

- (void)notificationActionWithString:(NSString *)string{
    
    //   [[[DForceCubeSubClass activeForceCube] campaignManager] setCampaignOfferAsRedeemed:[string integerValue]];
    // RESTART;
}

@end
