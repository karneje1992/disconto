//
//  DMainTableViewCell.m
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DMainTableViewCell.h"

@implementation DMainTableViewCell

+ (id)getCellForTableView:(UITableView *)tableView andClassCellString:(NSString *)classCell{

    [tableView registerNib:[UINib nibWithNibName:classCell bundle:nil] forCellReuseIdentifier:classCell];
    return [tableView dequeueReusableCellWithIdentifier:classCell];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
