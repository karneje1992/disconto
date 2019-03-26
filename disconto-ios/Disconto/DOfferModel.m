//
//  DOfferModel.m
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DOfferModel.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface DOfferModel ()


@end
@implementation DOfferModel

+ (instancetype)getOfferWithDictionary:(NSDictionary *)dictionary{

    return [[DOfferModel alloc] initWithDictionary:dictionary];
}

//- (instancetype)initWithOffer:(id<FCBCampaignOffer>)forceCubeModel
//{
//    self = [super init];
//    if (self) {
//
//        self.offerID = [NSString stringWithFormat:@"%@",@(forceCubeModel.campaignOfferId)];
//        self.name = forceCubeModel.fullscreenTitle;
//        self.offerDescription = forceCubeModel.fullscreenText;
//        self.imgURL = forceCubeModel.imageUrl;
//        self.dateTo = forceCubeModel.avaliableTo;
//        self.dateFrom = forceCubeModel.avaliableFrom;
//        NSString *to = [NSDateFormatter localizedStringFromDate:self.dateTo
//                                                      dateStyle:NSDateFormatterShortStyle
//                                                      timeStyle:NSDateFormatterNoStyle];
//        NSString *text = [NSString stringWithFormat:@"%@ ",to];
//        self.dateText = [NSString stringWithFormat:@"Конец акции: %@",text];
//        self.FCModel = forceCubeModel;
//        
//    }
//     
//    return self;
//}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.instuctions = @[].mutableCopy;
        self.instuctions = [(NSArray *)dictionary[@"instructions"] mutableCopy];
        self.offerID = [NSString stringWithFormat:@"%@",dictionary[@"id"]];
        if (![dictionary[@"game_id"] isEqual:[NSNull null]]) {
            
            self.gameID = dictionary[@"game_id"];
        }
        self.offerDescript = [ dictionary[@"description"] isEqual:[NSNull null]] ? @""  : dictionary[@"description"] ;
        self.offerDescription = [ dictionary[@"full_description"] isEqual:[NSNull null]] ? @""  : dictionary[@"full_description"] ;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        [dateFormatter setLocale:usLocale];
        self.dateFrom = [dateFormatter dateFromString:dictionary[@"starts_at"]];
        self.dateTo = [dateFormatter dateFromString:dictionary[@"expires_at"]];
        NSString *to = [NSDateFormatter localizedStringFromDate:self.dateTo
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterNoStyle];
        NSString *text = [NSString stringWithFormat:@"%@ ",to];
        self.dateText = [NSString stringWithFormat:@"Конец акции: %@",text];
        self.imgURL = [NSURL URLWithString:dictionary[@"img_url"]];
        self.name = [ dictionary[@"name"] isEqual:[NSNull null]] ? @""  : dictionary[@"name"];
        self.legal = dictionary[@"legal_description"];
        self.unloced = [dictionary[@"unlocked"] boolValue];
        
        
        if (![dictionary[@"url"] isEqual:[NSNull null]]) {
            
            self.offerURL = [NSURL URLWithString:dictionary[@"url"]];
        }
        if (dictionary[@"value"]) {
            self.offerValue =  [[NSData alloc] initWithBase64EncodedString:dictionary[@"value"] options:0];
        }
        
    }
    
    return self;
}

+ (void)getPromosWithCallBack:(void (^)(NSArray<DOfferModel *> *models))callBack{

   __block  NSMutableArray *arr = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:apiGetPromos withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            if ([resault[@"data"] isKindOfClass:[NSArray class]]) {
                
                [resault[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [arr addObject:[DOfferModel getOfferWithDictionary:obj]];
                }];
                callBack(arr);
            }
        }
    }];
}

+ (void)getCouponsWithCallBack:(void (^)(NSArray<DOfferModel *> *models))callBack{

    __block  NSMutableArray *arr = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:apiGetCupons withCallBack:^(BOOL success, NSDictionary *resault) {
        if ([resault[@"data"] isKindOfClass:[NSArray class]]) {
            
            [resault[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [arr addObject:[DOfferModel getOfferWithDictionary:obj]];
            }];
            callBack(arr);
        }
    }];
}

+ (void)getForceCubeModelsWithCallBack:(void (^)(NSArray<DOfferModel *> *models))callBack{

    NSMutableArray *arr = @[].mutableCopy;
    
//    [[[[DForceCubeSubClass activeForceCube] campaignManager] unopenedOffers] enumerateObjectsUsingBlock:^(id<FCBCampaignOffer>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        [arr addObject:[[DOfferModel alloc] initWithOffer:obj]];
//    }];
        
    callBack(arr);
}

- (void)getFullOfferWithOffer:(DOfferModel *)offer callback :(void (^)(DOfferModel *offer))callBack{

    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@/%@",offer.instuctions ? @"/promo" : @"/coupon",offer.offerID] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            callBack([DOfferModel getOfferWithDictionary:resault[@"data"]]);
        }
    }];
}
@end
