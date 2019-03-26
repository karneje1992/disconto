//
//  DShopPreview.m
//  Disconto
//
//  Created by user on 30.04.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DShopPreview.h"

@implementation DShopPreview

+ (DShopPreview *)getShopForDictionary:(NSDictionary *)dictionary{

    DShopPreview *object = [DShopPreview new];
    object.shopID = [dictionary[kID] integerValue];
    object.allShopCount = [dictionary[@"all_products"] integerValue];
    object.shopNewCount = [dictionary[@"new_products"] integerValue];
    object.shopPoints = [dictionary[@"points"] integerValue];
    object.shopIcon = [dictionary[@"img_url"] isEqual:[NSNull null]] ? [NSURL new] : [NSURL URLWithString:dictionary[@"img_url"]];
    object.shopName = dictionary[@"name"];
    return object;
}

+ (void)getAllShopsWithCallBack:(void (^)(NSArray *array))callBack{

    NSMutableArray *array = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"%@",apiStores] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            for (NSDictionary *list in resault[kServerData]) {
                [array addObject:[DShopPreview getShopForDictionary:list]];
            }
            callBack(array);
        }else{
            
            callBack(array);
        }
    }];
}

+ (void)shopsWithProduct:(DProductModel *)product withCallBack:(void (^)(NSArray *array))callBack{

    NSMutableArray *array = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{@"product_id":product ? @(product.productID) : @"",@"unlocked":@(YES)} andAPICall:[NSString stringWithFormat:@"%@",apiStores] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            for (NSDictionary *list in resault[kServerData]) {
                [array addObject:[DShopPreview getShopForDictionary:list]];
            }
            callBack(array);
        }else{
            
            callBack(array);
        }
    }];
}
@end
