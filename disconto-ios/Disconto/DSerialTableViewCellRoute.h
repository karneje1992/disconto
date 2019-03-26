//
//  DSerialTableViewCellRoute.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSerialTableViewCell.h"
#import "DSerialTableViewCellPresenter.h"
#import "DSerialTableViewCellIterator.h"
#import "DSerialTableViewCellRouteProtocol.h"

@interface DSerialTableViewCellRoute : NSObject<DSerialTableViewCellRouteProtocol>

@property UITableView *tableView;
@property DSerialTableViewCellPresenter *presenter;
@end
