//
//  DSingleOfferViewController.h
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSingleOfferViewModel.h"
#import "ForceCubeScanViewController.h"

@interface DSingleOfferViewController : DSuperViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel;
+ (instancetype)showSingleOfferWithViewModel:(id)viewModel;
@end
