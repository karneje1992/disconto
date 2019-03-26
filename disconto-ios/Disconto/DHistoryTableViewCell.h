//
//  DHistoryTableViewCell.h
//  Disconto
//
//  Created by Ross on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHistoryTableViewCell : DMainTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chakNumber;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@end
