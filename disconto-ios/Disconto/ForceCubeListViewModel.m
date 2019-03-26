//
//  ForceCubeListViewModel.m
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/22/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "ForceCubeListViewModel.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "AppDelegate.h"


@interface ForceCubeListViewModel() <CBCentralManagerDelegate, UIAlertViewDelegate>

@property NSMutableArray *serverItems;
@property NSMutableArray *forsecubeItems;
@property CLLocationManager * locationManager;
@property UIViewController * activeController;
@property CBCentralManager *bluetoothManager;
@end


@implementation ForceCubeListViewModel

+ (instancetype)setupViewComponets{
    
    return [[ForceCubeListViewModel alloc] init];
}

- (instancetype)initWithOffers:(NSArray<DOfferModel *> *)models
{
    self = [super init];
    if (self) {
        
        self.sizes = @[];
        self.cellsArray = @[].mutableCopy;
        self.serverItems = @[].mutableCopy;
        //        self.forceCube = [DForceCubeSubClass activeForceCube];
        //        self.forceCube.delegate = self;
        //        self.forceCube.campaignManager.delegate = self;
        
        self.locationManager = [CLLocationManager new];
        
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways)
        {
            [self.locationManager requestAlwaysAuthorization];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //   [self.forceCube start];
            
        });
        
        [models enumerateObjectsUsingBlock:^(DOfferModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self.serverItems addObject:[self convertToCoupon:obj]];
        }];
        
        [self.delegate viewModel:self forServertemsArray:self.serverItems];
        [self getForceCubeItems];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        self.sizes = @[];
        self.cellsArray = @[].mutableCopy;
//        self.forceCube = [DForceCubeSubClass activeForceCube];
//        self.forceCube.delegate = self;
//        self.forceCube.campaignManager.delegate = self;
        
        self.locationManager = [CLLocationManager new];
        
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways)
        {
            [self.locationManager requestAlwaysAuthorization];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
         //   [self.forceCube start];
            
        });
        
        
        [self getForceCubeItems];
        [self getServerItems];
    }
    return self;
}

- (void)getForceCubeItems{
    
    self.forsecubeItems = @[].mutableCopy;
    [self.delegate viewModel:self forForceCubeItemsArray:self.forsecubeItems];
    
}

- (void)getServerItems{
    
    self.serverItems = @[].mutableCopy;
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:@"/coupons" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            [resault[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.serverItems addObject:[[Coupon alloc] initWithDictionary:obj]];
            }];
        }
        
        [self.delegate viewModel:self forServertemsArray:self.serverItems];
    }];
}

- (void)updateController:(UIViewController *)controller{
    
    self.cellsArray = @[].mutableCopy;
    self.couponsArray = @[].mutableCopy;
    [self.couponsArray addObjectsFromArray:self.serverItems];
    [self.couponsArray addObjectsFromArray:self.forsecubeItems];
    UITableView *tableView = [self getTableViewFromController:controller];
    self.activeController = controller;
    [self updateCellsWithTableView:tableView];
    [tableView reloadData];
}

- (void)updateCellsWithTableView:(UITableView *)tableView{
    
    [self.couponsArray enumerateObjectsUsingBlock:^(Coupon * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        DListTableViewCell *cell = [DListTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DListTableViewCell class])];
        [cell.iconView setImage:[UIImage imageWithData:obj.imgData]];
        [cell.titleLabel setText:obj.title];
     //   [cell.descripLabel setText:obj.fullDescription];
        [cell.dateLabel setText:obj.dateText];
        [self showStickerForCoupon:obj stickerLabel:cell.stickerLabel];
        [self.cellsArray addObject:cell];

        // [cell.titleLabel setText:obj]
    }];
    
}

- (Coupon *)convertToCoupon:(DOfferModel *)offerModel{

    Coupon *model = [Coupon new];
    model.couponID = offerModel.offerID;
    model.fullDescription = offerModel.offerDescription;
    model.dateTo = offerModel.dateTo;
    model.dateFrom = offerModel.dateFrom;
    model.dateText = offerModel.dateText;
    model.imgData = [NSData dataWithContentsOfURL:offerModel.imgURL];
    model.title = offerModel.name;
    return model;
}

- (void)showStickerForCoupon:(Coupon *)coupon stickerLabel:(UILabel *)label {
    
    if ([[NSDate date] timeIntervalSinceDate:coupon.dateFrom] / (3600*24) > 5) {
        label.alpha = 0;
    }else{
        
        label.alpha = 1;
        label.transform = CGAffineTransformMakeRotation(-M_PI/4);
    }
    NSLog(@"%f",[[NSDate date] timeIntervalSinceDate:coupon.dateFrom]);
    
}

- (UITableView *)getTableViewFromController:(UIViewController *)controller{
    
    __block UITableView *tableView;
    [controller.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UITableView class]]) {
            tableView = obj;
        }
    }];
    return tableView;
}

@end
