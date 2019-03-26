//
//  DMessageCells.m
//  Disconto
//
//  Created by user on 15.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DMessageCells.h"

@implementation DMessageCells

- (void)awakeFromNib {
    
    self.subView.layer.cornerRadius = 3;
    self.pickerImageView.layer.cornerRadius = self.pickerImageView.bounds.size.width*0.5;
    // Initialization code
}

+ (NSArray *)cellsArrayWithMessageArray:(NSArray *)messages andTableView:(UITableView *)tableView{

    NSMutableArray *array = @[].mutableCopy;
    for (DMessageModel *obj in messages) {
        
        DMessageCells *cell = [DMessageCells getCellForTableView:tableView andClassCellString:NSStringFromClass([DMessageCells class])];
        [cell.messageLabel setText:obj.message];
        [cell.dayLabel setText:obj.day];
        
        if(obj.readit) {
            [cell.pickerImageView setAlpha:!obj.readit];
             cell.messageLabel.font = [UIFont fontWithName:@"Sansation-Light" size:12.0];
        }else {
            [cell.pickerImageView setAlpha:!obj.readit];
            cell.messageLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        }
        [array addObject:cell];
    }
    
    return array;
}

@end
