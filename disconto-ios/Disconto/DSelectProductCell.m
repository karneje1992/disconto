//
//  DSelectProductCell.m
//  Disconto
//
//  Created by user on 23.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSelectProductCell.h"

@implementation DSelectProductCell

- (void)awakeFromNib{

        
}

- (IBAction)plus:(id)sender {
    
    [self.delegate selectPlusInCell:self andProduct:self.product];
}

- (IBAction)minus:(id)sender {
    
    [self.delegate selectMinusInCell:self andProduct:self.product];
}
@end
