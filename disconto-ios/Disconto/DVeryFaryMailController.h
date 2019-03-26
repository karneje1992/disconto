//
//  DVeryFaryMailController.h
//  Disconto
//
//  Created by user on 05.04.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, actionsType) {
    emailAction = 0,
    supportAction,
    resendAction
};

@protocol DVeryFaryMailControllerDelegte <NSObject>

- (void)changeEmail;
- (void)resend;
- (void)toSupp;
- (void)exit;

@end

@interface DVeryFaryMailController : DSuperViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *changeEmailButton;
@property (weak, nonatomic) IBOutlet UIButton *sendToSupportButton;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIView *popUpAlertView;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property id <DVeryFaryMailControllerDelegte> delegate;
@property (weak, nonatomic) IBOutlet UIButton *resendButton;
@property UIViewController *parentVC;
+ (instancetype)showVeryFaryEmailWithUser:(DUserModel *)user code:(NSInteger)code;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andUserModel:(DUserModel *)user code:(NSInteger)code;
@end