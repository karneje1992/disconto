//
//  DListTableViewCell.m
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/22/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DListTableViewCell.h"

@implementation DListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.stickerLabel.layer.masksToBounds = NO;
    self.stickerLabel.layer.shadowOffset = CGSizeMake(0, 5);
    self.stickerLabel.layer.shadowRadius = 5;
    self.stickerLabel.layer.shadowOpacity = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
