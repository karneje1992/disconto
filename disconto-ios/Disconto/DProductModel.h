//
//  DQuestModel.h
//  Disconto
//
//  Created by user on 24.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DShopModel.h"
#import "DSelectProductCell.h"

@interface DProductModel : NSObject

@property NSURL *productImageURL;
@property NSString *descriptionProduct;
@property NSString *productName;
@property CGFloat productPoint;
@property NSInteger productCategory;
@property NSInteger productID;
@property NSInteger totalFavorites;
@property NSString *legalDescription;
@property NSInteger unlocedCount;
@property NSString *fullDescription;
@property NSString *expiresAt;
@property BOOL favorite;
@property BOOL infinity;
@property NSInteger status;
@property NSMutableArray *stores;
@property NSMutableArray *quests;
@property NSString *expires;
@property NSInteger sectedCount;
@property NSInteger sectionCount;
@property NSInteger step;

- (instancetype)initWithResponse:(NSDictionary *)response;
- (instancetype)initWithShortResponse:(NSDictionary *)shortResponse;

+ (void)getAllProductsWithCollectionView:(UICollectionView *)colectionView skip:(NSInteger)skip category:(DCategoryModel *)category andCallBack:(void (^)(NSArray *array))callBack;
- (DProductCollectionViewCell *)getCellsWithCollectionView:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath andProduct:(DProductModel *)product;
- (DSelectProductCell *)getCelllWithProduct:(DProductModel *)product tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (void)updateProduct:(DProductModel *)product withCollBack:(void (^)(DProductModel *obj))callBack;
+ (void)getUnloceadProductsWithProduct:(DProductModel *)product andShop:(DShopModel *)shop withCollBack:(void (^)(DProductModel *obj))callBack;
+ (void)getFavoriteProductsWithCallBack:(void (^)(NSArray<DProductModel *> *array))callBack;
+ (void)getAllProductsWithCollectionView:(UICollectionView *)colectionView skip:(NSInteger)skip shopID:(NSInteger)shopID andCallBack:(void (^)(NSArray *))callBack;
- (void)getUnlocedProductsWithShop:(DShopModel *)shop callBack:(void (^)(NSArray<DProductModel *> *array))callBack;
+ (void)getNewAllProductsWithCollectionView:(UICollectionView *)colectionView skip:(NSInteger)skip category:(DCategoryModel *)category andCallBack:(void (^)(NSArray *array))callBack;
@end
