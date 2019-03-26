//
//  DDateTableViewCellRoute.h
//  Disconto
//
//  Created by Rostislav on 7/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDateTableViewCellIterator.h"
#import "DDateTableViewCellPresenter.h"
#import "DDateTableViewCell.h"
#import "DDateTableViewCellRouteProtocol.h"

@interface DDateTableViewCellRoute : NSObject<DDateTableViewCellRouteProtocol>

@property DDateTableViewCellPresenter *presenter;
@property DDateTableViewCellIterator *iterator;
@property UITableView *tableView;
@property UIViewController *rootController;
@end
