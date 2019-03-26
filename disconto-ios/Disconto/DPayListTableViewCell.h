//
//  DPayListTableViewCell.h
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPayListTableViewCell : DMainTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *serviceMinimum;
@property (strong, nonatomic) IBOutlet UIImageView *serviceImageView;
@property (strong, nonatomic) IBOutlet UIView *subView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)updateWithPayType:(DPayType *)payType andIndexPath:(NSIndexPath *)indexPath;
@end
