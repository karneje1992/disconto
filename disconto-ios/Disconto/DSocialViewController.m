//
//  DSocialViewController.m
//  Disconto
//
//  Created by user on 02.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSocialViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <FBSDKShareKit/FBSDKShareLinkContent.h>
//#import <FBSDKShareKit/FBSDKShareDialog.h>

@interface DSocialViewController ()

@property DProductModel *product;
@end
static OKErrorBlock commonError = ^(NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    });
    
};
@implementation DSocialViewController

+ (instancetype)showSharedWithQuest:(DQuestModel *)quest andProduct:(DProductModel *)product{
    
    return [[DSocialViewController alloc] initWithNibName:NSStringFromClass([DSocialViewController class]) bundle:nil andQuest:quest andProduct:(DProductModel *)product];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andQuest:(DQuestModel *)quest andProduct:(DProductModel *)product
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.quest = quest;
        self.product = product;
//        self.content = [FBSDKShareLinkContent new];
//        _content.contentURL = self.quest.fbURL;
//        _content.contentDescription = self.quest.questMessage;
//        _content.imageURL = self.quest.questImageURL;
        
    }
    return self;
}

+ (void)allSocialLogOut{

    [VKSdk forceLogout];
    [[FBSDKLoginManager new] logOut];
    [OKSDK clearAuth];
}

+ (void)initSocialsPlatformWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    OKSDKInitSettings *settings = [OKSDKInitSettings new];
    settings.appKey = @"CBAOMLMFEBABABABA";
    settings.appId = @"1154141440";
    [OKSDK initWithSettings:settings];
    [VKSdk initializeWithAppId:@"5141964"];
    [FBSDKSettings setAppID:@"943279489125219"];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation andSocTypeString:(NSString *)socType{
    
    if([socType isEqualToString:kFB])
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation
                ];
    if([socType isEqualToString:kOK])
        [OKSDK openUrl:url];
    
    if([socType isEqualToString:kVK])
        return [VKSdk processOpenURL:url fromApplication:sourceApplication];
    
    return YES;
}

+ (void)loginWithSocTypeString:(NSString *)socType andLoginValuesDictionary:(NSDictionary *)dictionary{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:SYSTEM_COLOR];
    [StyleChangerClass changeBorderToButton:self.vk];
    [StyleChangerClass changeBorderToButton:self.fb];
    [StyleChangerClass changeBorderToButton:self.ok];
    _vk.layer.cornerRadius = 3;
    _ok.layer.cornerRadius = 3;
    _fb.layer.cornerRadius = 3;
    _fb.readPermissions = @[@"public_profile", @"email"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (IBAction)vkShare:(id)sender {
    
    if (![VKSdk isLoggedIn]) {
        
        [[VKSdk instance] registerDelegate:self];
        [[VKSdk instance] setUiDelegate:self];
        
        if ([VKSdk vkAppMayExists]) {
            
            [VKSdk authorize:@[VK_PER_EMAIL,VK_PER_WALL]];
        } else {
            
            [VKSdk authorize:@[VK_PER_EMAIL,VK_PER_WALL]];
        }

    }
    __block VKShareDialogController * shareDialog = [VKShareDialogController new]; //1
    shareDialog.text = self.quest.questMessage; //2
    shareDialog.uploadImages = @[[VKUploadImage uploadImageWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:self.quest.questImageURL]] andParams:[VKImageParameters jpegImageWithQuality:0.95]]];
    shareDialog.shareLink = [[VKShareLink alloc] initWithTitle:@"Дисконто" link:self.quest.vkURL]; //4
    [shareDialog setCompletionHandler:^(VKShareDialogController *dialog, VKShareDialogControllerResult result) {
        
        if (result == VKShareDialogControllerResultCancelled) {
            
            
        }else if(result == VKShareDialogControllerResultDone){
            
            [self.delegate sharedComplit];
        }else{
            
            
            SHOW_MESSAGE(socialQuestText, nil);
        }
        [dialog dismissViewControllerAnimated:YES completion:nil];
    }]; //5
    [self presentViewController:shareDialog animated:YES completion:nil];
}

- (IBAction)fbShare:(id)sender {
    
    if (self.quest.fbURL) {
        
//        FBSDKShareDialog *dialog = [FBSDKShareDialog new];
//        dialog.mode = FBSDKShareDialogModeFeedWeb;
//        dialog.shareContent = self.content;
//        dialog.fromViewController = self;
//        dialog.delegate = self;
//        [dialog show];
    }
    
}
- (IBAction)okShare:(id)sender {

   // NSString *old = [NSString stringWithFormat:@"{\"media\":[{\"text\":\"%@\",\"type\":\"text\"},{\"url\":\"%@\",\"type\":\"link\"},{\"text\":\" \",\"images\":[{\"title\":\"Дисконто\",\"mark\":\"disconto\",\"url\":\"%@\"}],\"type\":\"app\"}]}",self.quest.questMessage, _quest.okURL, self.quest.questImageURL];

    [OKSDK authorizeWithPermissions:@[@"VALUABLE_ACCESS",@"LONG_ACCESS_TOKEN",@"PHOTO_CONTENT"] success:^(id data) {
        
        [OKSDK showWidget:@"WidgetMediatopicPost" arguments:@{@"st.attachment":[NSString stringWithFormat:@"{\"media\":[{\"text\":\"%@\",\"type\":\"text\"},{\"url\":\"%@\",\"type\":\"link\"},{\"text\":\" \",\"images\":[{\"title\":\"Дисконто\",\"mark\":\"disconto\",\"url\":\"%@\"}],\"type\":\"app\"}]}",self.quest.questMessage, _quest.okURL, self.quest.questImageURL]} options:@{@"st.utext":@"on"} success:^(id data) {
            
                        [self.delegate sharedComplit];
                        [OKSDK shutdown];
        } error:^(NSError *error) {
            
            if (error) {
                
                [self.delegate sharedComplit];
                [OKSDK shutdown];
            }
        }];
    } error:^(NSError *error) {
        
    }];

}

//- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
//    
//    [self.delegate sharedComplit];
//}
//- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
//    
//    SHOW_MESSAGE(textQuestNotComplete, nil);
//}
//- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
//    
//    SHOW_MESSAGE(textQuestNotComplete, nil);
//}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller{
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers.firstObject presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError{
    
}
@end
