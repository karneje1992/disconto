//
//  DDateTableViewCell.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DDateTableViewCell.h"

@implementation DDateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    if (self.presenter) {
        [self.presenter updateUI];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
