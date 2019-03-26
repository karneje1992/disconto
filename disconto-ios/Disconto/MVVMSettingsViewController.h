//
//  MVVMSettingsViewController.h
//  Disconto
//
//  Created by Rostislav on 09.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface MVVMSettingsViewController : DSuperViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andModelView:(id)modelView;
+ (instancetype)showSettingsWithModelView:(id)modelView;
@end
