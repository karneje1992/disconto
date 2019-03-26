//
//  DCityModel.h
//  Disconto
//
//  Created by user on 29.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DShopModel : NSObject

@property NSString *createShopStringTime;
@property NSString *deleteShopStringTime;
@property NSString *infoForShop;
@property NSInteger shopID;
@property NSURL *shopImageURL;
@property NSURL *shopMapIcomURL;
@property NSString *shopName;
@property NSString *updateShopStringTime;

- (instancetype)initWithResponsDictionary:(NSDictionary *)response;
@end
