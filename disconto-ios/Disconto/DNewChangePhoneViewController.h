//
//  DNewChangePhoneViewController.h
//  Disconto
//
//  Created by Rostislav on 6/15/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNewChangePhonePresenterPotocol.h"

@interface DNewChangePhoneViewController : DSuperViewController

@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property id <DNewChangePhonePresenterPotocol> presenter;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *botLayout;

+ (void)showChangePhoneControllerCallBack:(void (^)(DNewChangePhoneViewController *resault))callback;
@end

