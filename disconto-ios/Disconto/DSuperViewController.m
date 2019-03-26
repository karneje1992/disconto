//
//  DSuperViewController.m
//  Disconto
//
//  Created by user on 16.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSuperViewController.h"
#import "SnowFalling.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "DTabBarController.h"

static const NSString *letters = @"abcdefghijklmnopqrstuvwxyz0123456789";
@interface DSuperViewController ()<CBCentralManagerDelegate, UIAlertViewDelegate
,CLLocationManagerDelegate
>

@property CLLocationManager * locationManager;
@property CBCentralManager *bluetoothManager;
@property ForceCuBe *forceCube;
@property int couponCount;

@end

@implementation DSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _couponCount = 0;
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
    self.navigationController.navigationBar.topItem.title = @"";
    self.tabBarController.tabBar.barTintColor =  SYSTEM_NAV;
    self.navigationController.navigationBar.barTintColor = SYSTEM_NAV;
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50)
//                                                         forBarMetrics:UIBarMetricsDefault];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:NSStringFromClass([self class])];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"alarmDate"]) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        [dateFormatter setLocale:usLocale];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:s"];
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"alarmDate"];
        
        if ([[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]] timeIntervalSinceDate:[dateFormatter dateFromString:str]] > couponTimeOut) {
            
            [self notificationActionWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"alarmID"]];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"alarmDate"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"alarmID"];
        }
    }
    
        if (USER_IS_LOGINED) {
          //  [self callForceCube];
    
        }
    
    
}

//- (void)callForceCube{
//    
//        self.forceCube = [DForceCubeSubClass activeForceCube];
//        self.forceCube.delegate = self;
//        self.forceCube.campaignManager.delegate = self;
//        self.locationManager = [CLLocationManager new];
//        self.locationManager.delegate = self;
//    
//        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways)
//        {
//            [self.locationManager requestAlwaysAuthorization];
//        }
//    
//        [self.forceCube start];
//}

+ (void)logOut{
    
    NSLog(@"%@",TOKEN);
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UID"];
    NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"numOfLCalls"];
    [[NSUserDefaults standardUserDefaults] setInteger:i+1 forKey:@"numOfLCalls"];
    RESTART;
}

