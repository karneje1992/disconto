//
//  DCategoryViewModel.h
//  Disconto
//
//  Created by Rostislav on 12/26/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIGestureRecognizer.h>

@protocol DCategoryViewModelDelegate <NSObject>

- (void)categoryDidFinihLoading:(id)viewModel;
- (void)bannerDidFinishLoading:(id)viewModel;

@end

@interface DCategoryViewModel : NSObject <MXBannerViewDelegate>

@property NSArray *cellsArray;
@property NSArray<DCategoryModel *> *categoryArray;
@property id <DCategoryViewModelDelegate> delegate;
@property UIView *bannerView;

- (void)updateController:(UIViewController *)controller;
@end
