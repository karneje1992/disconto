//
//  DStartViewModel.h
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRViewController.h"

typedef NS_ENUM(NSInteger, stratViewLabelsENUM) {
    
    enumRegistrationLabel = 0,
    enumLoginLabel
};

typedef NS_ENUM(NSInteger, stratViewButtonsENUM) {
    
    enumRegistrationButton = 0,
    enumLoginButton,
    enumSupportButton
};

static NSString * const kRegistrationLabelText = @"registrationLabelText";
static NSString * const kLoginLabelText = @"loginLabelText";
static NSString * const kRegistrationButtonText = @"registrationButtonText";
static NSString * const kLoginButtonText = @"loginButtonText";
static NSString * const kSupportButtonText = @"supportButtonText";

@interface DStartViewModel : NSObject

@property UIImage *iconImage;
@property NSString *registrationLabelText;
@property NSString *loginLabelText;
@property NSString *registrationButtonText;
@property NSString *loginButtonText;
@property NSString *supportButtonText;

- (instancetype)initWithParametrs:(NSDictionary *)parameters;
- (void)setupUIWithCotroller:(UIViewController *)controller;
@end
