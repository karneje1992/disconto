//
//  DSerialTableViewCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSerialTableViewCell.h"
#import "DSerialTableViewCellIteratorProtocol.h"
#import "DSerialTableViewCellRouteProtocol.h"
#import "DSerialTableViewCellPresenterProtocol.h"

@interface DSerialTableViewCellPresenter : NSObject<DSerialTableViewCellPresenterProtocol, UITextFieldDelegate>

@property DSerialTableViewCell *view;
@property id<DSerialTableViewCellIteratorProtocol> iterator;
@property id<DSerialTableViewCellRouteProtocol> route;
- (instancetype)initWithRoute:(id<DSerialTableViewCellRouteProtocol>)route iterator:(id<DSerialTableViewCellIteratorProtocol>)iterator view:(DSerialTableViewCell *)view;
@end
