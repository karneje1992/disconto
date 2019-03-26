//
//  DSerialTableViewCellRoute.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DSerialTableViewCellRoute.h"
#import "DSerialTableViewCellIterator.h"

@implementation DSerialTableViewCellRoute

- (DSerialTableViewCell *)showPasportSerialModule:(UITableView *)tableView{

    self.tableView = tableView;
    DSerialTableViewCell *cell = [DSerialTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DSerialTableViewCell class])];
    self.presenter = [[DSerialTableViewCellPresenter alloc] initWithRoute:self iterator:[DSerialTableViewCellIterator new] view:cell];
    return self.presenter.view;
}

- (UITableView *)getTableView{

    return self.tableView;
}

- (NSString *)getPasportSerial{

    return self.presenter.iterator.getPasportSirial;
}

- (void)setTextToTextField:(NSString *)text{

    [_presenter.view.serialTextField setText:text];
}
@end
