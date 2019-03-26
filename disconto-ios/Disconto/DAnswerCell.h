//
//  DAnswerCell.h
//  Disconto
//
//  Created by user on 24.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DAnswerCell.h"

@protocol DAnswerCellDelegate <NSObject>

- (void)isChakingCell:(id)cell chack:(BOOL)chack;

@end

@interface DAnswerCell : DMainTableViewCell
@property id <DAnswerCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *chackButton;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (nonatomic) BOOL isChak;

- (void)setIsChak:(BOOL)isChak;

@end
