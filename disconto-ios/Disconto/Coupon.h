//
//  Coupon.h
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/22/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DForceCubeSubClass.h"

typedef NS_ENUM(NSInteger, CouponCellsEnum) {
    enumCuponHeader = 0,
    enumCuponTitle,
    enumCuponDate,
    enumCuponDescription,
    enumCuponMap,
    enumCuponCounCell
};

typedef NS_ENUM(NSInteger, CuponType) {
    enumCuponUnAccept = 0,
    enumCuponAccept
};

@interface Coupon : NSObject

@property CuponType type;
@property NSString *couponID;
@property NSData *imgData;
@property NSDate *dateTo;
@property NSDate *dateFrom;
@property NSString *title;
@property NSString *fullDescription;
@property NSString *dateText;
//@property id<FCBCampaignOffer> offer;
//
//
//- (instancetype)initWithOffer:(id<FCBCampaignOffer>)offer;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
