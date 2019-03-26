//
//  DCardTableViewCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DCardTableViewCell.h"
@protocol DCardTableViewCellRouteProtocol <NSObject>

- (DCardTableViewCell *)showCardTableViewCellModuleWithTableView:(UITableView *)tableView;
- (NSString *)getCardNumder;
- (UITableView *)getTableView;
- (void)setTextToTextField:(NSString *)text;
@end
