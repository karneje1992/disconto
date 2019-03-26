//
//  DSettingViewController.h
//  Disconto
//
//  Created by user on 25.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DChangePhoneViewController.h"
#import "DSuperViewController.h"
#import "DVeryFaryMailController.h"
#import "DChangeEmailViewController.h"
#import "DCodeViewController.h"
#import "DShowWebSiteController.h"

@interface DSettingViewController : DSuperViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, DChangePhoneViewControllerDelegate, DVeryFaryMailControllerDelegte, DChangeEmailViewControllerDelegate,DCodeViewControllerDelegate, DShowWebSiteControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
