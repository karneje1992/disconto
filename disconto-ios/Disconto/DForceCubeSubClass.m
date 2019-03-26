////
////  DForceCubeSubClass.m
////  ForseCubeDiscontoDemo
////
////  Created by Rostislav on 12/22/16.
////  Copyright © 2016 Devium. All rights reserved.
////
//
//#import "DForceCubeSubClass.h"
//#import "AppDelegate.h"
//
//@interface DForceCubeSubClass ()
//
//
//@end
//
//@implementation DForceCubeSubClass
//
//+ (id)installForscubeWithAppDeveloperKey:(NSString*)devKey appDeveloperSecret:(NSString*)appDeveloperSecret externalId:(NSString*)externalId{
//    static ForceCuBe *sharedMyManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedMyManager = [[self alloc] initWithAppDeveloperKey:devKey appDeveloperSecret:appDeveloperSecret externalId:externalId];
//    });
//    return sharedMyManager;
//}
//
//- (instancetype)initWithAppDeveloperKey:(NSString *)appId appDeveloperSecret:(NSString *)appSecret externalId:(NSString *)externalId
//{
//    self = [super initWithAppDeveloperKey:appId appDeveloperSecret:appSecret externalId:externalId];
//    if (self) {
//        
//      //  [self.runtimeSettigs setServerPollInterval:60*60*24];
//    }
//    return self;
//}
//
//+ (id)activeForceCube{
//
//    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    if (appDelegate.forcecube) {
//        return appDelegate.forcecube;
//    }else{
//    
//        return nil;
//    }
//}
//
//+ (void)couponReaded{
//
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"alarm"]) {
//        [[[NSUserDefaults standardUserDefaults] objectForKey:@"alarm"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            NSDateFormatter *dateFormatter = [NSDateFormatter new];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd:hh:mm"];
//            NSDate *alertDate = [dateFormatter dateFromString:obj[@"date"]];
//            if ([[NSDate date] timeIntervalSinceDate:alertDate] > couponTimeOut) {
//                [[[DForceCubeSubClass activeForceCube] campaignManager] setCampaignOfferAsRedeemed:[obj[@"couponID"] integerValue]];
//                [[[NSUserDefaults standardUserDefaults] objectForKey:@"alarm"] removeObject:obj];
//
//            }
//        }];
//    }
//    
//}
//@end
