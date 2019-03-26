//
//  DYandexCardTableViewCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYandexCardTableViewCellPresenterProtocol.h"
#import "DYandexCardTableViewCell.h"
#import "DYandexCardTableViewCellPresenterProtocol.h"
#import "DYandexCardTableViewCellRouteProtocol.h"
#import "DYandexCardTableViewCellIteratorProtocol.h"
#import "DYandexCardTableViewCellPresenterProtocol.h"

@interface DYandexCardTableViewCellPresenter : NSObject<DYandexCardTableViewCellPresenterProtocol,DYandexCardTableViewCellPresenterProtocol, UITextFieldDelegate>

@property DYandexCardTableViewCell *view;
@property id<DYandexCardTableViewCellRouteProtocol> route;
@property id<DYandexCardTableViewCellIteratorProtocol> iterator;

- (instancetype)initWithView:(DYandexCardTableViewCell *)view iterator:(id<DYandexCardTableViewCellIteratorProtocol>)iterator route:(id<DYandexCardTableViewCellRouteProtocol>)route;
@end
