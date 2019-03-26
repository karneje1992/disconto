//
//  DSettingsViewModel.h
//  Disconto
//
//  Created by Rostislav on 09.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUserDataViewCell.h"
#import "DChangePhoneViewController.h"
#import "DVeryFaryMailController.h"
#import "DChangeEmailViewController.h"
#import "DCodeViewController.h"
#import "DShowWebSiteController.h"

@interface DSettingsViewModel : NSObject<UITextFieldDelegate,DChangePhoneViewControllerDelegate, DVeryFaryMailControllerDelegte, DChangeEmailViewControllerDelegate,DCodeViewControllerDelegate, DShowWebSiteControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UIAlertViewDelegate>

@property NSArray<DUserDataViewCell *> *cellsArray;
@property NSString *title;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *email;
@property NSString *phone;
@property NSString *city;
@property UIViewController *activeController;

- (void)updateViewWithController:(UIViewController *)controller callBack:(void (^)(id model))callBack;
- (void)tuter;
- (void)showLicens;
- (void)changePassword;
- (void)initCells;
@end
