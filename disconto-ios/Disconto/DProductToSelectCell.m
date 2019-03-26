//
//  DProductToSelectCell.m
//  Disconto
//
//  Created by user on 22.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DProductToSelectCell.h"

@implementation DProductToSelectCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [_stepper setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    [_stepper setTransform:CGAffineTransformScale(_stepper.transform, 0.6, 0.6)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
