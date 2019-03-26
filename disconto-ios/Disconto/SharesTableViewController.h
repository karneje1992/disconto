//
//  SharesTableViewController.h
//  Disconto
//
//  Created by Rostislav on 12/28/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharesTableViewController : UITableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andModelView:(id)modelView;

+ (instancetype)showSharesForViewModel:(id)viewModel;
@end
