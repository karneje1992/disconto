//
//  DNamesTableViewCellRoute.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNamesTableViewCell.h"
#import "DNamesTableViewCellPresenter.h"
#import "DNamesTableViewCell.h"
#import "DNamesTableViewCellRouteProtocol.h"
#import "DNamesTableViewCellIterato.h"

@interface DNamesTableViewCellRoute : NSObject<DNamesTableViewCellRouteProtocol>

@property DNamesTableViewCell *view;
@property DNamesTableViewCellPresenter *presenter;
@property UITableView *tableView;
@end
