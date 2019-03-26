//
//  DUserModel.h
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVerificationModel.h"
@interface DUserModel : NSObject

@property NSString *userUuid;
@property NSInteger userBalance;
@property NSInteger userLoginCount;
@property NSString *userPhone;
@property NSString *userEmail;
@property BOOL userActivate;
@property BOOL userBaned;
@property NSInteger userCityID;
@property NSString *userCityName;
@property NSString *userLastName;
@property NSString *userFirsName;
@property NSInteger userPoints;
@property NSMutableArray *socials;
@property NSInteger version;
@property NSArray<DVerificationModel *> *verifications;

+ (void)updateProfileWithCallBack:(void (^)(DUserModel *resault))callBack;
+ (NSArray *)getCellsArrayWithUserModel:(DUserModel *)userModel andTableView:(UITableView *)tableView andController:(id)controller;
+ (void)saveNewValuesFromUser:(DUserModel *)user andCallBack:(void (^)(DUserModel *resault))callBack;
+ (BOOL)compareOldUserModel:(DUserModel *)oldUserModel andCurrentUserModel:(DUserModel *)currentUserModel;
//+ (void)resendToUser:(DUserModel *)user withCallBack:(void (^)(BOOL succsess))callBack;
@end
