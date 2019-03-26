//
//  DPhoneTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPhoneCellPresenterProtocol.h"

@interface DPhoneTableViewCell : DMainTableViewCell

@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property  id<DPhoneCellPresenterProtocol> presenter;

@end
