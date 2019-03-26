//
//  MVVMDProductsViewController.h
//  Disconto
//
//  Created by Rostislav on 1/16/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DProductsVM.h"
#import "BannerCollectionReusableView.h"

@protocol MVVMDProductsViewControllerDelegate <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface MVVMDProductsViewController : DSuperViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property id<MVVMDProductsViewControllerDelegate> delegate;

+ (instancetype)showProductsWithViewModel:(id)viewModel;

@end
