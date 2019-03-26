//
//  SharesViewModel.m
//  Disconto
//
//  Created by Rostislav on 12/28/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "SharesViewModel.h"
#import "DListTableViewCell.h"


@interface SharesViewModel()

@property UIViewController *activeController;

@end

@implementation SharesViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellsArray = @[].mutableCopy;
        self.objectsArray = @[].mutableCopy;
        
        [self getDataFromServer];
    }
    return self;
}


- (void)getDataFromServer{

    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:apiGetPromos withCallBack:^(BOOL success, NSDictionary *resault) {
        if (success) {
            [resault[kServerData] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.objectsArray addObject:[[ShareModel alloc] initWithDictionary:obj]];
            }];
            [self.delegate viewModel:self arrayFromServer:self.objectsArray];
        }
    }];
}

- (void)updateTableView:(UITableView *)tableView{

    self.cellsArray = @[].mutableCopy;
    
    [self.objectsArray enumerateObjectsUsingBlock:^(ShareModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        DListTableViewCell *cell = [DListTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DListTableViewCell class])];
        [cell.iconView setImage:[UIImage imageWithData:obj.imgData]];
        [cell.titleLabel setText:obj.title];
        [cell.descripLabel setText:obj.fullDescription];
        [cell.dateLabel setText:obj.dateText];
        [self showStickerForCoupon:obj stickerLabel:cell.stickerLabel];
        [self.cellsArray addObject:cell];
    }];
    [tableView reloadData];
}

- (void)showStickerForCoupon:(ShareModel *)coupon stickerLabel:(UILabel *)label {
    
    if ([[NSDate date] timeIntervalSinceDate:coupon.dateFrom] / (3600*24) > 5) {
        label.alpha = 0;
    }else{
        
        label.alpha = 1;
        label.transform = CGAffineTransformMakeRotation(-M_PI/4);
    }
    NSLog(@"%f",[[NSDate date] timeIntervalSinceDate:coupon.dateFrom]);
    
}
@end
