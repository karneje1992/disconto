//
//  DCardTableViewCellRoute.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DCardTableViewCellRoute.h"

@implementation DCardTableViewCellRoute

- (DCardTableViewCell *)showCardTableViewCellModuleWithTableView:(UITableView *)tableView{

    self.tableView = tableView;
    DCardTableViewCell *cell = [DCardTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DCardTableViewCell class])];
    DCardTableViewCellIterator *iterator = [DCardTableViewCellIterator new];
    self.presenter = [[DCardTableViewCellPresenter alloc] initWithView:cell route:self iterator:iterator];
    return self.presenter.view;
}

- (NSString *)getCardNumder{

    NSLog(@"%@", self.presenter.iterator.getCardNumber);
    return self.presenter.iterator.getCardNumber;
}

- (UITableView *)getTableView{

    return self.tableView;
}

- (void)setTextToTextField:(NSString *)text{

    [self.presenter.view.cardTextField setText:text];
}
@end
