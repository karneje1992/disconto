//
//  DPaymentRoute.h
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPaymentRouteProtocol.h"
#import "DPaymentViewController.h"
#import "DPaymentIterator.h"
#import "DPaymentPresenter.h"

@interface DPaymentRoute : NSObject <DPaymentRouteActiveProtocol, DPaymentRouteDisableProtocol>
- (instancetype)initWithType:(NSInteger)type rootViewController:(UIViewController *)rootViewController;
+ (DPaymentRoute *)activeModuleWithType:(NSInteger)type rootViewController:(UIViewController *)rootViewController;

@property DPaymentIterator *iterator;
- (void)setParamsDictionary:(NSDictionary *)paramsDictionary;
@end
