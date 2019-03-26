//
//  DUserModel.m
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DUserModel.h"

@implementation DUserModel

+ (void)updateProfileWithCallBack:(void (^)(DUserModel *resault))callBack{
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiProfile] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        DUserModel *user = [DUserModel new];
        if (success) {
            NSDictionary *serverRespons = resault[kServerData];
            user.version = [serverRespons[@"version"] integerValue];
            //   user.userBalance = [serverRespons[kServerBalamce] isKindOfClass:[NSNull class]] ? 0 :[serverRespons[kServerBalamce] integerValue];
            user.userLoginCount = [serverRespons[@"login_count"] integerValue];
            
            
            [user setUserPhone:[NSString stringWithFormat:@"%@",serverRespons[@"phone"]]];
            if ([serverRespons[kEmail] isEqual:[NSNull null]]) {
                
                [user setUserEmail:@""];
                user.userActivate = NO;
            }else{
                
                [user setUserEmail:serverRespons[kEmail]];
                user.userActivate = YES;
            }
            
            user.userPoints = [serverRespons[@"points"] integerValue];
            user.userBalance = user.userPoints;
            user.userFirsName = serverRespons[kFirstName];
            user.userUuid = [NSString stringWithFormat:@"%@",@([serverRespons[kID] integerValue])];
            user.userCityID = [serverRespons[@"city"][@"id"] integerValue];
            user.userLastName = serverRespons[@"last_name"];
            user.userCityName = serverRespons[@"city"][@"title"];
            user.userBaned = [serverRespons[@"banned"] boolValue];
            NSMutableArray *arr = @[].mutableCopy;
            if ([serverRespons[@"verifications"] isKindOfClass:[NSArray class]]) {
                
                NSArray *verifications = serverRespons[@"verifications"];
                
                if (verifications.count > 0) {
                    
                    for (NSDictionary *dict in verifications) {
                        
                        
                            
                            
                            if (![dict[@"verified"] boolValue]) {
                                
                                [arr addObject:[[DVerificationModel alloc] initWithDictionary:dict]];
                            }
                        
                    }
                }
            }
            user.verifications = arr;
        }
        
        callBack(user);
    }];
}

+ (NSArray *)getCellsArrayWithUserModel:(DUserModel *)userModel andTableView:(UITableView *)tableView andController:(id)controller{
    
    NSMutableArray *array = @[].mutableCopy;
    DInputCell *userNameInputCell = [DInputCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DInputCell class])];
    
    [DInputCell setPlaceholder:@"Имя" toTextField:userNameInputCell.settingEditTextField];
    [userNameInputCell.settingEditTextField setKeyboardType:UIKeyboardTypeDefault];
    
    [userNameInputCell.settingEditTextField setText:userModel.userFirsName];
    [array addObject:userNameInputCell];
    
    DInputCell *userLastInputCell = [DInputCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DInputCell class])];
    
    [DInputCell setPlaceholder:@"Фамилия" toTextField:userLastInputCell.settingEditTextField];
    [userNameInputCell.settingEditTextField setKeyboardType:UIKeyboardTypeDefault];
    
    [userLastInputCell.settingEditTextField setText:userModel.userLastName];
    [array addObject:userLastInputCell];
    
    
    DInputCell *userEmailInputCell = [DInputCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DInputCell class])];
    
    [DInputCell setPlaceholder:@"Почта" toTextField:userEmailInputCell.settingEditTextField];
    [userEmailInputCell.settingEditTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    
    [userEmailInputCell.settingEditTextField setText:userModel.userEmail];
    [array addObject:userEmailInputCell];
    
    DInputCell *userPhoneInputCell = [DInputCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DInputCell class])];
    [DInputCell setPlaceholder:@"Телефон" toTextField:userPhoneInputCell.settingEditTextField];
    if (userModel.userPhone.length) {
        if ([userModel.userPhone rangeOfString:@"+"].location == NSNotFound) {
            
            [userPhoneInputCell.settingEditTextField setText:[NSString stringWithFormat:@"+%@",userModel.userPhone]];
        }else{
            [userPhoneInputCell.settingEditTextField setText:[NSString stringWithFormat:@"%@",userModel.userPhone]];
        }
    }
    
    
    [userPhoneInputCell.settingEditTextField setKeyboardType:UIKeyboardTypeNamePhonePad];
    [array addObject:userPhoneInputCell];
    
    DInputCell *userCityInputCell = [DInputCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DInputCell class])];
    
    [DInputCell setPlaceholder:@"Город" toTextField:userCityInputCell.settingEditTextField];
    [userCityInputCell.settingEditTextField setKeyboardType:UIKeyboardTypeDefault];
    
    [userCityInputCell.settingEditTextField setText:userModel.userCityName];
    [array addObject:userCityInputCell];
    
    return array;
}

+ (void)saveNewValuesFromUser:(DUserModel *)user andCallBack:(void (^)(DUserModel *resault))callBack{
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"city_id":@(user.userCityID), kFirstName:user.userFirsName, @"last_name":user.userLastName} andAPICall:[NSString stringWithFormat:@"%@",apiProfile] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            callBack(user);
        }
    }];
}

+ (BOOL)compareOldUserModel:(DUserModel *)oldUserModel andCurrentUserModel:(DUserModel *)currentUserModel{
    
    if ([oldUserModel.userFirsName isEqualToString:currentUserModel.userFirsName] && [oldUserModel.userLastName isEqualToString:currentUserModel.userLastName]  &&  [oldUserModel.userCityName isEqualToString:currentUserModel.userCityName]) {
        return NO;
    }else{
        
        return YES;
    }
    
}

@end
