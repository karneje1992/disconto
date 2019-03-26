//
//  DShopPreview.h
//  Disconto
//
//  Created by user on 30.04.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DShopPreview : NSObject

@property NSInteger shopID;
@property NSInteger allShopCount;
@property NSURL *shopIcon;
@property NSInteger shopNewCount;
@property NSInteger shopPoints;
@property NSString *shopName;

+ (DShopPreview *)getShopForDictionary:(NSDictionary *)dictionary;
+ (void)shopsWithProduct:(DProductModel *)product withCallBack:(void (^)(NSArray *array))callBack;
+ (void)getAllShopsWithCallBack:(void (^)(NSArray *array))callBack;
@end
