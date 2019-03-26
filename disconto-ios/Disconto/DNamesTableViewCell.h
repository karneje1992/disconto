//
//  DNamesTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNamesTableViewCellPresenterProtocol.h"

@interface DNamesTableViewCell : DMainTableViewCell
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;

@property id<DNamesTableViewCellPresenterProtocol> presenter;
@end
