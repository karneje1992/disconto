//
//  DTableViewQuestController.h
//  Disconto
//
//  Created by Ross on 22.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAnswerCell.h"
#import "DSuperViewController.h"

@protocol DTableViewQuestControllerDelegate <NSObject>

- (void)answerComplit;

@end

@interface DTableViewQuestController : DSuperViewController <UITableViewDataSource, UITableViewDelegate, DAnswerCellDelegate>

@property id <DTableViewQuestControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andQuest:(DQuestModel *)quest;
+ (instancetype)showQuest:(DQuestModel *)quest;

@end
