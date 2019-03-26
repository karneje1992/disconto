//
//  DPostCodeTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPostCodeTableViewCellPresenterProtocol.h"

@interface DPostCodeTableViewCell : DMainTableViewCell

@property (strong, nonatomic) IBOutlet UITextField *indexTextField;
@property id <DPostCodeTableViewCellPresenterProtocol> prersenter;
@end
