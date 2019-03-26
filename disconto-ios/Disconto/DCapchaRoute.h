//
//  DCapchaRoute.h
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCapchaPresenter.h"
#import "DCapchaRouteProtocol.h"

@interface DCapchaRoute : NSObject<DCapchaRouteProtocol>

@property DCapchaPresenter *presenter;

@end
