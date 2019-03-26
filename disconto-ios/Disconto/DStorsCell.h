//
//  DStorsCell.h
//  Disconto
//
//  Created by Ross on 21.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DStorsCell : DMainTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

- (void)shopsProduct:(DProductModel *)product withIndexPath:(NSIndexPath *)indexPath;

@end
