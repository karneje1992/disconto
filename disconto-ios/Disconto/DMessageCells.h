//
//  DMessageCells.h
//  Disconto
//
//  Created by user on 15.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMessageCells : DMainTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIImageView *pickerImageView;

+ (NSArray *)cellsArrayWithMessageArray:(NSArray *)messages andTableView:(UITableView *)tableView;
@end
