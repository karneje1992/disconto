//
//  DShopCellTableViewCell.h
//  Disconto
//
//  Created by user on 30.04.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DShopCellTableViewCell : DMainTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *allDiscontLabel;
@property (weak, nonatomic) IBOutlet UILabel *discontNewLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@end
