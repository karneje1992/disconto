//
//  DMoneyCellRoute.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DMoneyCellRoute.h"

@interface DMoneyCellRoute()

@property DMoneyCellPresenter *presenter;
@end

@implementation DMoneyCellRoute

- (DMoneyTableViewCell *)showModuleWithTableView:(UITableView *)tableView comision:(float)comision minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue{

    self.tableView = tableView;
    DMoneyTableViewCell *cell = [DMoneyTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DMoneyTableViewCell class])];
    DMoneyCellIterator *iterator = [[DMoneyCellIterator alloc] initWithComision:comision minValue:minValue maxValue:maxValue];
    self.presenter = [[DMoneyCellPresenter alloc] initWithView:cell route:self iterator:iterator];
    return self.presenter.view;
}

- (NSString *)getMoneyValue{

    NSLog(@"%@", self.presenter.iterator.getMoney);
    return self.presenter.iterator.getMoney;
}

- (UITableView *)getTableView{

    return self.tableView;
}

- (void)setComisionText:(NSString *)comision{

    [self.presenter.view.comisionLabel setText:comision];
}

- (void)setTextToTextField:(NSString *)text{

    [self.presenter.view.moneyTextField setText:text];
}

@end
