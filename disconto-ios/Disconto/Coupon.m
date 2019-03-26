//
//  Coupon.m
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/22/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "Coupon.h"


@implementation Coupon

//- (instancetype)initWithOffer:(id<FCBCampaignOffer>)offer
//{
//    self = [super init];
//    if (self) {
//        
//        self.couponID = [NSString stringWithFormat:@"%@",@(offer.campaignOfferId)];
//        self.title = offer.fullscreenTitle;
//        self.fullDescription = offer.fullscreenText;
//        self.imgData = [NSData dataWithContentsOfURL:offer.imageUrl];
//        self.dateTo = offer.avaliableTo;
//        self.dateFrom = offer.avaliableFrom;
//        self.offer = offer;
//        NSString *to = [NSDateFormatter localizedStringFromDate:self.dateTo
//                                                      dateStyle:NSDateFormatterShortStyle
//                                                      timeStyle:NSDateFormatterNoStyle];
//        NSString *text = [NSString stringWithFormat:@"%@ ",to];
//        self.dateText = [NSString stringWithFormat:@"Конец акции: %@",text];
//    }
//    return self;
//}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.couponID = dictionary[@"id"];
        self.title = dictionary[@"name"];
        self.fullDescription = dictionary[@"description"];
        self.imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dictionary[@"img_url"]]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        [dateFormatter setLocale:usLocale];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.dateFrom = [dateFormatter dateFromString:dictionary[@"starts_at"]];
        self.dateTo = [dateFormatter dateFromString:dictionary[@"expires_at"]];
        NSString *to = [NSDateFormatter localizedStringFromDate:self.dateTo
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterNoStyle];
        NSString *text = [NSString stringWithFormat:@"%@ ",to];
        self.dateText = [NSString stringWithFormat:@"Конец акции: %@",text];
    }
    return self;
}
@end
