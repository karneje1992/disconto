//
//  DCacheViewController.h
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DCacheViewController : DSuperViewController

@property (strong, nonatomic) IBOutlet UIButton *moneyButton;
@property (strong, nonatomic) IBOutlet UIButton *inProgressButton;
@property (strong, nonatomic) IBOutlet UIButton *historyButton;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *padingLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerLayout;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@end
