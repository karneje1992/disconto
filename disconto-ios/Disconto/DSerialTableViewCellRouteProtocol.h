//
//  DSerialTableViewCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DSerialTableViewCell.h"

@protocol DSerialTableViewCellRouteProtocol <NSObject>

- (DSerialTableViewCell *)showPasportSerialModule:(UITableView *)tableView;
- (UITableView *)getTableView;
- (NSString *)getPasportSerial;
- (void)setTextToTextField:(NSString *)text;
@end
