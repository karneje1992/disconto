//
//  DOfferViewController.h
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOfferViewController : DSuperViewController

@property NSString *parentTitle;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
+ (instancetype)showOffersWithViewModel:(id)viewModel;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel;
@end
