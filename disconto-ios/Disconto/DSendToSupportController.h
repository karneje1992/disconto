//
//  DSentToSupportController.h
//  Disconto
//
//  Created by user on 15.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DSendToSupportController : DSuperViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *send;
@property BOOL alternative;

@end
