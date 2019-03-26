//
//  ShareModel.h
//  Disconto
//
//  Created by Rostislav on 12/28/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject

@property NSString *shareID;
@property NSData *imgData;
@property NSDate *dateTo;
@property NSDate *dateFrom;
@property NSString *title;
@property NSString *fullDescription;
@property NSString *dateText;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
