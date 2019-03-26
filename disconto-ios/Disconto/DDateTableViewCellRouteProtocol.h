//
//  DDateTableViewCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DDateTableViewCell.h"

@protocol DDateTableViewCellRouteProtocol <NSObject>

- (DDateTableViewCell *)showDateCellModuleWithTableView:(UITableView *)tableView rootViewController:(UIViewController *)rootViewController;
- (UITableView *)getTableView;
- (NSString *)getDay;
- (NSString *)getMonth;
- (NSString *)getYear;
- (UIViewController *)getRootViewController;
- (void)setTitle:(NSString *)string;
- (void)setDay:(NSString *)day month:(NSString *)month year:(NSString *)year;
@end
