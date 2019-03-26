//
//  DMoneyTableViewCell.m
//  Disconto
//
//  Created by Rostislav on 7/7/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DMoneyTableViewCell.h"

@implementation DMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.presenter) {
        [self.presenter updateUI];
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
