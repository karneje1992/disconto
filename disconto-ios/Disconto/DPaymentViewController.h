//
//  DPaymentViewController.h
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPaymentPresenterProtocol.h"

@interface DPaymentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *botLayout;

@property id <DPaymentPresenterProtocol> presenter;
+ (DPaymentViewController *)showPaymentViewController;
@end
