//
//  DBanerModel.h
//  Disconto
//
//  Created by user on 17.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCategoryViewModel.h"
#import "DSingleProductController.h"
#import "DOfferViewModel.h"
#import "DSingleOfferViewController.h"
#import "DSingleOfferViewModel.h"

@interface DBanerModel : NSObject

@property NSString *banerID;
@property NSURL *banerImageUrl;
@property NSString *productID;
@property NSString *promoID;
@property NSString *categoryID;
@property NSString *shopID;
@property CGFloat banerX;
@property NSInteger step;
@property NSString *type;
@property NSString *url;

+ (void)getBanersWithCallBack:(void (^)(NSArray *resault))callBackk;
+ (void)getNewBanersWithCallBack:(void (^)(NSArray *resault))callBack;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary withStep:(NSInteger)step;
- (void)selectWithType:(DCategoryViewModel *)viewModel controller:(UIViewController *)controller;
@end
