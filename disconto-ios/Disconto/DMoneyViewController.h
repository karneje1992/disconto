//
//  DMoneyViewController.h
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DChangePhoneViewController.h"
#import "DVeryFaryMailController.h"
#import "DCodeViewController.h"

@protocol DMoneyViewControllerDelegate <NSObject>

- (void)presentMoney:(float)balance pading:(float)pading;

@end

@interface DMoneyViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, DChangePhoneViewControllerDelegate, DVeryFaryMailControllerDelegte, DShowWebSiteControllerDelegate,DCodeViewControllerDelegate>

@property id <DMoneyViewControllerDelegate> delegate;

+ (instancetype)showMoneyControllerWithUser:(DUserModel *)user;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andUserModel:(DUserModel *)user;

@end
