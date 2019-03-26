//
//  DProductsViewController.h
//  Disconto
//
//  Created by user on 17.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"



@interface DProductsViewController : DSuperViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property NSString *alertText;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property DCategoryModel *category;
@property (strong, nonatomic) IBOutlet UIButton *photoButton;

+ (instancetype)showProductsWithCategory:(DCategoryModel *)category;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andCategory:(DCategoryModel *)category;
+ (instancetype)showProductsWithShopID:(NSInteger)shopID andTitle:(NSString *)title;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andShopID:(NSInteger)shopID andTitle:(NSString *)title;
+ (instancetype)showProductsWithProductsArray:(NSArray *)productsArray;

//- (IBAction)showRightMenu:(id)sender;
@end
