//
//  DPhoneCellRoute.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPhoneCellRoute.h"
#import "DPhoneTableViewCell.h"
#import "DPhoneCellIterator.h"
#import "DPhoneCellPresenter.h"

@interface DPhoneCellRoute ()

@property DPhoneCellPresenter *presenter;

@end

@implementation DPhoneCellRoute

- (DPhoneTableViewCell *)showPhoneCellModuleWithTableView:(UITableView *)tableView{

    self.tableView = tableView;
    DPhoneTableViewCell *cell = [DPhoneTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DPhoneTableViewCell class])];
    DPhoneCellIterator *iterator = [DPhoneCellIterator new];
    self.presenter = [[DPhoneCellPresenter alloc] initWithView:cell route:self iterator:iterator];
    return self.presenter.view;
}

- (NSString *)getPhoneNumber{

    NSLog(@"%@", [self.presenter.iterator getPhoneNumber]);
    return [self.presenter.iterator getPhoneNumber];
}

- (UITableView *)getTableView{

    return self.tableView;
}

- (void)setTextToTextField:(NSString *)text{

    [_presenter.view.phoneTextField setText:text];
}
@end
