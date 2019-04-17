//
//  DProductsVM.m
//  Disconto
//
//  Created by Rostislav on 1/16/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DProductsVM.h"

@interface DProductsVM ()

@property UICollectionView *collectionView;

@property NSString *title;
@end

@implementation DProductsVM

- (instancetype)initWithCategory:(DCategoryModel *)category
{
    self = [super init];
    if (self) {
        _cellsArray = @[].mutableCopy;
        _modelsArray = @[].mutableCopy;
        _categoryModel = category;
        _title = category.categoryName;
        
    }
    return self;
}

- (instancetype)initWithShop:(DShopModel *)shop
{
    self = [super init];
    if (self) {
        _cellsArray = @[].mutableCopy;
        _modelsArray = @[].mutableCopy;
        _shopModel = shop;
        _title = shop.shopName;

    }
    return self;
}

- (instancetype)initWithHistory:(DHistoryModel *)historyModel
{
    self = [super init];
    if (self) {
        _cellsArray = @[].mutableCopy;
        _modelsArray = historyModel.products.mutableCopy;
        
    }
    return self;
}

+ (instancetype)showProductsOfCategory:(DCategoryModel *)category{

    return [[DProductsVM alloc] initWithCategory:category];
}

+ (instancetype)showProductsOfShop:(DShopModel *)shop{

    return [[DProductsVM alloc] initWithShop:shop];
}

+ (instancetype)showProductsOfHisory:(DHistoryModel *)historyModel{
    
    return [[DProductsVM alloc] initWithHistory:historyModel];
}

- (void)updateController:(UIViewController *)controller{

    [controller.navigationItem setTitle:_title];
    _collectionView = [self collectionViewFormController:controller];
    [self getModelsWithSkip:10];
    [_collectionView reloadData];
    
}

- (void)cellsGenerateWithCollectionView:(UICollectionView *)collectionView{

}

- (UICollectionView *)collectionViewFormController:(UIViewController *)controller{

   __block UICollectionView *collectinView = nil;
    [controller.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[UICollectionView class]]) {
            collectinView = (id)obj;
        }
    }];
    
    return collectinView;
}

- (void)getModelsWithSkip:(NSInteger)skip{

    [DProductModel getNewAllProductsWithCollectionView:nil skip:0 category:_categoryModel andCallBack:^(NSArray *array) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //tell the main UI thread here
            _modelsArray = array.mutableCopy;
            [_collectionView reloadData];
        });

    }];
}

@end
