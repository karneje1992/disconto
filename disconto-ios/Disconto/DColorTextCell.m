//
//  DColorTextCell.m
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DColorTextCell.h"

@implementation DColorTextCell

- (void)showProductName:(DProductModel *)product{

    [self.colorLabel setText:product.productName];
}

- (void)showProductPrice:(DProductModel *)product{
    
    [self.colorLabel setText:[NSString stringWithFormat:@"%1.1f ₽\n",product.productPoint]];
}
@end
