//
//  DLoginViewModel.m
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DLoginViewModel.h"
#import "DUserDataViewCell.h"
#import "DEntranceViewController.h"
#import "DCityModel.h"
#import "ValidatorValues.h"
#import "NetworkManeger.h"
#import "DRegistrationViewModel.h"
#import "DRViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

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

@interface DLoginViewModel()


@property DRegistrationViewModel *registrationViewModel;
@end
@implementation DLoginViewModel

- (instancetype)initWhithParametrs:(NSDictionary *)parametrs
{
    self = [super init];
    if (self) {
       
        self.login = parametrs[@"login"];
        self.password = parametrs[@"password"];
    }
    return self;
}

- (void)vkLogin{
    
    [[VKSdk instance] registerDelegate:self];
    [[VKSdk instance] setUiDelegate:self];
    
    if ([VKSdk vkAppMayExists]) {
        
        [VKSdk authorize:@[VK_PER_EMAIL,VK_PER_WALL]];
    } else {
        
        [VKSdk authorize:@[VK_PER_EMAIL,VK_PER_WALL]];
    }
    
}

- (void)okLogin{
    
    [OKSDK authorizeWithPermissions:@[@"VALUABLE_ACCESS",@"LONG_ACCESS_TOKEN",@"PHOTO_CONTENT"] success:^(id data) {
        
        [OKSDK invokeMethod:@"users.getCurrentUser" arguments:@{} success:^(NSDictionary* data) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.registrationViewModel = [[DRegistrationViewModel alloc] initWhithParametrs:@{@"firstName":data[kFirstName],@"lastName":data[kLastName],@"socID":data[@"uid"],@"socType":kOK}];
                [self loginInSocialWithDictionary:@{kID:data[@"uid"],kSocType:kOK,@"soc_meta":data} callBack:^(NSDictionary *resault) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (resault[@"data"]) {
                            
                            RESTART;
                        }else{
                            if (![self.controller isKindOfClass:[DRViewController class]]) {
                                [[[UIAlertView alloc] initWithTitle:@"Такого аккаунта нет. Хотите зарегистрироваться?" message:nil delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Зарегестрироваться", nil] show];
                                
                            }else{
                                
                                [self.controller.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:self.registrationViewModel andShowSocButtons:NO] animated:YES];
                            }

                        }
                    });
                    
                }];
                
            });
        } error: nil];
        
        
    } error:nil];
}

- (void)fbLogin{
    
    // SHOW_PROGRESS;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                
                NSLog(@"Process error");
            } else if (result.isCancelled) {
                
                NSLog(@"Cancelled");
            } else {
                NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                [parameters setValue:@"id, name, link, first_name, last_name, email, birthday, bio, gender" forKey:@"fields"];
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result, NSError *error) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         if (!error) {
                             
                             NSLog(@"%@",result);
                             self.registrationViewModel = [[DRegistrationViewModel alloc] initWhithParametrs:@{@"firstName":[result[@"name"] componentsSeparatedByString:@" "][0],@"lastName":[result[@"name"] componentsSeparatedByString:@" "][1],@"email":result[kEmail] ? result[kEmail] : @"",@"socID":result[kID],@"socType":kFB}];
                             [self loginInSocialWithDictionary:@{kID:result[kID],kSocType:kFB,@"soc_meta":(NSDictionary *)result} callBack:^(NSDictionary *resault) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     NSLog(@"%@",resault);
                                     
                                     if (resault[@"data"]) {
                                         RESTART;
                                     }else{
                                         if (![self.controller isKindOfClass:[DRViewController class]]) {
                                             [[[UIAlertView alloc] initWithTitle:@"Такого аккаунта нет. Хотите зарегистрироваться?" message:nil delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Зарегестрироваться", nil] show];
                                             
                                         }else{
                                             
                                             [self.controller.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:self.registrationViewModel andShowSocButtons:NO] animated:YES];
                                         }
                                     }
                                 });
                                 
                             }];
                             
                         }else{
                             
                             SHOW_MESSAGE(socErrorConnect, nil);
                         }
                     });
                 }];
            }
        });
    }];
    
}

