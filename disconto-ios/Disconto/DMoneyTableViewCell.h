//
//  DMoneyTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 7/7/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMoneyCellPresenterProtocol.h"

@interface DMoneyTableViewCell : DMainTableViewCell

@property (strong, nonatomic) IBOutlet UITextField *moneyTextField;
@property (strong, nonatomic) IBOutlet UILabel *comisionLabel;

@property id <DMoneyCellPresenterProtocol> presenter;
@end
