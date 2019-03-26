//
//  DSerialTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSerialTableViewCellPresenterProtocol.h"

@interface DSerialTableViewCell : DMainTableViewCell

@property (strong, nonatomic) IBOutlet UITextField *serialTextField;
@property id <DSerialTableViewCellPresenterProtocol> presenter;
@end
