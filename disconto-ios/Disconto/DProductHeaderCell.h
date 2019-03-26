//
//  DProductHeaderCell.h
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DProductHeaderCell : DMainTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *unlocedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property DProductModel *product;

+ (DProductHeaderCell *)getHeaderWithProduct:(DProductModel *)product andTableView:(UITableView *)tableView;
- (void)updateCell;
@end
