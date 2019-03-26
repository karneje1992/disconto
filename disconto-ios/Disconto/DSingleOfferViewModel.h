//
//  DSingleOfferViewModel.h
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOfferModel.h"
#import "DSingleOfferViewController.h"

@interface DSingleOfferViewModel : NSObject

@property DOfferModel *offer;
@property NSMutableArray *cellsArray;
@property float headerSize;

+ (instancetype)showSingleOffer:(DOfferModel *)offer;
- (instancetype)initWithOffer:(DOfferModel *)offer;

- (void)updateViewController:(UIViewController *)controller;
@end
