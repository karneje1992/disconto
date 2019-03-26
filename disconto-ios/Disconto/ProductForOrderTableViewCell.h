//
//  ProductForOrderTableViewCell.h
//  Disconto
//
//  Created by Rostyslav Didenko on 3/20/19.
//  Copyright © 2019 Disconto. All rights reserved.
//

#import "DMainTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductForOrderTableViewCell : DMainTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

NS_ASSUME_NONNULL_END
