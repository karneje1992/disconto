//
//  DPostCodeTableViewCellRoute.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPostCodeTableViewCell.h"
#import "DPostCodeTableViewCellRouteProtocol.h"
#import "DPostCodeTableViewCellPresenter.h"

@interface DPostCodeTableViewCellRoute : NSObject<DPostCodeTableViewCellRouteProtocol>

@property DPostCodeTableViewCellPresenter *presenter;
@end
