//
//  DCategoryTableViewCell.h
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMainCollectionViewCell.h"

@interface DCategoryTableViewCell : DMainTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *allDiscontoLabel;
@property (weak, nonatomic) IBOutlet UILabel *countNewLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@end
