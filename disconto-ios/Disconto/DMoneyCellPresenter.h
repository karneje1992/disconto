//
//  DMoneyCellPresenter.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMoneyCellPresenterProtocol.h"
#import "DMoneyCellIteratorProtocol.h"
#import "DMoneyCellPresenter.h"
#import "DMoneyCellRouteProtocol.h"
#import "DMoneyTableViewCell.h"

@interface DMoneyCellPresenter : NSObject<DMoneyCellPresenterProtocol, UITextFieldDelegate>

@property id<DMoneyCellIteratorProtocol> iterator;
@property id<DMoneyCellRouteProtocolOut> route;
@property DMoneyTableViewCell *view;

- (instancetype)initWithView:(DMoneyTableViewCell *)view route:(id<DMoneyCellRouteProtocolOut>)route iterator:(id<DMoneyCellIteratorProtocol>)iterator;
@end
