
//
//  DTextTableViewCellRoute.m
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DTextTableViewCellRoute.h"

@interface DTextTableViewCellRoute ()

@property DTextTableViewCellIterator *iterator;
@end

@implementation DTextTableViewCellRoute

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.iterator = [[DTextTableViewCellIterator alloc] init];
    }
    return self;
}

- (DTextTableViewCell *)showTextModule:(UITableView *)tableView{

    DTextTableViewCell *cell = [DTextTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DTextTableViewCell class])];
    
    self.presenter = [[DTextTableViewCellPresenter alloc] initWithRoute:self iterator:self.iterator view:cell];
    
    return self.presenter.view;
}

- (void)setPlaceholder:(NSString *)string{

    [self.presenter setPlaceholder:string];
}

- (NSString *)getTextValue{

    return [self.presenter.iterator getTextValue];
}

- (void)setTextToTextField:(NSString *)text{

    [_presenter.view.textTextField setText:text];
}
@end
