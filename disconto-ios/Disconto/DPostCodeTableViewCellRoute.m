//
//  DPostCodeTableViewCellRoute.m
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPostCodeTableViewCellRoute.h"
#import "DPostCodeTableViewCellIterator.h"

@implementation DPostCodeTableViewCellRoute

- (DPostCodeTableViewCell *)showIndex:(UITableView *)tableView{

    DPostCodeTableViewCell *cell = [DPostCodeTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DPostCodeTableViewCell class])];
    self.presenter = [[DPostCodeTableViewCellPresenter alloc] initWithRoute:self iterator:[DPostCodeTableViewCellIterator new] view:cell];
    return self.presenter.view;
}

- (NSString *)getPostCode{

    return [self.presenter.iterator getCodeIndex];
}

- (void)setTextToTextField:(NSString *)text{

    [_presenter.view.indexTextField setText:text];
}
@end
