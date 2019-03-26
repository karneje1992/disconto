//
//  DCityModel.m
//  Disconto
//
//  Created by user on 29.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DShopModel.h"

@implementation DShopModel

- (instancetype)initWithResponsDictionary:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        
        self.shopID = [response[kID] intValue];
        self.createShopStringTime = response[@"created_at"];
        self.updateShopStringTime = response[@"updated_at"];
        self.deleteShopStringTime = response[@"deleted_at"];
        self.shopImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",response[@"img_url"]]];
        self.shopMapIcomURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",response[@"map_icon"]]];
        self.shopName = response[@"name"];
        self.infoForShop = response[@"description"];
    }
    return self;
}

@end