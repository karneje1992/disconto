//
//  DSubTableViewController.h
//  Disconto
//
//  Created by Rostislav on 12/26/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSubTableViewController : UITableViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel;

+ (instancetype)showCatecoryListWithViewModel:(id)viewModel;
@end
