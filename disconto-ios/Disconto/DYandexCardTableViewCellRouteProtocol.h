//
//  DYandexCardTableViewCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//
#import "DYandexCardTableViewCell.h"

@protocol DYandexCardTableViewCellRouteProtocol <NSObject>

- (DYandexCardTableViewCell *)showYandexCardModuleWithTableView:(UITableView *)tableView;

- (NSString *)getYandexCard;
- (void)setTextToTextField:(NSString *)text;
@end
