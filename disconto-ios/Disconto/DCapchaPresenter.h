//
//  DCapchaPresenter.h
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCapchaPresenterProtocol.h"
#import "DCapchaViewController.h"
#import "DCapchaRouteProtocol.h"
#import "DCapchaIteratorProtocol.h"

@interface DCapchaPresenter : NSObject<DCapchaPresenterProtocol, UITextFieldDelegate>

@property id<DCapchaRouteProtocol> route;
@property id<DCapchaIteratorProtocol> iterator;
@property DCapchaViewController *view;
@property id<DCapchaIteratorProtocol> dataSourse;

- (instancetype)initWithRoute:(id<DCapchaRouteProtocol>)route iterator:(id<DCapchaIteratorProtocol>)iterator view:(DCapchaViewController *)view;
@end
