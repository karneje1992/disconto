//
//  DMoneyCellRoute.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMoneyCellRouteProtocol.h"
#import "DMoneyTableViewCell.h"
#import "DMoneyCellIterator.h"
#import "DMoneyCellPresenter.h"

@interface DMoneyCellRoute : NSObject<DMoneyCellRouteProtocol,DMoneyCellRouteProtocolOut>

@property UITableView *tableView;
@end