- (void)setupUIWhithController:(UIViewController *)controller{
    
    UITableView *tableView = [self getTableViewFromController:controller];
    self.controller = controller;
    controller.navigationController.navigationBarHidden = NO;
    controller.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Далее" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
    controller.navigationItem.rightBarButtonItem = rightButton;
    switch (self.loginStep) {
        case enumLogin:{
            TTTAttributedLabel *label = [self getLabelFromController:controller];
            [label setText:@"или войти"];
            DUserDataViewCell *fnCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:fnCell withPlaceholder:placeholderLogin];
            DUserDataViewCell *lnCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:lnCell withPlaceholder:placeholderPas];
            self.cellArray = @[fnCell,lnCell];
        }
            break;
        case enumForg:{
            TTTAttributedLabel *label = [self getLabelFromController:controller];
            [label setText:footerPassText];
            DUserDataViewCell *fnCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:fnCell withPlaceholder:placeholderLogin];
            self.cellArray = @[fnCell];
            UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
            controller.navigationItem.leftBarButtonItem = back;
        }
            break;
        default:
            break;
    }
}

- (UITableView *)getTableViewFromController:(UIViewController *)controller{
    
    for (UITableView *tableView in controller.view.subviews) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            return tableView;
        }
    };
    return nil;
}

- (void)addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:(NSString *)placeholder{
    
    // Recommended frame height is around 70.
    HoshiTextField *hoshiTextField = [[HoshiTextField alloc] initWithFrame:cell.textFildView.bounds];
    
    hoshiTextField.placeholder = placeholder;
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    hoshiTextField.placeholderFontScale = 1;
    
    // The color of the inactive border, default value is R185 G193 B202
    hoshiTextField.borderInactiveColor = [UIColor whiteColor];
    
    // The color of the active border, default value is R106 B121 B137
    hoshiTextField.borderActiveColor = [UIColor whiteColor];
    
    // The color of the placeholder, default value is R185 G193 B202
    hoshiTextField.placeholderColor = [UIColor whiteColor];
    
    // The color of the cursor, default value is R89 G95 B110
    hoshiTextField.cursorColor = [UIColor blueColor];
    
    // The color of the text, default value is R89 G95 B110
    hoshiTextField.textColor = [UIColor whiteColor];
    hoshiTextField.delegate = self;
    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    hoshiTextField.didBeginEditingHandler = ^{
        // ...
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    hoshiTextField.didEndEditingHandler = ^{
        // ...
    };
    [hoshiTextField addTarget:hoshiTextField
                       action:@selector(resignFirstResponder)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    switch (self.loginStep) {
        case enumLogin:{
            if ([placeholder isEqualToString:placeholderLogin]) {
                
                hoshiTextField.text = self.login;
            }else if ([placeholder isEqualToString:placeholderPas]) {
                hoshiTextField.text = self.password;
                hoshiTextField.secureTextEntry = YES;
            }
        }
            break;
            
        default:{
            hoshiTextField.text = self.login;
        }
            break;
    }
    [cell.textFildView addSubview:hoshiTextField];
}

- (void)doneAction{
    
    [self.controller.view endEditing:YES];
    switch (_loginStep) {
        case enumLogin:{
            if (_login && _password) {
                [self sendLogin];
            }else{
            
                SHOW_MESSAGE(@"Заполните все поля", nil);
            }
            
        }
            

            break;
            
        default:
            if (_login) {
                [self sendForg];
            }else{
                
                SHOW_MESSAGE(@"Заполните все поля", nil);
            }
            break;
    }
}

- (void)back{
    
    [self.controller.view endEditing:YES];
    if (self.loginStep == enumForg) {
        self.loginStep = enumLogin;
    }
    [self.controller.navigationController popViewControllerAnimated:YES];
}

- (void)sendLogin{
    
    NSString *type = [ValidatorValues validatePhoneNumber:self.login] ? @"phone" : @"login";
    type = [ValidatorValues validateEmail:self.login] ? @"email" : type;
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{type:self.login,@"password":self.password} andAPICall:apiLogin withCallBack:^(BOOL success, NSDictionary *resault) {
       
        if (success) {
            
            SET_TOKEN(resault[kServerData][@"UID"]);
            NSLog(@"%@",resault[kServerData][@"UID"]);
            [[NSUserDefaults standardUserDefaults] setObject:resault[kServerData][kID] forKey:@"userID"];
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                if ([[NetworkManeger sharedManager] responseValidate:resault]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isLogin"];
                    RESTART;
                }else{
                    
                    
                }
            });
            
        }
    }];
}

