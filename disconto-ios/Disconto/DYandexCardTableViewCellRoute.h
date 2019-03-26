//
//  DYandexCardTableViewCellRoute.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYandexCardTableViewCellRouteProtocol.h"
#import "DYandexCardTableViewCell.h"
#import "DYandexCardTableViewCellPresenter.h"
#import "DYandexCardTableViewCellIterator.h"

@interface DYandexCardTableViewCellRoute : NSObject<DYandexCardTableViewCellRouteProtocol>

@property DYandexCardTableViewCellPresenter *presenter;
@end
