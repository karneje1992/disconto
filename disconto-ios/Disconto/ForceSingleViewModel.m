//
//  ForceSingleViewModel.m
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/23/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "ForceSingleViewModel.h"
#import "DListTableViewCell.h"
#import "DMapViewController.h"

@interface ForceSingleViewModel ()


@property UIViewController *activeController;

@end

@implementation ForceSingleViewModel

+ (instancetype)singleForceCubeForCoub:(Coupon *)coupon{

    return [[ForceSingleViewModel alloc] initWithCoupon:coupon];
}

- (instancetype)initWithCoupon:(Coupon *)coupon
{
    self = [super init];
    if (self) {
        
        self.cellsArray = @[];
        self.object = coupon;
    }
    return self;
}

- (void)updateCintroller:(UIViewController *)updateController{

    UITableView *tableView = [self getTableViewFromController:updateController];
    [self createCellsFromTableView:tableView];
    [self setupMapButtonToController:updateController];
    self.activeController = updateController;
   // updateController.title = [_object.offer fullscreenTitle];
}

- (UITableView *)getTableViewFromController:(UIViewController *)controller{
    
    __block UITableView *tableView;
    [controller.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UITableView class]]) {
            tableView = obj;
        }else if([obj isKindOfClass:[UIButton class]]){
        
            obj.layer.cornerRadius = 3;
        }
    }];
    return tableView;
}

- (void)setupMapButtonToController:(UIViewController *)controller{

 //   UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation"] style:UIBarButtonItemStylePlain target:self action:@selector(showMap)];
//                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
//                                  target:self action:@selector(showMap)];
  // [controller.navigationItem setRightBarButtonItem:mapButton];
}

- (void)showMap{
    
    
}

- (void)createCellsFromTableView:(UITableView *)tableView{

    DCouponHeaderCell *header = [DCouponHeaderCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DCouponHeaderCell class])];
    if (self.object.imgData) {

        [header.imgView setImage:[UIImage imageWithData:self.object.imgData]];
    }

    DColorTextCell *titleCell = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];
    [titleCell.colorLabel setText:self.object.title];
    
    DColorTextCell *dateCell = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];

    [dateCell.colorLabel setText:self.object.dateText];
    DColorTextCell *descrCell = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];
    [descrCell.colorLabel setText:@"Детали"];
    
    
    DDescriptionCell *descrCell2 = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];
    [descrCell2.descriptionLabel setText:_object.fullDescription];
    [descrCell2.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.cellsArray = @[header,titleCell,dateCell,descrCell,descrCell2];
    UIImage *img = [UIImage imageWithData:self.object.imgData];
    self.headerSize = tableView.bounds.size.width/img.size.width * img.size.height;
    [self showStickerForCoupon:self.object stickerLabel:header.stickerLabel];
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
@end
