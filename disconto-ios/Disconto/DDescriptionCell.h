//
//  DDescriptionCell.h
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDescriptionCell : DMainTableViewCell

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *descriptionLabel;
@property DProductModel *product;

- (void)showSmallDescriptionFromProduct:(DProductModel *)product;
- (void)showFullDescriptionFromProduct:(DProductModel *)product;
- (void)showLegal:(DProductModel *)product;
@end
