//
//  DTextTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTextTableViewCellPresenterProtocol.h"

@interface DTextTableViewCell : DMainTableViewCell
@property (strong, nonatomic) IBOutlet UITextField *textTextField;
@property id <DTextTableViewCellPresenterProtocol> presenter;
@end
