//
//  DQuestsFromProductController.h
//  Disconto
//
//  Created by Ross on 22.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTimer.h"
#import "DShowWebSiteController.h"
#import "DSocialViewController.h"
#import "DTableViewQuestController.h"
#import "DSuperViewController.h"

@interface DQuestsFromProductController : DSuperViewController <DShowWebSiteControllerDelegate,DTimerDelegate, DSocialViewControllerDelegate, DTableViewQuestControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *action;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property DTimer *timer;
@property DProductModel *product;

+ (instancetype)openQuests:(DProductModel *)product;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProduct:(DProductModel *)product;

@end
