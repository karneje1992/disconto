//
//  DCardTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCardTableViewCellPresenterProtocol.h"

@interface DCardTableViewCell : DMainTableViewCell

@property id <DCardTableViewCellPresenterProtocol> presenter;
@property (strong, nonatomic) IBOutlet UITextField *cardTextField;
@end
