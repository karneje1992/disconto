//
//  DDateTableViewCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 7/3/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDateTableViewCell.h"
#import "DDateTableViewCellIteratorProtocol.h"
#import "DDateTableViewCellPresenterProtocol.h"
#import "DDateTableViewCellRouteProtocol.h"

@interface DDateTableViewCellPresenter : NSObject<DDateTableViewCellPresenterProtocol, UITextFieldDelegate>

@property DDateTableViewCell *view;
@property id <DDateTableViewCellIteratorProtocol> iterator;
@property id <DDateTableViewCellRouteProtocol> route;

- (instancetype)initWithRoute:(id<DDateTableViewCellRouteProtocol>)route iterator:(id<DDateTableViewCellIteratorProtocol>)iterator view:(DDateTableViewCell *)view;
@end
