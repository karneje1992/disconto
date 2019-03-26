//
//  DShopsViewController.h
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DShopsViewController : DSuperViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property BOOL showPrice;
@property BOOL isStepPhoto;

+ (instancetype)showShopsWithProduct:(DProductModel *)product;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProduct:(DProductModel *)product;
+ (instancetype)getAllShopsWithPrice:(BOOL)showPrice;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
@end
