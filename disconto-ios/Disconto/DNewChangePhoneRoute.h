//
//  DNewChangePhoneRoute.h
//  Disconto
//
//  Created by Rostislav on 6/15/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNewChangePhonePresenter.h"
#import "DNewChangePhoneRouteProtocol.h"

@interface DNewChangePhoneRoute : NSObject<DNewChangePhoneRouteOutput>

@property UIViewController *rootViewController;
@property DNewChangePhonePresenter *presenter;
@property DNewChangePhoneViewController *view;

- (instancetype)initRootViewController:(UIViewController *)rootViewController;
- (void)showChangePhoneModuleWithRootController:(UIViewController *)rootViewController;
@end
