//
//  DPhoneTableViewCell.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPhoneTableViewCell.h"

@implementation DPhoneTableViewCell

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
