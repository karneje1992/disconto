//
//  DNewChangePhonePresenter.h
//  Disconto
//
//  Created by Rostislav on 6/15/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNewChangePhonePresenterPotocol.h"
#import "DNewChangePhoneIterator.h"
#import "DNewChangePhoneRouteProtocol.h"
#import "DNewChangePhoneViewController.h"

@interface DNewChangePhonePresenter : NSObject <DNewChangePhonePresenterPotocol, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property DNewChangePhoneViewController *view;
@property DNewChangePhoneIterator *iterator;
@property id <DNewChangePhoneRouteOutput> route;

- (instancetype)initWithRoute:(id<DNewChangePhoneRouteProtocol>)route iterator:(DNewChangePhoneIterator *)iterator view:(DNewChangePhoneViewController *)view;
@end


