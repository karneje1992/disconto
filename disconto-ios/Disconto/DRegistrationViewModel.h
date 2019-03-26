//
//  DRegistrationViewModel.h
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTextFieldEffects.h"
#import "TTTAttributedLabel.h"
#import "DShowWebSiteController.h"

static NSString *const plaseHolderFirstName = @"Имя";
static NSString *const plaseHolderLastName = @"Фамилия";
static NSString *const plaseHolderCityName = @"Введите город";
static NSString *const plaseHolderEmail = @"Адрес электронной почты";
static NSString *const plaseHolderPass= @"Придумайте пароль";
static NSString *const plaseHolderPassword2 = @"Повторите пароль";

typedef NS_ENUM(NSInteger, registrationViewModelENUM) {
    
    enumNames = 0,
    enumCitys,
    enumEmail,
    enumPassword,
    enumFullRegistration
};

@interface DRegistrationViewModel : NSObject <UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource,TTTAttributedLabelDelegate,DShowWebSiteControllerDelegate>

@property NSString *firstName;
@property NSString *lastName;
@property NSString *cityID;
@property NSString *email;
@property NSString *password;
@property NSString *confermPassword;
@property NSInteger registrationStep;
@property NSArray *cellArray;
@property NSString *socType;
@property NSString *socID;
@property NSString *cityName;

- (instancetype)initWhithParametrs:(NSDictionary *)parametrs;
- (void)setupUIWhithController:(UIViewController *)controller;
- (void)getModelWithController:(UIViewController *)controller callBack:(void (^)(DRegistrationViewModel *model))callBack;
@end
