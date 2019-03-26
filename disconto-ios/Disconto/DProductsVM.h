//
//  DProductsVM.h
//  Disconto
//
//  Created by Rostislav on 1/16/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DProductsVM : NSObject

@property NSMutableArray *cellsArray;
@property NSMutableArray<DProductModel *> *modelsArray;
@property DCategoryModel *categoryModel;
@property DShopModel *shopModel;

+ (instancetype)showProductsOfCategory:(DCategoryModel *)category;
+ (instancetype)showProductsOfShop:(DShopModel *)shop;
+ (instancetype)showProductsOfHisory:(DHistoryModel *)historyModel;

- (instancetype)initWithCategory:(DCategoryModel *)category;
- (instancetype)initWithShop:(DShopModel *)shop;
- (void)updateController:(UIViewController *)controller;
- (void)getModelsWithSkip:(NSInteger)skip;
@end
