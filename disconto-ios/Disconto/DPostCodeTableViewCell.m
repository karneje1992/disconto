//
//  DPostCodeTableViewCell.m
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPostCodeTableViewCell.h"

@implementation DPostCodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.prersenter) {
        
        [self.prersenter updateUI];
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
