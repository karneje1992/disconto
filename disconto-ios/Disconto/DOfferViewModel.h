//
//  DOfferViewModel.h
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOfferViewController.h"
#import "DOfferModel.h"

@interface DOfferViewModel : NSObject

@property NSMutableArray <DOfferModel *> *offersArray;
@property NSMutableArray *cellsArray;

- (instancetype)initWithOffersArray:(NSArray<DOfferModel *> *)offersArray;
- (void)updateViewController:(DOfferViewController *)viewController;

+ (instancetype)showOffers:(NSArray<DOfferModel *> *)offers;
@end
