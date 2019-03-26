//
//  DReadMessageViewController.h
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DReadMessageViewController : DSuperViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andMessages:(NSArray<DMessageModel *> *)messages;
+ (instancetype)getMessagesWithArray:(NSArray *)array;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
