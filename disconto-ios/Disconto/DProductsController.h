//
//  DProductsController.h
//  Disconto
//
//  Created by Rostislav on 12.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"
#import "DNavigationBarModel.h"
#import "DProductsViewModel.h"
@interface DProductsController : DSuperViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel delegateController:(UIViewController *)delegateController;
@end
