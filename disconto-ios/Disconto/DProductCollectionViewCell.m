//
//  DProductCollectionViewCell.m
//  Disconto
//
//  Created by user on 17.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DProductCollectionViewCell.h"

@implementation DProductCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = NO;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeZero;
//    self.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0f;
    self.statusImage.layer.masksToBounds = YES;
    self.counterLabel.layer.masksToBounds = YES;
    self.statusImage.layer.cornerRadius = self.statusImage.bounds.size.width*0.5;
    self.counterLabel.layer.cornerRadius = self.counterLabel.bounds.size.width*0.5;
}

@end
