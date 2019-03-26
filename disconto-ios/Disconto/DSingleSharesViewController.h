//
//  DSingleSharesViewController.h
//  Disconto
//
//  Created by user on 19.08.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DSingleSharesViewController : DSuperViewController

@property (strong, nonatomic) IBOutlet UIView *banerView;

+ (instancetype)showSingleSharesViewControllerWithSharesModel:(DSharesModel *)sharesModel;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andSharesModel:(DSharesModel *)model;
@end
