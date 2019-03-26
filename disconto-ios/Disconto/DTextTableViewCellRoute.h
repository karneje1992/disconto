//
//  DTextTableViewCellRoute.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTextTableViewCellIterator.h"
#import "DTextTableViewCellPresenter.h"
#import "DTextTableViewCell.h"
#import "DTextTableViewCellRouteProtocol.h"

@interface DTextTableViewCellRoute : NSObject<DTextTableViewCellRouteProtocol>

@property DTextTableViewCellPresenter *presenter;

- (DTextTableViewCell *)showTextModule:(UITableView *)tableView;
@end
