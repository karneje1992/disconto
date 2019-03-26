//
//  ForceCubeListViewModel.h
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/22/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DForceCubeSubClass.h"
#import "Coupon.h"
#import "DListTableViewCell.h"
#import "DOfferModel.h"

@protocol ForceCubeListViewModelDelegate <NSObject>

- (void)viewModel:(id)viewModel forForceCubeItemsArray:(NSArray<Coupon *> *)items;
- (void)viewModel:(id)viewModel forServertemsArray:(NSArray<Coupon *> *)items;

@end

@interface ForceCubeListViewModel : NSObject

@property id <ForceCubeListViewModelDelegate> delegate;

@property NSMutableArray<DListTableViewCell *> *cellsArray;
@property NSMutableArray<Coupon *> *couponsArray;
@property NSArray *sizes;
@property ForceCuBe *forceCube;

- (void)updateController:(UIViewController *)controller;
- (void)updateCellsWithTableView:(UITableView *)tableView;
- (void)getServerItems;
- (instancetype)initWithOffers:(NSArray<DOfferModel *> *)models;

+ (instancetype)setupViewComponets;
@end
