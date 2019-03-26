//
//  DCapchaRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

@protocol DCapchaRouteProtocol <NSObject>

- (void)showCapchaModuleWithRootVC:(UIViewController *)rootVC;
- (void)dismiss;

@end
