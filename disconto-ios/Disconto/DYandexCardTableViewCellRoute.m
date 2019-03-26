//
//  DYandexCardTableViewCellRoute.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DYandexCardTableViewCellRoute.h"

@implementation DYandexCardTableViewCellRoute

- (DYandexCardTableViewCell *)showYandexCardModuleWithTableView:(UITableView *)tableView{

    DYandexCardTableViewCell *cell = [DYandexCardTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DYandexCardTableViewCell class])];
    self.presenter = [[DYandexCardTableViewCellPresenter alloc] initWithView:cell iterator:[DYandexCardTableViewCellIterator new] route:self];
    
    return self.presenter.view;
}

- (NSString *)getYandexCard{

    return [self.presenter.iterator getYandexCard];
}

- (void)setTextToTextField:(NSString *)text{

    [_presenter.view.yandexTextFieald setText:text];
}
@end
