//
//  DSingleProductController.h
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVeryFaryMailController.h"
#import "DChangeEmailViewController.h"

@interface DSingleProductController : DSuperViewController<DVeryFaryMailControllerDelegte, DChangeEmailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property DProductModel *product;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

+ (instancetype)openSingleProduct:(DProductModel *)product;

@end
