//
//  DYandexCardTableViewCell.h
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYandexCardTableViewCellPresenterProtocol.h"

@interface DYandexCardTableViewCell : DMainTableViewCell

@property (strong, nonatomic) IBOutlet UITextField *yandexTextFieald;
@property id<DYandexCardTableViewCellPresenterProtocol> presenter;
@end
