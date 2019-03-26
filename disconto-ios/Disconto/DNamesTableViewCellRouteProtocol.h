//
//  DNamesTableViewCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//
#import "DNamesTableViewCell.h"

@protocol DNamesTableViewCellRouteProtocol <NSObject>

- (DNamesTableViewCell *)showNamesCellModuleWithTableView:(UITableView *)tableView;
- (UITableView *)getTableView;
- (NSString *)getFirstName;
- (NSString *)getMidleName;
- (NSString *)getLastName;

- (void)setFirst:(NSString *)first second:(NSString *)second lastNames:(NSString *)last;
@end
