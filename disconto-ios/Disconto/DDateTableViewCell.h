//
//  DDateTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDateTableViewCellPresenterProtocol.h"


@interface DDateTableViewCell : DMainTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateTitle;
@property (strong, nonatomic) IBOutlet UITextField *dayTextField;
@property (strong, nonatomic) IBOutlet UITextField *monthTextField;
@property (strong, nonatomic) IBOutlet UITextField *yearTextField;

@property id<DDateTableViewCellPresenterProtocol> presenter;
@end
