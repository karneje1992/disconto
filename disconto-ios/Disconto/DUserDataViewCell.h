//
//  DUserDataViewCell.h
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMainTableViewCell.h"

@interface DUserDataViewCell : DMainTableViewCell
@property (strong, nonatomic) IBOutlet UIView *textFildView;
@property (strong, nonatomic) IBOutlet UILabel *maskLabel;


@end
