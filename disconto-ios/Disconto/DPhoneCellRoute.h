//
//  DPhoneCellRoute.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPhoneCellRouteProtocol.h"

@interface DPhoneCellRoute : NSObject<DPhoneCellRouteProtocol, DPhoneCellRouteProtocolOutput>

@property UITableView *tableView;
@end
