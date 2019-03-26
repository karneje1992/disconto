//
//  DCardTableViewCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCardTableViewCellIteratorProtocol.h"
#import "DCardTableViewCell.h"
#import "DCardTableViewCellRouteProtocol.h"
#import "DCardTableViewCellPresenterProtocol.h"

@interface DCardTableViewCellPresenter : NSObject<UITextFieldDelegate, DCardTableViewCellPresenterProtocol>

@property DCardTableViewCell *view;
@property id<DCardTableViewCellIteratorProtocol> iterator;
@property id<DCardTableViewCellRouteProtocol> route;

- (instancetype)initWithView:(DCardTableViewCell *)view route:(id<DCardTableViewCellRouteProtocol>)route iterator:(id<DCardTableViewCellIteratorProtocol>)iterator;
@end
