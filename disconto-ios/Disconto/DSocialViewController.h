//
//  DSocialViewController.h
//  Disconto
//
//  Created by user on 02.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <FBSDKShareKit/FBSDKSharingContent.h>
#import "OKSDK.h"
#import "VKSdk.h"
//#import <FBSDKShareKit/FBSDKSharing.h>
#import "DSuperViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@protocol DSocialViewControllerDelegate <NSObject>

- (void)sharedComplit;

@end

@interface DSocialViewController : DSuperViewController< VKSdkUIDelegate,VKSdkDelegate>
+ (instancetype)showSharedWithQuest:(DQuestModel *)quest andProduct:(DProductModel *)product;
+ (void)initSocialsPlatformWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation andSocTypeString:(NSString *)socType;
+ (void)allSocialLogOut;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fb;

@property (strong, nonatomic) IBOutlet UIButton *vk;
@property (strong, nonatomic) IBOutlet UIButton *ok;
@property DQuestModel *quest;
@property id <DSocialViewControllerDelegate> delegate;

@end
