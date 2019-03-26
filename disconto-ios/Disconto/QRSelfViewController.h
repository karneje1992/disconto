//
//  QRSelfViewController.h
//  Disconto
//
//  Created by Rostislav on 8/18/18.
//  Copyright © 2018 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRSelfViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (instancetype)showCQRSelfViewController;
@end
