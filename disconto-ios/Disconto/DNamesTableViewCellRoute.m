
//
//  DNamesTableViewCellRoute.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DNamesTableViewCellRoute.h"

@implementation DNamesTableViewCellRoute

- (DNamesTableViewCell *)showNamesCellModuleWithTableView:(UITableView *)tableView{

    self.tableView = tableView;
    DNamesTableViewCell *cell = [DNamesTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DNamesTableViewCell class])];
    self.presenter = [[DNamesTableViewCellPresenter alloc] initWithRoute:self iterator:[DNamesTableViewCellIterato new] view:cell];
    return self.presenter.view;
}

- (UITableView *)getTableView{

    return self.tableView;
}

- (NSString *)getFirstName{

    NSLog(@"%@",[self.presenter.iterator getFirstName]);
    return [self.presenter.iterator getFirstName];
}

- (NSString *)getMidleName{

    NSLog(@"%@",[self.presenter.iterator getSecondName]);
    return [self.presenter.iterator getSecondName];
}

- (NSString *)getLastName{

    NSLog(@"%@",[self.presenter.iterator getLastName]);
    return [self.presenter.iterator getLastName];
}

- (void)setFirst:(NSString *)first second:(NSString *)second lastNames:(NSString *)last{

    [_presenter.view.firstNameTextField setText:first];
    [_presenter.view.lastNameTextField setText:last];
    [_presenter.view.secondNameTextField setText:second];
}
@end
