//
//  DSingleOfferViewModel.m
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DSingleOfferViewModel.h"
#import "DCouponHeaderCell.h"


@implementation DSingleOfferViewModel

+ (instancetype)showSingleOffer:(DOfferModel *)offer{
    
    return [[DSingleOfferViewModel alloc] initWithOffer:offer];
}
- (instancetype)initWithOffer:(DOfferModel *)offer
{
    self = [super init];
    if (self) {
        
        self.offer = offer;
        self.cellsArray = @[].mutableCopy;
//        if (self.offer.FCModel) {
//            [[[DForceCubeSubClass activeForceCube] campaignManager] setCampaignOfferAsAccepted:[self.offer.FCModel campaignOfferId]];
//        }
        
    }
    return self;
}

- (void)updateViewController:(UIViewController *)controller{
    
    UITableView *tableView = [self getTableViewFromController:controller];
    [self updateCellsWithTableView:tableView];
    controller.title = _offer.name;
    [self updateButtonFromController:controller];
    
    [tableView reloadData];
}

- (void)updateCellsWithTableView:(UITableView *)tableView{
    
    DCouponHeaderCell *header = [DCouponHeaderCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DCouponHeaderCell class])];
    if (self.offer.imgURL) {
        
        [header.imgView sd_setImageWithURL:self.offer.imgURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (!error) {
                
                _headerSize = tableView.bounds.size.width / image.size.width * image.size.height;
                [tableView reloadData];
            }
        }];
    }
    
    [self.cellsArray addObject:header];
    if (self.offer.dateText.length) {
        DColorTextCell *titleCell = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];
        [titleCell.colorLabel setText:@"Период действия:"];
        [titleCell.colorLabel setTextAlignment:NSTextAlignmentLeft];
        
        DDescriptionCell *descrCell1 = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];
        [descrCell1.descriptionLabel setText:self.offer.dateText];
        [descrCell1.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self.cellsArray addObjectsFromArray:@[titleCell,descrCell1]];
    }
    
    if (self.offer.offerDescript.length) {
        
        DColorTextCell *deteil = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];
        [deteil.colorLabel setText:@"Описание:"];
        [deteil.colorLabel setTextAlignment:NSTextAlignmentLeft];
        
        DDescriptionCell *descrCell2 = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];
        [descrCell2.descriptionLabel setText:[NSString stringWithFormat:@"%@",self.offer.offerDescript]];
        [descrCell2.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
        [self.cellsArray addObjectsFromArray:@[deteil,descrCell2]];
    }
    
    if (self.offer.offerDescription.length) {
        DColorTextCell *deteilFull = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];
        [deteilFull.colorLabel setText:@"Полное описание:"];
        [deteilFull.colorLabel setTextAlignment:NSTextAlignmentLeft];
        
        DDescriptionCell *descrCellFull2 = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];
        [descrCellFull2.descriptionLabel setText:[NSString stringWithFormat:@"%@",self.offer.offerDescription]];
        [descrCellFull2.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
        [self.cellsArray addObjectsFromArray:@[deteilFull,descrCellFull2]];
    }
    
    
    if (_offer.legal.length) {
        
        DColorTextCell *legal = [DColorTextCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DColorTextCell class])];
        [legal.colorLabel setText:@"Дополнительно:"];
        [legal.colorLabel setTextAlignment:NSTextAlignmentLeft];
        
        DDescriptionCell *descrCell3 = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];
        [descrCell3.descriptionLabel setText:self.offer.legal];
        [descrCell3.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
        [self.cellsArray addObject:legal];
        [self.cellsArray addObject:descrCell3];
    }
    
    [self showStickerForCoupon:self.offer stickerLabel:header.stickerLabel imageView:header.stikerImageView];
}

- (void)showStickerForCoupon:(DOfferModel *)coupon stickerLabel:(UILabel *)label imageView:(UIImageView *)imageView{
    
//    if (coupon.FCModel) {
//        if ([[NSDate date] timeIntervalSinceDate:coupon.dateFrom] / (3600*24) > 5) {
//            label.alpha = 0;
//            imageView.alpha = 0;
//        }
//        else{
//            
//            label.alpha = 1;
//            label.transform = CGAffineTransformMakeRotation(-M_PI/4);
//            imageView.alpha = 1;
//        }
//    }else{

        label.alpha = 0;
        imageView.alpha = 0;
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

- (void)updateButtonFromController:(UIViewController *)controller{
    
    __block UIButton *button;
    [controller.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            button = obj;
            button.layer.cornerRadius = 3;
            [button setTitle:_offer.offerValue  ? @"Использовать купон" : @"Участвовать" forState:UIControlStateNormal];
            
        }
    }];
}

@end
