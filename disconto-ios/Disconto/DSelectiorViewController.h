//
//  DSelectiorViewController.h
//  Disconto
//
//  Created by user on 29.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSelectProductCell.h"

@interface DSelectiorViewController : DSuperViewController<UITableViewDataSource, UITableViewDelegate, DSelectProductCellDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UILabel *allPointsLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property DShopPreview *shop;

+ (instancetype)showSelrctorViewControllerWithProductsArray:(NSArray <DProductModel *> *)products;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProducts:(NSArray <DProductModel *> *)products;
@end
