//
//  DCardTableViewCellRoute.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCardTableViewCellIterator.h"
#import "DCardTableViewCell.h"
#import "DCardTableViewCellPresenter.h"
#import "DCardTableViewCellRouteProtocol.h"

@interface DCardTableViewCellRoute : NSObject<DCardTableViewCellRouteProtocol>

@property DCardTableViewCellPresenter* presenter;
@property UITableView *tableView;
@end
