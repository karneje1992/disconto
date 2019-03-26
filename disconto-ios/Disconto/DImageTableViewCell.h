//
//  DImageTableViewCell.h
//  testCameOverlayr
//
//  Created by user on 31.08.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMainTableViewCell.h"

@interface DImageTableViewCell : DMainTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
+ (id)getCellForTableView:(UITableView *)tableView andClassCellString:(NSString *)classCell andIndexPath:(NSIndexPath *)indexPath;
@end
