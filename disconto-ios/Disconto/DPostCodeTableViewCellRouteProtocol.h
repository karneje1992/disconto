//
//  DPostCodeTableViewCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPostCodeTableViewCell.h"

@protocol DPostCodeTableViewCellRouteProtocol <NSObject>

- (DPostCodeTableViewCell *)showIndex:(UITableView *)tableView;
- (NSString *)getPostCode;
- (void)setTextToTextField:(NSString *)text;
@end
