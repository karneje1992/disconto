//
//  DTextTableViewCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DTextTableViewCell.h"

@protocol DTextTableViewCellRouteProtocol <NSObject>

- (DTextTableViewCell *)showTextModule:(UITableView *)tableView;
- (void)setPlaceholder:(NSString *)string;
- (NSString *)getTextValue;
- (void)setTextToTextField:(NSString *)text;
@end
