//
//  DLocalOfferRouteProtocol.h
//  Disconto
//
//  Created by Rostislav on 10.08.17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLocalOfferRouteProtocol <NSObject>

- (void)showLocalOfferModuleWithMoc:(DOfferModel *)moc viewController:(UIViewController *)viewController;

@end
