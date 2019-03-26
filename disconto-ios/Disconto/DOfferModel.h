//
//  DOfferModel.h
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DForceCubeSubClass.h"

@interface DOfferModel : NSObject

@property NSString *offerID;
@property NSDate *dateTo;
@property NSDate *dateFrom;
@property NSString *offerDescription;
@property NSString *offerDescript;
@property NSURL *imgURL;
@property NSString *name;
@property NSMutableArray *instuctions;
@property NSString *dateText;
@property NSURL *offerURL;
@property NSString *legal;
@property BOOL unloced;
@property NSData *offerValue;
@property NSString *type;
@property NSString *gameID;
//@property id<FCBCampaignOffer> FCModel;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)getFullOfferWithOffer:(DOfferModel *)offer callback :(void (^)(DOfferModel *offer))callBack;
//- (instancetype)initWithOffer:(id<FCBCampaignOffer>)forceCubeModel;

+ (instancetype)getOfferWithDictionary:(NSDictionary *)dictionary;
+ (void)getPromosWithCallBack:(void (^)(NSArray<DOfferModel *> *models))callBack;
+ (void)getCouponsWithCallBack:(void (^)(NSArray<DOfferModel *> *models))callBack;
+ (void)getForceCubeModelsWithCallBack:(void (^)(NSArray<DOfferModel *> *models))callBack;

@end