+ (NSString *)randomStringWithLength:(int)len{
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

+ (void)openSettings{
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
}

+ (NSArray *)getTutorial{
    
    return @[@"IOS_1",@"IOS_2",@"IOS_3",@"IOS_4",@"IOS_5",@"IOS_6",@"IOS_7",@"IOS_8",@"IOS_9"];
    
}

+ (NSArray *)getPhotoTutorial{
    
    return @[@"c1",@"c2",@"c3"];
}

- (void)notificationActionWithString:(NSString *)string{
    
   //   [[[DForceCubeSubClass activeForceCube] campaignManager] setCampaignOfferAsRedeemed:[string integerValue]];
    
}

- (void)bageUpdate{
    
    if ([[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController isKindOfClass:[DTabBarController class]]) {
        DTabBarController *tc = [UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController;
        [tc.couponItem setBadgeValue:[NSString stringWithFormat:@"%@",@(_couponCount)]];
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message{
    
    __block  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cencel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cencel];
    [self presentViewController:alertController animated:YES completion:nil];
}

//#pragma mark - FCBDelegate
//
////**************************************************************************************************
//- (void) manager: (id<FCBCampaignManager>) campaignManager didDeliverCampaignOffer: (id<FCBCampaignOffer>) campaignOffer {
//
//    _couponCount = _couponCount+1;
//    [self bageUpdate];
//   [self alarmWithOffer:campaignOffer];
//
//}
//
////**************************************************************************************************
//- (void) forceCuBe: (ForceCuBe *) fcb didRunIntoError: (NSError *) error
//{
//    [self showAlertWithTitle: @"Error"
//                     message: [NSString stringWithFormat: @"%@", error]];
//}

//**************************************************************************************************
//- (void) showAlertWithTitle: (NSString *) title message: (NSString *) message
//{
//    UIAlertController * ac = [UIAlertController alertControllerWithTitle: title
//                                                                 message: message
//                                                          preferredStyle: UIAlertControllerStyleAlert];
//
//    UIAlertAction * quitAction = [UIAlertAction actionWithTitle: @"OK"
//                                                          style: UIAlertActionStyleDefault
//                                                        handler:^(UIAlertAction * action) {
//
//
//                                                        }];
//    [ac addAction: quitAction];
//
//    [self presentViewController: ac animated: YES completion: nil];
//}

//**************************************************************************************************
//- (void) forceCuBe: (ForceCuBe *) fcb didChangeStatus: (FCBStatus) status error: (NSError *) error
//{
//    if (status == FCBStatusStopped)
//    {
//        if (error.code == kFCBUserErrorBackgroundLocationTrackingIsOff)
//        {
//            //            [self showAlertWithTitle: @"Error" message: @"Access to user location in background is denied."];
//        }
//        else if (error.code == kFCBNoNetworkOnInitError)
//        {
//            [self showAlertWithTitle: @"Error" message: @"No network access while initializing"];
//        }
//        else if (error.domain == kFCBServerErrorDomain)
//        {
//            [self showAlertWithTitle: @"Error" message: @"Server error while initializing"];
//        }
//        else if (error.code == kFCBUnrecoverableErrorAuthFailure)
//        {
//            [self showAlertWithTitle: @"Error" message: @"Wrong dev key or/and dev secret"];
//        }
//        else if (error.domain == kFCBRegionMonitoringErrorDomain)
//        {
//
//        }
//        else if (error.code == kFCBUnrecoverableErrorBLEIsUnsupported)
//        {
//            [self showAlertWithTitle: @"Error" message: @"BLE is not supported on this device"];
//        }
//        else if (error.code == kFCBUnrecoverableErrorBLEAccessIsUnauthorized)
//        {
//            [self showAlertWithTitle: @"Error" message: @"App doesnt have permission to access BLE"];
//        }
//    }
//    else if (status == FCBStatusStartedWithGeofencing)
//    {
//
//        _bluetoothManager  = [[CBCentralManager alloc]
//                              initWithDelegate:nil
//                              queue:dispatch_get_main_queue()
//                              options:@{CBCentralManagerOptionShowPowerAlertKey: @(YES)}];
//    
//
//            
//        
//        
//        //  [self showAlertWithTitle: @"Дисконто" message: @"Включите Bluetooth"];
//    }
//}

//- (void)centralManagerDidUpdateState:(CBCentralManager *)central
//{
//    NSString *stateString = nil;
//    switch(self.bluetoothManager.state)
//    {
//        case CBCentralManagerStateResetting: stateString = @"The connection with the system service was momentarily lost, update imminent."; break;
//        case CBCentralManagerStateUnsupported: stateString = @"The platform doesn't support Bluetooth Low Energy."; break;
//        case CBCentralManagerStateUnauthorized: stateString = @"The app is not authorized to use Bluetooth Low Energy."; break;
//        case CBCentralManagerStatePoweredOff: stateString = @"Bluetooth is currently powered off."; break;
//        case CBCentralManagerStatePoweredOn: stateString = @"Bluetooth is currently powered on and available to use."; break;
//        default: stateString = @"State unknown, update imminent."; break;
//    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bluetooth state"
//                                                    message:stateString
//                                                   delegate:nil
//                                          cancelButtonTitle:@"ok" otherButtonTitles: nil];
//    [_bluetoothManager.]
//    [alert show];
//}

//- (void)alarmWithOffer:(id<FCBCampaignOffer>)offer{
//
//    UILocalNotification *notific = [[UILocalNotification alloc] init];
//    [notific setHasAction:YES];
//    [notific setFireDate:[[NSDate date] dateByAddingTimeInterval:0]];
//    [notific setAlertBody:[NSString stringWithFormat:@"Доступен купон  %@",[offer fullscreenTitle]]];
//    [notific setAlertTitle:@"Дисконто"];
//    [notific setSoundName:@"push.caf"];
//    [[UIApplication sharedApplication] scheduleLocalNotification:notific];
//
//}


@end
