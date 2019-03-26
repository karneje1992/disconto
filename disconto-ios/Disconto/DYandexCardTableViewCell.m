//
//  DYandexCardTableViewCell.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DYandexCardTableViewCell.h"

@implementation DYandexCardTableViewCell

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
