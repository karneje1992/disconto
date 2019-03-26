//
//  DLoginViewModel.h
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCTextFieldEffects.h"

static NSString *const placeholderLogin = @"Почта или телефон";
static NSString *const placeholderPas = @"Пароль";

typedef NS_ENUM(NSInteger, loginViewModelENUM) {
    
    enumLogin = 0,
    enumForg
};
@interface DLoginViewModel : NSObject <UITextFieldDelegate,VKSdkDelegate,VKSdkUIDelegate,UIAlertViewDelegate>
@property NSString *login;
@property NSString *password;
@property NSArray *cellArray;
@property NSInteger loginStep;
@property UIViewController *controller;

- (instancetype)initWhithParametrs:(NSDictionary *)parametrs;
- (void)setupUIWhithController:(UIViewController *)controller;
- (void)vkLogin;
- (void)okLogin;
- (void)fbLogin;
- (void)sendLogin;
- (void)loginInSocialWithDictionary:(NSDictionary *)dictionary callBack:(void (^)(NSDictionary *resault))callBack;

//- (void)loginInSocialWithDictionary:(NSDictionary *)dictionary callBack:(void (^)(BOOL logined))callBack;
@end
