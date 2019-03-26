//
//  DPhoneCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//
#import "DPhoneTableViewCell.h"

@protocol DPhoneCellRouteProtocol <NSObject>

- (DPhoneTableViewCell *)showPhoneCellModuleWithTableView:(UITableView *)tableView;
- (NSString *)getPhoneNumber;
- (void)setTextToTextField:(NSString *)text;
@end

@protocol DPhoneCellRouteProtocolOutput <NSObject>

- (UITableView *)getTableView;

@end
