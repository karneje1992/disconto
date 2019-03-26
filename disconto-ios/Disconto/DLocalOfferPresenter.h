//
//  DLocalOfferPresenter.h
//  Disconto
//
//  Created by Rostislav on 10.08.17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLocalOfferPresenterProtocol.h"
#import "DLocalOfferRoute.h"
#import "DLocalOffeIteratorProtocol.h"
#import "DLocalOffeIterator.h"
#import "DLocalOfferRoute.h"
#import "DLocalOfferViewController.h"

@interface DLocalOfferPresenter : NSObject<DLocalOfferPresenterProtocol, UITextFieldDelegate>

@property DLocalOfferRoute *route;
@property DLocalOffeIterator *iterator;
@property DLocalOfferViewController *view;

- (instancetype)initWith:(DLocalOfferRoute *)route iterator:(DLocalOffeIterator *)iterator view:(DLocalOfferViewController *)view;
@end
