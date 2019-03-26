//
//  DSelectProductCell.h
//  Disconto
//
//  Created by user on 23.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSelectProductCellDelegate <NSObject>

- (void)selectPlusInCell:(id)cell andProduct:(id)product;
- (void)selectMinusInCell:(id)cell andProduct:(id)product;

@end

@interface DSelectProductCell : DMainTableViewCell

@property id <DSelectProductCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *unlocedCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property (weak, nonatomic) IBOutlet UIStepper *stepperProduct;
@property (strong, nonatomic) IBOutlet UILabel *productLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property id product;

@end
