//
//  DPayListTableViewCell.m
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DPayListTableViewCell.h"

@implementation DPayListTableViewCell

- (void)updateWithPayType:(DPayType *)payType andIndexPath:(NSIndexPath *)indexPath{

    [self.serviceMinimum setText:[NSString stringWithFormat:@"%@ рублей минимум",@(payType.payMin)]];
    [self.serviceImageView sd_setImageWithURL:[NSURL URLWithString:payType.iconUrl]];
    [self.subView.layer setCornerRadius:8];
    [self.titleLabel setText:payType.title];
}

@end
