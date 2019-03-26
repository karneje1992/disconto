//
//  DLoginModel.m
//  Disconto
//
//  Created by user on 12.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DLoginModel.h"

@implementation DLoginModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.loginValue = @"";
        self.passwordValue = @"";
        self.loginType = login;
        self.cellsArray = @[];
    }
    return self;
}

//- (void)setupCellsArrayWithScreenType:(NSInteger)screenType andController:(DLoginViewController *)controller andTableView:(UITableView *)tableView{
//    
//    NSMutableArray *cells = @[].mutableCopy;
//    switch (screenType) {
//        
//        case login:{
//            
//            DTextFildInputCell *cellLogin = [DTextFildInputCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DTextFildInputCell class])];
//            cellLogin.inputTextField.delegate = controller;
//            cellLogin.inputTextField.placeholder = apiLoginPlaceholder;
//            cellLogin.inputTextField.text = self.loginValue;
//            cellLogin.inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
//            [cells addObject:cellLogin];
//
//            DTextFildInputCell *cellPassword = [DTextFildInputCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DTextFildInputCell class])];
//            cellPassword.inputTextField.delegate = controller;
//            cellPassword.inputTextField.placeholder = placeholderPassword;
//            cellPassword.inputTextField.text = self.passwordValue;
//          //  cellPassword.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
//            cellPassword.inputTextField.secureTextEntry = YES;
//            [cells addObject:cellPassword];
//        }
//            break;
//            
//        case forgot:{
//            
//            DTextFildInputCell *cellLogin = [DTextFildInputCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DTextFildInputCell class])];
//            cellLogin.inputTextField.delegate = controller;
//            cellLogin.inputTextField.placeholder = apiLoginPlaceholder;
//            cellLogin.inputTextField.text = self.loginValue;
//            cellLogin.inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
//            [cells addObject:cellLogin];
//        }
//            break;
//        default:
//            break;
//    }
//    
//    self.cellsArray = cells;
//}

+ (void)loginWithLoginModel:(DLoginModel *)loginModel{

    NSString *logiType = @"";
    if ([ValidatorValues validatePhoneNumber:loginModel.loginValue]) {
        logiType = @"phone";
    }else{
    
        logiType = kEmail;
    }
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{logiType:loginModel.loginValue, @"password":[DLoginModel urlencode:loginModel.passwordValue]} andAPICall:apiLogin withCallBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (success) {
                
                [[NSUserDefaults standardUserDefaults] setObject:resault[kServerData][kID] forKey:@"userID"];
                SET_TOKEN(resault[kServerData][@"UID"]);
                RESTART;
            }else{
            
              //  [[[UIAlertView alloc] initWithTitle:@"Неверный логин или пароль" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                
            }
        });
    }];
}

+ (void)loginInSocialWithDictionary:(NSDictionary *)dictionary callBack:(void (^)(BOOL logined))callBack{

    __block NSString *socID = dictionary[kID];
    __block NSString *socType = dictionary[kSocType];
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{kSocID:socID,kSocType:socType, @"check":@(YES)} andAPICall:apiLogin withCallBack:^(BOOL success, NSDictionary *resault) {
        
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
        callBack(success);
    }];
}

+ (NSString *)urlencode:(NSString *)input {
    const char *input_c = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *result = [NSMutableString new];
    for (NSInteger i = 0, len = strlen(input_c); i < len; i++) {
        unsigned char c = input_c[i];
        if (
            (c >= '0' && c <= '9')
            || (c >= 'A' && c <= 'Z')
            || (c >= 'a' && c <= 'z')
            || c == '-' || c == '.' || c == '_' || c == '~'
            ) {
            [result appendFormat:@"%c", c];
        }
        else {
            [result appendFormat:@"%%%02X", c];
        }
    }
    return result;
}

+ (void)forgotWithLoginModel:(DLoginModel *)loginModel callBack:(void (^)(BOOL))callBack{

    NSMutableDictionary *mDictionary = @{}.mutableCopy;
    if ([ValidatorValues validateEmail:loginModel.loginValue]) {
        
        [mDictionary setObject:loginModel.loginValue forKey:kEmail];
    }else if ([ValidatorValues validatePhoneNumber:loginModel.loginValue]){
    
        [mDictionary setObject:loginModel.loginValue forKey:kPhone];
    }else{
    
        callBack(NO);
        return;
    }
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:mDictionary andAPICall:apiForgotPassword withCallBack:^(BOOL success, NSDictionary *resault) {
        
            callBack (success);
    }];
}


@end
