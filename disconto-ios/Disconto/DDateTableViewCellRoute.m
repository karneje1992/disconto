//
//  DDateTableViewCellRoute.m
//  Disconto
//
//  Created by Rostislav on 7/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DDateTableViewCellRoute.h"

@implementation DDateTableViewCellRoute

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.iterator = [DDateTableViewCellIterator new];
    }
    return self;
}

- (DDateTableViewCell *)showDateCellModuleWithTableView:(UITableView *)tableView rootViewController:(UIViewController *)rootViewController{
    
    self.tableView = tableView;
    self.rootController = rootViewController;
    
    DDateTableViewCell *cell = [DDateTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDateTableViewCell class])];
    
    self.presenter = [[DDateTableViewCellPresenter alloc] initWithRoute:self iterator:self.iterator view:cell];
    return self.presenter.view;
}

- (UITableView *)getTableView{
    
    return self.tableView;
}

- (NSString *)getDay{

    NSLog(@"%@",[self.iterator getDay]);
    return [self.iterator getDay];
}

- (NSString *)getMonth{

    NSLog(@"%@",[self.iterator getMonth]);
    return [self.iterator getMonth];
}

- (NSString *)getYear{

    NSLog(@"%@",[self.iterator getYear]);
    return [self.iterator getYear];
}

- (UIViewController *)getRootViewController{

    return self.rootController;
}

- (void)setTitle:(NSString *)string{

    [self.presenter setTitle:string];
}

- (void)setDay:(NSString *)day month:(NSString *)month year:(NSString *)year{

    [_presenter.view.dayTextField setText:day];
    [_presenter.view.monthTextField setText:month];
    [_presenter.view.yearTextField setText:year];
}
@end
