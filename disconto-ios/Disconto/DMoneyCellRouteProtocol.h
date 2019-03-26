//
//  DMoneyCellRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DMoneyTableViewCell.h"

@protocol DMoneyCellRouteProtocol <NSObject>

- (DMoneyTableViewCell *)showModuleWithTableView:(UITableView *)tableView comision:(float)comision minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;
- (NSString *)getMoneyValue;
- (void)setTextToTextField:(NSString *)text;

@end

@protocol DMoneyCellRouteProtocolOut <NSObject>

- (UITableView *)getTableView;
- (void)setComisionText:(NSString *)comision;
@end