- (void)sendForg{
    NSString *type = [ValidatorValues validatePhoneNumber:self.login] ? @"phone" : @"email";
    type = [ValidatorValues validateEmail:self.login] ? @"email" : @"phone";
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{type:self.login} andAPICall:apiForgotPassword withCallBack:^(BOOL success, NSDictionary *resault) {
        if (success) {
            SHOW_MESSAGE(@"Проверьте вашу эл. почту", nil);
            self.loginStep = self.loginStep-1;
            [self.controller.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (self.loginStep) {
        case enumLogin:{
            if ([textField.placeholder isEqualToString:placeholderLogin]) {
                
                self.login = textField.text;
            }else if ([textField.placeholder isEqualToString:placeholderPas]) {
                self.password = textField.text;
            }
        }
            break;
            
        default:{
            self.login = textField.text;
        }
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( [string isEqualToString:@" "] && range.length==0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (TTTAttributedLabel *)getLabelFromController:(UIViewController *)controller{
    
    for (TTTAttributedLabel *label in controller.view.subviews) {
        if ([label isKindOfClass:[TTTAttributedLabel class]]) {
            return label;
        }
    };
    return nil;
}

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result{
    
    
    if (result.token) {
        [[[VKApi users] get:@{ VK_API_FIELDS : @"id,first_name,last_name,sex,city,bdate" }]
         executeWithResultBlock:^(VKResponse *response) {
             
             VKUser * user = ((VKUsersArray*)response.parsedModel).firstObject;
             NSLog(@"Любой другой параметр: %@", user.first_name);
             NSMutableDictionary *dict = @{}.mutableCopy;
             [dict setObject:result.token.email ? result.token.email : @"" forKey:kEmail];
             [dict setObject:result.token.userId forKey:kID];
             self.registrationViewModel = [[DRegistrationViewModel alloc] initWhithParametrs:@{@"firstName":user.first_name,@"lastName":user.last_name,@"socID":dict[kID],@"socType":kVK,@"email":dict[kEmail]}];
             
             [self loginInSocialWithDictionary:@{kID:result.token.userId,kSocType:@"vk",@"soc_meta":(NSDictionary *)response.json} callBack:^(NSDictionary *resault) {
                 
                 if (resault[@"data"]) {
                     RESTART;
                 }else{
                     
                     if (![self.controller isKindOfClass:[DRViewController class]]) {
                         [[[UIAlertView alloc] initWithTitle:@"Такого аккаунта нет. Хотите зарегистрироваться?" message:nil delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Зарегестрироваться", nil] show];
                         return ;
                     }else{
                     
                         [self.controller.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:self.registrationViewModel andShowSocButtons:NO] animated:YES];
                     }
                 }
           
             }];
             
         } errorBlock:^(NSError *error) {
             NSLog(@"Error: %@", error);
         }];
        
    }
    
}

- (void)vkSdkUserAuthorizationFailed{
    
}

- (void)loginInSocialWithDictionary:(NSDictionary *)dictionary callBack:(void (^)(NSDictionary *resault))callBack{
    
    __block NSString *socID = dictionary[kID];
    __block NSString *socType = dictionary[kSocType];
    if (!(![dictionary[@"id"] isEqual:[NSNull null]] && [[NSCharacterSet decimalDigitCharacterSet] isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:dictionary[@"id"]]])) {
        
         SHOW_MESSAGE(socErrorConnect, nil);
         callBack(nil);
        return;
    }else{
    
        [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{kSocType:socType,@"soc_id":socID} andAPICall:@"/users/exists/social" withCallBack:^(BOOL success, NSDictionary *resault) {
            if (success) {
                
                if ([resault[@"data"][@"count"] boolValue]) {
                    
                    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{kSocID:socID,kSocType:socType} andAPICall:apiLogin withCallBack:^(BOOL success, NSDictionary *resault) {
                        
                        if (success) {
                            SET_TOKEN(resault[kServerData][@"UID"]);
                            NSLog(@"%@",resault[kServerData][@"UID"]);
                            [[NSUserDefaults standardUserDefaults] setObject:resault[kServerData][kID] forKey:@"userID"];
                            
                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                
                                if ([[NetworkManeger sharedManager] responseValidate:resault]) {
                                    
                                    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isLogin"];
                                    RESTART;
                                }else{
                                    
                                    RESTART;
                                }
                            });
                            
                        }
                        callBack(resault);
                    }];
                }else{
                    
                    callBack(nil);
                }
            }
        }];
    }
    


}

#pragma mark - UIAletrView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex) {
        
        [self.controller.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:self.registrationViewModel andShowSocButtons:NO] animated:YES];
    }else{
    
        [DSocialViewController allSocialLogOut];
    }
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller{

    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers.firstObject presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError{

}
@end
