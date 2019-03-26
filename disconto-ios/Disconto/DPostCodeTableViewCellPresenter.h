//
//  DPostCodeTableViewCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPostCodeTableViewCell.h"
#import "DPostCodeTableViewCellIteratorProtocol.h"
#import "DPostCodeTableViewCellRouteProtocol.h"
#import "DPostCodeTableViewCellPresenterProtocol.h"

@interface DPostCodeTableViewCellPresenter : NSObject<DPostCodeTableViewCellPresenterProtocol, UITextFieldDelegate>

@property id <DPostCodeTableViewCellIteratorProtocol> iterator;
@property id <DPostCodeTableViewCellRouteProtocol> route;
@property DPostCodeTableViewCell *view;

- (instancetype)initWithRoute:(id<DPostCodeTableViewCellRouteProtocol>)route iterator:(id<DPostCodeTableViewCellIteratorProtocol>)iterator view:(DPostCodeTableViewCell *)view;
@end
