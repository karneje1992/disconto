//
//  DImageTableViewCell.m
//  testCameOverlayr
//
//  Created by user on 31.08.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DImageTableViewCell.h"

@implementation DImageTableViewCell

+ (id)getCellForTableView:(UITableView *)tableView andClassCellString:(NSString *)classCell andIndexPath:(NSIndexPath *)indexPath{
    
    [tableView registerNib:[UINib nibWithNibName:classCell bundle:nil] forCellReuseIdentifier:classCell];
    return [tableView dequeueReusableCellWithIdentifier:classCell forIndexPath:indexPath];
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
