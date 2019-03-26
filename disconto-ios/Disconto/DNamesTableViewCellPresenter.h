//
//  DNamesTableViewCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNamesTableViewCellIteratorProtocol.h"
#import "DNamesTableViewCellRouteProtocol.h"
#import "DNamesTableViewCell.h"
#import "DNamesTableViewCellPresenterProtocol.h"

@interface DNamesTableViewCellPresenter : NSObject<DNamesTableViewCellPresenterProtocol,UITextFieldDelegate>

@property DNamesTableViewCell *view;
@property id<DNamesTableViewCellRouteProtocol> route;
@property id<DNamesTableViewCellIteratorProtocol> iterator;

- (instancetype)initWithRoute:(id<DNamesTableViewCellRouteProtocol>)route iterator:(id<DNamesTableViewCellIteratorProtocol>)iterator view:(DNamesTableViewCell *)view;
@end
