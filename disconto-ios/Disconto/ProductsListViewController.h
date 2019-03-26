//
//  ProductsListViewController.h
//  Disconto
//
//  Created by Rostyslav Didenko on 3/19/19.
//  Copyright © 2019 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductsListViewController : UIViewController

+ (instancetype)showOrderProducts:(NSArray<DProductModel *> *)products;
@end

NS_ASSUME_NONNULL_END
