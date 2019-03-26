//
//  DCouponHeaderCell.m
//  Disconto
//
//  Created by Rostislav on 12/27/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DCouponHeaderCell.h"

@implementation DCouponHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.stickerLabel.layer.masksToBounds = NO;
    self.stickerLabel.layer.shadowOffset = CGSizeMake(0, 5);
    self.stickerLabel.layer.shadowRadius = 5;
    self.stickerLabel.layer.shadowOpacity = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
