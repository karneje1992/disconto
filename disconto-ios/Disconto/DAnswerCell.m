//
//  DAnswerCell.m
//  Disconto
//
//  Created by user on 24.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DAnswerCell.h"

@interface DAnswerCell ()


@end

@implementation DAnswerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
     // Configure the view for the selected state
}
- (IBAction)chack:(id)sender {
    
    
    [self.delegate isChakingCell:self chack:!self.isChak];

}

- (void)setIsChak:(BOOL)isChak{

        isChak ? [self.chackButton setImage:[UIImage imageNamed:@"check-mark"] forState:UIControlStateNormal] : [self.chackButton setImage:[UIImage imageNamed:@"check-mark_uns"] forState:UIControlStateNormal];
}

@end
