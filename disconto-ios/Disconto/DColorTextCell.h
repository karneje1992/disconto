//
//  DColorTextCell.h
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DColorTextCell : DMainTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

- (void)showProductName:(DProductModel *)product;
- (void)showProductPrice:(DProductModel *)product;
@end
