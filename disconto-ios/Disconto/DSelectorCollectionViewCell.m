//
//  DSelectorCollectionViewCell.m
//  Disconto
//
//  Created by user on 22.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSelectorCollectionViewCell.h"

@implementation DSelectorCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [_stepper setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    [_stepper setTransform:CGAffineTransformScale(_stepper.transform, 0.6, 0.6)];
}

@end
