//
//  DOfferViewModel.m
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DOfferViewModel.h"
#import "DListTableViewCell.h"

@interface DOfferViewModel ()



@end

@implementation DOfferViewModel

+ (instancetype)showOffers:(NSArray<DOfferModel *> *)offers{
    
    return [[DOfferViewModel alloc] initWithOffersArray:offers];
}

- (instancetype)initWithOffersArray:(NSArray<DOfferModel *> *)offersArray
{
    self = [super init];
    if (self) {
        self.offersArray = @[].mutableCopy;
        self.cellsArray = @[].mutableCopy;
        self.offersArray = offersArray.mutableCopy;        
    }
    return self;
}

- (void)updateViewController:(DOfferViewController *)viewController{
    
    UITableView *tableView = [self getTableViewFromController:viewController];
    [self updateCellsWithTableView:tableView];
    [tableView reloadData];
    
    if (!_cellsArray.count) {
        NSString *msg = [NSString stringWithFormat:@"%@ не доступны",viewController.parentTitle];
        SHOW_MESSAGE(msg, nil);
    }
}

- (void)updateCellsWithTableView:(UITableView *)tableView{
    
    [self.offersArray enumerateObjectsUsingBlock:^(DOfferModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        DListTableViewCell *cell = [DListTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DListTableViewCell class])];
        [cell.iconView sd_setImageWithURL:obj.imgURL];
        [cell.titleLabel setText:obj.name];
        [cell.descripLabel setText:obj.offerDescript];
        [cell.dateLabel setText:obj.dateText];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self showStickerForCoupon:obj stickerLabel:cell.stickerLabel];
        [cell.stikerImageView setAlpha:cell.stickerLabel.alpha];
//        if (obj.FCModel) {
//           // cell.iconView.contentMode = UIViewContentModeScaleAspectFill;
//        }
        [self.cellsArray addObject:cell];
        
        // [cell.titleLabel setText:obj]
    }];
    
}
- (void)showStickerForCoupon:(DOfferModel *)coupon stickerLabel:(UILabel *)label {
    
//    if (coupon.FCModel) {
//        if ([[NSDate date] timeIntervalSinceDate:coupon.dateFrom] / (3600*24) > 5) {
//            label.alpha = 0;
//        }else{
//            
//            label.alpha = 1;
//            label.transform = CGAffineTransformMakeRotation(-M_PI/4);
//        }
//    }else{
        if (!coupon.unloced){
            
            label.alpha = 0;
        }else{
            
            label.alpha = 1;
            label.transform = CGAffineTransformMakeRotation(-M_PI/4);
        }
//    }
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
